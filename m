Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVDBWux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVDBWux (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVDBWuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:50:52 -0500
Received: from mail.dif.dk ([193.138.115.101]:46754 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261310AbVDBWtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:49:35 -0500
Date: Sun, 3 Apr 2005 00:51:52 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][1/7] cifs: dir.c cleanup - function defs
Message-ID: <Pine.LNX.4.62.0504030050410.2525@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whitespace cleanups of function definitions in fs/cifs/dir.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4-orig/fs/cifs/dir.c	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.12-rc1-mm4/fs/cifs/dir.c	2005-04-02 23:28:28.000000000 +0200
@@ -31,8 +31,7 @@
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
 
-void
-renew_parental_timestamps(struct dentry *direntry)
+void renew_parental_timestamps(struct dentry *direntry)
 {
 	/* BB check if there is a way to get the kernel to do this or if we really need this */
 	do {
@@ -42,8 +41,7 @@ renew_parental_timestamps(struct dentry 
 }
 
 /* Note: caller must free return buffer */
-char *
-build_path_from_dentry(struct dentry *direntry)
+char *build_path_from_dentry(struct dentry *direntry)
 {
 	struct dentry *temp;
 	int namelen = 0;
@@ -102,8 +100,7 @@ cifs_bp_rename_retry:
 }
 
 /* Note: caller must free return buffer */
-char *
-build_wildcard_path_from_dentry(struct dentry *direntry)
+char *build_wildcard_path_from_dentry(struct dentry *direntry)
 {
 	struct dentry *temp;
 	int namelen = 0;
@@ -165,10 +162,8 @@ cifs_bwp_rename_retry:
 }
 
 /* Inode operations in similar order to how they appear in the Linux file fs.h */
-
-int
-cifs_create(struct inode *inode, struct dentry *direntry, int mode,
-		struct nameidata *nd)
+int cifs_create(struct inode *inode, struct dentry *direntry, int mode,
+	struct nameidata *nd)
 {
 	int rc = -ENOENT;
 	int xid;
@@ -332,7 +327,8 @@ cifs_create(struct inode *inode, struct 
 	return rc;
 }
 
-int cifs_mknod(struct inode *inode, struct dentry *direntry, int mode, dev_t device_number) 
+int cifs_mknod(struct inode *inode, struct dentry *direntry, int mode,
+	dev_t device_number) 
 {
 	int rc = -EPERM;
 	int xid;
@@ -382,9 +378,8 @@ int cifs_mknod(struct inode *inode, stru
 	return rc;
 }
 
-
-struct dentry *
-cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry, struct nameidata *nd)
+struct dentry *cifs_lookup(struct inode *parent_dir_inode,
+	struct dentry *direntry, struct nameidata *nd)
 {
 	int xid;
 	int rc = 0; /* to get around spurious gcc warning, set to zero here */
@@ -453,9 +448,9 @@ cifs_lookup(struct inode *parent_dir_ino
 	return ERR_PTR(rc);
 }
 
-int
-cifs_dir_open(struct inode *inode, struct file *file)
-{				/* NB: currently unused since searches are opened in readdir */
+int cifs_dir_open(struct inode *inode, struct file *file)
+{
+/* NB: currently unused since searches are opened in readdir */
 	int rc = 0;
 	int xid;
 	struct cifs_sb_info *cifs_sb;
@@ -484,8 +479,7 @@ cifs_dir_open(struct inode *inode, struc
 	return rc;
 }
 
-static int
-cifs_d_revalidate(struct dentry *direntry, struct nameidata *nd)
+static int cifs_d_revalidate(struct dentry *direntry, struct nameidata *nd)
 {
 	int isValid = 1;
 
