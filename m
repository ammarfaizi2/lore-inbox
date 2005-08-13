Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVHMVg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVHMVg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVHMVg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 17:36:58 -0400
Received: from smtp.gentoo.org ([134.68.220.30]:22701 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S932269AbVHMVg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 17:36:58 -0400
Subject: [PATCH] Watchdog device node name unification
From: Henrik Brix Andersen <brix@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Content-Type: text/plain
Organization: Gentoo Metadistribution
Date: Sat, 13 Aug 2005 23:36:55 +0200
Message-Id: <1123969015.13656.13.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch for unifying the watchdog device node name
to /dev/watchdog as expected by most user-space applications.

Please CC: me on replies as I am not subscribed to LKML.


Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>


diff -urp linux-2.6.13-rc6/drivers/char/watchdog/ixp2000_wdt.c linux-2.6.13-rc6-watchdog/drivers/char/watchdog/ixp2000_wdt.c
--- linux-2.6.13-rc6/drivers/char/watchdog/ixp2000_wdt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-watchdog/drivers/char/watchdog/ixp2000_wdt.c	2005-08-13 23:10:22.000000000 +0200
@@ -186,7 +186,7 @@ static struct file_operations ixp2000_wd
 static struct miscdevice ixp2000_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP2000 Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp2000_wdt_fops,
 };
 
diff -urp linux-2.6.13-rc6/drivers/char/watchdog/ixp4xx_wdt.c linux-2.6.13-rc6-watchdog/drivers/char/watchdog/ixp4xx_wdt.c
--- linux-2.6.13-rc6/drivers/char/watchdog/ixp4xx_wdt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-watchdog/drivers/char/watchdog/ixp4xx_wdt.c	2005-08-13 23:10:33.000000000 +0200
@@ -180,7 +180,7 @@ static struct file_operations ixp4xx_wdt
 static struct miscdevice ixp4xx_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP4xx Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp4xx_wdt_fops,
 };
 
diff -urp linux-2.6.13-rc6/drivers/char/watchdog/sa1100_wdt.c linux-2.6.13-rc6-watchdog/drivers/char/watchdog/sa1100_wdt.c
--- linux-2.6.13-rc6/drivers/char/watchdog/sa1100_wdt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-watchdog/drivers/char/watchdog/sa1100_wdt.c	2005-08-13 23:14:05.000000000 +0200
@@ -176,7 +176,7 @@ static struct file_operations sa1100dog_
 static struct miscdevice sa1100dog_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "SA1100/PXA2xx watchdog",
+	.name		= "watchdog",
 	.fops		= &sa1100dog_fops,
 };
 
diff -urp linux-2.6.13-rc6/drivers/char/watchdog/scx200_wdt.c linux-2.6.13-rc6-watchdog/drivers/char/watchdog/scx200_wdt.c
--- linux-2.6.13-rc6/drivers/char/watchdog/scx200_wdt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-watchdog/drivers/char/watchdog/scx200_wdt.c	2005-08-13 23:14:33.000000000 +0200
@@ -210,7 +210,7 @@ static struct file_operations scx200_wdt
 
 static struct miscdevice scx200_wdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
-	.name  = NAME,
+	.name  = "watchdog",
 	.fops  = &scx200_wdt_fops,
 };
 

-- 
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

