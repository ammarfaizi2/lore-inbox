Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUEJP6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUEJP6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUEJP6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:58:17 -0400
Received: from mail.cyberdeck.net ([213.30.142.148]:50105 "EHLO
	mail.cyberdeck.com") by vger.kernel.org with ESMTP id S264836AbUEJP6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:58:04 -0400
From: Patrice Bouchand <PBouchand@cyberdeck.com>
Organization: Cyberdeck
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ib700wdt watchdog driver for 2.6.6
Date: Mon, 10 May 2004 17:57:58 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405101757.58104.PBouchand@cyberdeck.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

        The following is a kernel 2.6.6 patch for the ib700wdt watchdog 
driver. I tried to mail Charles Howes, but his address seems to be down.

	The modified file is ib700wdt.c

	The thing which is modified :

 ibwdt_ping() : a bug removed ,port value must be written not the timeout in 
second

        Comments are welcome,

        Best regards

        Patrice BOUCHAND 

------------------------------------------------------------------------------------------------------------------

--- ./ib700wdt.c.orig   2004-05-10 08:57:54.000000000 +0200
+++ ./ib700wdt.c        2004-05-10 08:44:50.000000000 +0200
@@ -135,7 +135,7 @@
 ibwdt_ping(void)
 {
        /* Write a watchdog value */
-       outb_p(wd_times[wd_margin], WDT_START);
+       outb_p(wd_margin, WDT_START);
 }

 static ssize_t


