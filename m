Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270110AbTGPD6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 23:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270112AbTGPD6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 23:58:38 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:55903 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S270110AbTGPD6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 23:58:37 -0400
Date: Tue, 15 Jul 2003 21:13:26 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] [RESEND] fs/nfs/dir.c trivial debugging fix
Message-ID: <20030715211326.C9016@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.69/fs/nfs/dir.c.orig	Sun Jun  1 23:25:24 2003
+++ linux-2.5.69/fs/nfs/dir.c	Sun Jun  1 23:26:29 2003
@@ -794,7 +794,7 @@
 	struct nfs_fh fhandle;
 	int error;
 
-	dfprintk(VFS, "NFS: create(%s/%ld, %s\n", dir->i_sb->s_id, 
+	dfprintk(VFS, "NFS: create(%s/%ld, %s)\n", dir->i_sb->s_id, 
 		dir->i_ino, dentry->d_name.name);
 
 	attr.ia_mode = mode;
@@ -829,7 +829,7 @@
 	struct nfs_fh fhandle;
 	int error;
 
-	dfprintk(VFS, "NFS: mknod(%s/%ld, %s\n", dir->i_sb->s_id,
+	dfprintk(VFS, "NFS: mknod(%s/%ld, %s)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name);
 
 	attr.ia_mode = mode;
@@ -857,7 +857,7 @@
 	struct nfs_fh fhandle;
 	int error;
 
-	dfprintk(VFS, "NFS: mkdir(%s/%ld, %s\n", dir->i_sb->s_id,
+	dfprintk(VFS, "NFS: mkdir(%s/%ld, %s)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name);
 
 	attr.ia_valid = ATTR_MODE;
@@ -888,7 +888,7 @@
 {
 	int error;
 
-	dfprintk(VFS, "NFS: rmdir(%s/%ld, %s\n", dir->i_sb->s_id,
+	dfprintk(VFS, "NFS: rmdir(%s/%ld, %s)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry->d_name.name);
 
 	lock_kernel();
