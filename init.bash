##Infra Init
terraform init
terraform plan
terraform apply -auto-approve

## ECR commands & Docker Build/Deploy
aws ecr get-login-password --region <region>| docker login --username <username> --password-stdin <account_number>.dkr.ecr.<region>.amazonaws.com
cd app
docker buildx build --platform linux/amd64 -t hello-world-flask:v1 .
docker tag hello-world-flask:v1 <account_number>.dkr.ecr.<region>.amazonaws.com/<repository_name>:v1
docker push <account_number>.dkr.ecr.<region>.amazonaws.com/<repository_name>:v1
cd..

## K8S Deploy
kubectl apply -f app/main.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

## Add Argo + Prometheus
helm repo add eks https://aws.github.io/eks-charts

helm upgrade -i appmesh-prometheus eks/appmesh-prometheus \
--namespace appmesh-system