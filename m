Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270582AbTGNOEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270567AbTGNMbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49028
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270593AbTGNMNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:13:36 -0400
Date: Mon, 14 Jul 2003 13:27:35 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141227.h6ECRZ8N030947@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: update intelfb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#ra1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/video/intel/intelfb.h linux.22-pre5-ac1/drivers/video/intel/intelfb.h
--- linux.22-pre5/drivers/video/intel/intelfb.h	2003-07-14 12:26:53.000000000 +0100
+++ linux.22-pre5-ac1/drivers/video/intel/intelfb.h	2003-07-07 16:22:32.000000000 +0100
@@ -6,7 +6,7 @@
 
 
 /*** Version/name ***/
-#define INTELFB_VERSION			"0.7.5"
+#define INTELFB_VERSION			"0.7.7"
 #define INTELFB_MODULE_NAME		"intelfb"
 #define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G"
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/video/intel/intelfbhw.h linux.22-pre5-ac1/drivers/video/intel/intelfbhw.h
--- linux.22-pre5/drivers/video/intel/intelfbhw.h	2003-07-14 12:26:53.000000000 +0100
+++ linux.22-pre5-ac1/drivers/video/intel/intelfbhw.h	2003-07-07 16:22:36.000000000 +0100
@@ -183,7 +183,7 @@
 #endif
 #define PALETTE_8_SIZE			(PALETTE_8_ENTRIES * 4)
 #define PALETTE_10_ENTRIES		128
-#define PALETTE_8_SIZE			(PALETTE_10_ENTRIES * 8)
+#define PALETTE_10_SIZE			(PALETTE_10_ENTRIES * 8)
 #define PALETTE_8_MASK			0xff
 #define PALETTE_8_RED_SHIFT		16
 #define PALETTE_8_GREEN_SHIFT		8
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/video/intel/Makefile linux.22-pre5-ac1/drivers/video/intel/Makefile
--- linux.22-pre5/drivers/video/intel/Makefile	2003-07-14 12:26:53.000000000 +0100
+++ linux.22-pre5-ac1/drivers/video/intel/Makefile	2003-07-07 16:57:43.000000000 +0100
@@ -3,6 +3,7 @@
 
 O_TARGET := intelfb.o
 
-obj-$(CONFIG_FB_INTEL)	+= intelfbdrv.o intelfbhw.o
+obj-y	:= intelfbdrv.o intelfbhw.o
+obj-m	:= $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
