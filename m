Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWACNaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWACNaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWACNau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:30:50 -0500
Received: from tougher.kangaroot.net ([62.213.203.135]:57833 "EHLO
	tougher.kangaroot.net") by vger.kernel.org with ESMTP
	id S932362AbWACNap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:30:45 -0500
Date: Tue, 3 Jan 2006 14:30:31 +0100
From: Wouter Paesen <wouter@kangaroot.net>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15] ftdi_sio: new PID for PCDJ DAC2
Message-ID: <20060103133031.GA10080@tougher.kangaroot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch adds a new PID for the ftdi_sio driver.  It will
enable support for PC-DJ's DAC-2 controller module 
(more information on http://www.pcdjhardware.com/DAC2.asp)

------------------------------------------------------------------------
Wouter Paesen                                  Kangaroot Linux Solutions            
System Adminstrator / Developer                        Grote Steenweg 91            
wouter@kangaroot.net                                        2600 Berchem            
Tel: +32 3 286 17 10                                             Belgium            
Fax: +32 3 281 23 49                                                                
------------------------- http://www.kangaroot.net ---------------------

Signed-off-by: Wouter Paesen <wouter@kangaroot.net>

diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/drivers/usb/serial/ftdi_sio.c linux-2.6.15/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.15-vanilla/drivers/usb/serial/ftdi_sio.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/usb/serial/ftdi_sio.c	2006-01-03 12:59:15.000000000 +0100
@@ -477,6 +477,7 @@ static struct usb_device_id id_table_com
 	{ USB_DEVICE(FTDI_VID, FTDI_ATIK_ATK16HR_PID) },
 	{ USB_DEVICE(KOBIL_VID, KOBIL_CONV_B1_PID) },
 	{ USB_DEVICE(KOBIL_VID, KOBIL_CONV_KAAN_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_PCDJ_DAC2_PID) },
 	{ },					/* Optional parameter entry */
 	{ }					/* Terminating entry */
 };
diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/drivers/usb/serial/ftdi_sio.h linux-2.6.15/drivers/usb/serial/ftdi_sio.h
--- linux-2.6.15-vanilla/drivers/usb/serial/ftdi_sio.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/usb/serial/ftdi_sio.h	2006-01-03 12:58:53.000000000 +0100
@@ -51,6 +51,12 @@
 #define FTDI_VNHCPCUSB_D_PID 0xfe38 /* Product Id */
 
 /*
+ * PCDJ use ftdi based dj-controllers.  The following PID is for their DAC-2 device
+ * http://www.pcdjhardware.com/DAC2.asp (PID sent by Wouter Paesen)
+ * (the VID is the standard ftdi vid (FTDI_VID) */
+#define FTDI_PCDJ_DAC2_PID 0xFA88
+
+/*
  * The following are the values for the Matrix Orbital LCD displays,
  * which are the FT232BM ( similar to the 8U232AM )
  */



