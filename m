Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbULOX4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbULOX4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbULOX4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:56:37 -0500
Received: from mail.dif.dk ([193.138.115.101]:64418 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262534AbULOX43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:56:29 -0500
Date: Thu, 16 Dec 2004 01:06:58 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 2/30] return statement cleanup - kill pointless parentheses
 in fs/efs/namei.c
Message-ID: <Pine.LNX.4.61.0412160105450.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/efs/namei.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/efs/namei.c	2004-12-06 22:24:43.000000000 +0100
+++ linux-2.6.10-rc3-bk8/fs/efs/namei.c	2004-12-15 22:31:45.000000000 +0100
@@ -37,7 +37,7 @@ static efs_ino_t efs_find_entry(struct i
 		if (be16_to_cpu(dirblock->magic) != EFS_DIRBLK_MAGIC) {
 			printk(KERN_ERR "EFS: find_entry(): invalid directory block\n");
 			brelse(bh);
-			return(0);
+			return 0;
 		}
 
 		for(slot = 0; slot < dirblock->slots; slot++) {
@@ -49,12 +49,12 @@ static efs_ino_t efs_find_entry(struct i
 			if ((namelen == len) && (!memcmp(name, nameptr, len))) {
 				inodenum = be32_to_cpu(dirslot->inode);
 				brelse(bh);
-				return(inodenum);
+				return inodenum;
 			}
 		}
 		brelse(bh);
 	}
-	return(0);
+	return 0;
 }
 
 struct dentry *efs_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd) {


