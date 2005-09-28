Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVI1HMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVI1HMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbVI1HMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:12:43 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:23939 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030198AbVI1HMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:12:42 -0400
Date: Wed, 28 Sep 2005 09:12:05 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/7] HPET: remove unused variable
In-reply-to: <20050928071155.23025.43523.balrog@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20050928071205.23025.49235.balrog@turing>
Content-transfer-encoding: 7BIT
References: <20050928071155.23025.43523.balrog@turing>
X-Scan-Signature: b60a4fd9f15a2178650dbc7e1e141b14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The variable hpet_ntimer is never read, so remove it.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-09-27 21:39:43.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-09-27 21:42:12.000000000 +0200
@@ -49,7 +49,7 @@
 #define	HPET_USER_FREQ	(64)
 #define	HPET_DRIFT	(500)
 
-static u32 hpet_ntimer, hpet_nhpet, hpet_max_freq = HPET_USER_FREQ;
+static u32 hpet_nhpet, hpet_max_freq = HPET_USER_FREQ;
 
 /* A lock for concurrent access by app and isr hpet activity. */
 static DEFINE_SPINLOCK(hpet_lock);
@@ -854,8 +854,7 @@ int hpet_alloc(struct hpet_data *hdp)
 		writeq(mcfg, &hpet->hpet_config);
 	}
 
-	for (i = 0, devp = hpetp->hp_dev; i < hpetp->hp_ntimer;
-	     i++, hpet_ntimer++, devp++) {
+	for (i = 0, devp = hpetp->hp_dev; i < hpetp->hp_ntimer; i++, devp++) {
 		unsigned long v;
 		struct hpet_timer __iomem *timer;
 
