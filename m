Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266202AbUGOWRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUGOWRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUGOWRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:17:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26842 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266357AbUGOWRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:17:50 -0400
Date: Fri, 16 Jul 2004 00:17:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: hamish@zot.apana.org.au
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/seeq8005.c: small cleanups
Message-ID: <20040715221742.GN25633@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following small cleanups in seeq8005.c:
- kill ancient version variable
- remove Emacs settings


diffstat output:
 drivers/net/seeq8005.c |   18 ------------------
 1 files changed, 18 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full-3.4/drivers/net/seeq8005.c.old	2004-07-16 00:08:55.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full-3.4/drivers/net/seeq8005.c	2004-07-16 00:09:28.000000000 +0200
@@ -12,12 +12,7 @@
 	This file is a network device driver for the SEEQ 8005 chipset and
 	the Linux operating system.
 
-*/
-
-static const char version[] =
-	"seeq8005.c:v1.00 8/07/95 Hamish Coleman (hamish@zot.apana.org.au)\n";
 
-/*
   Sources:
   	SEEQ 8005 databook
   	
@@ -150,7 +145,6 @@
 
 static int __init seeq8005_probe1(struct net_device *dev, int ioaddr)
 {
-	static unsigned version_printed;
 	int i,j;
 	unsigned char SA_prom[32];
 	int old_cfg1;
@@ -291,9 +285,6 @@
 	}
 #endif
 
-	if (net_debug  &&  version_printed++ == 0)
-		printk(version);
-
 	printk("%s: %s found at %#3x, ", dev->name, "seeq8005", ioaddr);
 
 	/* Fill in the 'dev' fields. */
@@ -757,12 +748,3 @@
 }
 
 #endif /* MODULE */
-
-/*
- * Local variables:
- *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -m486 -c skeleton.c"
- *  version-control: t
- *  kept-new-versions: 5
- *  tab-width: 4
- * End:
- */

