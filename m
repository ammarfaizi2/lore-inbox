Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318227AbSG3LQC>; Tue, 30 Jul 2002 07:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSG3LQC>; Tue, 30 Jul 2002 07:16:02 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:29446 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318227AbSG3LP5>; Tue, 30 Jul 2002 07:15:57 -0400
Message-ID: <3D467625.1080507@namesys.com>
Date: Tue, 30 Jul 2002 15:19:01 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS C99 style conversion
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

     Thanks to Rusty Russell for informing us of the need for this.
     trivial changeset to convert named struct initialisers in reiserfs to
     C99 style.
     You can pull it from bk://cvs.namesys.com/bk/reiser3-linux-2.5
     Diffstat:
  file.c     |   18 +++++------
  item_ops.c |   96 
++++++++++++++++++++++++++++++------------------------------- super.c    |   10 
+++---
  3 files changed, 62 insertions(+), 62 deletions(-)


    Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
# 
            ChangeSet	1.508   -> 1.509
# 
   fs/reiserfs/file.c	1.17    -> 1.18
# 
fs/reiserfs/item_ops.c 
1.8     -> 1.9
# 
  fs/reiserfs/super.c	1.50    -> 1.51
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/30	green@angband.namesys.com	1.509
# super.c, item_ops.c, file.c:
#   C99 struct initialisers
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/file.c b/fs/reiserfs/file.c
--- a/fs/reiserfs/file.c	Tue Jul 30 14:03:10 2002
+++ b/fs/reiserfs/file.c	Tue Jul 30 14:03:10 2002
@@ -141,19 +141,19 @@
  }

  struct file_operations reiserfs_file_operations = {
-    read:	generic_file_read,
-    write:	generic_file_write,
-    ioctl:	reiserfs_ioctl,
-    mmap:	generic_file_mmap,
-    release:	reiserfs_file_release,
-    fsync:	reiserfs_sync_file,
-    sendfile:	generic_file_sendfile,
+    .read	= generic_file_read,
+    .write	= generic_file_write,
+    .ioctl	= reiserfs_ioctl,
+    .mmap	= generic_file_mmap,
+    .release	= reiserfs_file_release,
+    .fsync	= reiserfs_sync_file,
+    .sendfile	= generic_file_sendfile,
  };


  struct  inode_operations reiserfs_file_inode_operations = {
-    truncate:	reiserfs_vfs_truncate_file,
-    setattr:    reiserfs_setattr,
+    .truncate	= reiserfs_vfs_truncate_file,
+    .setattr    = reiserfs_setattr,
  };


diff -Nru a/fs/reiserfs/item_ops.c b/fs/reiserfs/item_ops.c
--- a/fs/reiserfs/item_ops.c	Tue Jul 30 14:03:10 2002
+++ b/fs/reiserfs/item_ops.c	Tue Jul 30 14:03:10 2002
@@ -111,18 +111,18 @@
  }

  struct item_operations stat_data_ops = {
- 
bytes_number: 
	sd_bytes_number,
- 
decrement_key: 
	sd_decrement_key,
- 
is_left_mergeable: 
sd_is_left_mergeable,
- 
print_item: 
	sd_print_item,
- 
check_item: 
	sd_check_item,
-
- 
create_vi: 
	sd_create_vi,
- 
check_left: 
	sd_check_left,
- 
check_right: 
	sd_check_right,
- 
part_size: 
	sd_part_size,
- 
unit_num: 
	sd_unit_num,
- 
print_vi: 
	sd_print_vi
+ 
.bytes_number 
	= sd_bytes_number,
+ 
.decrement_key 
	= sd_decrement_key,
+ 
.is_left_mergeable 
= sd_is_left_mergeable,
+ 
.print_item 
	= sd_print_item,
+ 
.check_item 
	= sd_check_item,
+
+ 
.create_vi 
	= sd_create_vi,
+ 
.check_left 
	= sd_check_left,
+ 
.check_right 
	= sd_check_right,
+ 
.part_size 
	= sd_part_size,
+ 
.unit_num 
	= sd_unit_num,
+ 
.print_vi 
	= sd_print_vi
  };


