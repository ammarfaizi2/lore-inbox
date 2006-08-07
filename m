Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWHGNpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWHGNpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHGNpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:45:11 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:51423 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932096AbWHGNpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:45:10 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 7 Aug 2006 14:44:15 +0100 (BST)
From: Jonathan Davies <jjd27@cam.ac.uk>
X-X-Sender: jjd27@hermes-2.csi.cam.ac.uk
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, jjd27@cam.ac.uk
Subject: Re: [PATCH] ftdi_sio driver - new PIDs
In-Reply-To: <20060804172340.GA10696@kroah.com>
Message-ID: <Pine.LNX.4.64.0608071350300.8139@hermes-2.csi.cam.ac.uk>
References: <44D35AF1.2040200@cam.ac.uk> <20060804172340.GA10696@kroah.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-231980480-1154958255=:8139"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-231980480-1154958255=:8139
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE


> Your patch is line-wrapped and the tabs are eaten, making it hard to
> apply the patch :(

Sorry; I'll try again with a different mail client!

> Also, can you make this against the 2.6.18-rc3 kernel, as there are a
> lot of new ids already added for this device and this patch conflicts
> with it a bit.

Done. The new patch is below. Hopefully this one is an improvement...

Signed-off-by: Jonathan Davies <jjd27@cam.ac.uk>

diff -uprN -X linux-2.6.18-rc3-vanilla/Documentation/dontdiff linux-2.6.18-=
rc3-vanilla/drivers/usb/serial/ftdi_sio.c linux-2.6.18-rc3/drivers/usb/seri=
al/ftdi_sio.c
--- linux-2.6.18-rc3-vanilla/drivers/usb/serial/ftdi_sio.c=092006-07-30 07:=
15:36.000000000 +0100
+++ linux-2.6.18-rc3/drivers/usb/serial/ftdi_sio.c=092006-08-07 11:33:15.00=
0000000 +0100
@@ -306,6 +306,8 @@ static struct ftdi_sio_quirk ftdi_HE_TIR


  static struct usb_device_id id_table_combined [] =3D {
+=09{ USB_DEVICE(FTDI_VID, FTDI_AMC232_PID) },
+=09{ USB_DEVICE(FTDI_VID, FTDI_CANUSB_PID) },
  =09{ USB_DEVICE(FTDI_VID, FTDI_ACTZWAVE_PID) },
  =09{ USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
  =09{ USB_DEVICE(FTDI_VID, FTDI_IPLUS_PID) },
diff -uprN -X linux-2.6.18-rc3-vanilla/Documentation/dontdiff linux-2.6.18-=
rc3-vanilla/drivers/usb/serial/ftdi_sio.h linux-2.6.18-rc3/drivers/usb/seri=
al/ftdi_sio.h
--- linux-2.6.18-rc3-vanilla/drivers/usb/serial/ftdi_sio.h=092006-07-30 07:=
15:36.000000000 +0100
+++ linux-2.6.18-rc3/drivers/usb/serial/ftdi_sio.h=092006-08-07 11:32:25.00=
0000000 +0100
@@ -35,6 +35,11 @@
  /* ACT Solutions HomePro ZWave interface (http://www.act-solutions.com/Ho=
mePro.htm) */
  #define FTDI_ACTZWAVE_PID=090xF2D0

+/* www.canusb.com/ Lawicel CANUSB device */
+#define FTDI_CANUSB_PID 0xFFA8 /* Product Id */
+
+/* AlphaMicro Components AMC-232USB01 device */
+#define FTDI_AMC232_PID 0xFF00 /* Product Id */

  /* www.starting-point-systems.com =C2=B5Chameleon device */
  #define FTDI_MICRO_CHAMELEON_PID=090xCAA0=09/* Product Id */

--1870870024-231980480-1154958255=:8139--
