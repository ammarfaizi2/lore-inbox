Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTECO0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbTECO0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:26:19 -0400
Received: from [203.145.184.221] ([203.145.184.221]:8722 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263322AbTECO0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:26:18 -0400
Subject: [PATCH 2.{4,5}.x] mod_timer fix for sdla_ppp.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: davej@codemonkey.org.uk
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:13:29 +0530
Message-Id: <1051973010.2018.158.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdla_ppp.c: trivial {del,add}_timer to mod_timer conversions.

--- linux-2.5.68/drivers/net/wan/sdla_ppp.c	2003-03-25 10:07:27.000000000 +0530
+++ linux-2.5.68-nvk/drivers/net/wan/sdla_ppp.c	2003-05-03 16:02:05.000000000 +0530
@@ -758,9 +758,7 @@
 	/* Start the PPP configuration after 1sec delay.
 	 * This will give the interface initilization time
 	 * to finish its configuration */
-	del_timer(&ppp_priv_area->poll_delay_timer);
-	ppp_priv_area->poll_delay_timer.expires = jiffies+HZ;
-	add_timer(&ppp_priv_area->poll_delay_timer);
+	mod_timer(&ppp_priv_area->poll_delay_timer, jiffies + HZ);
 	return 0;
 }
 



