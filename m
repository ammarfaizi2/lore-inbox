Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVHMVyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVHMVyA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVHMVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 17:54:00 -0400
Received: from smtp.gentoo.org ([134.68.220.30]:1737 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S932270AbVHMVx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 17:53:59 -0400
Subject: Re: [PATCH] Watchdog device node name unification
From: Henrik Brix Andersen <brix@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
In-Reply-To: <1123969015.13656.13.camel@sponge.fungus>
References: <1123969015.13656.13.camel@sponge.fungus>
Content-Type: text/plain
Organization: Gentoo Metadistribution
Date: Sat, 13 Aug 2005 23:53:56 +0200
Message-Id: <1123970037.13656.16.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 23:36 +0200, Henrik Brix Andersen wrote:
> Here's a patch for unifying the watchdog device node name
> to /dev/watchdog as expected by most user-space applications.
> 
> Please CC: me on replies as I am not subscribed to LKML.
> 
> 
> Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>

The last patch was accidentally against 2.6.12 - this one is against
2.6.13-rc6.


diff -urp linux-2.6.13-rc6/drivers/char/watchdog/ixp2000_wdt.c linux-2.6.13-rc6-watchdog/drivers/char/watchdog/ixp2000_wdt.c
--- linux-2.6.13-rc6/drivers/char/watchdog/ixp2000_wdt.c	2005-08-13 23:48:02.000000000 +0200
+++ linux-2.6.13-rc6-watchdog/drivers/char/watchdog/ixp2000_wdt.c	2005-08-13 23:50:17.000000000 +0200
@@ -182,7 +182,7 @@ static struct file_operations ixp2000_wd
 static struct miscdevice ixp2000_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP2000 Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp2000_wdt_fops,
 };
 
diff -urp linux-2.6.13-rc6/drivers/char/watchdog/ixp4xx_wdt.c linux-2.6.13-rc6-watchdog/drivers/char/watchdog/ixp4xx_wdt.c
--- linux-2.6.13-rc6/drivers/char/watchdog/ixp4xx_wdt.c	2005-08-13 23:48:02.000000000 +0200
+++ linux-2.6.13-rc6-watchdog/drivers/char/watchdog/ixp4xx_wdt.c	2005-08-13 23:50:17.000000000 +0200
@@ -176,7 +176,7 @@ static struct file_operations ixp4xx_wdt
 static struct miscdevice ixp4xx_wdt_miscdev =
 {
 	.minor		= WATCHDOG_MINOR,
-	.name		= "IXP4xx Watchdog",
+	.name		= "watchdog",
 	.fops		= &ixp4xx_wdt_fops,
 };
 
diff -urp linux-2.6.13-rc6/drivers/char/watchdog/scx200_wdt.c linux-2.6.13-rc6-watchdog/drivers/char/watchdog/scx200_wdt.c
--- linux-2.6.13-rc6/drivers/char/watchdog/scx200_wdt.c	2005-08-13 23:48:02.000000000 +0200
+++ linux-2.6.13-rc6-watchdog/drivers/char/watchdog/scx200_wdt.c	2005-08-13 23:50:21.000000000 +0200
@@ -206,7 +206,7 @@ static struct file_operations scx200_wdt
 
 static struct miscdevice scx200_wdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
-	.name  = NAME,
+	.name  = "watchdog",
 	.fops  = &scx200_wdt_fops,
 };
 


-- 
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

