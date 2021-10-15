{
  containerDefinitions: [
    {
      cpu: 1024,
      environment: [],
      essential: true,
      image: 'nginx:{{ env `NGINX_VERSION` `latest` }}',
      logConfiguration: {
        logDriver: 'awslogs',
        options: {
          'awslogs-group': 'ecspresso-test',
          'awslogs-region': 'ap-northeast-1',
          'awslogs-stream-prefix': 'nginx',
        },
      },
      mountPoints: [],
      name: 'nginx',
      portMappings: [
        {
          containerPort: 80,
          hostPort: 80,
          protocol: 'tcp',
        },
      ],
      secrets: [
        {
          name: 'FOO',
          valueFrom: '/ecspresso-test/foo',
        },
        {
          name: 'BAR',
          valueFrom: 'arn:aws:ssm:ap-northeast-1:{{must_env `AWS_ACCOUNT_ID`}}:parameter/ecspresso-test/bar',
        },
        {
          name: 'BAZ',
          valueFrom: 'arn:aws:secretsmanager:ap-northeast-1:{{must_env `AWS_ACCOUNT_ID`}}:secret:ecspresso-test/baz-06XQOH',
        },
      ],
      volumesFrom: [],
    },
    {
      essential: true,
      image: 'debian:buster-slim',
      logConfiguration: {
        logDriver: 'awslogs',
        options: {
          'awslogs-group': 'ecspresso-test',
          'awslogs-region': 'ap-northeast-1',
          'awslogs-stream-prefix': 'bash',
        },
      },
      name: 'bash',
      command: [
        'tail',
        '-f',
        '/dev/null',
      ],
    },
  ],
  cpu: '256',
  ephemeralStorage: {
    sizeInGiB: 50,
  },
  executionRoleArn: 'arn:aws:iam::{{must_env `AWS_ACCOUNT_ID`}}:role/ecsTaskRole',
  family: 'ecspresso-test',
  memory: '512',
  networkMode: 'awsvpc',
  placementConstraints: [],
  requiresCompatibilities: [
    'FARGATE',
  ],
  tags: [
    {
      key: 'TaskType',
      value: 'ecspresso-test',
    },
  ],
  taskRoleArn: 'arn:aws:iam::{{must_env `AWS_ACCOUNT_ID`}}:role/ecsTaskRole',
  volumes: [],
}
