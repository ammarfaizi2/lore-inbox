Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbULPBxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbULPBxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbULPAyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:54:21 -0500
Received: from mail.dif.dk ([193.138.115.101]:30116 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262550AbULPAXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:23:00 -0500
Date: Thu, 16 Dec 2004 01:33:29 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 19/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/linux-2.6/xfs_buf.c
Message-ID: <Pine.LNX.4.61.0412160132120.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/linux-2.6/xfs_buf.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/linux-2.6/xfs_buf.c	2004-10-18 23:53:07.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/linux-2.6/xfs_buf.c	2004-12-15 23:47:26.000000000 +0100
@@ -538,7 +538,7 @@ _pagebuf_find(				/* find buffer for blo
 	}
 
 	spin_unlock(&h->pb_hash_lock);
-	return (new_pb);
+	return new_pb;
 
 found:
 	spin_unlock(&h->pb_hash_lock);
@@ -564,7 +564,7 @@ found:
 
 			pagebuf_rele(pb);
 			XFS_STATS_INC(pb_busy_locked);
-			return (NULL);
+			return NULL;
 		}
 	} else {
 		/* trylock worked */
@@ -575,7 +575,7 @@ found:
 		pb->pb_flags &= PBF_MAPPED;
 	PB_TRACE(pb, "got_lock", 0);
 	XFS_STATS_INC(pb_get_locked);
-	return (pb);
+	return pb;
 }
 
 
@@ -941,7 +941,7 @@ pagebuf_cond_lock(			/* lock buffer, if 
 		PB_SET_OWNER(pb);
 	}
 	PB_TRACE(pb, "cond_lock", (long)locked);
-	return(locked ? 0 : -EBUSY);
+	return locked ? 0 : -EBUSY;
 }
 
 /*
@@ -953,7 +953,7 @@ int
 pagebuf_lock_value(
 	xfs_buf_t		*pb)
 {
-	return(atomic_read(&pb->pb_sema.count));
+	return atomic_read(&pb->pb_sema.count);
 }
 
 /*



