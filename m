Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVAHICc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVAHICc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVAHHwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:52:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:36741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261845AbVAHFsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:11 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632643128@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:44 -0800
Message-Id: <1105163264463@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.8, 2004/12/15 15:10:26-08:00, phil@ipom.com

[PATCH] USB Storage: Remove MODE_XLATE flag from unusual_devs.h

This patch removes all MODE_XLATE flags from unusual_devs.h. Since the
file is no longer close to in sync with the 2.4 version, Alan and I
agreed it's reasonable to remove all of these now.

Signed-off-by: Phil Dibowitz <phil@ipom.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/storage/unusual_devs.h |   58 ++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 29 deletions(-)


diff -Nru a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	2005-01-07 15:50:31 -08:00
+++ b/drivers/usb/storage/unusual_devs.h	2005-01-07 15:50:31 -08:00
@@ -321,14 +321,14 @@
 		"Sony",
 		"DSC-S30/S70/S75/505V/F505/F707/F717/P8", 
 		US_SC_SCSI, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN | US_FL_MODE_XLATE ),
+		US_FL_SINGLE_LUN ),
 
 /* This entry is needed because the device reports Sub=ff */
 UNUSUAL_DEV(  0x054c, 0x0010, 0x0500, 0x0500, 
                "Sony",
                "DSC-T1", 
                US_SC_8070, US_PR_DEVICE, NULL,
-               US_FL_SINGLE_LUN | US_FL_MODE_XLATE ),
+               US_FL_SINGLE_LUN ),
 
 
 /* Reported by wim@geeks.nl */
@@ -357,14 +357,14 @@
 		"Sony",
 		"Handycam",
 		US_SC_SCSI, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN | US_FL_MODE_XLATE),
+		US_FL_SINGLE_LUN ),
 
 /* Submitted by Rajesh Kumble Nayak <nayak@obs-nice.fr> */
 UNUSUAL_DEV(  0x054c, 0x002e, 0x0500, 0x0500, 
 		"Sony",
 		"Handycam HC-85",
 		US_SC_UFI, US_PR_DEVICE, NULL,
-		US_FL_SINGLE_LUN | US_FL_MODE_XLATE),
+		US_FL_SINGLE_LUN ),
 
 UNUSUAL_DEV(  0x054c, 0x0032, 0x0000, 0x9999,
 		"Sony",
@@ -494,7 +494,7 @@
 		"Lexar",
 		"Jumpshot USB CF Reader",
 		US_SC_SCSI, US_PR_JUMPSHOT, NULL,
-		US_FL_NEED_OVERRIDE | US_FL_MODE_XLATE ),
+		US_FL_NEED_OVERRIDE ),
 #endif
 
 /* Reported by Blake Matheny <bmatheny@purdue.edu> */
@@ -510,7 +510,7 @@
 		"Vivitar",
 		"Vivicam 35Xx",
 		US_SC_SCSI, US_PR_BULK, NULL,
-		US_FL_FIX_INQUIRY | US_FL_MODE_XLATE),
+		US_FL_FIX_INQUIRY ),
 
 UNUSUAL_DEV(  0x0644, 0x0000, 0x0100, 0x0100, 
 		"TEAC",
@@ -620,48 +620,48 @@
 		"Datafab",
 		"MDCFE-B USB CF Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 
-	/*
-	 * The following Datafab-based devices may or may not work
-	 * using the current driver...the 0xffff is arbitrary since I
-	 * don't know what device versions exist for these guys.
-	 *
-	 * The 0xa003 and 0xa004 devices in particular I'm curious about.
-	 * I'm told they exist but so far nobody has come forward to say that
-	 * they work with this driver.  Given the success we've had getting
-	 * other Datafab-based cards operational with this driver, I've decided
-	 * to leave these two devices in the list.
-	 */
+/*
+ * The following Datafab-based devices may or may not work
+ * using the current driver...the 0xffff is arbitrary since I
+ * don't know what device versions exist for these guys.
+ *
+ * The 0xa003 and 0xa004 devices in particular I'm curious about.
+ * I'm told they exist but so far nobody has come forward to say that
+ * they work with this driver.  Given the success we've had getting
+ * other Datafab-based cards operational with this driver, I've decided
+ * to leave these two devices in the list.
+ */
 UNUSUAL_DEV( 0x07c4, 0xa001, 0x0000, 0xffff,
 		"SIIG/Datafab",
 		"SIIG/Datafab Memory Stick+CF Reader/Writer",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 
 UNUSUAL_DEV( 0x07c4, 0xa003, 0x0000, 0xffff,
 		"Datafab/Unknown",
 		"Datafab-based Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 
 UNUSUAL_DEV( 0x07c4, 0xa004, 0x0000, 0xffff,
 		"Datafab/Unknown",
 		"Datafab-based Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 
 UNUSUAL_DEV( 0x07c4, 0xa005, 0x0000, 0xffff,
 		"PNY/Datafab",
 		"PNY/Datafab CF+SM Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 
 UNUSUAL_DEV( 0x07c4, 0xa006, 0x0000, 0xffff,
 		"Simple Tech/Datafab",
 		"Simple Tech/Datafab CF+SM Reader",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 #endif
 		
 #ifdef CONFIG_USB_STORAGE_SDDR55
@@ -679,7 +679,7 @@
 		"Datafab Systems, Inc.",
 		"USB to CF + SM Combo (LC1)",
 		US_SC_SCSI, US_PR_DATAFAB, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 #endif
 #ifdef CONFIG_USB_STORAGE_SDDR55
 /* SM part - aeb <Andries.Brouwer@cwi.nl> */
@@ -746,7 +746,7 @@
 		"AIPTEK",
 		"PocketCAM 3Mega",
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 
 /* Entry needed for flags. Moreover, all devices with this ID use
  * bulk-only transport, but _some_ falsely report Control/Bulk instead.
@@ -757,14 +757,14 @@
 		"Trumpion",
 		"t33520 USB Flash Card Controller",
 		US_SC_DEVICE, US_PR_BULK, NULL,
-		US_FL_NEED_OVERRIDE | US_FL_MODE_XLATE),
+		US_FL_NEED_OVERRIDE ),
 
 /* Trumpion Microelectronics MP3 player (felipe_alfaro@linuxmail.org) */
 UNUSUAL_DEV( 0x090a, 0x1200, 0x0000, 0x9999,
 		"Trumpion",
 		"MP3 player",
 		US_SC_RBC, US_PR_BULK, NULL,
-		US_FL_MODE_XLATE),
+		0 ),
 
 /* aeb */
 UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
@@ -777,7 +777,7 @@
 		"Minds@Work",
 		"Digital Wallet",
  		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 
 /* This Pentax still camera is not conformant
  * to the USB storage specification: -
@@ -892,7 +892,7 @@
 		"CCYU TECHNOLOGY",
 		"EasyDisk Portable Device",
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		US_FL_MODE_XLATE ),
+		0 ),
 
 /* Reported by Kotrla Vitezslav <kotrla@ceb.cz> */
 UNUSUAL_DEV(  0x1370, 0x6828, 0x0110, 0x0110,

