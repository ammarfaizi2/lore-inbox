Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTI1Xem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbTI1XeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:34:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46318 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262788AbTI1X35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:29:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 01:29:52 +0200 (MEST)
Message-Id: <UTC200309282329.h8SNTq101060.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] freevxfs sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
--- a/fs/freevxfs/vxfs_immed.c	Mon Sep 29 01:05:41 2003
+++ b/fs/freevxfs/vxfs_immed.c	Mon Sep 29 01:12:16 2003
@@ -39,7 +39,7 @@
 #include "vxfs_inode.h"
 
 
-static int	vxfs_immed_readlink(struct dentry *, char *, int);
+static int	vxfs_immed_readlink(struct dentry *, char __user *, int);
 static int	vxfs_immed_follow_link(struct dentry *, struct nameidata *);
 
 static int	vxfs_immed_readpage(struct file *, struct page *);
@@ -77,7 +77,7 @@
  *   Number of bytes successfully copied to userspace.
  */
 static int
-vxfs_immed_readlink(struct dentry *dp, char *bp, int buflen)
+vxfs_immed_readlink(struct dentry *dp, char __user *bp, int buflen)
 {
 	struct vxfs_inode_info		*vip = VXFS_INO(dp->d_inode);
 
