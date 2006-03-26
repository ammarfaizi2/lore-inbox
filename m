Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWCZQbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCZQbR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWCZQbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:31:16 -0500
Received: from main.gmane.org ([80.91.229.2]:17562 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751430AbWCZQbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:31:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: [2.6 PATCH 2/2]: add support for Papouch TMU (USB thermometer)
Date: Mon, 27 Mar 2006 01:30:55 +0900
Message-ID: <4426C1BF.90802@thinrope.net>
References: <4426BD1A.7070204@thinrope.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Folkert van Heusden <folkert@vanheusden.com>
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060324)
In-Reply-To: <4426BD1A.7070204@thinrope.net>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds support for new vendor (papouch) and one of their
devices - TMU (a USB thermometer).

More information:
vendor homepage:
	http://www.papouch.com/en/
product homepage (Polish):
	http://www.papouch.com/shop/scripts/_detail.asp?katcislo=0188

This patch is based on the submission from Folkert van Heusden [1].
Folkert, please test it and add your ACK here.

Unfortunately I don't own such device, so this is not tested.

[1]	http://article.gmane.org/gmane.linux.kernel/392970


Signed-off-by: Kalin KOZHUHAROV <kalin@thinrope.net>


diff -pruN linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.c linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.c	2006-03-27 00:52:20.000000000 +0900
@@ -492,6 +492,7 @@ static struct usb_device_id id_table_com
 	{ USB_DEVICE(FTDI_VID, FTDI_WESTREX_MODEL_777_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_WESTREX_MODEL_8900F_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_PCDJ_DAC2_PID) },
+	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_TMU_PID) },
 	{ },					/* Optional parameter entry */
 	{ }					/* Terminating entry */
 };
diff -pruN linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.h linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.h
--- linux-2.6.16-K01/drivers/usb/serial/ftdi_sio.h	2006-03-27 00:49:43.000000000 +0900
+++ linux-2.6.16-tmp/drivers/usb/serial/ftdi_sio.h	2006-03-27 00:46:55.000000000 +0900
@@ -392,6 +392,15 @@
 #define FTDI_WESTREX_MODEL_777_PID	0xDC00	/* Model 777 */
 #define FTDI_WESTREX_MODEL_8900F_PID	0xDC01	/* Model 8900F */
 
+/*
+ * Papouch products (http://www.papouch.com/)
+ * Submitted by Folkert van Heusden
+ */
+
+#define PAPOUCH_VID			0x5050	/* Vendor ID */
+#define PAPOUCH_TMU_PID			0x0400	/* TMU USB Thermometer */
+
+
 /* Commands */
 #define FTDI_SIO_RESET			0	/* Reset the port */
 #define FTDI_SIO_MODEM_CTRL		1	/* Set the modem control register */


-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

