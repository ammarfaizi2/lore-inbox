Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVCZN4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVCZN4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 08:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCZN4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 08:56:25 -0500
Received: from mail.dif.dk ([193.138.115.101]:39828 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262071AbVCZNzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 08:55:53 -0500
Date: Sat, 26 Mar 2005 14:57:52 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][1/6] cifs: inode.c cleanup - function definitions (whitespace
 changes only)
Message-ID: <Pine.LNX.4.62.0503261456390.2488@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up function definitione. Return value on same line as function name,
consistent spacing between arguments, etc.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3-orig/fs/cifs/inode.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/inode.c	2005-03-26 00:33:52.000000000 +0100
@@ -30,10 +30,8 @@
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
 
-int
-cifs_get_inode_info_unix(struct inode **pinode,
-			 const unsigned char *search_path,
-			 struct super_block *sb,int xid)
+int cifs_get_inode_info_unix(struct inode **pinode,
+	const unsigned char *search_path, struct super_block *sb, int xid)
 {
 	int rc = 0;
 	FILE_UNIX_BASIC_INFO findData;
@@ -182,9 +180,9 @@ cifs_get_inode_info_unix(struct inode **
 	return rc;
 }
 
-int
-cifs_get_inode_info(struct inode **pinode, const unsigned char *search_path, 
-		FILE_ALL_INFO * pfindData, struct super_block *sb, int xid)
+int cifs_get_inode_info(struct inode **pinode,
+	const unsigned char *search_path, FILE_ALL_INFO *pfindData,
+	struct super_block *sb, int xid)
 {
 	int rc = 0;
 	struct cifsTconInfo *pTcon;
@@ -353,8 +351,7 @@ cifs_get_inode_info(struct inode **pinod
 	return rc;
 }
 
-void
-cifs_read_inode(struct inode *inode)
+void cifs_read_inode(struct inode *inode)
 {				/* gets root inode */
 	int xid;
 	struct cifs_sb_info *cifs_sb;
@@ -369,8 +366,7 @@ cifs_read_inode(struct inode *inode)
 	_FreeXid(xid);
 }
 
-int
-cifs_unlink(struct inode *inode, struct dentry *direntry)
+int cifs_unlink(struct inode *inode, struct dentry *direntry)
 {
 	int rc = 0;
 	int xid;
@@ -489,8 +485,7 @@ cifs_unlink(struct inode *inode, struct 
 	return rc;
 }
 
-int
-cifs_mkdir(struct inode *inode, struct dentry *direntry, int mode)
+int cifs_mkdir(struct inode *inode, struct dentry *direntry, int mode)
 {
 	int rc = 0;
 	int xid;
@@ -556,8 +551,7 @@ cifs_mkdir(struct inode *inode, struct d
 	return rc;
 }
 
-int
-cifs_rmdir(struct inode *inode, struct dentry *direntry)
+int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 {
 	int rc = 0;
 	int xid;
@@ -600,9 +594,8 @@ cifs_rmdir(struct inode *inode, struct d
 	return rc;
 }
 
-int
-cifs_rename(struct inode *source_inode, struct dentry *source_direntry,
-	    struct inode *target_inode, struct dentry *target_direntry)
+int cifs_rename(struct inode *source_inode, struct dentry *source_direntry,
+	struct inode *target_inode, struct dentry *target_direntry)
 {
 	char *fromName;
 	char *toName;
@@ -702,8 +695,7 @@ cifs_rename_exit:
 	return rc;
 }
 
-int
-cifs_revalidate(struct dentry *direntry)
+int cifs_revalidate(struct dentry *direntry)
 {
 	int xid;
 	int rc = 0;
@@ -826,7 +818,8 @@ cifs_revalidate(struct dentry *direntry)
 	return rc;
 }
 
-int cifs_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
+int cifs_getattr(struct vfsmount *mnt, struct dentry *dentry,
+	struct kstat *stat)
 {
 	int err = cifs_revalidate(dentry);
 	if (!err)
@@ -855,8 +848,7 @@ static int cifs_truncate_page(struct add
 	return rc;
 }
 
-int
-cifs_setattr(struct dentry *direntry, struct iattr *attrs)
+int cifs_setattr(struct dentry *direntry, struct iattr *attrs)
 {
 	int xid;
 	struct cifs_sb_info *cifs_sb;
@@ -1054,8 +1046,7 @@ cifs_setattr(struct dentry *direntry, st
 	return rc;
 }
 
-void
-cifs_delete_inode(struct inode *inode)
+void cifs_delete_inode(struct inode *inode)
 {
 	cFYI(1, ("In cifs_delete_inode, inode = 0x%p ", inode));
 	/* may have to add back in if and when safe distributed caching of

