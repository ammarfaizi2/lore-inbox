Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVHDXtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVHDXtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVHDXtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:49:04 -0400
Received: from tim.rpsys.net ([194.106.48.114]:38349 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262732AbVHDXtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:49:03 -0400
Subject: [patch] Corgi: Add keyboard and touchscreen device definitions
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 00:48:48 +0100
Message-Id: <1123199328.8987.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add keyboard and touchscreen device definitions for corgi.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/corgi.c	2005-08-05 00:29:45.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/corgi.c	2005-08-05 00:29:47.000000000 +0100
@@ -99,6 +99,27 @@
 
 
 /*
+ * Corgi Keyboard Device
+ */
+static struct platform_device corgikbd_device = {
+	.name		= "corgi-keyboard",
+	.id		= -1,
+};
+
+
+/*
+ * Corgi Touch Screen Device
+ */
+static struct platform_device corgits_device = {
+	.name		= "corgi-ts",
+	.dev		= {
+ 		.parent = &corgissp_device.dev,
+	},		
+	.id		= -1,
+};
+
+
+/*
  * MMC/SD Device
  *
  * The card detect interrupt isn't debounced so we delay it by HZ/4
@@ -180,6 +201,7 @@
 };
 
 
+
 /*
  * USB Device Controller
  */
@@ -205,7 +227,9 @@
 	&corgiscoop_device,
 	&corgissp_device,
 	&corgifb_device,
+	&corgikbd_device,
 	&corgibl_device,
+	&corgits_device,
 };
 
 static void __init corgi_init(void)

