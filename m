Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVAFPEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVAFPEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVAFPEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:04:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30471 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262857AbVAFPDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:03:52 -0500
Date: Thu, 6 Jan 2005 16:03:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       Simon Evans <spse@secret.org.uk>, joern@wh.fh-wedel.de
Subject: [patch] 2.6.10-mm2: fix MTD_BLOCK2MTD dependency
Message-ID: <20050106150346.GC3096@stusta.de>
References: <20050106002240.00ac4611.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes an obviously wrong dependency coming from Linus' 
tree.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/drivers/mtd/devices/Kconfig.old	2005-01-06 16:00:49.000000000 +0100
+++ linux-2.6.10-mm2-full/drivers/mtd/devices/Kconfig	2005-01-06 16:00:59.000000000 +0100
@@ -127,7 +127,7 @@
 
 config MTD_BLOCK2MTD
 	tristate "MTD using block device (rewrite)"
-	depends on MTD || EXPERIMENTAL
+	depends on MTD && EXPERIMENTAL
 	help
 	  This driver is basically the same at MTD_BLKMTD above, but
 	  experienced some interface changes plus serious speedups.  In

