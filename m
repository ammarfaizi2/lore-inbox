Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965906AbWKNTPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965906AbWKNTPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965940AbWKNTPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:15:34 -0500
Received: from sardaukar.technologeek.org ([213.41.134.240]:28605 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S965906AbWKNTPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:15:34 -0500
From: Julien BLACHE <jb@jblache.org>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Subject: [PATCH] hid-core: canonical defines for Apple USB device IDs
References: <871wo6q6y1.fsf@frigate.technologeek.org>
	<1163526312.28910.14.camel@deep-space-9.dsnet>
Date: Tue, 14 Nov 2006 20:15:34 +0100
In-Reply-To: <1163526312.28910.14.camel@deep-space-9.dsnet> (Stelian Pop's
	message of "Tue, 14 Nov 2006 18:45:12 +0100")
Message-ID: <87k61xq1pl.fsf_-_@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> wrote:

Hi,

>> Small readability improvement for appletouch: use canonical names
>> instead of raw USB IDs for some of the devices.
>
> While you're at it, please update hid-core.c too for the FN_KEY quirks.
>
> The same comments applies to your other patch which adds the new Geyser
> IV ids. Those needs to be added to hid-core.c too.

Here it is.

Use canonical defines for the Apple USB device IDs.
Also add the Geyser IV devices missing in my previous patch.

Signed-off-by: Julien BLACHE <jb@jblache.org>

--- linux-2.6.19-rc5/drivers/usb/input/hid-core.c.orig	2006-11-14 20:06:54.523719128 +0100
+++ linux-2.6.19-rc5/drivers/usb/input/hid-core.c	2006-11-14 19:43:18.050998948 +0100
@@ -1627,6 +1627,19 @@
 
 #define USB_VENDOR_ID_APPLE		0x05ac
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
+#define USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI	0x020e
+#define USB_DEVICE_ID_APPLE_FOUNTAIN_ISO	0x020f
+#define USB_DEVICE_ID_APPLE_GEYSER_ANSI	0x0214
+#define USB_DEVICE_ID_APPLE_GEYSER_ISO	0x0215
+#define USB_DEVICE_ID_APPLE_GEYSER_JIS	0x0216
+#define USB_DEVICE_ID_APPLE_GEYSER3_ANSI	0x0217
+#define USB_DEVICE_ID_APPLE_GEYSER3_ISO	0x0218
+#define USB_DEVICE_ID_APPLE_GEYSER3_JIS	0x0219
+#define USB_DEVICE_ID_APPLE_GEYSER4_ANSI	0x021a
+#define USB_DEVICE_ID_APPLE_GEYSER4_ISO	0x021b
+#define USB_DEVICE_ID_APPLE_GEYSER4_JIS	0x021c
+#define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
+#define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
 
 #define USB_VENDOR_ID_CHERRY		0x046a
 #define USB_DEVICE_ID_CHERRY_CYMOTION	0x0023
@@ -1794,17 +1807,19 @@
 
 	{ USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION, HID_QUIRK_CYMOTION },
 
-	{ USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x0217, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x0218, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x0219, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x021B, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_POWERBOOK_HAS_FN },
 
 	{ USB_VENDOR_ID_PANJIT, 0x0001, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_PANJIT, 0x0002, HID_QUIRK_IGNORE },


> Oh, and put your patch in the mail inline, it's easier to quote if
> needed.

MIME-inline obviously isn't good enough :/ Sorry for that.

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169
