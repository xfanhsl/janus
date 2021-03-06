---
title: API
---

:insert toc

---

Install Janus from the Python package index using `pip`:

    $ pip install libjanus

Alternatively, you can incorporate the single, public-domain `janus.py` file directly into your application. Janus has no external dependencies.

Import the Janus module:

::: python

    >>> import janus

Janus requires Python 3.0 or later.



## Basic Usage

Initialize an argument parser, optionally specifying the application's help text and version as string arguments:

::: python

    parser = janus.ArgParser(helptext=None, version=None)

Supplying help text activates an automatic `--help` flag; supplying a version string activates an automatic `--version` flag. (Automatic `-h` and `-v` shortcuts are also activated unless registered by other options.)

You can now register your application's options and commands on the parser using the registration functions described below. Once the required options and commands have been registered, call the parser's `parse()` method to process the application's command line arguments:

::: python

    parser.parse()

Parsed option values can be retrieved from the parser instance itself.



## Register Options

Janus supports long-form options, `--foo`, with single-character shortcuts, `-f`.

An option can have an unlimited number of long and short-form aliases. Aliases are specified via the `name` parameter which accepts a string of space-separated alternatives, e.g. `"foo f"`.

Option values can be separated on the command line by either a space, `--foo 123`, or an equals symbol, `--foo=123`.


||  `.new_flag(name)`  ||

    Register a flag (a boolean option) with a default value of `False`. Flag options take no arguments but are either present (`True`) or absent (`False`).


||  `.new_float(name, fallback=None)`  ||

    Register a floating-point option, optionally specifying a fallback value.


||  `.new_int(name, fallback=None)`  ||

    Register an integer option, optionally specifying a fallback value.


||  `.new_str(name, fallback=None)`  ||

    Register a string option, optionally specifying a fallback value.



## Retrieve Option Values

An option's value can be retrieved from the parser instance using any of its registered aliases.

Each option maintains an internal list of values — the value of the option is the final value in the list or the fallback value if the list is empty.


||  `.found(name)`  ||

    Returns true if the specified option was found while parsing.


||  `.get(name)`  ||

    Returns the value of the specified option.


||  `.get_list(name)`  ||

    Returns the specified option's list of values.


||  `.len_list(name)`  ||

    Returns the length of the specified option's list of values.


An option's value can also be retrieved using read-only dictionary syntax:

::: python

    value = parser["name"]



## Retrieve Positional Arguments


Options can be preceded, followed, or interspaced with positional arguments.


||  `.get_args()`  ||

    Returns the positional arguments as a list of strings.


||  `.get_args_as_floats()`  ||

    Attempts to parse and return the positional arguments as a list of floats.
    Exits with an error message on failure.


||  `.get_args_as_ints()`  ||

    Attempts to parse and return the positional arguments as a list of
    integers. Exits with an error message on failure.


||  `.has_args()`  ||

    Returns true if at least one positional argument has been found.


||  `.num_args()`  ||

    Returns the number of positional arguments.


Positional arguments can also be accessed using read-only list syntax:

::: python

    value = parser[index]



## Commands

Janus supports git-style command interfaces with arbitrarily-nested commands. Register a command on a parser instance using the `new_cmd()` method:

::: python

    cmd_parser = parser.new_cmd(name, helptext, callback)

This method returns a new `ArgParser` instance associated with the command. You can register the command's flags and options on this sub-parser using the standard methods listed above. (Note that you never need to call `parse()` on a command parser --- if a command is found, its arguments are parsed automatically.)

* Like options, commands can have an unlimited number of aliases specified via the `name` string.

* Commands support an automatic `--help` flag and an automatic `help <name>` command using the specified help text.

* The specified callback function will be called if the command is found. The callback should accept the command's `ArgParser` instance as its sole argument and should have no return value.

The following `ArgParser` methods are also available for processing commands manually:


||  `.get_cmd_name()`  ||

    Returns the command name, if the parser has found a command; otherwise returns `None`.


||  `.get_cmd_parser()`  ||

    Returns the command parser instance, if the parser has found a command; otherwise returns `None`.


||  `.get_parent()`  ||

    Returns a command parser's parent parser.


||  `.has_cmd()`  ||

    Returns true if the parser has found a command.
