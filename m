Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265964AbSKBNWP>; Sat, 2 Nov 2002 08:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265965AbSKBNWP>; Sat, 2 Nov 2002 08:22:15 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:28857 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265964AbSKBNWN>; Sat, 2 Nov 2002 08:22:13 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4.20-rc1] Promise Config.in/Configure.help updates
Date: Sat, 2 Nov 2002 14:28:02 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200211021422.26555.m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QQAY2DEXM9BVGYPSJDZH"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QQAY2DEXM9BVGYPSJDZH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcello,

attached patches updates Config.in and Configure.help entries
for Promise PDC20XXX series.

Source code looks to me that it also supports PDC20270,
PDC20275 and PDC20276.

I have such a PDC20270 and a friend has a PDC20276 working.


Please apply.

ciao, Marc





--------------Boundary-00=_QQAY2DEXM9BVGYPSJDZH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="02_promise-docu-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02_promise-docu-update.patch"

--- linux-old/Documentation/Configure.help	2002-11-02 14:09:21.000000000 +0100
+++ linux/Documentation/Configure.help	2002-11-02 14:14:26.000000000 +0100
@@ -1217,11 +1217,12 @@
 
   If unsure, say N.
 
-PROMISE PDC20246/PDC20262/PDC20265/PDC20267/PDC20268 support
+PROMISE PDC20246/PDC20262/PDC20265/PDC20267/PDC20268/PDC20270/PDC20275/PDC20276 support
 CONFIG_BLK_DEV_PDC202XX
   Promise Ultra33 or PDC20246
   Promise Ultra66 or PDC20262
-  Promise Ultra100 or PDC20265/PDC20267/PDC20268
+  Promise Ultra100 or PDC20265/PDC20267/PDC20268/PDC20269/PDC20270
+  Promise Ultra133 or PDC20275/PDC20276
 
   This driver adds up to 4 more EIDE devices sharing a single
   interrupt. This add-on card is a bootable PCI UDMA controller. Since

--------------Boundary-00=_QQAY2DEXM9BVGYPSJDZH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="01_promise-config.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01_promise-config.in.patch"

--- linux-old/drivers/ide/Config.in	2002-11-02 14:09:31.000000000 +0100
+++ linux/drivers/ide/Config.in	2002-11-02 14:11:13.000000000 +0100
@@ -83,7 +83,7 @@
 	    dep_bool '    NS87415 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	    dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
 #	    dep_mbool '   Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_BLK_DEV_ADMA $CONFIG_IDEDMA_PCI_WIP $CONFIG_EXPERIMENTAL
-	    dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70|75|76} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
 	    dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
 	    dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86

--------------Boundary-00=_QQAY2DEXM9BVGYPSJDZH--

