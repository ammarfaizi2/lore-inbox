Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVFWHf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVFWHf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVFWHbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:31:51 -0400
Received: from [24.22.56.4] ([24.22.56.4]:15078 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262278AbVFWGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:42 -0400
Message-Id: <20050623061801.877982000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:30 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 38/38] CKRM e18: Delete target file from tc_magic.c
Content-Disposition: inline; filename=target_fileops_fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to delete target file from tc_magic.c.

Signed-Off-By:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By:  Gerrit Huizenga <gh@us.ibm.com>

Index: linux-2.6.12-ckrm2/fs/rcfs/tc_magic.c
===================================================================
--- linux-2.6.12-ckrm2.orig/fs/rcfs/tc_magic.c	2005-06-20 16:45:27.000000000 -0700
+++ linux-2.6.12-ckrm2/fs/rcfs/tc_magic.c	2005-06-21 16:52:26.000000000 -0700
@@ -44,12 +44,6 @@ struct rcfs_magf tc_rootdesc[] = {
 	 },
 	/* Rest are root's magic files */
 	{
-	 .name = "target",
-	 .mode = TC_FILE_MODE,
-	 .i_fop = &target_fileops,
-	 .i_op = &rcfs_file_inode_operations,
-	 },
-	{
 	 .name = "members",
 	 .mode = TC_FILE_MODE,
 	 .i_fop = &members_fileops,
Index: linux-2.6.12-ckrm2/include/linux/rcfs.h
===================================================================
--- linux-2.6.12-ckrm2.orig/include/linux/rcfs.h	2005-06-20 16:45:27.000000000 -0700
+++ linux-2.6.12-ckrm2/include/linux/rcfs.h	2005-06-21 16:52:26.000000000 -0700
@@ -73,7 +73,6 @@ extern struct inode_operations rcfs_dir_
 extern struct inode_operations rcfs_rootdir_inode_operations;
 extern struct inode_operations rcfs_file_inode_operations;
 
-extern struct file_operations target_fileops;
 extern struct file_operations shares_fileops;
 extern struct file_operations stats_fileops;
 extern struct file_operations config_fileops;

--
