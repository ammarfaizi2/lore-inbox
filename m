Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbTECO3F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263327AbTECO3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:29:04 -0400
Received: from [203.145.184.221] ([203.145.184.221]:11282 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263323AbTECO3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:29:04 -0400
Subject: [PATCH 2.{4,5}.x] mod_timer fix for sdla_fr.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: davej@codemonkey.org.uk
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:16:16 +0530
Message-Id: <1051973176.1243.162.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdla_fr.c: trivial {del,add}_timer to mod_timer conversions.

--- linux-2.5.68/drivers/net/wan/sdla_fr.c	2003-03-25 10:07:27.000000000 +0530
+++ linux-2.5.68-nvk/drivers/net/wan/sdla_fr.c	2003-05-03 16:01:02.000000000 +0530
@@ -4156,9 +4156,7 @@
 {
 	fr_channel_t* chan = dev->priv;
 
-	del_timer(&chan->fr_arp_timer);
-	chan->fr_arp_timer.expires = jiffies + (chan->inarp_interval * HZ);
-	add_timer(&chan->fr_arp_timer);
+	mod_timer(&chan->fr_arp_timer, jiffies + (chan->inarp_interval) * HZ);
 	return;
 }
 



