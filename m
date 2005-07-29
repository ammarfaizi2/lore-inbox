Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVG2KXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVG2KXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVG2KXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:23:33 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:20643
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S262571AbVG2KWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:22:05 -0400
Message-ID: <42EA0346.8070703@ev-en.org>
Date: Fri, 29 Jul 2005 11:21:58 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
Cc: bunk@stusta.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net: Spelling mistakes threshoulds -> thresholds
References: <20050728220410.GG4790@stusta.de> <20050728.203021.35467760.davem@davemloft.net>
In-Reply-To: <20050728.203021.35467760.davem@davemloft.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------040001040802060706010407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040001040802060706010407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Just simple spelling mistake fixes.

Signed-Off-By: Baruch Even <baruch@ev-en.org>


--------------040001040802060706010407
Content-Type: text/plain;
 name="threshould.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="threshould.diff"

diff -Nurp 2.6.13-rc4-orig/include/net/tcp.h 2.6.13-rc4/include/net/tcp.h
--- 2.6.13-rc4-orig/include/net/tcp.h	2005-07-29 11:17:25.000000000 +0100
+++ 2.6.13-rc4/include/net/tcp.h	2005-07-29 11:14:28.000000000 +0100
@@ -1236,7 +1236,7 @@ static inline void tcp_sync_left_out(str
 	tp->left_out = tp->sacked_out + tp->lost_out;
 }
 
-/* Set slow start threshould and cwnd not falling to slow start */
+/* Set slow start threshold and cwnd not falling to slow start */
 static inline void __tcp_enter_cwr(struct tcp_sock *tp)
 {
 	tp->undo_marker = 0;
diff -Nurp 2.6.13-rc4-orig/net/ipv4/ipmr.c 2.6.13-rc4/net/ipv4/ipmr.c
--- 2.6.13-rc4-orig/net/ipv4/ipmr.c	2005-07-29 11:17:25.000000000 +0100
+++ 2.6.13-rc4/net/ipv4/ipmr.c	2005-07-29 11:14:28.000000000 +0100
@@ -362,7 +362,7 @@ out:
 
 /* Fill oifs list. It is called under write locked mrt_lock. */
 
-static void ipmr_update_threshoulds(struct mfc_cache *cache, unsigned char *ttls)
+static void ipmr_update_thresholds(struct mfc_cache *cache, unsigned char *ttls)
 {
 	int vifi;
 
@@ -727,7 +727,7 @@ static int ipmr_mfc_add(struct mfcctl *m
 	if (c != NULL) {
 		write_lock_bh(&mrt_lock);
 		c->mfc_parent = mfc->mfcc_parent;
-		ipmr_update_threshoulds(c, mfc->mfcc_ttls);
+		ipmr_update_thresholds(c, mfc->mfcc_ttls);
 		if (!mrtsock)
 			c->mfc_flags |= MFC_STATIC;
 		write_unlock_bh(&mrt_lock);
@@ -744,7 +744,7 @@ static int ipmr_mfc_add(struct mfcctl *m
 	c->mfc_origin=mfc->mfcc_origin.s_addr;
 	c->mfc_mcastgrp=mfc->mfcc_mcastgrp.s_addr;
 	c->mfc_parent=mfc->mfcc_parent;
-	ipmr_update_threshoulds(c, mfc->mfcc_ttls);
+	ipmr_update_thresholds(c, mfc->mfcc_ttls);
 	if (!mrtsock)
 		c->mfc_flags |= MFC_STATIC;
 

--------------040001040802060706010407--
