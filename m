Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWAEOez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWAEOez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWAEOey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:34:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56080 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751358AbWAEOex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:34:53 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, parisc <parisc-linux@parisc-linux.org>
Subject: [CFT 10/29] Add parisc_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:34:38 +0000
Message-ID: <20060105142951.13.10@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/parisc/kernel/drivers.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/parisc/kernel/drivers.c linux/arch/parisc/kernel/drivers.c
--- linus/arch/parisc/kernel/drivers.c	Sun Nov  6 22:14:46 2005
+++ linux/arch/parisc/kernel/drivers.c	Sun Nov 13 16:08:49 2005
@@ -173,8 +173,6 @@ int register_parisc_driver(struct parisc
 	WARN_ON(driver->drv.probe != NULL);
 	WARN_ON(driver->drv.remove != NULL);
 
-	driver->drv.probe = parisc_driver_probe;
-	driver->drv.remove = parisc_driver_remove;
 	driver->drv.name = driver->name;
 
 	return driver_register(&driver->drv);
@@ -570,6 +568,8 @@ struct bus_type parisc_bus_type = {
 	.name = "parisc",
 	.match = parisc_generic_match,
 	.dev_attrs = parisc_device_attrs,
+	.probe = parisc_driver_probe,
+	.remove = parisc_driver_remove,
 };
 
 /**
