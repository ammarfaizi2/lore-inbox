Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWEBJcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWEBJcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 05:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWEBJcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 05:32:52 -0400
Received: from k2smtpout02-02.prod.mesa1.secureserver.net ([64.202.189.91]:46491
	"HELO k2smtpout02-02.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1750789AbWEBJcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 05:32:52 -0400
X-Antivirus-MYDOMAIN-Mail-From: razvan.g@plutohome.com via plutohome.com.secureserver.net
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(82.77.255.201):SA:0(-2.3/5.0):. Processed in 3.249497 secs Process 7698)
Message-ID: <44572749.6090103@plutohome.com>
Date: Tue, 02 May 2006 12:32:57 +0300
From: Razvan Gavril <razvan.g@plutohome.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ftdi_sio: ACT Solutions HomePro ZWave interface
Content-Type: multipart/mixed;
 boundary="------------010903020409000801060309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903020409000801060309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010903020409000801060309
Content-Type: text/x-patch;
 name="ftdi_sio-ZWave.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ftdi_sio-ZWave.patch"

diff -Nur linux-2.6.16.12/drivers/usb/serial/ftdi_sio.c linux-2.6.16.12-pluto-1/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.16.12/drivers/usb/serial/ftdi_sio.c	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12-pluto-1/drivers/usb/serial/ftdi_sio.c	2006-05-02 05:12:10.000000000 -0400
@@ -307,6 +307,7 @@
 
 
 static struct usb_device_id id_table_combined [] = {
+	{ USB_DEVICE(FTDI_VID, FTDI_ACTZWAVE_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
diff -Nur linux-2.6.16.12/drivers/usb/serial/ftdi_sio.h linux-2.6.16.12-pluto-1/drivers/usb/serial/ftdi_sio.h
--- linux-2.6.16.12/drivers/usb/serial/ftdi_sio.h	2006-05-01 15:14:26.000000000 -0400
+++ linux-2.6.16.12-pluto-1/drivers/usb/serial/ftdi_sio.h	2006-05-02 05:13:00.000000000 -0400
@@ -380,6 +380,9 @@
 /* Pyramid Computer GmbH */
 #define FTDI_PYRAMID_PID	0xE6C8	/* Pyramid Appliance Display */
 
+/* ACT Solutions HomePro ZWave interface (http://www.act-solutions.com/HomePro.htm) */
+#define FTDI_ACTZWAVE_PID      0xF2D0
+
 /*
  * Posiflex inc retail equipment (http://www.posiflex.com.tw)
  */

--------------010903020409000801060309--
