Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271943AbTHDREC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271944AbTHDREC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:04:02 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:27847 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S271943AbTHDRD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:03:58 -0400
Date: Mon, 4 Aug 2003 13:03:59 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22pre10: Missing parens in drivesr/pcmcia/ti113x.h
Message-ID: <20030804170359.GA7168@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seems like a precedence fix.  I don't have the appropriate
hardware to test a behavior change, so I can't be sure.

Index: linux/drivers/pcmcia/ti113x.h
--- linux/drivers/pcmcia/ti113x.h.old	2003-08-04 12:45:32.000000000 -0400
+++ linux/drivers/pcmcia/ti113x.h	2003-08-04 12:53:08.000000000 -0400
@@ -180,5 +180,5 @@
 
 		devctl = config_readb(socket, TI113X_DEVICE_CONTROL);
-		if (devctl & TI113X_DCR_IMODE_MASK != TI12XX_DCR_IMODE_ALL_SERIAL) {
+		if ((devctl & TI113X_DCR_IMODE_MASK) != TI12XX_DCR_IMODE_ALL_SERIAL) {
 			printk (KERN_INFO "ti113x: Routing card interrupts to PCI\n");
 

-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
