Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWAEOlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWAEOlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWAEOlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:41:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46095 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751368AbWAEOlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:41:14 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, PCMCIA <linux-pcmcia@lists.infradead.org>
Subject: [CFT 22/29] Add pcmcia_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:40:58 +0000
Message-ID: <20060105142951.13.22@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/pcmcia/ds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linus/drivers/pcmcia/ds.c	Sun Nov  6 22:17:11 2005
+++ linux/drivers/pcmcia/ds.c	Sun Nov 13 16:33:41 2005
@@ -315,8 +315,6 @@ int pcmcia_register_driver(struct pcmcia
 	/* initialize common fields */
 	driver->drv.bus = &pcmcia_bus_type;
 	driver->drv.owner = driver->owner;
-	driver->drv.probe = pcmcia_device_probe;
-	driver->drv.remove = pcmcia_device_remove;
 
 	return driver_register(&driver->drv);
 }
@@ -1226,6 +1224,8 @@ struct bus_type pcmcia_bus_type = {
 	.hotplug = pcmcia_bus_hotplug,
 	.match = pcmcia_bus_match,
 	.dev_attrs = pcmcia_dev_attrs,
+	.probe = pcmcia_device_probe,
+	.remove = pcmcia_device_remove,
 };
 
 
