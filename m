Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWAEOcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWAEOcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAEOcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:32:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53264 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751338AbWAEOcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:32:41 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 6/29] Add SA1111 bus_type probe/remove methods
Date: Thu, 05 Jan 2006 14:32:32 +0000
Message-ID: <20060105142951.13.06@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/arm/common/sa1111.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/arm/common/sa1111.c linux/arch/arm/common/sa1111.c
--- linus/arch/arm/common/sa1111.c	Fri Nov 11 21:20:00 2005
+++ linux/arch/arm/common/sa1111.c	Sun Nov 13 15:55:17 2005
@@ -1247,14 +1247,14 @@ static int sa1111_bus_remove(struct devi
 struct bus_type sa1111_bus_type = {
 	.name		= "sa1111-rab",
 	.match		= sa1111_match,
+	.probe		= sa1111_bus_probe,
+	.remove		= sa1111_bus_remove,
 	.suspend	= sa1111_bus_suspend,
 	.resume		= sa1111_bus_resume,
 };
 
 int sa1111_driver_register(struct sa1111_driver *driver)
 {
-	driver->drv.probe = sa1111_bus_probe;
-	driver->drv.remove = sa1111_bus_remove;
 	driver->drv.bus = &sa1111_bus_type;
 	return driver_register(&driver->drv);
 }
