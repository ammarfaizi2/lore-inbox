Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030619AbWHIJsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbWHIJsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbWHIJsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:48:15 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:26086 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030619AbWHIJsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:48:14 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 9 Aug 2006 10:48:03 +0100
From: Jonathan Davies <jjd27@cam.ac.uk>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, jjd27@cam.ac.uk
Subject: Re: [PATCH] ftdi_sio driver - new PIDs
Message-ID: <20060809094803.GA22922@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> On Mon, Aug 07, 2006 at 02:44:15PM +0100, Jonathan Davies wrote:
>>> Your patch is line-wrapped and the tabs are eaten, making it hard to
>>> apply the patch :(
>> Sorry; I'll try again with a different mail client!
> 
> Closer, the tabs are now fine, but the patch is line-wrapped, and you
> are using a mime email, which means I can't directly apply the patch...

Time to try a third mail client.

> Care to try again, third time's the charm :)

Here we go again:

Signed-off-by: Jonathan Davies <jjd27@cam.ac.uk>

diff -uprN -X linux-2.6.18-rc3-vanilla/Documentation/dontdiff linux-2.6.18-rc3-vanilla/drivers/usb/serial/ftdi_sio.c linux-2.6.18-rc3/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.18-rc3-vanilla/drivers/usb/serial/ftdi_sio.c	2006-07-30 07:15:36.000000000 +0100
+++ linux-2.6.18-rc3/drivers/usb/serial/ftdi_sio.c	2006-08-07 11:33:15.000000000 +0100
@@ -306,6 +306,8 @@ static struct ftdi_sio_quirk ftdi_HE_TIR
 
 
 static struct usb_device_id id_table_combined [] = {
+	{ USB_DEVICE(FTDI_VID, FTDI_AMC232_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_CANUSB_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ACTZWAVE_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_IPLUS_PID) },
diff -uprN -X linux-2.6.18-rc3-vanilla/Documentation/dontdiff linux-2.6.18-rc3-vanilla/drivers/usb/serial/ftdi_sio.h linux-2.6.18-rc3/drivers/usb/serial/ftdi_sio.h
--- linux-2.6.18-rc3-vanilla/drivers/usb/serial/ftdi_sio.h	2006-07-30 07:15:36.000000000 +0100
+++ linux-2.6.18-rc3/drivers/usb/serial/ftdi_sio.h	2006-08-09 10:34:50.000000000 +0100
@@ -32,6 +32,12 @@
 #define FTDI_NF_RIC_PID	0x0001	/* Product Id */
 
 
+/* www.canusb.com Lawicel CANUSB device */
+#define FTDI_CANUSB_PID 0xFFA8 /* Product Id */
+
+/* AlphaMicro Components AMC-232USB01 device */
+#define FTDI_AMC232_PID 0xFF00 /* Product Id */
+
 /* ACT Solutions HomePro ZWave interface (http://www.act-solutions.com/HomePro.htm) */
 #define FTDI_ACTZWAVE_PID	0xF2D0
 
