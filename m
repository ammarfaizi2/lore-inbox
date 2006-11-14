Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933445AbWKNRWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933445AbWKNRWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbWKNRWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:22:30 -0500
Received: from sardaukar.technologeek.org ([213.41.134.240]:65440 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S1755450AbWKNRW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:22:29 -0500
From: Julien BLACHE <jb@jblache.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: dmitry.torokhov@gmail.com, stelian@popies.net
Subject: [PATCH] appletouch: use canonical names instead of raw USB IDs
Date: Tue, 14 Nov 2006 18:22:30 +0100
Message-ID: <871wo6q6y1.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

Small readability improvement for appletouch: use canonical names
instead of raw USB IDs for some of the devices.

Signed-off-by: Julien BLACHE <jb@jblache.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=appletouch-canonical-names.patch
Content-Description: appletouch: use canonical names instead of raw USD IDs
 for some devices

--- appletouch.c.orig	2006-11-14 18:14:30.619405923 +0100
+++ appletouch.c	2006-11-14 18:18:14.612170544 +0100
@@ -38,14 +38,21 @@
 #define APPLE_VENDOR_ID		0x05AC
 
 /* These names come from Info.plist in AppleUSBTrackpad.kext */
-#define GEYSER_ANSI_PRODUCT_ID	0x0214
-#define GEYSER_ISO_PRODUCT_ID	0x0215
-#define GEYSER_JIS_PRODUCT_ID	0x0216
+#define FOUNTAIN_ANSI_PRODUCT_ID	0x020E
+#define FOUNTAIN_ISO_PRODUCT_ID		0x020F
+
+#define FOUNTAIN_TP_ONLY_PRODUCT_ID	0x030A
+
+#define GEYSER1_TP_ONLY_PRODUCT_ID	0x030B
+
+#define GEYSER_ANSI_PRODUCT_ID		0x0214
+#define GEYSER_ISO_PRODUCT_ID		0x0215
+#define GEYSER_JIS_PRODUCT_ID		0x0216
 
 /* MacBook devices */
-#define GEYSER3_ANSI_PRODUCT_ID	0x0217
-#define GEYSER3_ISO_PRODUCT_ID	0x0218
-#define GEYSER3_JIS_PRODUCT_ID	0x0219
+#define GEYSER3_ANSI_PRODUCT_ID		0x0217
+#define GEYSER3_ISO_PRODUCT_ID		0x0218
+#define GEYSER3_JIS_PRODUCT_ID		0x0219
 
 #define ATP_DEVICE(prod)					\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -58,10 +65,10 @@
 
 /* table of devices that work with this driver */
 static struct usb_device_id atp_table [] = {
-	{ ATP_DEVICE(0x020E) },
-	{ ATP_DEVICE(0x020F) },
-	{ ATP_DEVICE(0x030A) },
-	{ ATP_DEVICE(0x030B) },
+	{ ATP_DEVICE(FOUNTAIN_ANSI_PRODUCT_ID) },
+	{ ATP_DEVICE(FOUNTAIN_ISO_PRODUCT_ID) },
+	{ ATP_DEVICE(FOUNTAIN_TP_ONLY_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER1_TP_ONLY_PRODUCT_ID) },
 
 	/* PowerBooks Oct 2005 */
 	{ ATP_DEVICE(GEYSER_ANSI_PRODUCT_ID) },

--=-=-=


JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169

--=-=-=--