@@ -214,18 +214,18 @@
  }

  struct item_operations direct_ops = {
- 
bytes_number: 
	direct_bytes_number,
- 
decrement_key: 
	direct_decrement_key,
- 
is_left_mergeable: 
direct_is_left_mergeable,
- 
print_item: 
	direct_print_item,
- 
check_item: 
	direct_check_item,
-
- 
create_vi: 
	direct_create_vi,
- 
check_left: 
	direct_check_left,
- 
check_right: 
	direct_check_right,
- 
part_size: 
	direct_part_size,
- 
unit_num: 
	direct_unit_num,
- 
print_vi: 
	direct_print_vi
+ 
.bytes_number 
	= direct_bytes_number,
+ 
.decrement_key 
	= direct_decrement_key,
+ 
.is_left_mergeable 
= direct_is_left_mergeable,
+ 
.print_item 
	= direct_print_item,
+ 
.check_item 
	= direct_check_item,
+
+ 
.create_vi 
	= direct_create_vi,
+ 
.check_left 
	= direct_check_left,
+ 
.check_right 
	= direct_check_right,
+ 
.part_size 
	= direct_part_size,
+ 
.unit_num 
	= direct_unit_num,
+ 
.print_vi 
	= direct_print_vi
  };


@@ -368,18 +368,18 @@
  }

  struct item_operations indirect_ops = {
- 
bytes_number: 
	indirect_bytes_number,
- 
decrement_key: 
	indirect_decrement_key,
- 
is_left_mergeable: 
indirect_is_left_mergeable,
- 
print_item: 
	indirect_print_item,
- 
check_item: 
	indirect_check_item,
-
- 
create_vi: 
	indirect_create_vi,
- 
check_left: 
	indirect_check_left,
- 
check_right: 
	indirect_check_right,
- 
part_size: 
	indirect_part_size,
- 
unit_num: 
	indirect_unit_num,
- 
print_vi: 
	indirect_print_vi
+ 
.bytes_number 
	= indirect_bytes_number,
+ 
.decrement_key 
	= indirect_decrement_key,
+ 
.is_left_mergeable 
= indirect_is_left_mergeable,
+ 
.print_item 
	= indirect_print_item,
+ 
.check_item 
	= indirect_check_item,
+
+ 
.create_vi 
	= indirect_create_vi,
+ 
.check_left 
	= indirect_check_left,
+ 
.check_right 
	= indirect_check_right,
+ 
.part_size 
	= indirect_part_size,
+ 
.unit_num 
	= indirect_unit_num,
+ 
.print_vi 
	= indirect_print_vi
  };


@@ -662,18 +662,18 @@
  }

  struct item_operations direntry_ops = {
- 
bytes_number: 
	direntry_bytes_number,
- 
decrement_key: 
	direntry_decrement_key,
- 
is_left_mergeable: 
direntry_is_left_mergeable,
- 
print_item: 
	direntry_print_item,
- 
check_item: 
	direntry_check_item,
-
- 
create_vi: 
	direntry_create_vi,
- 
check_left: 
	direntry_check_left,
- 
check_right: 
	direntry_check_right,
- 
part_size: 
	direntry_part_size,
- 
unit_num: 
	direntry_unit_num,
- 
print_vi: 
	direntry_print_vi
+ 
.bytes_number 
	= direntry_bytes_number,
+ 
.decrement_key 
	= direntry_decrement_key,
+ 
.is_left_mergeable 
= direntry_is_left_mergeable,
+ 
.print_item 
	= direntry_print_item,
+ 
.check_item 
	= direntry_check_item,
+
+ 
.create_vi 
	= direntry_create_vi,
+ 
.check_left 
	= direntry_check_left,
+ 
.check_right 
	= direntry_check_right,
+ 
.part_size 
	= direntry_part_size,
+ 
.unit_num 
	= direntry_unit_num,
+ 
.print_vi 
	= direntry_print_vi
  };


diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue Jul 30 14:03:10 2002
+++ b/fs/reiserfs/super.c	Tue Jul 30 14:03:10 2002
@@ -1313,11 +1313,11 @@
  }

  static struct file_system_type reiserfs_fs_type = {
- 
owner: THIS_MODULE,
- 
name: "reiserfs",
- 
get_sb: get_super_block,
- 
kill_sb: kill_block_super,
- 
fs_flags: FS_REQUIRES_DEV,
+ 
.owner 
	= THIS_MODULE,
+ 
.name 
	= "reiserfs",
+ 
.get_sb 
	= get_super_block,
+ 
.kill_sb 
= kill_block_super,
+ 
.fs_flags 
= FS_REQUIRES_DEV,
  };

  MODULE_DESCRIPTION ("ReiserFS journaled filesystem");

Bye,
     Oleg



