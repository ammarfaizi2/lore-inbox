Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVCYRWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVCYRWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVCYRWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:22:53 -0500
Received: from mail.dif.dk ([193.138.115.101]:6812 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261696AbVCYRVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:21:33 -0500
Date: Fri, 25 Mar 2005 18:23:25 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][1/5] cifs: cifsfs.c cleanup - whitespace changes to function
 defs
Message-ID: <Pine.LNX.4.62.0503251822110.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up function definitions to use a consistent style and match
the previous cleanups.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3-orig/fs/cifs/cifsfs.c	2005-03-25 15:28:58.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c	2005-03-25 16:04:37.000000000 +0100
@@ -80,9 +80,8 @@ extern mempool_t *cifs_mid_poolp;
 
 extern kmem_cache_t *cifs_oplock_cachep;
 
-static int
-cifs_read_super(struct super_block *sb, void *data,
-		const char *devname, int silent)
+static int cifs_read_super(struct super_block *sb, void *data,
+	const char *devname, int silent)
 {
 	struct inode *inode;
 	struct cifs_sb_info *cifs_sb;
@@ -145,8 +144,7 @@ out_mount_failed:
 	return rc;
 }
 
-static void
-cifs_put_super(struct super_block *sb)
+static void cifs_put_super(struct super_block *sb)
 {
 	int rc = 0;
 	struct cifs_sb_info *cifs_sb;
@@ -166,8 +164,7 @@ cifs_put_super(struct super_block *sb)
 	return;
 }
 
-static int
-cifs_statfs(struct super_block *sb, struct kstatfs *buf)
+static int cifs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	int xid, rc = -EOPNOTSUPP;
 	struct cifs_sb_info *cifs_sb;
@@ -208,7 +205,7 @@ cifs_statfs(struct super_block *sb, stru
 	return 0;		/* always return success? what if volume is no longer available? */
 }
 
-static int cifs_permission(struct inode * inode, int mask, struct nameidata *nd)
+static int cifs_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	struct cifs_sb_info *cifs_sb;
 
@@ -232,8 +229,7 @@ mempool_t *cifs_sm_req_poolp;
 mempool_t *cifs_req_poolp;
 mempool_t *cifs_mid_poolp;
 
-static struct inode *
-cifs_alloc_inode(struct super_block *sb)
+static struct inode *cifs_alloc_inode(struct super_block *sb)
 {
 	struct cifsInodeInfo *cifs_inode;
 	cifs_inode =
@@ -256,8 +252,7 @@ cifs_alloc_inode(struct super_block *sb)
 	return &cifs_inode->vfs_inode;
 }
 
-static void
-cifs_destroy_inode(struct inode *inode)
+static void cifs_destroy_inode(struct inode *inode)
 {
 	kmem_cache_free(cifs_inode_cachep, CIFS_I(inode));
 }
@@ -267,8 +262,7 @@ cifs_destroy_inode(struct inode *inode)
  * Not all settable options are displayed but most of the important
  * ones are.
  */
