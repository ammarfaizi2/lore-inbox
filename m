Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269163AbUHZRTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269163AbUHZRTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbUHZRN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:13:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1263 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269216AbUHZRJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:09:48 -0400
Date: Thu, 26 Aug 2004 19:09:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] really uninline lmc_trace
Message-ID: <20040826170931.GM29965@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of some gcc 3.4 fixes, someone removed the inline from the 
prototype of lmc_trace in lmc_debug.c, but the useless inline at the 
actual function remained.

The patch below removes it.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full/drivers/net/wan/lmc/lmc_debug.c.old	2004-08-26 18:55:27.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/net/wan/lmc/lmc_debug.c	2004-08-26 18:55:53.000000000 +0200
@@ -64,7 +64,7 @@
 #endif
 }
 
-inline void lmc_trace(struct net_device *dev, char *msg){
+void lmc_trace(struct net_device *dev, char *msg){
 #ifdef LMC_TRACE
     unsigned long j = jiffies + 3; /* Wait for 50 ms */
 
