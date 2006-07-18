Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWGRSTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWGRSTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWGRSTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:19:32 -0400
Received: from server6.greatnet.de ([83.133.96.26]:27278 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932342AbWGRSTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:19:31 -0400
Message-ID: <44BD26E2.9080106@nachtwindheim.de>
Date: Tue, 18 Jul 2006 20:22:26 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: [PATCH] Remove pci_module_init() from Intel I/OAT DMA engine
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes pci_module_init() to pci_register_driver().
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

diff -ruN linux-2.6.18-rc2/drivers/dma/ioatdma.c linux/drivers/dma/ioatdma.c
--- linux-2.6.18-rc2/drivers/dma/ioatdma.c      2006-07-18 13:36:57.000000000 +0200
+++ linux/drivers/dma/ioatdma.c 2006-07-18 19:56:51.000000000 +0200
@@ -828,7 +828,7 @@
        /* if forced, worst case is that rmmod hangs */
        __unsafe(THIS_MODULE);

-       return pci_module_init(&ioat_pci_drv);
+       return pci_register_driver(&ioat_pci_drv);
 }

 module_init(ioat_init_module);
