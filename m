Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVDENgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVDENgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 09:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDENgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 09:36:39 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:56476
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261542AbVDENgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 09:36:35 -0400
Message-ID: <4252945A.40904@ev-en.org>
Date: Tue, 05 Apr 2005 14:36:26 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Spelling mistake threshoulds -> thresholds
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090802050303050700050602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090802050303050700050602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Just a simple spelling mistake fix.

Signed-Off-By: Baruch Even <baruch@ev-en.org>

--------------090802050303050700050602
Content-Type: text/x-patch;
 name="spelling_threshold.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spelling_threshold.patch"

diff -Nurp -X dontdiff 2.6.11.orig/include/net/tcp.h 2.6.11/include/net/tcp.h
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
 

--------------090802050303050700050602--
