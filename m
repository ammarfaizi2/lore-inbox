Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWAEOnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWAEOnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWAEOnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:43:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23820 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751359AbWAEOmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:42:46 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, SH <linux-sh@m17n.org>
Subject: [CFT 25/29] Add superhyway_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:42:40 +0000
Message-ID: <20060105142951.13.25@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/sh/superhyway/superhyway.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/sh/superhyway/superhyway.c linux/drivers/sh/superhyway/superhyway.c
--- linus/drivers/sh/superhyway/superhyway.c	Mon Nov  7 19:58:05 2005
+++ linux/drivers/sh/superhyway/superhyway.c	Sun Nov 13 16:38:04 2005
@@ -175,8 +175,6 @@ int superhyway_register_driver(struct su
 {
 	drv->drv.name	= drv->name;
 	drv->drv.bus	= &superhyway_bus_type;
-	drv->drv.probe	= superhyway_device_probe;
-	drv->drv.remove	= superhyway_device_remove;
 
 	return driver_register(&drv->drv);
 }
@@ -213,6 +211,8 @@ struct bus_type superhyway_bus_type = {
 #ifdef CONFIG_SYSFS
 	.dev_attrs	= superhyway_dev_attrs,
 #endif
+	.probe		= superhyway_device_probe,
+	.remove		= superhyway_device_remove,
 };
 
 static int __init superhyway_bus_init(void)
