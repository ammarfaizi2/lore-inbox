Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWCNXoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWCNXoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWCNXoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:44:44 -0500
Received: from airborne.nrl.navy.mil ([132.250.182.112]:34519 "EHLO
	airborne.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S1751139AbWCNXon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:44:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17431.21847.295167.980061@airborne.nrl.navy.mil>
Date: Tue, 14 Mar 2006 18:44:23 -0500
From: "A. Maitland Bottoms" <bottoms@debian.org>
To: Greg KH <greg@kroah.com>, Bill Ryder <bryder@sgi.com>,
       Kuba Ober <kuba@mareimbrium.org>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: PATCH - ftdi_sio: add Icom ID1 USB product and vendor ids
In-Reply-To: <20060313223806.GA25380@kroah.com>
References: <20060313223806.GA25380@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-Attribution: Maitland
X-Organization: AMRAD, aa4hs@amrad.org
X-Tom-Swifty: "I'll have to grade your test again," Tom remarked. 
X-Face: #_Z/6E$=iDx1F]P+Ihzq7A<v$oCzxp*t+AV4bAbTX:5Ksc|%b>.ptGp'9^{lq:).f}z;/C~
 TS*Y?KNb=~^*%0FWY>#8tyl]O')dv!Y:s~a#BK?fuo;~J8u,S>HZ&|o9gi~'<@woChY;)>#|">)vr+
 9Zd,@,)F[7)5O!Ry2>BJC%<N.ALz7)FHAt-t.eSF$Z{j'*vE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "A. Maitland Bottoms" <bottoms@debian.org>

The Icom ID-1 1.2 GHz band digital transceiver is a new radio
that has a USB interface. With this patch, the ftdi_sio driver
will report "Detected FT8U232AM" and provide a serial device
interface.

Signed-off-by: "A. Maitland Bottoms" <bottoms@debian.org>

---

diff -uprN linux-source-2.6.15.orig/drivers/usb/serial/ftdi_sio.c linux-source-2.6.15/drivers/usb/serial/ftdi_sio.c
--- linux-source-2.6.15.orig/drivers/usb/serial/ftdi_sio.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-source-2.6.15/drivers/usb/serial/ftdi_sio.c	2006-03-14 17:15:03.462259760 -0500
@@ -477,6 +477,7 @@ static struct usb_device_id id_table_com
 	{ USB_DEVICE(FTDI_VID, FTDI_ATIK_ATK16HR_PID) },
 	{ USB_DEVICE(KOBIL_VID, KOBIL_CONV_B1_PID) },
 	{ USB_DEVICE(KOBIL_VID, KOBIL_CONV_KAAN_PID) },
+	{ USB_DEVICE(ICOM_ID1_VID, ICOM_ID1_PID) },
 	{ },					/* Optional parameter entry */
 	{ }					/* Terminating entry */
 };
diff -uprN linux-source-2.6.15.orig/drivers/usb/serial/ftdi_sio.h linux-source-2.6.15/drivers/usb/serial/ftdi_sio.h
--- linux-source-2.6.15.orig/drivers/usb/serial/ftdi_sio.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-source-2.6.15/drivers/usb/serial/ftdi_sio.h	2006-03-14 17:14:18.199140800 -0500
@@ -135,6 +135,13 @@
 #define KOBIL_CONV_KAAN_PID	0x2021	/* KOBIL_Konverter for KAAN */
 
 /*
+ * Icom ID-1 digital transceiver
+ */
+
+#define ICOM_ID1_VID            0x0C26
+#define ICOM_ID1_PID            0x0004
+
+/*
  * DSS-20 Sync Station for Sony Ericsson P800
  */
  
