#Call Hub Struts Check Instances to check for projects
echo "Please enter a max instance number: ex. 06"
read input_variable

for i in $(seq -f "%02g" 00 $input_variable)
do
  curl -s POST --data 'j_username=test&j_password=test' -i "https://tc$i.blackducksoftware.com:443/j_spring_security_check" -c cookie-jar.txt > /dev/null
  PROJECTSPERINSTANCE=$(curl -X GET --data 'j_username=test&j_password=test' --header "Accept: application/json" "https://tc$i.blackducksoftware.com:443/api/projects" -L -b cookie-jar.txt | python -c 'import sys, json; print json.load(sys.stdin)["totalCount"]')
  echo "Projects for Instance $i: " $PROJECTSPERINSTANCE
done
