Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSGNAZI>; Sat, 13 Jul 2002 20:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSGNAZH>; Sat, 13 Jul 2002 20:25:07 -0400
Received: from p50886DAC.dip.t-dialin.net ([80.136.109.172]:644 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315479AbSGNAZF>; Sat, 13 Jul 2002 20:25:05 -0400
Date: Sat, 13 Jul 2002 18:27:52 -0600 (MDT)
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH][2.5] Remove EXPORT_NO_SYMBOLS from modules
Message-ID: <Pine.LNX.4.44.0207131821410.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes EXPORT_NO_SYMBOLS from modules, because it's default now. It 
could also be removed from the headers now.

Index: thunder-2.5/drivers/char/genrtc.c
===================================================================
RCS file: thunder-2.5/drivers/char/genrtc.c,v
retrieving revision 1.1
diff -u -r1.1 genrtc.c
--- thunder-2.5/drivers/char/genrtc.c	10 Jul 2002 16:51:41 -0000	1.1
+++ thunder-2.5/drivers/char/genrtc.c	14 Jul 2002 00:19:47 -0000
@@ -414,8 +414,6 @@
 
 module_init(rtc_generic_init);
 module_exit(rtc_generic_exit);
-EXPORT_NO_SYMBOLS;
-
 
 /*
  *	Info exported via "/proc/rtc".
Index: thunder-2.5/drivers/char/w83877f_wdt.c
===================================================================
RCS file: thunder-2.5/drivers/char/w83877f_wdt.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 w83877f_wdt.c
--- thunder-2.5/drivers/char/w83877f_wdt.c	19 Jun 2002 02:11:47 -0000	1.1.1.1
+++ thunder-2.5/drivers/char/w83877f_wdt.c	14 Jul 2002 00:19:47 -0000
@@ -358,4 +358,3 @@
 MODULE_AUTHOR("Scott and Bill Jennings");
 MODULE_DESCRIPTION("Driver for watchdog timer in w83877f chip");
 MODULE_LICENSE("GPL");
-EXPORT_NO_SYMBOLS;
Index: thunder-2.5/drivers/message/fusion/isense.c
===================================================================
RCS file: thunder-2.5/drivers/message/fusion/isense.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 isense.c
--- thunder-2.5/drivers/message/fusion/isense.c	21 Jun 2002 22:17:25 -0000	1.1.1.1
+++ thunder-2.5/drivers/message/fusion/isense.c	14 Jul 2002 00:19:47 -0000
@@ -89,7 +89,6 @@
 #define my_VERSION	MPT_LINUX_VERSION_COMMON
 #define MYNAM		"isense"
 
-EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR(MODULEAUTHOR);
 MODULE_DESCRIPTION(my_NAME);
 
Index: thunder-2.5/drivers/message/fusion/mptctl.c
===================================================================
RCS file: thunder-2.5/drivers/message/fusion/mptctl.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mptctl.c
--- thunder-2.5/drivers/message/fusion/mptctl.c	21 Jun 2002 22:17:25 -0000	1.1.1.1
+++ thunder-2.5/drivers/message/fusion/mptctl.c	14 Jul 2002 00:19:47 -0000
@@ -102,7 +102,6 @@
 #define my_VERSION	MPT_LINUX_VERSION_COMMON
 #define MYNAM		"mptctl"
 
-EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR(MODULEAUTHOR);
 MODULE_DESCRIPTION(my_NAME);
 MODULE_LICENSE("GPL");
Index: thunder-2.5/drivers/serial/serial_21285.c
===================================================================
RCS file: thunder-2.5/drivers/serial/serial_21285.c,v
retrieving revision 1.1
diff -u -r1.1 serial_21285.c
--- thunder-2.5/drivers/serial/serial_21285.c	7 Jul 2002 13:16:13 -0000	1.1
+++ thunder-2.5/drivers/serial/serial_21285.c	14 Jul 2002 00:19:47 -0000
@@ -552,7 +552,5 @@
 module_init(serial21285_init);
 module_exit(serial21285_exit);
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Intel Footbridge (21285) serial driver $Revision: 1.1 $");
Index: thunder-2.5/drivers/serial/serial_8250_pci.c
===================================================================
RCS file: thunder-2.5/drivers/serial/serial_8250_pci.c,v
retrieving revision 1.1
diff -u -r1.1 serial_8250_pci.c
--- thunder-2.5/drivers/serial/serial_8250_pci.c	7 Jul 2002 13:16:13 -0000	 1.1
+++ thunder-2.5/drivers/serial/serial_8250_pci.c	14 Jul 2002 00:19:47 -0000
@@ -1131,8 +1131,6 @@
 module_init(serial8250_pci_init);
 module_exit(serial8250_pci_exit);
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 PCI serial probe module");
 MODULE_DEVICE_TABLE(pci, serial_pci_tbl);
Index: thunder-2.5/drivers/serial/serial_8250_pnp.c
===================================================================
RCS file: thunder-2.5/drivers/serial/serial_8250_pnp.c,v
retrieving revision 1.1
diff -u -r1.1 serial_8250_pnp.c
--- thunder-2.5/drivers/serial/serial_8250_pnp.c	7 Jul 2002 13:16:13 -0000	 1.1
+++ thunder-2.5/drivers/serial/serial_8250_pnp.c	14 Jul 2002 00:19:47 -0000
@@ -541,8 +541,6 @@
 module_init(serial8250_pnp_init);
 module_exit(serial8250_pnp_exit);
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 PNPBIOS serial probe module");
 MODULE_DEVICE_TABLE(pnpbios, pnp_dev_table);
Index: thunder-2.5/drivers/serial/serial_amba.c
===================================================================
RCS file: thunder-2.5/drivers/serial/serial_amba.c,v
retrieving revision 1.1
diff -u -r1.1 serial_amba.c
--- thunder-2.5/drivers/serial/serial_amba.c	7 Jul 2002 13:16:13 -0000	1.1
+++ thunder-2.5/drivers/serial/serial_amba.c	14 Jul 2002 00:19:47 -0000
@@ -782,8 +782,6 @@
 module_init(ambauart_init);
 module_exit(ambauart_exit);
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_AUTHOR("ARM Ltd/Deep Blue Solutions Ltd");
 MODULE_DESCRIPTION("ARM AMBA serial port driver $Revision: 1.1 $");
 MODULE_LICENSE("GPL");
Index: thunder-2.5/drivers/serial/serial_anakin.c
===================================================================
RCS file: thunder-2.5/drivers/serial/serial_anakin.c,v
retrieving revision 1.1
diff -u -r1.1 serial_anakin.c
--- thunder-2.5/drivers/serial/serial_anakin.c	7 Jul 2002 13:16:13 -0000	1.1
+++ thunder-2.5/drivers/serial/serial_anakin.c	14 Jul 2002 00:19:47 -0000
@@ -551,5 +551,3 @@
 MODULE_AUTHOR("Tak-Shing Chan <chan@aleph1.co.uk>");
 MODULE_SUPPORTED_DEVICE("ttyAN");
 MODULE_LICENSE("GPL");
-
-EXPORT_NO_SYMBOLS;
Index: thunder-2.5/drivers/serial/serial_clps711x.c
===================================================================
RCS file: thunder-2.5/drivers/serial/serial_clps711x.c,v
retrieving revision 1.1
diff -u -r1.1 serial_clps711x.c
--- thunder-2.5/drivers/serial/serial_clps711x.c	7 Jul 2002 13:16:13 -0000	 1.1
+++ thunder-2.5/drivers/serial/serial_clps711x.c	14 Jul 2002 00:19:47 -0000
@@ -646,8 +646,6 @@
 module_init(clps711xuart_init);
 module_exit(clps711xuart_exit);
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_AUTHOR("Deep Blue Solutions Ltd");
 MODULE_DESCRIPTION("CLPS-711x generic serial driver $Revision: 1.1 $");
 MODULE_LICENSE("GPL");
Index: thunder-2.5/drivers/serial/serial_sa1100.c
===================================================================
RCS file: thunder-2.5/drivers/serial/serial_sa1100.c,v
retrieving revision 1.1
diff -u -r1.1 serial_sa1100.c
--- thunder-2.5/drivers/serial/serial_sa1100.c	7 Jul 2002 13:16:14 -0000	1.1
+++ thunder-2.5/drivers/serial/serial_sa1100.c	14 Jul 2002 00:19:47 -0000
@@ -894,8 +894,6 @@
 module_init(sa1100_serial_init);
 module_exit(sa1100_serial_exit);
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_AUTHOR("Deep Blue Solutions Ltd");
 MODULE_DESCRIPTION("SA1100 generic serial port driver $Revision: 1.1 $");
 MODULE_LICENSE("GPL");
Index: thunder-2.5/fs/quota_v1.c
===================================================================
RCS file: thunder-2.5/fs/quota_v1.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 quota_v1.c
--- thunder-2.5/fs/quota_v1.c	19 Jun 2002 02:11:57 -0000	1.1.1.1
+++ thunder-2.5/fs/quota_v1.c	14 Jul 2002 00:19:47 -0000
@@ -234,8 +234,6 @@
         unregister_quota_format(&v1_quota_format);
 }
 
-EXPORT_NO_SYMBOLS;
-
 module_init(init_v1_quota_format);
 module_exit(exit_v1_quota_format);
 
Index: thunder-2.5/fs/quota_v2.c
===================================================================
RCS file: thunder-2.5/fs/quota_v2.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 quota_v2.c
--- thunder-2.5/fs/quota_v2.c	19 Jun 2002 02:11:50 -0000	1.1.1.1
+++ thunder-2.5/fs/quota_v2.c	14 Jul 2002 00:19:48 -0000
@@ -686,7 +686,5 @@
 	unregister_quota_format(&v2_quota_format);
 }
 
-EXPORT_NO_SYMBOLS;
-
 module_init(init_v2_quota_format);
 module_exit(exit_v2_quota_format);

