Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTDUTgC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTDUTgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:36:02 -0400
Received: from pop.gmx.net ([213.165.65.60]:18164 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261895AbTDUTgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:36:01 -0400
Date: Mon, 21 Apr 2003 21:48:05 +0200
From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: some additional unusual_devs-entries for usb-storage-driver,
 kernel 2.5.68
Message-Id: <20030421214805.7de5e4f3.hanno@gmx.de>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.68 adds support for some digital cameras.
Same patch is already applied to the 2.4-ac-series.
It is taken from the lycoris kernel-source.

Hanno Boeck




--- linux-2.5.68-old/drivers/usb/storage/unusual_devs.h	2003-04-15 14:05:09.000000000 +0200
+++ linux-2.5.68/drivers/usb/storage/unusual_devs.h	2003-04-21 21:19:53.000000000 +0200
@@ -236,6 +236,13 @@
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
 
+/* This entry is needed because the device reports Sub=ff */
+UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0432, 
+		"Sony",
+		"DSC-F707/U10/U20", 
+		US_SC_SCSI, US_PR_CB, NULL,
+		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
+
 /* Reported by wim@geeks.nl */
 UNUSUAL_DEV(  0x054c, 0x0025, 0x0100, 0x0100, 
 		"Sony",
@@ -268,6 +275,12 @@
 		"PEG Mass Storage",
 		US_SC_8070, US_PR_CBI, NULL,
 		US_FL_FIX_INQUIRY ),
+
+UNUSUAL_DEV(  0x054c, 0x0058, 0x0000, 0x9999,
+                "Sony",
+		"PEG-N760C Mass Storage",
+		US_SC_8070, US_PR_CBI, NULL,
+		US_FL_FIX_INQUIRY ),
 		
 UNUSUAL_DEV(  0x057b, 0x0000, 0x0000, 0x0299, 
 		"Y-E Data",
@@ -375,6 +388,12 @@
 		US_SC_SCSI, US_PR_BULK, NULL,
 		US_FL_FIX_INQUIRY | US_FL_MODE_XLATE),
 
+UNUSUAL_DEV(  0x0636, 0x0003, 0x0000, 0x9999,
+		"Vivitar",
+		"Vivicam 35Xx",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_START_STOP | US_FL_FIX_INQUIRY | US_FL_MODE_XLATE),
+
 UNUSUAL_DEV(  0x0644, 0x0000, 0x0100, 0x0100, 
 		"TEAC",
 		"Floppy Drive",
@@ -440,6 +459,12 @@
 		US_FL_SINGLE_LUN | US_FL_START_STOP ),
 #endif
 
+UNUSUAL_DEV(  0x0784, 0x1688, 0x0000, 0x9999,
+		"Vivitar",
+		"Vivicam 36xx",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_START_STOP | US_FL_FIX_INQUIRY | US_FL_MODE_XLATE),
+
 #ifdef CONFIG_USB_STORAGE_FREECOM
 UNUSUAL_DEV(  0x07ab, 0xfc01, 0x0000, 0x9999,
 		"Freecom",
