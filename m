Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTAAQFI>; Wed, 1 Jan 2003 11:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTAAQFI>; Wed, 1 Jan 2003 11:05:08 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:26815 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267260AbTAAQFF>; Wed, 1 Jan 2003 11:05:05 -0500
Date: Wed, 1 Jan 2003 17:13:29 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show the PCI hotplug submenu if PCI hotplug is selected
Message-ID: <20030101161329.GE15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the PCI hotplug submenu if the PCI hotplug entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/hotplug/Kconfig b/drivers/hotplug/Kconfig
--- a/drivers/hotplug/Kconfig	2002-11-11 08:45:02.000000000 +0100
+++ b/drivers/hotplug/Kconfig	2003-01-01 17:10:06.000000000 +0100
@@ -2,12 +2,9 @@
 # PCI Hotplug support
 #
 
-menu "PCI Hotplug Support"
-	depends on HOTPLUG
-
 config HOTPLUG_PCI
 	tristate "Support for PCI Hotplug (EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	depends on HOTPLUG && PCI && EXPERIMENTAL
 	---help---
 	  Say Y here if you have a motherboard with a PCI Hotplug controller.
 	  This allows you to add and remove PCI cards while the machine is
@@ -21,6 +18,9 @@
 
 	  When in doubt, say N.
 
+menu "PCI Hotplug Support config"
+	depends on HOTPLUG_PCI
+
 config HOTPLUG_PCI_COMPAQ
 	tristate "Compaq PCI Hotplug driver"
 	depends on HOTPLUG_PCI && X86