-static int
-cifs_show_options(struct seq_file *s, struct vfsmount *m)
+static int cifs_show_options(struct seq_file *s, struct vfsmount *m)
 {
 	struct cifs_sb_info *cifs_sb;
 
@@ -293,8 +287,8 @@ cifs_show_options(struct seq_file *s, st
 }
 
 #ifdef CONFIG_CIFS_QUOTA
-int cifs_xquota_set(struct super_block * sb, int quota_type, qid_t qid,
-		struct fs_disk_quota * pdquota)
+int cifs_xquota_set(struct super_block *sb, int quota_type, qid_t qid,
+	struct fs_disk_quota *pdquota)
 {
 	int xid;
 	int rc = 0;
@@ -318,8 +312,8 @@ int cifs_xquota_set(struct super_block *
 	return rc;
 }
 
-int cifs_xquota_get(struct super_block * sb, int quota_type, qid_t qid,
-                struct fs_disk_quota * pdquota)
+int cifs_xquota_get(struct super_block *sb, int quota_type, qid_t qid,
+	struct fs_disk_quota *pdquota)
 {
 	int xid;
 	int rc = 0;
@@ -342,7 +336,7 @@ int cifs_xquota_get(struct super_block *
 	return rc;
 }
 
-int cifs_xstate_set(struct super_block * sb, unsigned int flags, int operation)
+int cifs_xstate_set(struct super_block *sb, unsigned int flags, int operation)
 {
 	int xid; 
 	int rc = 0;
@@ -365,7 +359,7 @@ int cifs_xstate_set(struct super_block *
 	return rc;
 }
 
-int cifs_xstate_get(struct super_block * sb, struct fs_quota_stat *qstats)
+int cifs_xstate_get(struct super_block *sb, struct fs_quota_stat *qstats)
 {
 	int xid;
 	int rc = 0;
@@ -417,9 +411,8 @@ struct super_operations cifs_super_ops =
 	.remount_fs = cifs_remount,
 };
 
-static struct super_block *
-cifs_get_sb(struct file_system_type *fs_type,
-	    int flags, const char *dev_name, void *data)
+static struct super_block *cifs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
 {
 	int rc;
 	struct super_block *sb = sget(fs_type, NULL, set_anon_super, NULL);
@@ -441,9 +434,8 @@ cifs_get_sb(struct file_system_type *fs_
 	return sb;
 }
 
-static ssize_t
-cifs_read_wrapper(struct file * file, char __user *read_data, size_t read_size,
-          loff_t * poffset)
+static ssize_t cifs_read_wrapper(struct file *file, char __user *read_data,
+	size_t read_size, loff_t *poffset)
 {
 	if(file == NULL)
 		return -EIO;
@@ -484,9 +476,8 @@ cifs_read_wrapper(struct file * file, ch
 	}
 }
 
-static ssize_t
-cifs_write_wrapper(struct file * file, const char __user *write_data,
-           size_t write_size, loff_t * poffset) 
+static ssize_t cifs_write_wrapper(struct file *file,
+	const char __user *write_data, size_t write_size, loff_t *poffset) 
 {
 	ssize_t written;
 
@@ -521,7 +512,6 @@ cifs_write_wrapper(struct file * file, c
 	return written;
 }
 
-
 static struct file_system_type cifs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "cifs",
@@ -529,6 +519,7 @@ static struct file_system_type cifs_fs_t
 	.kill_sb = kill_anon_super,
 	/*  .fs_flags */
 };
+
 struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
 	.lookup = cifs_lookup,
@@ -605,8 +596,8 @@ struct file_operations cifs_dir_ops = {
 #endif /* CONFIG_CIFS_EXPERIMENTAL */
 };
 
-static void
-cifs_init_once(void *inode, kmem_cache_t * cachep, unsigned long flags)
+static void cifs_init_once(void *inode, kmem_cache_t *cachep,
+	unsigned long flags)
 {
 	struct cifsInodeInfo *cifsi = (struct cifsInodeInfo *) inode;
 
@@ -617,8 +608,7 @@ cifs_init_once(void *inode, kmem_cache_t
 	}
 }
 
-static int
-cifs_init_inodecache(void)
+static int cifs_init_inodecache(void)
 {
 	cifs_inode_cachep = kmem_cache_create("cifs_inode_cache",
 					      sizeof (struct cifsInodeInfo),
@@ -630,15 +620,13 @@ cifs_init_inodecache(void)
 	return 0;
 }
 
-static void
-cifs_destroy_inodecache(void)
+static void cifs_destroy_inodecache(void)
 {
 	if (kmem_cache_destroy(cifs_inode_cachep))
 		printk(KERN_WARNING "cifs_inode_cache: error freeing\n");
 }
 
-static int
-cifs_init_request_bufs(void)
+static int cifs_init_request_bufs(void)
 {
 	if(CIFSMaxBufSize < 8192) {
 	/* Buffer size can not be smaller than 2 * PATH_MAX since maximum
@@ -711,8 +699,7 @@ cifs_init_request_bufs(void)
 	return 0;
 }
 
-static void
-cifs_destroy_request_bufs(void)
+static void cifs_destroy_request_bufs(void)
 {
 	mempool_destroy(cifs_req_poolp);
 	if (kmem_cache_destroy(cifs_req_cachep))
@@ -724,8 +711,7 @@ cifs_destroy_request_bufs(void)
 		      "cifs_destroy_request_cache: cifs_small_rq free error\n");
 }
 
-static int
-cifs_init_mids(void)
+static int cifs_init_mids(void)
 {
 	cifs_mid_cachep = kmem_cache_create("cifs_mpx_ids",
 				sizeof (struct mid_q_entry), 0,
@@ -754,8 +740,7 @@ cifs_init_mids(void)
 	return 0;
 }
 
-static void
-cifs_destroy_mids(void)
+static void cifs_destroy_mids(void)
 {
 	mempool_destroy(cifs_mid_poolp);
 	if (kmem_cache_destroy(cifs_mid_cachep))
@@ -767,7 +752,7 @@ cifs_destroy_mids(void)
 		       "error not all oplock structures were freed\n");
 }
 
-static int cifs_oplock_thread(void * dummyarg)
+static int cifs_oplock_thread(void *dummyarg)
 {
 	struct oplock_q_entry * oplock_item;
 	struct cifsTconInfo *pTcon;
@@ -836,8 +821,7 @@ static int cifs_oplock_thread(void * dum
 	complete_and_exit (&cifs_oplock_exited, 0);
 }
 
-static int __init
-init_cifs(void)
+static int __init init_cifs(void)
 {
 	int rc = 0;
 #ifdef CONFIG_PROC_FS
@@ -899,8 +883,7 @@ init_cifs(void)
 	return rc;
 }
 
-static void __exit
-exit_cifs(void)
+static void __exit exit_cifs(void)
 {
 	cFYI(0, ("In unregister ie exit_cifs"));
 #ifdef CONFIG_PROC_FS


