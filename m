Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVAMThW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVAMThW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVAMTgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:36:11 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:29189 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S261356AbVAMTcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:32:32 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]: add Ever UPS vendor/product id to ftdi_sio driver
Date: Thu, 13 Jan 2005 20:30:33 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200501132014.34558.arekm@pld-linux.org> <20050113192517.GA29433@kroah.com>
In-Reply-To: <20050113192517.GA29433@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Zxs5BauTuOk0oaz"
Message-Id: <200501132030.33996.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Zxs5BauTuOk0oaz
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 13 of January 2005 20:25, Greg KH wrote:

> Your email client got hungry and ate all of the tabs for lunch.=20
Hungry bastard.

> Care to=20
> resend it?
This time as attachment.

> thanks,
> greg k-h

=2D-=20
Arkadiusz Mi=B6kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/

--Boundary-00=_Zxs5BauTuOk0oaz
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="ftdi_sio-ever.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ftdi_sio-ever.patch"

--- drivers/usb/serial/ftdi_sio.h.org	2005-01-13 16:32:21.000000000 +0100
+++ drivers/usb/serial/ftdi_sio.h	2005-01-13 16:37:33.000000000 +0100
@@ -240,6 +240,12 @@
 #define FTDI_RM_VID		0x0403	/* Vendor  Id */
 #define FTDI_RMCANVIEW_PID	0xfd60	/* Product Id */
 
+/*
+ * EVER Eco Pro UPS (http://www.ever.com.pl/)
+ */
+
+#define	EVER_ECO_PRO_CDS	0xe520	/* RS-232 converter */
+
 /* Commands */
 #define FTDI_SIO_RESET 		0 /* Reset the port */
 #define FTDI_SIO_MODEM_CTRL 	1 /* Set the modem control register */
--- drivers/usb/serial/ftdi_sio.c.org	2005-01-13 16:32:26.000000000 +0100
+++ drivers/usb/serial/ftdi_sio.c	2005-01-13 17:04:12.000000000 +0100
@@ -372,6 +372,7 @@
 	{ USB_DEVICE_VER(BANDB_VID, BANDB_USOTL4_PID, 0, 0x3ff) },
 	{ USB_DEVICE_VER(BANDB_VID, BANDB_USTL4_PID, 0, 0x3ff) },
 	{ USB_DEVICE_VER(BANDB_VID, BANDB_USO9ML2_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FTDI_VID, EVER_ECO_PRO_CDS, 0, 0x3ff) },
 	{ }						/* Terminating entry */
 };
 
@@ -486,6 +487,7 @@
 	{ USB_DEVICE_VER(BANDB_VID, BANDB_USOTL4_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(BANDB_VID, BANDB_USTL4_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(BANDB_VID, BANDB_USO9ML2_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, EVER_ECO_PRO_CDS, 0x400, 0xffff) },
 	{ }						/* Terminating entry */
 };
 
@@ -608,6 +610,7 @@
 	{ USB_DEVICE(BANDB_VID, BANDB_USOTL4_PID) },
 	{ USB_DEVICE(BANDB_VID, BANDB_USTL4_PID) },
 	{ USB_DEVICE(BANDB_VID, BANDB_USO9ML2_PID) },
+	{ USB_DEVICE(FTDI_VID, EVER_ECO_PRO_CDS) },
 	{ }						/* Terminating entry */
 };
 

--Boundary-00=_Zxs5BauTuOk0oaz--
