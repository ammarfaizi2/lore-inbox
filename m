Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272597AbTHJIjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275474AbTHJIjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:39:45 -0400
Received: from [203.145.184.221] ([203.145.184.221]:50445 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272597AbTHJIjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:39:43 -0400
Subject: [PATCH 2.6.0-test3][ISDN] make sedlbauer.c compile
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Kai Germaschewski <kai.germaschewski@gmx.de>
Cc: trivial@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 10 Aug 2003 14:29:34 +0530
Message-Id: <1060505974.1354.14.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes drivers/isdn/hisax/sedlbauer.c compile without which
the following compilation errors are generated:

drivers/isdn/hisax/sedlbauer.c: In function `setup_sedlbauer':
drivers/isdn/hisax/sedlbauer.c:763: label `err' used but not defined


--- linux-2.6.0-test3/drivers/isdn/hisax/sedlbauer.c	2003-07-15 17:22:23.000000000 +0530
+++ linux-2.6.0-test3-nvk/drivers/isdn/hisax/sedlbauer.c	2003-08-10 14:16:19.000000000 +0530
@@ -760,7 +760,7 @@
 						printk(KERN_ERR "Sedlbauer PnP:some resources are missing %ld/%lx\n",
 						       pnp_irq(pd, 0), pnp_port_start(pd, 0));
 						pnp_device_detach(pd);
-						goto err;
+						return 0;
 					}
 					card->para[1] = pnp_port_start(pd, 0);
 					card->para[0] = pnp_irq(pd, 0);
@@ -777,7 +777,7 @@
 					}
 				} else {
 					printk(KERN_ERR "Sedlbauer PnP: PnP error card found, no device\n");
-					goto err;
+					return 0;
 				}
 			}
 			pdev++;



