Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318622AbSHEQK2>; Mon, 5 Aug 2002 12:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318589AbSHEQJ0>; Mon, 5 Aug 2002 12:09:26 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:65483 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318643AbSHEQJW>; Mon, 5 Aug 2002 12:09:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
Organization: IBM Deutschland Entwicklung GmbH
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 16/18 add more possible root devices
Date: Mon, 5 Aug 2002 19:56:39 +0200
User-Agent: KMail/1.4.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com>
In-Reply-To: <200208051830.50713.arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208051956.39722.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some more s/390 specific devices to the list of root devices.

diff -urN linux-2.4.19-rc3/init/do_mounts.c linux-2.4.19-s390/init/do_mounts.c
--- linux-2.4.19-rc3/init/do_mounts.c	Tue Jul 30 09:02:32 2002
+++ linux-2.4.19-s390/init/do_mounts.c	Tue Jul 30 09:02:57 2002
@@ -162,6 +162,58 @@
 	{ "dasdf", (DASD_MAJOR << MINORBITS) + (5 << 2) },
 	{ "dasdg", (DASD_MAJOR << MINORBITS) + (6 << 2) },
 	{ "dasdh", (DASD_MAJOR << MINORBITS) + (7 << 2) },
+        { "dasdi", (DASD_MAJOR << MINORBITS) + (8 << 2) },
+        { "dasdj", (DASD_MAJOR << MINORBITS) + (9 << 2) },
+        { "dasdk", (DASD_MAJOR << MINORBITS) + (10 << 2) },
+        { "dasdl", (DASD_MAJOR << MINORBITS) + (11 << 2) },
+        { "dasdm", (DASD_MAJOR << MINORBITS) + (12 << 2) },
+        { "dasdn", (DASD_MAJOR << MINORBITS) + (13 << 2) },
+        { "dasdo", (DASD_MAJOR << MINORBITS) + (14 << 2) },
+        { "dasdp", (DASD_MAJOR << MINORBITS) + (15 << 2) },
+        { "dasdq", (DASD_MAJOR << MINORBITS) + (16 << 2) },
+        { "dasdr", (DASD_MAJOR << MINORBITS) + (17 << 2) },
+        { "dasds", (DASD_MAJOR << MINORBITS) + (18 << 2) },
+        { "dasdt", (DASD_MAJOR << MINORBITS) + (19 << 2) },
+        { "dasdu", (DASD_MAJOR << MINORBITS) + (20 << 2) },
+        { "dasdv", (DASD_MAJOR << MINORBITS) + (21 << 2) },
+        { "dasdw", (DASD_MAJOR << MINORBITS) + (22 << 2) },
+        { "dasdx", (DASD_MAJOR << MINORBITS) + (23 << 2) },
+        { "dasdy", (DASD_MAJOR << MINORBITS) + (24 << 2) },
+        { "dasdz", (DASD_MAJOR << MINORBITS) + (25 << 2) },
+#endif
+#ifdef CONFIG_BLK_DEV_XPRAM
+	{ "xpram0", (XPRAM_MAJOR << MINORBITS) },
+	{ "xpram1", (XPRAM_MAJOR << MINORBITS) + 1 },
+	{ "xpram2", (XPRAM_MAJOR << MINORBITS) + 2 },
+	{ "xpram3", (XPRAM_MAJOR << MINORBITS) + 3 },
+	{ "xpram4", (XPRAM_MAJOR << MINORBITS) + 4 },
+	{ "xpram5", (XPRAM_MAJOR << MINORBITS) + 5 },
+	{ "xpram6", (XPRAM_MAJOR << MINORBITS) + 6 },
+	{ "xpram7", (XPRAM_MAJOR << MINORBITS) + 7 },
+	{ "xpram8", (XPRAM_MAJOR << MINORBITS) + 8 },
+	{ "xpram9", (XPRAM_MAJOR << MINORBITS) + 9 },
+	{ "xpram10", (XPRAM_MAJOR << MINORBITS) + 10 },
+	{ "xpram11", (XPRAM_MAJOR << MINORBITS) + 11 },
+	{ "xpram12", (XPRAM_MAJOR << MINORBITS) + 12 },
+	{ "xpram13", (XPRAM_MAJOR << MINORBITS) + 13 },
+	{ "xpram14", (XPRAM_MAJOR << MINORBITS) + 14 },
+	{ "xpram15", (XPRAM_MAJOR << MINORBITS) + 15 },
+	{ "xpram16", (XPRAM_MAJOR << MINORBITS) + 16 },
+	{ "xpram17", (XPRAM_MAJOR << MINORBITS) + 17 },
+	{ "xpram18", (XPRAM_MAJOR << MINORBITS) + 18 },
+	{ "xpram19", (XPRAM_MAJOR << MINORBITS) + 19 },
+	{ "xpram20", (XPRAM_MAJOR << MINORBITS) + 20 },
+	{ "xpram21", (XPRAM_MAJOR << MINORBITS) + 21 },
+	{ "xpram22", (XPRAM_MAJOR << MINORBITS) + 22 },
+	{ "xpram23", (XPRAM_MAJOR << MINORBITS) + 23 },
+	{ "xpram24", (XPRAM_MAJOR << MINORBITS) + 24 },
+	{ "xpram25", (XPRAM_MAJOR << MINORBITS) + 25 },
+	{ "xpram26", (XPRAM_MAJOR << MINORBITS) + 26 },
+	{ "xpram27", (XPRAM_MAJOR << MINORBITS) + 27 },
+	{ "xpram28", (XPRAM_MAJOR << MINORBITS) + 28 },
+	{ "xpram29", (XPRAM_MAJOR << MINORBITS) + 29 },
+	{ "xpram30", (XPRAM_MAJOR << MINORBITS) + 30 },
+	{ "xpram31", (XPRAM_MAJOR << MINORBITS) + 31 },
 #endif
 #if defined(CONFIG_BLK_CPQ_DA) || defined(CONFIG_BLK_CPQ_DA_MODULE)
 	{ "ida/c0d0p",0x4800 },


