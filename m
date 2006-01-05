Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWAEOlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWAEOlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAEOlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:41:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22284 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750942AbWAEOlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:41:45 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, Adam Belay <ambx1@neo.rr.com>
Subject: [CFT 23/29] Add pnp_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:41:37 +0000
Message-ID: <20060105142951.13.23@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/pnp/driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/pnp/driver.c linux/drivers/pnp/driver.c
--- linus/drivers/pnp/driver.c	Mon Nov  7 19:57:55 2005
+++ linux/drivers/pnp/driver.c	Sun Nov 13 16:34:22 2005
@@ -150,6 +150,8 @@ static int pnp_bus_match(struct device *
 struct bus_type pnp_bus_type = {
 	.name	= "pnp",
 	.match	= pnp_bus_match,
+	.probe	= pnp_device_probe,
+	.remove	= pnp_device_remove,
 };
 
 
@@ -168,8 +170,6 @@ int pnp_register_driver(struct pnp_drive
 
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pnp_bus_type;
-	drv->driver.probe = pnp_device_probe;
-	drv->driver.remove = pnp_device_remove;
 
 	count = driver_register(&drv->driver);
 
