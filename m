Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTA1VkA>; Tue, 28 Jan 2003 16:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTA1VkA>; Tue, 28 Jan 2003 16:40:00 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:44162 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261356AbTA1Vj6>; Tue, 28 Jan 2003 16:39:58 -0500
Subject: [PATCH] 2.5.59 add four help texts to drivers/char/watchdog/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Jan 2003 14:46:57 -0700
Message-Id: <1043790419.2552.138.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some help texts from 2.4.21-pre3 Configure.help which are
needed in 2.5.59 drivers/char/watchdog/Kconfig.

Steven

--- linux-2.5.59/drivers/char/watchdog/Kconfig.orig	Tue Jan 28 14:13:48 2003
+++ linux-2.5.59/drivers/char/watchdog/Kconfig	Tue Jan 28 14:21:18 2003
@@ -303,17 +303,55 @@
 config SC520_WDT
 	tristate "AMD Elan SC520 processor Watchdog"
 	depends on WATCHDOG
+	help
+	  This is the driver for the hardware watchdog built in to the
+	  AMD "Elan" SC520 microcomputer commonly used in embedded systems.
+	  This watchdog simply watches your kernel to make sure it doesn't
+	  freeze, and if it does, it reboots your computer after a certain
+	  amount of time.
+	
+	  You can compile this driver directly into the kernel, or use
+	  it as a module.  The module will be called sc520_wdt.o.
 
 config ALIM7101_WDT
 	tristate "ALi M7101 PMU Computer Watchdog"
 	depends on WATCHDOG
+	help
+	  This is the driver for the hardware watchdog on the ALi M7101 PMU
+	  as used in the x86 Cobalt servers.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called alim7101_wdt.o.  If you want to compile it as a
+	  module, say M here and read Documentation/modules.txt.  Most
+	  people will say N.
 
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
 	depends on WATCHDOG
+	help
+	  This is a driver for National Semiconductor PC87307/PC97307 hardware
+	  watchdog cards as found on the SC1200. This watchdog is mainly used
+	  for power management purposes and can be used to power down the device
+	  during inactivity periods (includes interrupt activity monitoring).
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called sc1200wdt.o.  If you want to compile it as a
+	  module, say M here and read Documentation/modules.txt.  Most
+	  people will say N.
 
 config WAFER_WDT
 	tristate "ICP Wafer 5823 Single Board Computer Watchdog"
 	depends on WATCHDOG
+	help
+	  This is a driver for the hardware watchdog on the ICP Wafer 5823
+	  Single Board Computer (and probably other similar models).
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  If you want to compile it as a module, say M here and read
+	  Documentation/modules.txt. The module will be called
+	  wafer5823wdt.o
 
 endmenu




