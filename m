Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbSLNVKP>; Sat, 14 Dec 2002 16:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbSLNVKP>; Sat, 14 Dec 2002 16:10:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:13504 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265939AbSLNVKK>; Sat, 14 Dec 2002 16:10:10 -0500
Message-ID: <3DFBA009.3000608@namesys.com>
Date: Sun, 15 Dec 2002 00:18:01 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK] [PATCH] ReiserFS assorted trivia
Content-Type: multipart/mixed;
 boundary="------------010302070409020404040307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010302070409020404040307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010302070409020404040307
Content-Type: message/rfc822;
 name="reiserfs fixes for 2.5.51"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs fixes for 2.5.51"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24628 invoked from network); 13 Dec 2002 17:04:25 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 13 Dec 2002 17:04:25 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 8B7CE17C55F; Fri, 13 Dec 2002 20:04:24 +0300 (MSK)
Date: Fri, 13 Dec 2002 20:04:24 +0300
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: reiserfs fixes for 2.5.51
Message-ID: <20021213200424.A8873@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

   These five changesets contain fixes for reiserfs. They fix issue with
   handling of displacing_large_files allocator option, a problem with
   remounting from readwrite to readwrite mode if FS holds some deleted,
   but not yet closed files, replace lock_kernel() stuff with reiserfs
   analogs, some C99 designated initialisers fixes and fixes for annoying
   warnings in fs/reiserfs/procfs.c if you compile with reiserfs statistics.

   You can pull these from bk://thebsh.namesys.com/bk/reiser3-linux-2.5-fixes

ChangeSet@1.849, 2002-12-07 14:13:55+03:00, green@angband.namesys.com
  reiserfs: Fixed annoying warnings in fs/reiserfs/procfs.c

ChangeSet@1.848, 2002-12-07 13:20:18+03:00, green@angband.namesys.com
  reiserfs: C99 designated initializers, by Art Haas

ChangeSet@1.847, 2002-12-07 13:18:51+03:00, green@angband.namesys.com
  reiserfs: lock_kernel is replaced with its reiserfs variant

ChangeSet@1.846, 2002-12-07 13:17:28+03:00, green@angband.namesys.com
  reiserfs: Fix a problem with delayed unlinks and remounting RW filesystem RW.

ChangeSet@1.845, 2002-12-07 13:16:27+03:00, green@angband.namesys.com
  reiserfs: Take into account file information even when not doing preallocation. Fixes a bug with displacing_large_files option.

Diffstats:
 fs/reiserfs/dir.c           |    6 +++---
 fs/reiserfs/inode.c         |   16 ++++++++--------
 fs/reiserfs/journal.c       |    5 ++---
 fs/reiserfs/namei.c         |   18 +++++++++---------
 fs/reiserfs/procfs.c        |   16 ++++++++--------
 fs/reiserfs/super.c         |   36 ++++++++++++++++++++----------------
 include/linux/reiserfs_fs.h |    3 ++-
 7 files changed, 52 insertions(+), 48 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.844   -> 1.849  
#	fs/reiserfs/procfs.c	1.14    -> 1.15   
#	 fs/reiserfs/inode.c	1.68    -> 1.70   
#	 fs/reiserfs/super.c	1.54    -> 1.56   
#	   fs/reiserfs/dir.c	1.17    -> 1.18   
#	 fs/reiserfs/namei.c	1.44    -> 1.45   
#	fs/reiserfs/journal.c	1.59    -> 1.60   
#	include/linux/reiserfs_fs.h	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/07	green@angband.namesys.com	1.845
# reiserfs: Take into account file information even when not doing preallocation. Fixes a bug with displacing_large_files option.
# --------------------------------------------
# 02/12/07	green@angband.namesys.com	1.846
# reiserfs: Fix a problem with delayed unlinks and remounting RW filesystem RW.
# --------------------------------------------
# 02/12/07	green@angband.namesys.com	1.847
# reiserfs: lock_kernel is replaced with its reiserfs variant
# --------------------------------------------
# 02/12/07	green@angband.namesys.com	1.848
# reiserfs: C99 designated initializers, by Art Haas
# --------------------------------------------
# 02/12/07	green@angband.namesys.com	1.849
# reiserfs: Fixed annoying warnings in fs/reiserfs/procfs.c
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
--- a/fs/reiserfs/dir.c	Sat Dec  7 14:14:58 2002
+++ b/fs/reiserfs/dir.c	Sat Dec  7 14:14:58 2002
@@ -18,9 +18,9 @@
 int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) ;
 
 struct file_operations reiserfs_dir_operations = {
-    read:	generic_read_dir,
-    readdir:	reiserfs_readdir,
-    fsync:	reiserfs_dir_fsync,
+    .read	= generic_read_dir,
+    .readdir	= reiserfs_readdir,
+    .fsync	= reiserfs_dir_fsync,
 };
 
 int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) {
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Sat Dec  7 14:14:58 2002
+++ b/fs/reiserfs/inode.c	Sat Dec  7 14:14:58 2002
@@ -490,7 +490,7 @@
 	return reiserfs_new_unf_blocknrs2(th, inode, allocated_block_nr, path, block);
     }
 #endif
