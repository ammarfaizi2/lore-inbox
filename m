Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbULOX7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbULOX7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbULOX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:59:40 -0500
Received: from mail.dif.dk ([193.138.115.101]:7587 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262527AbULOX7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:59:00 -0500
Date: Thu, 16 Dec 2004 01:09:30 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 4/30] return statement cleanup - kill pointless parentheses
 in fs/efs/inode.c
Message-ID: <Pine.LNX.4.61.0412160108260.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/efs/inode.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/efs/super.c	2004-12-06 22:24:43.000000000 +0100
+++ linux-2.6.10-rc3-bk8/fs/efs/super.c	2004-12-15 22:32:39.000000000 +0100
@@ -202,12 +202,13 @@ static efs_block_t efs_validate_vh(struc
 			sblock);
 #endif
 	}
-	return(sblock);
+	return sblock;
 }
 
 static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
 
-	if (!IS_EFS_MAGIC(be32_to_cpu(super->fs_magic))) return -1;
+	if (!IS_EFS_MAGIC(be32_to_cpu(super->fs_magic)))
+		return -1;
 
 	sb->fs_magic     = be32_to_cpu(super->fs_magic);
 	sb->total_blocks = be32_to_cpu(super->fs_size);


