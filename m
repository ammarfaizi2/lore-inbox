Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVBSAYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVBSAYB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVBSAX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:23:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51460 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261582AbVBSARj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:17:39 -0500
Date: Sat, 19 Feb 2005 01:17:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/slhc.c: remove 2 functions
Message-ID: <20050219001733.GM4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes two unused global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/slhc.c    |   27 ---------------------------
 include/net/slhc_vj.h |    3 ---
 2 files changed, 30 deletions(-)

--- linux-2.6.11-rc3-mm2-full/include/net/slhc_vj.h.old	2005-02-16 18:43:00.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/include/net/slhc_vj.h	2005-02-16 18:43:49.000000000 +0100
@@ -185,7 +185,4 @@
 			  int isize));
 int slhc_toss __ARGS((struct slcompress *comp));
 
-void slhc_i_status __ARGS((struct slcompress *comp));
-void slhc_o_status __ARGS((struct slcompress *comp));
-
 #endif	/* _SLHC_H */
--- linux-2.6.11-rc3-mm2-full/drivers/net/slhc.c.old	2005-02-16 18:43:15.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/slhc.c	2005-02-16 18:43:40.000000000 +0100
@@ -693,33 +693,6 @@
 }
 
 
-void slhc_i_status(struct slcompress *comp)
-{
-	if (comp != NULLSLCOMPR) {
-		printk("\t%d Cmp, %d Uncmp, %d Bad, %d Tossed\n",
-			comp->sls_i_compressed,
-			comp->sls_i_uncompressed,
-			comp->sls_i_error,
-			comp->sls_i_tossed);
-	}
-}
-
-
-void slhc_o_status(struct slcompress *comp)
-{
-	if (comp != NULLSLCOMPR) {
-		printk("\t%d Cmp, %d Uncmp, %d AsIs, %d NotTCP\n",
-			comp->sls_o_compressed,
-			comp->sls_o_uncompressed,
-			comp->sls_o_tcp,
-			comp->sls_o_nontcp);
-		printk("\t%10d Searches, %10d Misses\n",
-			comp->sls_o_searches,
-			comp->sls_o_misses);
-	}
-}
-
-/* Should this be surrounded with "#ifdef CONFIG_MODULES" ? */
 /* VJ header compression */
 EXPORT_SYMBOL(slhc_init);
 EXPORT_SYMBOL(slhc_free);

