Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWGRVKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWGRVKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWGRVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:10:16 -0400
Received: from server6.greatnet.de ([83.133.96.26]:23957 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750736AbWGRVKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:10:15 -0400
Message-ID: <44BD4EE3.7010509@nachtwindheim.de>
Date: Tue, 18 Jul 2006 23:13:07 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove pci_module_init() from Intel I/OAT DMA engine
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your email client corrupted your patch by changing tabs
> into spaces, therefore your patch does not apply and is
> unusable.
So this one should work. Thanks for reply.

Greets,
Henrik Kretzschmar

---
From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes pci_module_init() to pci_register_driver().
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

diff -ruN linux-2.6.18-rc2/drivers/dma/ioatdma.c linux/drivers/dma/ioatdma.c
--- linux-2.6.18-rc2/drivers/dma/ioatdma.c	2006-07-18 13:36:57.000000000 +0200
+++ linux/drivers/dma/ioatdma.c	2006-07-18 19:56:51.000000000 +0200
@@ -828,7 +828,7 @@
 	/* if forced, worst case is that rmmod hangs */
 	__unsafe(THIS_MODULE);

-	return pci_module_init(&ioat_pci_drv);
+	return pci_register_driver(&ioat_pci_drv);
 }

 module_init(ioat_init_module);