-    return reiserfs_new_unf_blocknrs (th, allocated_block_nr, path, block);
+    return reiserfs_new_unf_blocknrs (th, inode, allocated_block_nr, path, block);
 }
 
 int reiserfs_get_block (struct inode * inode, sector_t block,
@@ -2113,11 +2113,11 @@
 }
 
 struct address_space_operations reiserfs_address_space_operations = {
-    writepage: reiserfs_writepage,
-    readpage: reiserfs_readpage, 
-    releasepage: reiserfs_releasepage,
-    sync_page: block_sync_page,
-    prepare_write: reiserfs_prepare_write,
-    commit_write: reiserfs_commit_write,
-    bmap: reiserfs_aop_bmap
+    .writepage = reiserfs_writepage,
+    .readpage = reiserfs_readpage, 
+    .releasepage = reiserfs_releasepage,
+    .sync_page = block_sync_page,
+    .prepare_write = reiserfs_prepare_write,
+    .commit_write = reiserfs_commit_write,
+    .bmap = reiserfs_aop_bmap
 } ;
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Sat Dec  7 14:14:58 2002
+++ b/fs/reiserfs/journal.c	Sat Dec  7 14:14:58 2002
@@ -1812,8 +1812,7 @@
   struct reiserfs_journal_commit_task *ct = __ct;
   struct reiserfs_journal_list *jl ;
 
-  /* FIXMEL: is this needed? */
-  lock_kernel();
+  reiserfs_write_lock(ct->p_s_sb);
 
   jl = SB_JOURNAL_LIST(ct->p_s_sb) + ct->jindex ;
 
@@ -1824,7 +1823,7 @@
     kupdate_one_transaction(ct->p_s_sb, jl) ;
   }
   reiserfs_kfree(ct->self, sizeof(struct reiserfs_journal_commit_task), ct->p_s_sb) ;
