Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSJ0Xy4>; Sun, 27 Oct 2002 18:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbSJ0Xy4>; Sun, 27 Oct 2002 18:54:56 -0500
Received: from cm13774.telecable.es ([213.141.62.61]:32644 "EHLO Catharsis")
	by vger.kernel.org with ESMTP id <S262129AbSJ0Xyz>;
	Sun, 27 Oct 2002 18:54:55 -0500
Date: Mon, 28 Oct 2002 01:01:25 +0100
From: David Garcia <zako@telecable.es>
To: linux-kernel@vger.kernel.org
Subject: Palm ZIRE drivers/usb/serial/visor patch
Message-ID: <20021028000125.GA12160@Catharsis>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Mailer: Mutt 1.4i
X-Operating-System: Linux Catharsis 2.4.19 Debian 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all!

I've just made a patch to the 2.4.19 kernel, in order to support the
hotsync with the ZIRE Palm handheld.

The problem was that the product_id of this new palm was not defined,
so the visor.o module didn't recognize it and didn't load.

I added the product_id to the ID defines at
drivers/usb/serial/visor.h and added an array entry with the new
define at drivers/usb/serial/visor.h

I attach the patch needed to make that changes.

I'd like to be CC with the answers, cause i'm not subscribed to the
list.

Stay in touch.
David.

--
--------------------------------++----------------------------------
David Garcia		        ||	            Debian GNU/Linux 
zako@telecable.es	        ||             http://www.debian.org
http://www.asturiaswireless.net || GNU's Not Unix http://www.gnu.org
--------------------------------++----------------------------------
GnuPG Public Key: http://www.asturiaswireless.net/zako@telecable.asc
Key fingerprint = 1D11 9F84 7442 5E01 3462  3CD7 0701 DD7B F04F E15B
--------------------------------------------------------------------
--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_zire_palm

--- linux-2.4.19/drivers/usb/serial/visor.h	2002-10-28 00:32:25.000000000 +0100
+++ linux/drivers/usb/serial/visor.h	2002-10-28 00:35:33.000000000 +0100
@@ -27,6 +27,7 @@
 #define PALM_I705_ID			0x0020
 #define PALM_M125_ID			0x0040
 #define PALM_M130_ID			0x0050
+#define PALM_ZIRE_ID                    0x0070
 
 #define SONY_VENDOR_ID			0x054C
 #define SONY_CLIE_3_5_ID		0x0038
--- linux-2.4.19/drivers/usb/serial/visor.c	2002-10-28 00:32:20.000000000 +0100
+++ linux/drivers/usb/serial/visor.c	2002-10-28 00:29:48.000000000 +0100
@@ -182,6 +182,7 @@
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M125_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M130_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_I705_ID) },
+        { USB_DEVICE(PALM_VENDOR_ID, PALM_ZIRE_ID) },
 	{ }					/* Terminating entry */
 };
 

--cWoXeonUoKmBZSoM--
