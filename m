Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWAEOdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWAEOdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAEOdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:33:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54032 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751345AbWAEOdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:33:09 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, Richard Purdie <rpurdie@rpsys.net>
Subject: [CFT 7/29] Add locomo bus_type probe/remove methods
Date: Thu, 05 Jan 2006 14:33:04 +0000
Message-ID: <20060105142951.13.07@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/arm/common/locomo.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/arm/common/locomo.c linux/arch/arm/common/locomo.c
--- linus/arch/arm/common/locomo.c	Fri Nov 11 21:20:00 2005
+++ linux/arch/arm/common/locomo.c	Sun Nov 13 15:56:31 2005
@@ -1103,14 +1103,14 @@ static int locomo_bus_remove(struct devi
 struct bus_type locomo_bus_type = {
 	.name		= "locomo-bus",
 	.match		= locomo_match,
+	.probe		= locomo_bus_probe,
+	.remove		= locomo_bus_remove,
 	.suspend	= locomo_bus_suspend,
 	.resume		= locomo_bus_resume,
 };
 
 int locomo_driver_register(struct locomo_driver *driver)
 {
-	driver->drv.probe = locomo_bus_probe;
-	driver->drv.remove = locomo_bus_remove;
 	driver->drv.bus = &locomo_bus_type;
 	return driver_register(&driver->drv);
 }
