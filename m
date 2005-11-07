Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVKGRjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVKGRjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVKGRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:39:42 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:45577 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S965086AbVKGRjl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:39:41 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] fat: s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 02:39:33 +0900
In-Reply-To: <878xw0tl3r.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's message of "Tue, 08 Nov 2005 02:37:44 +0900")
Message-ID: <874q6otl0q.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All EXPORT_SYMBOL of fatfs is only for vfat/msdos. _GPL would be proper.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c    |   14 +++++++-------
 fs/fat/fatent.c |    2 +-
 fs/fat/file.c   |    2 +-
 fs/fat/inode.c  |   10 +++++-----
 fs/fat/misc.c   |    6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)

diff -puN fs/fat/dir.c~fat_export_symbol_gpl fs/fat/dir.c
--- linux-2.6.14/fs/fat/dir.c~fat_export_symbol_gpl	2005-11-07 03:58:53.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/dir.c	2005-11-07 03:58:53.000000000 +0900
@@ -418,7 +418,7 @@ EODir:
 	return err;
 }
 
-EXPORT_SYMBOL(fat_search_long);
+EXPORT_SYMBOL_GPL(fat_search_long);
 
 struct fat_ioctl_filldir_callback {
 	struct dirent __user *dirent;
@@ -780,7 +780,7 @@ int fat_get_dotdot_entry(struct inode *d
 	return -ENOENT;
 }
 
-EXPORT_SYMBOL(fat_get_dotdot_entry);
+EXPORT_SYMBOL_GPL(fat_get_dotdot_entry);
 
 /* See if directory is empty */
 int fat_dir_empty(struct inode *dir)
@@ -803,7 +803,7 @@ int fat_dir_empty(struct inode *dir)
 	return result;
 }
 
-EXPORT_SYMBOL(fat_dir_empty);
+EXPORT_SYMBOL_GPL(fat_dir_empty);
 
 /*
  * fat_subdirs counts the number of sub-directories of dir. It can be run
@@ -849,7 +849,7 @@ int fat_scan(struct inode *dir, const un
 	return -ENOENT;
 }
 
-EXPORT_SYMBOL(fat_scan);
+EXPORT_SYMBOL_GPL(fat_scan);
 
 static int __fat_remove_entries(struct inode *dir, loff_t pos, int nr_slots)
 {
@@ -936,7 +936,7 @@ int fat_remove_entries(struct inode *dir
 	return 0;
 }
 
-EXPORT_SYMBOL(fat_remove_entries);
+EXPORT_SYMBOL_GPL(fat_remove_entries);
 
 static int fat_zeroed_cluster(struct inode *dir, sector_t blknr, int nr_used,
 			      struct buffer_head **bhs, int nr_bhs)
@@ -1048,7 +1048,7 @@ error:
 	return err;
 }
 
-EXPORT_SYMBOL(fat_alloc_new_dir);
+EXPORT_SYMBOL_GPL(fat_alloc_new_dir);
 
 static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 			       int *nr_cluster, struct msdos_dir_entry **de,
@@ -1264,4 +1264,4 @@ error_remove:
 	return err;
 }
 
-EXPORT_SYMBOL(fat_add_entries);
+EXPORT_SYMBOL_GPL(fat_add_entries);
diff -puN fs/fat/fatent.c~fat_export_symbol_gpl fs/fat/fatent.c
--- linux-2.6.14/fs/fat/fatent.c~fat_export_symbol_gpl	2005-11-07 03:58:53.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/fatent.c	2005-11-07 03:58:53.000000000 +0900
@@ -581,7 +581,7 @@ error:
 	return err;
 }
 
-EXPORT_SYMBOL(fat_free_clusters);
+EXPORT_SYMBOL_GPL(fat_free_clusters);
 
 int fat_count_free_clusters(struct super_block *sb)
 {
diff -puN fs/fat/file.c~fat_export_symbol_gpl fs/fat/file.c
--- linux-2.6.14/fs/fat/file.c~fat_export_symbol_gpl	2005-11-07 03:58:53.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/file.c	2005-11-07 03:58:53.000000000 +0900
@@ -173,7 +173,7 @@ out:
 	return error;
 }
 
-EXPORT_SYMBOL(fat_notify_change);
+EXPORT_SYMBOL_GPL(fat_notify_change);
 
 /* Free all clusters after the skip'th cluster. */
 static int fat_free(struct inode *inode, int skip)
diff -puN fs/fat/inode.c~fat_export_symbol_gpl fs/fat/inode.c
--- linux-2.6.14/fs/fat/inode.c~fat_export_symbol_gpl	2005-11-07 03:58:53.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/inode.c	2005-11-07 03:58:53.000000000 +0900
@@ -197,7 +197,7 @@ void fat_attach(struct inode *inode, lof
 	spin_unlock(&sbi->inode_hash_lock);
 }
 
-EXPORT_SYMBOL(fat_attach);
+EXPORT_SYMBOL_GPL(fat_attach);
 
 void fat_detach(struct inode *inode)
 {
@@ -208,7 +208,7 @@ void fat_detach(struct inode *inode)
 	spin_unlock(&sbi->inode_hash_lock);
 }
 
-EXPORT_SYMBOL(fat_detach);
+EXPORT_SYMBOL_GPL(fat_detach);
 
 struct inode *fat_iget(struct super_block *sb, loff_t i_pos)
 {
@@ -362,7 +362,7 @@ out:
 	return inode;
 }
 
-EXPORT_SYMBOL(fat_build_inode);
+EXPORT_SYMBOL_GPL(fat_build_inode);
 
 static void fat_delete_inode(struct inode *inode)
 {
@@ -557,7 +557,7 @@ int fat_sync_inode(struct inode *inode)
 	return fat_write_inode(inode, 1);
 }
 
-EXPORT_SYMBOL(fat_sync_inode);
+EXPORT_SYMBOL_GPL(fat_sync_inode);
 
 static int fat_show_options(struct seq_file *m, struct vfsmount *mnt);
 static struct super_operations fat_sops = {
@@ -1365,7 +1365,7 @@ out_fail:
 	return error;
 }
 
-EXPORT_SYMBOL(fat_fill_super);
+EXPORT_SYMBOL_GPL(fat_fill_super);
 
 int __init fat_cache_init(void);
 void fat_cache_destroy(void);
diff -puN fs/fat/misc.c~fat_export_symbol_gpl fs/fat/misc.c
--- linux-2.6.14/fs/fat/misc.c~fat_export_symbol_gpl	2005-11-07 03:58:53.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/misc.c	2005-11-07 03:58:53.000000000 +0900
@@ -33,7 +33,7 @@ void fat_fs_panic(struct super_block *s,
 	}
 }
 
-EXPORT_SYMBOL(fat_fs_panic);
+EXPORT_SYMBOL_GPL(fat_fs_panic);
 
 /* Flushes the number of free clusters on FAT32 */
 /* XXX: Need to write one per FSINFO block.  Currently only writes 1 */
@@ -192,7 +192,7 @@ void fat_date_unix2dos(int unix_date, __
 	*date = cpu_to_le16(nl_day-day_n[month-1]+1+(month << 5)+(year << 9));
 }
 
-EXPORT_SYMBOL(fat_date_unix2dos);
+EXPORT_SYMBOL_GPL(fat_date_unix2dos);
 
 int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
 {
@@ -220,4 +220,4 @@ int fat_sync_bhs(struct buffer_head **bh
 	return err;
 }
 
-EXPORT_SYMBOL(fat_sync_bhs);
+EXPORT_SYMBOL_GPL(fat_sync_bhs);
_