-  unlock_kernel();
+  reiserfs_write_unlock(ct->p_s_sb);
 }
 
 static void setup_commit_task_arg(struct reiserfs_journal_commit_task *ct,
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Sat Dec  7 14:14:58 2002
+++ b/fs/reiserfs/namei.c	Sat Dec  7 14:14:58 2002
@@ -1296,14 +1296,14 @@
  */
 struct inode_operations reiserfs_dir_inode_operations = {
   //&reiserfs_dir_operations,	/* default_file_ops */
-    create:	reiserfs_create,
-    lookup:	reiserfs_lookup,
-    link:	reiserfs_link,
-    unlink:	reiserfs_unlink,
-    symlink:	reiserfs_symlink,
-    mkdir:	reiserfs_mkdir,
-    rmdir:	reiserfs_rmdir,
-    mknod:	reiserfs_mknod,
-    rename:	reiserfs_rename,
+    .create	= reiserfs_create,
+    .lookup	= reiserfs_lookup,
+    .link	= reiserfs_link,
+    .unlink	= reiserfs_unlink,
+    .symlink	= reiserfs_symlink,
+    .mkdir	= reiserfs_mkdir,
+    .rmdir	= reiserfs_rmdir,
+    .mknod	= reiserfs_mknod,
+    .rename	= reiserfs_rename,
 };
 
diff -Nru a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
--- a/fs/reiserfs/procfs.c	Sat Dec  7 14:14:58 2002
+++ b/fs/reiserfs/procfs.c	Sat Dec  7 14:14:58 2002
@@ -78,7 +78,7 @@
 	struct super_block *sb;
 	char *format;
     
-	sb = procinfo_prologue((dev_t)data);
+	sb = procinfo_prologue((int)data);
 	if( sb == NULL )
 		return -ENOENT;
 	if ( REISERFS_SB(sb)->s_properties & (1 << REISERFS_3_6) ) {
@@ -136,7 +136,7 @@
 	struct reiserfs_sb_info *r;
 	int len = 0;
     
-	sb = procinfo_prologue((dev_t)data);
+	sb = procinfo_prologue((int)data);
 	if( sb == NULL )
 		return -ENOENT;
 	r = REISERFS_SB(sb);
@@ -229,7 +229,7 @@
 	int len = 0;
 	int level;
 	
-	sb = procinfo_prologue((dev_t)data);
+	sb = procinfo_prologue((int)data);
 	if( sb == NULL )
 		return -ENOENT;
 	r = REISERFS_SB(sb);
@@ -308,7 +308,7 @@
 	struct reiserfs_sb_info *r;
 	int len = 0;
     
-	sb = procinfo_prologue((dev_t)data);
+	sb = procinfo_prologue((int)data);
 	if( sb == NULL )
 		return -ENOENT;
 	r = REISERFS_SB(sb);
@@ -352,7 +352,7 @@
 	int hash_code;
 	int len = 0;
     
-	sb = procinfo_prologue((dev_t)data);
+	sb = procinfo_prologue((int)data);
 	if( sb == NULL )
 		return -ENOENT;
 	sb_info = REISERFS_SB(sb);
@@ -409,7 +409,7 @@
 	int len = 0;
 	int exact;
     
-	sb = procinfo_prologue((dev_t)data);
+	sb = procinfo_prologue((int)data);
 	if( sb == NULL )
 		return -ENOENT;
 	sb_info = REISERFS_SB(sb);
@@ -461,7 +461,7 @@
 	struct journal_params *jp;	
 	int len = 0;
     
-	sb = procinfo_prologue((dev_t)data);
+	sb = procinfo_prologue((int)data);
 	if( sb == NULL )
 		return -ENOENT;
 	r = REISERFS_SB(sb);
@@ -604,7 +604,7 @@
 {
 	return ( REISERFS_SB(sb)->procdir ) ? create_proc_read_entry
 		( name, 0, REISERFS_SB(sb)->procdir, func, 
-		  ( void * ) sb->s_bdev->bd_dev) : NULL;
+		  ( void * )(int) sb->s_bdev->bd_dev) : NULL;
 }
 
 void reiserfs_proc_unregister( struct super_block *sb, const char *name )
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Sat Dec  7 14:14:58 2002
+++ b/fs/reiserfs/super.c	Sat Dec  7 14:14:58 2002
@@ -474,25 +474,25 @@
 
 struct super_operations reiserfs_sops = 
 {
-  alloc_inode: reiserfs_alloc_inode,
-  destroy_inode: reiserfs_destroy_inode,
-  write_inode: reiserfs_write_inode,
-  dirty_inode: reiserfs_dirty_inode,
-  delete_inode: reiserfs_delete_inode,
-  put_super: reiserfs_put_super,
-  write_super: reiserfs_write_super,
-  write_super_lockfs: reiserfs_write_super_lockfs,
-  unlockfs: reiserfs_unlockfs,
-  statfs: reiserfs_statfs,
-  remount_fs: reiserfs_remount,
+  .alloc_inode = reiserfs_alloc_inode,
+  .destroy_inode = reiserfs_destroy_inode,
+  .write_inode = reiserfs_write_inode,
+  .dirty_inode = reiserfs_dirty_inode,
+  .delete_inode = reiserfs_delete_inode,
+  .put_super = reiserfs_put_super,
+  .write_super = reiserfs_write_super,
+  .write_super_lockfs = reiserfs_write_super_lockfs,
+  .unlockfs = reiserfs_unlockfs,
+  .statfs = reiserfs_statfs,
+  .remount_fs = reiserfs_remount,
 
 };
 
 static struct export_operations reiserfs_export_ops = {
-  encode_fh: reiserfs_encode_fh,
-  decode_fh: reiserfs_decode_fh,
-  get_parent: reiserfs_get_parent,
-  get_dentry: reiserfs_get_dentry,
+  .encode_fh = reiserfs_encode_fh,
+  .decode_fh = reiserfs_decode_fh,
+  .get_parent = reiserfs_get_parent,
+  .get_dentry = reiserfs_get_dentry,
 } ;
 
 /* this struct is used in reiserfs_getopt () for containing the value for those
@@ -716,7 +716,7 @@
   }
 
   if (*mount_flags & MS_RDONLY) {
-    /* remount rean-only */
+    /* remount read-only */
     if (s->s_flags & MS_RDONLY)
       /* it is read-only already */
       return 0;
@@ -732,6 +732,10 @@
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     s->s_dirt = 0;
   } else {
+    /* remount read-write */
+    if (!(s->s_flags & MS_RDONLY))
+	return 0; /* We are read-write already */
+
     REISERFS_SB(s)->s_mount_state = sb_umount_state(rs) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
     journal_begin(&th, s, 10) ;
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Sat Dec  7 14:14:58 2002
+++ b/include/linux/reiserfs_fs.h	Sat Dec  7 14:14:58 2002
@@ -2073,13 +2073,14 @@
 }
 
 extern inline int reiserfs_new_unf_blocknrs (struct reiserfs_transaction_handle *th,
+					     struct inode *inode,
 					     b_blocknr_t *new_blocknrs,
 					     struct path * path, long block)
 {
     reiserfs_blocknr_hint_t hint = {
 	.th = th,
 	.path = path,
-	.inode = NULL,
+	.inode = inode,
 	.block = block,
 	.formatted_node = 0,
 	.preallocate = 0



--------------010302070409020404040307--

