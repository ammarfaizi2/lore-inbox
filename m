Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266822AbUAXAn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUAXAn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:43:58 -0500
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:33765 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S266822AbUAXAnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:43:55 -0500
Message-ID: <4011BFD7.7030308@mech.kuleuven.ac.be>
Date: Sat, 24 Jan 2004 01:44:07 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@zip.com.au
Subject: [patch] Graphire3 support
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020003030601080600020907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020003030601080600020907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I got a Wacom Graphire3 for my birthday and unfortunately it didn't 
work. After some playing around, I noticed the 2.6 kernel needs a few 
small modifications to make it work.

This simple patch adds support for the Wacom Graphire 3.  It applies 
fine to both 2.6.2-rc1-mm2 and 2.6.2-rc1.

With friendly regards,
Takis

--------------020003030601080600020907
Content-Type: text/x-patch;
 name="pi-20040124_0120-linux_2.6.2_rc1_mm2-graphire3_support.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pi-20040124_0120-linux_2.6.2_rc1_mm2-graphire3_support.diff"

diff -ur linux-2.6.1/drivers/usb/input/hid-core.c /scratch/src/linux-2.6/drivers/usb/input/hid-core.c
--- linux-2.6.1/drivers/usb/input/hid-core.c	2004-01-24 01:09:01.000000000 +0100
+++ /scratch/src/linux-2.6/drivers/usb/input/hid-core.c	2004-01-24 00:27:24.000000000 +0100
@@ -1369,6 +1369,7 @@
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 2, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 2, HID_QUIRK_IGNORE },
diff -ur linux-2.6.1/drivers/usb/input/wacom.c /scratch/src/linux-2.6/drivers/usb/input/wacom.c
--- linux-2.6.1/drivers/usb/input/wacom.c	2004-01-24 01:07:28.000000000 +0100
+++ /scratch/src/linux-2.6/drivers/usb/input/wacom.c	2004-01-24 00:53:23.000000000 +0100
@@ -428,6 +428,7 @@
         { "Wacom Graphire",      8,  10206,  7422,  511, 32, 1, wacom_graphire_irq },
 	{ "Wacom Graphire2 4x5", 8,  10206,  7422,  511, 32, 1, wacom_graphire_irq },
  	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 32, 1, wacom_graphire_irq },
+ 	{ "Wacom Graphire3", 8,  13918, 10206,  511, 32, 1, wacom_graphire_irq },
   	{ "Wacom Intuos 4x5",   10,  12700, 10360, 1023, 15, 2, wacom_intuos_irq },
  	{ "Wacom Intuos 6x8",   10,  20600, 16450, 1023, 15, 2, wacom_intuos_irq },
  	{ "Wacom Intuos 9x12",  10,  30670, 24130, 1023, 15, 2, wacom_intuos_irq },
@@ -452,6 +453,7 @@
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x10) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x11) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x12) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x13) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x20) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x21) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x22) },

--------------020003030601080600020907--
