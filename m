Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWAEOgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWAEOgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWAEOgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:36:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39695 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751345AbWAEOgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:36:22 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, PowerPC <linuxppc-embedded@ozlabs.org>
Subject: [CFT 13/29] Add of_platform_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:36:16 +0000
Message-ID: <20060105142951.13.13@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/powerpc/kernel/of_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/powerpc/kernel/of_device.c linux/arch/powerpc/kernel/of_device.c
--- linus/arch/powerpc/kernel/of_device.c	Mon Oct 31 07:31:59 2005
+++ linux/arch/powerpc/kernel/of_device.c	Sun Nov 13 16:12:38 2005
@@ -132,6 +132,8 @@ static int of_device_resume(struct devic
 struct bus_type of_platform_bus_type = {
        .name	= "of_platform",
        .match	= of_platform_bus_match,
+       .probe	= of_device_probe,
+       .remove	= of_device_remove,
        .suspend	= of_device_suspend,
        .resume	= of_device_resume,
 };
@@ -150,8 +152,6 @@ int of_register_driver(struct of_platfor
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &of_platform_bus_type;
-	drv->driver.probe = of_device_probe;
-	drv->driver.remove = of_device_remove;
 
 	/* register with core */
 	count = driver_register(&drv->driver);
