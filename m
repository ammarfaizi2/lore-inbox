Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWAEOha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWAEOha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWAEOh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:37:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41231 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751367AbWAEOhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:37:24 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 15/29] Add dio_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:37:18 +0000
Message-ID: <20060105142951.13.15@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/dio/dio-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/dio/dio-driver.c linux/drivers/dio/dio-driver.c
--- linus/drivers/dio/dio-driver.c	Sun Nov  6 22:15:57 2005
+++ linux/drivers/dio/dio-driver.c	Sun Nov 13 16:18:45 2005
@@ -83,7 +83,6 @@ int dio_register_driver(struct dio_drive
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &dio_bus_type;
-	drv->driver.probe = dio_device_probe;
 
 	/* register with core */
 	count = driver_register(&drv->driver);
@@ -145,7 +144,8 @@ static int dio_bus_match(struct device *
 
 struct bus_type dio_bus_type = {
 	.name	= "dio",
-	.match	= dio_bus_match
+	.match	= dio_bus_match,
+	.probe	= dio_device_probe,
 };
 
 
