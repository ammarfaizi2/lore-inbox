Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbULPAck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbULPAck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbULPAX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:23:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:56483 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262546AbULPANP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:13:15 -0500
Date: Thu, 16 Dec 2004 01:23:41 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 12/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_inode.c
Message-ID: <Pine.LNX.4.61.0412160122370.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_inode.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_inode.c	2004-10-18 23:55:28.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_inode.c	2004-12-15 22:57:15.000000000 +0100
@@ -1778,7 +1778,7 @@ xfs_itruncate_finish(
 		xfs_trans_ijoin(ntp, ip, XFS_ILOCK_EXCL | XFS_IOLOCK_EXCL);
 		xfs_trans_ihold(ntp, ip);
 		if (error)
-			return (error);
+			return error;
 	}
 	/*
 	 * Only update the size in the case of the data fork, but
@@ -3786,7 +3786,7 @@ xfs_iroundup(
 			return v + 1;
 	}
 	ASSERT(0);
-	return( 0 );
+	return 0;
 }
 
 /*



