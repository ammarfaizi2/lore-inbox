Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVAHJaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVAHJaA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVAHJXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:23:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:32901 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261832AbVAHFsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:08 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163264997@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:44 -0800
Message-Id: <11051632643519@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.10, 2004/12/15 15:12:10-08:00, phil@ipom.com

[PATCH] USB Storage: Remove old XLATE-only entries from unusual_devs.h

This patch removes all entries from unusual_devs.h that appear to have
only been there for the MODE_XLATE flag which was removed in my previous
patch.


Signed-off-by: Phil Dibowitz <phil@ipom.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/storage/unusual_devs.h |   26 --------------------------
 1 files changed, 26 deletions(-)


diff -Nru a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h	2005-01-07 15:50:16 -08:00
+++ b/drivers/usb/storage/unusual_devs.h	2005-01-07 15:50:16 -08:00
@@ -739,15 +739,6 @@
 		US_FL_BULK32),
 
 
-/* Aiptek PocketCAM 3Mega
- * Nicolas DUPEUX <nicolas@dupeux.net> 
- */
-UNUSUAL_DEV(  0x08ca, 0x2011, 0x0000, 0x9999,
-		"AIPTEK",
-		"PocketCAM 3Mega",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		0 ),
-
 /* Entry needed for flags. Moreover, all devices with this ID use
  * bulk-only transport, but _some_ falsely report Control/Bulk instead.
  * One example is "Trumpion Digital Research MYMP3".
@@ -773,12 +764,6 @@
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_CAPACITY ),
 
-UNUSUAL_DEV(  0x097a, 0x0001, 0x0000, 0x0001,
-		"Minds@Work",
-		"Digital Wallet",
- 		US_SC_DEVICE, US_PR_DEVICE, NULL,
-		0 ),
-
 /* This Pentax still camera is not conformant
  * to the USB storage specification: -
  * - It does not like the INQUIRY command. So we must handle this command
@@ -881,17 +866,6 @@
 		"Desknote",
 		"UCR-61S2B",
 		US_SC_DEVICE, US_PR_DEVICE, usb_stor_ucr61s2b_init,
-		0 ),
-
-/* Reported by Dan Pilone <pilone@slac.com>
- * The device needs the flags only.
- * Also reported by Brian Hall <brihall@pcisys.net>, again for flags.
- * I also suspect this device may have a broken serial number.
- */
-UNUSUAL_DEV(  0x1065, 0x2136, 0x0000, 0x9999,
-		"CCYU TECHNOLOGY",
-		"EasyDisk Portable Device",
-		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		0 ),
 
 /* Reported by Kotrla Vitezslav <kotrla@ceb.cz> */

