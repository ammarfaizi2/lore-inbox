Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWAEOnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWAEOnv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWAEOnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:43:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25100 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751359AbWAEOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:43:49 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, M68K <linux-m68k@vger.kernel.org>
Subject: [CFT 27/29] Add zorro_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:43:43 +0000
Message-ID: <20060105142951.13.27@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/zorro/zorro-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/zorro/zorro-driver.c linux/drivers/zorro/zorro-driver.c
--- linus/drivers/zorro/zorro-driver.c	Sun Nov  6 22:18:11 2005
+++ linux/drivers/zorro/zorro-driver.c	Sun Nov 13 16:41:51 2005
@@ -77,7 +77,6 @@ int zorro_register_driver(struct zorro_d
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &zorro_bus_type;
-	drv->driver.probe = zorro_device_probe;
 
 	/* register with core */
 	count = driver_register(&drv->driver);
@@ -132,7 +131,8 @@ static int zorro_bus_match(struct device
 
 struct bus_type zorro_bus_type = {
 	.name	= "zorro",
-	.match	= zorro_bus_match
+	.match	= zorro_bus_match,
+	.probe	= zorro_device_probe,
 };
 
 
