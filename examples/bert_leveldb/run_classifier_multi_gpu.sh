#!/bin/bash
BERT_BASE_PATH="./bert_uncased_L-12_H-768_A-12/"
DATA_PATH="./data/glue_data/MNLI/"
CKPT_PATH="./data/saved_model/mnli_models"

# start fine-tuning
python3.7 -m paddle.distributed.launch --started_port 8899 --selected_gpus=0,1,2,3 bert_classifier.py\
    --use_cuda true \
    --do_train true \
    --do_test true \
    --batch_size 64 \
    --data_dir ${DATA_PATH} \
    --vocab_path ${BERT_BASE_PATH}/vocab.txt \
    --checkpoints ${CKPT_PATH} \
    --save_steps 1000 \
    --weight_decay  0.01 \
    --warmup_proportion 0.1 \
    --validation_steps 100 \
    --epoch 3 \
    --max_seq_len 128 \
    --bert_config_path ${BERT_BASE_PATH}/bert_config.json \
    --learning_rate 5e-5 \
    --skip_steps 10 \
    --shuffle true

