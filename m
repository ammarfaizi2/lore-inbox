Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVGLU1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVGLU1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVGLU1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:27:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16904 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262372AbVGLU1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:27:35 -0400
Date: Tue, 12 Jul 2005 22:27:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-net@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, Baruch Even <baruch@ev-en.org>
Subject: [2.6 patch] Spelling mistakes threshoulds -> thresholds
Message-ID: <20050712202732.GI4034@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just imple spelling mistake fixes.

Signed-Off-By: Baruch Even <baruch@ev-en.org>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Baruch Even on:
- 05 Apr 2005

--- 2.6.11.orig/include/net/tcp.h	2005-03-16 00:09:00.000000000 +0000
+++ 2.6.11/include/net/tcp.h	2005-04-05 14:33:13.473828484 +0100
@@ -1351,7 +1351,7 @@ static inline void tcp_cwnd_validate(str
 	}
 }
 
-/* Set slow start threshould and cwnd not falling to slow start */
+/* Set slow start threshold and cwnd not falling to slow start */
 static inline void __tcp_enter_cwr(struct tcp_sock *tp)
 {
 	tp->undo_marker = 0;
diff -Nurp -X dontdiff 2.6.11.orig/net/ipv4/ipmr.c 2.6.11/net/ipv4/ipmr.c
--- 2.6.11.orig/net/ipv4/ipmr.c	2005-03-16 00:09:06.000000000 +0000
+++ 2.6.11/net/ipv4/ipmr.c	2005-04-05 14:33:13.541817170 +0100
@@ -359,7 +359,7 @@ out:
 
 /* Fill oifs list. It is called under write locked mrt_lock. */
 
-static void ipmr_update_threshoulds(struct mfc_cache *cache, unsigned char *ttls)
+static void ipmr_update_thresholds(struct mfc_cache *cache, unsigned char *ttls)
 {
 	int vifi;
 
@@ -721,7 +721,7 @@ static int ipmr_mfc_add(struct mfcctl *m
 	if (c != NULL) {
 		write_lock_bh(&mrt_lock);
 		c->mfc_parent = mfc->mfcc_parent;
-		ipmr_update_threshoulds(c, mfc->mfcc_ttls);
+		ipmr_update_thresholds(c, mfc->mfcc_ttls);
 		if (!mrtsock)
 			c->mfc_flags |= MFC_STATIC;
 		write_unlock_bh(&mrt_lock);
@@ -738,7 +738,7 @@ static int ipmr_mfc_add(struct mfcctl *m
 	c->mfc_origin=mfc->mfcc_origin.s_addr;
 	c->mfc_mcastgrp=mfc->mfcc_mcastgrp.s_addr;
 	c->mfc_parent=mfc->mfcc_parent;
-	ipmr_update_threshoulds(c, mfc->mfcc_ttls);
+	ipmr_update_thresholds(c, mfc->mfcc_ttls);
 	if (!mrtsock)
 		c->mfc_flags |= MFC_STATIC;
 


