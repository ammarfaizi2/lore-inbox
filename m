Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbULPAqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbULPAqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbULPApi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:45:38 -0500
Received: from mail.dif.dk ([193.138.115.101]:24228 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262549AbULPAVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:21:13 -0500
Date: Thu, 16 Dec 2004 01:31:43 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 18/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/xfs_trans_item.c
Message-ID: <Pine.LNX.4.61.0412160130320.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/xfs/xfs_trans_item.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/xfs_trans_item.c	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/xfs_trans_item.c	2004-12-15 23:45:47.000000000 +0100
@@ -93,7 +93,7 @@ xfs_trans_add_item(xfs_trans_t *tp, xfs_
 		lidp->lid_size = 0;
 		lip->li_desc = lidp;
 		lip->li_mountp = tp->t_mountp;
-		return (lidp);
+		return lidp;
 	}
 
 	/*
@@ -134,7 +134,7 @@ xfs_trans_add_item(xfs_trans_t *tp, xfs_
 	lidp->lid_size = 0;
 	lip->li_desc = lidp;
 	lip->li_mountp = tp->t_mountp;
-	return (lidp);
+	return lidp;
 }
 
 /*
@@ -195,7 +195,7 @@ xfs_trans_find_item(xfs_trans_t	*tp, xfs
 {
 	ASSERT(lip->li_desc != NULL);
 
-	return (lip->li_desc);
+	return lip->li_desc;
 }
 
 
@@ -234,10 +234,10 @@ xfs_trans_first_item(xfs_trans_t *tp)
 			continue;
 		}
 
-		return (XFS_LIC_SLOT(licp, i));
+		return XFS_LIC_SLOT(licp, i);
 	}
 	cmn_err(CE_WARN, "xfs_trans_first_item() -- no first item");
-	return(NULL);
+	return NULL;
 }
 
 
@@ -267,7 +267,7 @@ xfs_trans_next_item(xfs_trans_t *tp, xfs
 			continue;
 		}
 
-		return (XFS_LIC_SLOT(licp, i));
+		return XFS_LIC_SLOT(licp, i);
 	}
 
 	/*
@@ -276,7 +276,7 @@ xfs_trans_next_item(xfs_trans_t *tp, xfs
 	 * If there is no next chunk, return NULL.
 	 */
 	if (licp->lic_next == NULL) {
-		return (NULL);
+		return NULL;
 	}
 
 	licp = licp->lic_next;
@@ -286,7 +286,7 @@ xfs_trans_next_item(xfs_trans_t *tp, xfs
 			continue;
 		}
 
-		return (XFS_LIC_SLOT(licp, i));
+		return XFS_LIC_SLOT(licp, i);
 	}
 	ASSERT(0);
 	/* NOTREACHED */
@@ -440,7 +440,7 @@ xfs_trans_unlock_chunk(
 		}
 	}
 
-	return (freed);
+	return freed;
 }
 
 
@@ -493,7 +493,7 @@ xfs_trans_add_busy(xfs_trans_t *tp, xfs_
 		 */
 		lbsp->lbc_ag = ag;
 		lbsp->lbc_idx = idx;
-		return (lbsp);
+		return lbsp;
 	}
 
 	/*
@@ -527,7 +527,7 @@ xfs_trans_add_busy(xfs_trans_t *tp, xfs_
 	tp->t_busy_free--;
 	lbsp->lbc_ag = ag;
 	lbsp->lbc_idx = idx;
-	return (lbsp);
+	return lbsp;
 }
 
 


