Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVCOOtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVCOOtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVCOOtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:49:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47887 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261290AbVCOOtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:49:09 -0500
Date: Tue, 15 Mar 2005 15:49:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Robert Olsson <robert.olsson@its.uu.se>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/core/pktgen.c: make a function static
Message-ID: <20050315144907.GN3189@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pktgen_xmit is already inline but not static.

This doesn't make much sense - especially since there's no external user 
of this function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3-full/net/core/pktgen.c.old	2005-03-15 13:25:04.000000000 +0100
+++ linux-2.6.11-mm3-full/net/core/pktgen.c	2005-03-15 13:25:20.000000000 +0100
@@ -2587,7 +2587,7 @@
         thread_unlock();
 }
 
-__inline__ void pktgen_xmit(struct pktgen_dev *pkt_dev)
+static inline void pktgen_xmit(struct pktgen_dev *pkt_dev)
 {
 	struct net_device *odev = NULL;
 	__u64 idle_start = 0;

