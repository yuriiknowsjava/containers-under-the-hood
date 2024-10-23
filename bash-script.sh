#!/bin/bash

# Variables
echo "Bash has only 3 data types: string, number, and array"

first_script_var="First Value"
an_array=(1 6 63 22 243)
echo "The whole array: ${an_array[@]}"
echo "The second element: ${an_array[1]}"
echo "Array size: ${#an_array[@]}"
echo ""

echo "Enter application name:"
read app_name
echo "App name ${app_name}"
echo ""

echo "Default value if not exist: ${non_existent_val:=my_default_value}"
echo ""

# Expansions
echo "This is shell expansion: \"$(ls -la | head -1)\""
echo "This is arithmetic expansion 2**10 + 2=$(( 2**10 + 2 ))"
echo ""

echo "One or move chars *"
ls ~/.bash*
echo ""

echo "One char ?"
ls ~/.bashr?
echo ""

echo "Chars from set [..]"
ls ~/.bash[_,r]*
echo ""

echo "Word splitting is antipattern, try to avoid it. Use double quotes"
echo ""

# Conditions
echo "0 is true, other integers are false"
echo 'echo $? returns the last command status code'
echo $?
echo ""

type test
echo "Command test is used to checs if a given expression is true or false"
echo "in practice, it is rarely used since there is a syntatic sugar [[ ]] for strings and (( )) for numbers"
echo "Test ~/.bashrc is file"
[[ -f ~/.bashrc ]]
echo $?
echo ""

# if-elif-else
echo "IF-elif-else"
if [[ "${app_name}" == 'x' ]]; then
    echo "App is X"
    if ls -la ~ | grep bash ; then
        echo 'If can accept the whole command and use its status code 0 - true'
        echo 'If you use shell expansion, you get std in'
    fi
elif (( $(date +%s) % 2 == 0)); then
    echo "Unix time mod 2 is zero"
else 
    echo "Else branch"
fi
echo ""

# switch case
echo "CASE"
case "${app_name}" in
asdf)
    echo "asdf is invoked"
    ;;
x)
    echo "x is invoked"
    ;;
*)
    echo "app is not supported"
    ;;
esac
echo ""

# while/until loop
echo "WHILE"
counter=10
while (( counter > 0 )); do
    echo "while counter is ${counter}"
    counter=$(( counter - 1))
    (( counter-- )) # both options will work
done
echo ""

echo "UNTIL similar to while, but while condition is false"
counter=10
until (( counter < 0 )); do
    echo "until counter is ${counter}"
    counter=$(( counter - 1))
    (( counter-- )) # both options will work
done
echo ""

# for loops
echo "FORI"
for (( i = 0; i < 5; i++ )); do
    echo "fori value: ${i}"
done
echo ""

echo "FOREACH"
for value in "${an_array[@]}" ; do
    echo "foreach array el: ${value}"
done
echo ""

echo "FOREACH file"
echo "in this example we don't use double-quotes, because we need word splitting"
for ff in ~/.bash* ; do
    echo "${ff}"
done
echo ""

# FUNCTIONS!!!
echo "FUNCTIONS"
function first_fn() {
    echo "function keyword may be omitted"
}
first_fn

second_fn() {
    echo "First arg(\$1): $1"
    echo "All args as string(\$*): $*" # requires word splitting
    echo "All args as array(\$@): $@"
    for arg in "$@" ; do
        echo "iter over args: $arg"
    done
    # return 0 # don't need to write it, since it default
}
second_fn arg1 arg2 arg3
echo ""

echo "Functions in bash return status code. If you don't write return, it's 0 by default
      You can pass data through std in using echo. It's a bad practice!"
echo ""

############################
# Description of the function
# Global:
# - List
# - of
# - global
# - variables
# - used
# Argumets:
# - None
############################
third_fn() {
    echo "You need to mark all the function local variables with local keyword"
    local local_var=42
    echo "${local_var}"
}
result=$(third_fn)
echo "third_fn result ${result}"
echo ""
