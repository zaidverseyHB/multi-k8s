docker build -t zaidverseyhb/multi-client:latest -t zaidverseyhb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zaidverseyhb/multi-server:latest -t zaidverseyhb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zaidverseyhb/multi-worker:latest -t zaidverseyhb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zaidverseyhb/multi-client:latest
docker push zaidverseyhb/multi-server:latest
docker push zaidverseyhb/multi-worker:latest

docker push zaidverseyhb/multi-client:$SHA
docker push zaidverseyhb/multi-server:$SHA
docker push zaidverseyhb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=zaidverseyhb/multi-client:$SHA
kubectl set image deployments/server-deployment server=zaidverseyhb/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=zaidverseyhb/multi-worker:$SHA