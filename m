Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVBSIlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVBSIlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVBSIlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 03:41:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25870 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261652AbVBSIkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:40:37 -0500
Date: Sat, 19 Feb 2005 09:40:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: tulip-users@lists.sourceforge.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/tulip/interrupt.c: make a variable static
Message-ID: <20050219084034.GR4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/net/tulip/interrupt.c.old	2005-02-16 18:54:52.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/tulip/interrupt.c	2005-02-16 18:55:02.000000000 +0100
@@ -26,7 +26,7 @@
 #define MIT_SIZE 15
 #define MIT_TABLE 15 /* We use 0 or max */
 
-unsigned int mit_table[MIT_SIZE+1] =
+static unsigned int mit_table[MIT_SIZE+1] =
 {
         /*  CRS11 21143 hardware Mitigation Control Interrupt
             We use only RX mitigation we other techniques for

