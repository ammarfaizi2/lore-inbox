Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbTCZN0I>; Wed, 26 Mar 2003 08:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbTCZN0I>; Wed, 26 Mar 2003 08:26:08 -0500
Received: from p508ECF24.dip.t-dialin.net ([80.142.207.36]:5250 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id <S261683AbTCZN0H>;
	Wed, 26 Mar 2003 08:26:07 -0500
Date: Wed, 26 Mar 2003 14:37:18 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Patch to shut up pppoe warnings
Message-ID: <20030326133717.GA26668@oscar.ping.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch removes a warning printk for pppoe.
This is not a fix, but it's flooding my syslog. Maybe
someone could look into this.

Patch is against BK current.

Patrick

--- ./bk-2.5/net/core/dev.c	2003-03-25 18:26:05.000000000 +0100
+++ ./test-2.5/net/core/dev.c	2003-03-25 23:00:55.000000000 +0100
@@ -1368,8 +1368,10 @@
 #if CONFIG_SMP
 	/* Old protocols did not depened on BHs different of NET_BH and
 	   TIMER_BH - they need to be fixed for the new assumptions.
-	 */
+	   This needs to be fixed for pppoe. I don't now how.
+
 	print_symbol("fix old protocol handler %s!\n", (unsigned long)pt->func);
+	 */
 #endif
 	ret = pt->func(skb, skb->dev, pt);
 out:
