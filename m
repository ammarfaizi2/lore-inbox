Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUGRTPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUGRTPh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUGRTPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:15:37 -0400
Received: from web53802.mail.yahoo.com ([206.190.36.197]:20383 "HELO
	web53802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264492AbUGRTPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:15:32 -0400
Message-ID: <20040718191531.80876.qmail@web53802.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:15:31 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/xfs files
To: lkml <linux-kernel@vger.kernel.org>
Cc: nathans@sgi.com, linux-xfs@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/xfs/linux-2.6/xfs_fs_subr.h
linux-2.6.7-new/fs/xfs/linux-2.6/xfs_fs_subr.h
--- linux-2.6.7-orig/fs/xfs/linux-2.6/xfs_fs_subr.h     2004-06-15 22:19:42.000000000 -0700
+++ linux-2.6.7-new/fs/xfs/linux-2.6/xfs_fs_subr.h      2004-07-18 08:40:42.000000000 -0700
@@ -40,7 +40,6 @@

 extern int     fs_noerr(void);
 extern int     fs_nosys(void);
-extern int     fs_nodev(void);
 extern void    fs_noval(void);
 extern void    fs_tosspages(bhv_desc_t *, xfs_off_t, xfs_off_t, int);
 extern void    fs_flushinval_pages(bhv_desc_t *, xfs_off_t, xfs_off_t, int);
diff -ru linux-2.6.7-orig/fs/xfs/quota/xfs_qm.h linux-2.6.7-new/fs/xfs/quota/xfs_qm.h
--- linux-2.6.7-orig/fs/xfs/quota/xfs_qm.h      2004-06-15 22:19:03.000000000 -0700
+++ linux-2.6.7-new/fs/xfs/quota/xfs_qm.h       2004-07-18 08:34:23.000000000 -0700
@@ -187,7 +187,6 @@
 extern int             xfs_qm_sync(xfs_mount_t *, short);

 /* dquot stuff */
-extern void            xfs_qm_dqunlink(xfs_dquot_t *);
 extern boolean_t       xfs_qm_dqalloc_incore(xfs_dquot_t **);
 extern int             xfs_qm_dqattach(xfs_inode_t *, uint);
 extern void            xfs_qm_dqdetach(xfs_inode_t *);
diff -ru linux-2.6.7-orig/fs/xfs/xfs_acl.h linux-2.6.7-new/fs/xfs/xfs_acl.h
--- linux-2.6.7-orig/fs/xfs/xfs_acl.h   2004-06-15 22:19:13.000000000 -0700
+++ linux-2.6.7-new/fs/xfs/xfs_acl.h    2004-07-18 08:36:48.000000000 -0700
@@ -71,8 +71,6 @@

 extern int xfs_acl_inherit(struct vnode *, struct vattr *, xfs_acl_t *);
 extern int xfs_acl_iaccess(struct xfs_inode *, mode_t, cred_t *);
-extern int xfs_acl_get(struct vnode *, xfs_acl_t *, xfs_acl_t *);
-extern int xfs_acl_set(struct vnode *, xfs_acl_t *, xfs_acl_t *);
 extern int xfs_acl_vtoacl(struct vnode *, xfs_acl_t *, xfs_acl_t *);
 extern int xfs_acl_vhasacl_access(struct vnode *);
 extern int xfs_acl_vhasacl_default(struct vnode *);
diff -ru linux-2.6.7-orig/fs/xfs/xfs_attr_leaf.h linux-2.6.7-new/fs/xfs/xfs_attr_leaf.h
--- linux-2.6.7-orig/fs/xfs/xfs_attr_leaf.h     2004-06-15 22:18:37.000000000 -0700
+++ linux-2.6.7-new/fs/xfs/xfs_attr_leaf.h      2004-07-18 08:39:17.000000000 -0700
@@ -246,7 +246,6 @@
 int    xfs_attr_shortform_to_leaf(struct xfs_da_args *args);
 int    xfs_attr_shortform_remove(struct xfs_da_args *remove);
 int    xfs_attr_shortform_list(struct xfs_attr_list_context *context);
-int    xfs_attr_shortform_replace(struct xfs_da_args *args);
 int    xfs_attr_shortform_allfit(struct xfs_dabuf *bp, struct xfs_inode *dp);

 /*
diff -ru linux-2.6.7-orig/fs/xfs/xfs_bmap_btree.h linux-2.6.7-new/fs/xfs/xfs_bmap_btree.h
--- linux-2.6.7-orig/fs/xfs/xfs_bmap_btree.h    2004-06-15 22:19:23.000000000 -0700
+++ linux-2.6.7-new/fs/xfs/xfs_bmap_btree.h     2004-07-18 08:36:18.000000000 -0700
@@ -551,13 +551,6 @@
        struct xfs_btree_cur *,
        int *);

-int
-xfs_bmbt_insert_many(
-       struct xfs_btree_cur *,
-       int,
-       xfs_bmbt_rec_t *,
-       int *);
-
 void
 xfs_bmbt_log_block(
        struct xfs_btree_cur *,
diff -ru linux-2.6.7-orig/fs/xfs/xfs_inode.h linux-2.6.7-new/fs/xfs/xfs_inode.h
--- linux-2.6.7-orig/fs/xfs/xfs_inode.h 2004-06-15 22:19:43.000000000 -0700
+++ linux-2.6.7-new/fs/xfs/xfs_inode.h  2004-07-18 08:38:39.000000000 -0700
@@ -508,7 +508,6 @@
 uint           xfs_dic2xflags(struct xfs_dinode_core *, xfs_arch_t);
 int            xfs_ifree(struct xfs_trans *, xfs_inode_t *,
                           struct xfs_bmap_free *);
-int            xfs_atruncate_start(xfs_inode_t *);
 void           xfs_itruncate_start(xfs_inode_t *, uint, xfs_fsize_t);
 int            xfs_itruncate_finish(struct xfs_trans **, xfs_inode_t *,
                                     xfs_fsize_t, int, int);
diff -ru linux-2.6.7-orig/fs/xfs/xfs_log_priv.h linux-2.6.7-new/fs/xfs/xfs_log_priv.h
--- linux-2.6.7-orig/fs/xfs/xfs_log_priv.h      2004-06-15 22:18:58.000000000 -0700
+++ linux-2.6.7-new/fs/xfs/xfs_log_priv.h       2004-07-18 08:35:15.000000000 -0700
@@ -543,7 +543,6 @@
                                xfs_daddr_t *head_blk,
                                xfs_daddr_t *tail_blk,
                                int readonly);
-extern int      xlog_print_find_oldest(xlog_t *log, xfs_daddr_t *last_blk);
 extern int      xlog_recover(xlog_t *log, int readonly);
 extern int      xlog_recover_finish(xlog_t *log, int mfsi_flags);
 extern void     xlog_pack_data(xlog_t *log, xlog_in_core_t *iclog);

