Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWB1Wzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWB1Wzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWB1Wzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:55:52 -0500
Received: from ns2.tasking.nl ([195.193.207.10]:4780 "EHLO ns2.tasking.nl")
	by vger.kernel.org with ESMTP id S932681AbWB1Wzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:55:52 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
From: dick@streefland.net (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
Subject: [PATCH] support for USB-to-serial cable from Speed Dragon Multimedia
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <1a9a.4404d4f6.330ff@altium.nl>
Date: Tue, 28 Feb 2006 22:55:50 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The USB data cable for my Samsung GSM phone contains the USB-to-serial
converter chip MS3303H from Speed Dragon Multimedia, Inc. that appears
to be compatible with the PL2303 chip. The following patch adds support
for this chip to the pl2303 driver.

Signed-off-by: Dick Streefland <dick@streefland.net>

--- linux-2.6.16-rc5/drivers/usb/serial/pl2303.c.orig	2006-02-28 22:24:44.000000000 +0100
+++ linux-2.6.16-rc5/drivers/usb/serial/pl2303.c	2006-02-28 22:55:54.000000000 +0100
@@ -77,6 +77,7 @@ static struct usb_device_id id_table [] 
 	{ USB_DEVICE(CA_42_CA42_VENDOR_ID, CA_42_CA42_PRODUCT_ID) },
 	{ USB_DEVICE(SAGEM_VENDOR_ID, SAGEM_PRODUCT_ID) },
 	{ USB_DEVICE(LEADTEK_VENDOR_ID, LEADTEK_9531_PRODUCT_ID) },
+	{ USB_DEVICE(SPEEDDRAGON_VENDOR_ID, SPEEDDRAGON_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
--- linux-2.6.16-rc5/drivers/usb/serial/pl2303.h.orig	2006-02-28 22:24:44.000000000 +0100
+++ linux-2.6.16-rc5/drivers/usb/serial/pl2303.h	2006-02-28 22:57:58.000000000 +0100
@@ -75,3 +75,7 @@
 /* Leadtek GPS 9531 (ID 0413:2101) */
 #define LEADTEK_VENDOR_ID	0x0413
 #define LEADTEK_9531_PRODUCT_ID	0x2101
+
+/* USB GSM cable from Speed Dragon Multimedia, Ltd */
+#define SPEEDDRAGON_VENDOR_ID	0x0e55
+#define SPEEDDRAGON_PRODUCT_ID	0x110b

