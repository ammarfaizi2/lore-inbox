Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVDLKwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVDLKwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVDLKva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:51:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:35274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262264AbVDLKdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:19 -0400
Message-Id: <200504121033.j3CAXAoK005797@shell0.pdx.osdl.net>
Subject: [patch 160/198] IB: Trivial FMR printk cleanup
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, libor@topspin.com,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Libor Michalek <libor@topspin.com>

Add missing newline in printk.

Signed-off-by: Libor Michalek <libor@topspin.com>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/core/fmr_pool.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/infiniband/core/fmr_pool.c~ib-trivial-fmr-printk-cleanup drivers/infiniband/core/fmr_pool.c
--- 25/drivers/infiniband/core/fmr_pool.c~ib-trivial-fmr-printk-cleanup	2005-04-12 03:21:41.753789360 -0700
+++ 25-akpm/drivers/infiniband/core/fmr_pool.c	2005-04-12 03:21:41.756788904 -0700
@@ -442,7 +442,7 @@ struct ib_pool_fmr *ib_fmr_pool_map_phys
 		list_add(&fmr->list, &pool->free_list);
 		spin_unlock_irqrestore(&pool->pool_lock, flags);
 
-		printk(KERN_WARNING "fmr_map returns %d",
+		printk(KERN_WARNING "fmr_map returns %d\n",
 		       result);
 
 		return ERR_PTR(result);
_
