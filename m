Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVA2W1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVA2W1h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVA2W02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:26:28 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28591 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261582AbVA2WVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:21:07 -0500
Date: Sat, 29 Jan 2005 23:21:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 8/8] Kconfig: cleanup USB menu
Message-ID: <Pine.LNX.4.61.0501292320530.7670@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This properly indents the USB menu.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 Kconfig         |   18 ++++++++++++++++++
 host/Kconfig    |   18 ------------------
 storage/Kconfig |    1 +
 3 files changed, 19 insertions(+), 18 deletions(-)

Index: linux-2.6.11/drivers/usb/host/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/usb/host/Kconfig	2005-01-29 22:50:43.297964628 +0100
+++ linux-2.6.11/drivers/usb/host/Kconfig	2005-01-29 22:56:58.568325936 +0100
@@ -1,21 +1,3 @@
-# Host-side USB depends on having a host controller
-# NOTE:  dummy_hcd is always an option, but it's ignored here ...
-# NOTE:  SL-811 option should be board-specific ...
-config USB_ARCH_HAS_HCD
-	boolean
-	default y if USB_ARCH_HAS_OHCI
-	default y if ARM				# SL-811
-	default PCI
-
-# many non-PCI hcds implement OHCI
-config USB_ARCH_HAS_OHCI
-	boolean
-	default y if SA1111
-	default y if ARCH_OMAP
-	default y if ARCH_LH7A404
-	default y if PXA27x
-	default PCI
-
 #
 # USB Host Controller Drivers
 #
Index: linux-2.6.11/drivers/usb/storage/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/usb/storage/Kconfig	2005-01-29 22:50:43.297964628 +0100
+++ linux-2.6.11/drivers/usb/storage/Kconfig	2005-01-29 22:56:58.568325936 +0100
@@ -3,6 +3,7 @@
 #
 
 comment "NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information"
+	depends on USB
 
 config USB_STORAGE
 	tristate "USB Mass Storage support"
Index: linux-2.6.11/drivers/usb/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/usb/Kconfig	2005-01-29 22:50:43.297964628 +0100
+++ linux-2.6.11/drivers/usb/Kconfig	2005-01-29 22:56:58.568325936 +0100
@@ -4,6 +4,24 @@
 
 menu "USB support"
 
+# Host-side USB depends on having a host controller
+# NOTE:  dummy_hcd is always an option, but it's ignored here ...
+# NOTE:  SL-811 option should be board-specific ...
+config USB_ARCH_HAS_HCD
+	boolean
+	default y if USB_ARCH_HAS_OHCI
+	default y if ARM				# SL-811
+	default PCI
+
+# many non-PCI hcds implement OHCI
+config USB_ARCH_HAS_OHCI
+	boolean
+	default y if SA1111
+	default y if ARCH_OMAP
+	default y if ARCH_LH7A404
+	default y if PXA27x
+	default PCI
+
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
 config USB
 	tristate "Support for Host-side USB"
