Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVHWUYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVHWUYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVHWUYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:24:44 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:32262 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932370AbVHWUYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:24:44 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 23 Aug 2005 22:22:24 +0200)
Subject: [PATCH 1/8] remove ia_attr_flags
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:24:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused ia_attr_flags from struct iattr, and related defines.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/hostfs/hostfs.h
===================================================================
--- linux.orig/fs/hostfs/hostfs.h	2005-08-19 14:13:47.000000000 +0200
+++ linux/fs/hostfs/hostfs.h	2005-08-19 15:01:48.000000000 +0200
@@ -49,7 +49,6 @@ struct hostfs_iattr {
 	struct timespec	ia_atime;
 	struct timespec	ia_mtime;
 	struct timespec	ia_ctime;
-	unsigned int	ia_attr_flags;
 };
 
 extern int stat_file(const char *path, unsigned long long *inode_out,
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-08-19 14:58:53.000000000 +0200
+++ linux/include/linux/fs.h	2005-08-19 15:01:06.000000000 +0200
@@ -283,19 +283,9 @@ struct iattr {
 	struct timespec	ia_atime;
 	struct timespec	ia_mtime;
 	struct timespec	ia_ctime;
-	unsigned int	ia_attr_flags;
 };
 
 /*
- * This is the inode attributes flag definitions
- */
-#define ATTR_FLAG_SYNCRONOUS	1 	/* Syncronous write */
-#define ATTR_FLAG_NOATIME	2 	/* Don't update atime */
-#define ATTR_FLAG_APPEND	4 	/* Append-only file */
-#define ATTR_FLAG_IMMUTABLE	8 	/* Immutable file */
-#define ATTR_FLAG_NODIRATIME	16 	/* Don't update atime for directory */
-
-/*
  * Includes for diskquotas.
  */
 #include <linux/quota.h>
