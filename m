Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVAHGkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVAHGkk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVAHGhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:37:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:17542 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261931AbVAHFss convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:48 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163264463@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:44 -0800
Message-Id: <1105163264997@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.9, 2004/12/15 15:11:26-08:00, david-b@pacbell.net

[PATCH] USB: update drivers/usb/README

This just adds a bit more info to drivers/usb/README, mostly
just pointing to where documentation is to be found (including
current kerneldoc).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/README |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)


diff -Nru a/drivers/usb/README b/drivers/usb/README
--- a/drivers/usb/README	2005-01-07 15:50:23 -08:00
+++ b/drivers/usb/README	2005-01-07 15:50:23 -08:00
@@ -1,14 +1,37 @@
+To understand all the Linux-USB framework, you'll use these resources:
+
+    * This source code.  This is necessarily an evolving work, and
+      includes kerneldoc that should help you get a current overview.
+      ("make pdfdocs", and then look at "usb.pdf" for host side and
+      "gadget.pdf" for peripheral side.)  Also, Documentation/usb has
+      more information.
+
+    * The USB 2.0 specification (from www.usb.org), with supplements
+      such as those for USB OTG and the various device classes.
+      The USB specification has a good overview chapter, and USB
+      peripherals conform to the widely known "Chapter 9".
+
+    * Chip specifications for USB controllers.  Examples include
+      host controllers (on PCs, servers, and more); peripheral
+      controllers (in devices with Linux firmware, like printers or
+      cell phones); and hard-wired peripherals like Ethernet adapters.
+
+    * Specifications for other protocols implemented by USB peripheral
+      functions.  Some are vendor-specific; others are vendor-neutral
+      but just standardized outside of the www.usb.org team.
+
 Here is a list of what each subdirectory here is, and what is contained in
 them.
 
 core/		- This is for the core USB host code, including the
-		  usbfs files.
+		  usbfs files and the hub class driver ("khubd").
 
-host/		- This is for all of the USB host drivers.  This
-		  includes UHCI, OHCI, EHCI, and any others that might
-		  be created in the future.
+host/		- This is for USB host controller drivers.  This
+		  includes UHCI, OHCI, EHCI, and others that might
+		  be used with more specialized "embedded" systems.
 
-gadget/		- This is for all of the USB device controller drivers. 
+gadget/		- This is for USB peripheral controller drivers and
+		  the various gadget drivers which talk to them.
 
 
 Individual USB driver directories.  A new driver should be added to the

