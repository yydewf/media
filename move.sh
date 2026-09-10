#!/bin/bash

# 变量定义（WSL环境，D盘挂载到/mnt/d）
source_dir="/home/zhfall/src/github.com/FongMi/media/libraries"
target_dir="/home/zhfall/src/github.com/FongMi/TV/app/libs"
move_list="/home/zhfall/src/github.com/FongMi/media/move.txt"

# 先确保目标文件夹存在
mkdir -p "$target_dir"

# 递归查找 lib-*-release.aar 文件
find "$source_dir" -type f -name "lib-*-release.aar" | while read -r file; do
    # 获取纯文件名（不带路径）
    filename=$(basename "$file")
    # 整行精确匹配，判断文件名是否在move_list中
    grep -Fxq "$filename" "$move_list"
    if [ $? -eq 0 ]; then
        cp "$file" "$target_dir/"
        echo "Moved \"$file\" to \"$target_dir\""
    fi
done

