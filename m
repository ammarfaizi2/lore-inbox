Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbULPAcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbULPAcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbULPAXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:23:33 -0500
Received: from mail.dif.dk ([193.138.115.101]:44195 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262551AbULPAJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:09:05 -0500
Date: Thu, 16 Dec 2004 01:19:29 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 9/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_trans_buf.c
Message-ID: <Pine.LNX.4.61.0412160118300.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_trans_buf.c	2004-10-18 23:53:10.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_trans_buf.c	2004-12-15 22:50:18.000000000 +0100
@@ -89,7 +89,7 @@ xfs_trans_get_buf(xfs_trans_t	*tp,
 	if (tp == NULL) {
 		bp = xfs_buf_get_flags(target_dev, blkno, len,
 							flags | BUF_BUSY);
-		return(bp);
+		return bp;
 	}
 
 	/*
@@ -125,7 +125,7 @@ xfs_trans_get_buf(xfs_trans_t	*tp,
 		bip->bli_recur++;
 		xfs_buftrace("TRANS GET RECUR", bp);
 		xfs_buf_item_trace("GET RECUR", bip);
-		return (bp);
+		return bp;
 	}
 
 	/*
@@ -178,7 +178,7 @@ xfs_trans_get_buf(xfs_trans_t	*tp,
 
 	xfs_buftrace("TRANS GET", bp);
 	xfs_buf_item_trace("GET", bip);
-	return (bp);
+	return bp;
 }
 
 /*
@@ -202,7 +202,7 @@ xfs_trans_getsb(xfs_trans_t	*tp,
 	 * if tp is NULL.
 	 */
 	if (tp == NULL) {
-		return (xfs_getsb(mp, flags));
+		return xfs_getsb(mp, flags);
 	}
 
 	/*
@@ -218,7 +218,7 @@ xfs_trans_getsb(xfs_trans_t	*tp,
 		ASSERT(atomic_read(&bip->bli_refcount) > 0);
 		bip->bli_recur++;
 		xfs_buf_item_trace("GETSB RECUR", bip);
-		return (bp);
+		return bp;
 	}
 
 	bp = xfs_getsb(mp, flags);
@@ -260,7 +260,7 @@ xfs_trans_getsb(xfs_trans_t	*tp,
 	XFS_BUF_SET_FSPRIVATE2(bp, tp);
 
 	xfs_buf_item_trace("GETSB", bip);
-	return (bp);
+	return bp;
 }
 
 #ifdef DEBUG



