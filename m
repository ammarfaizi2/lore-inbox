Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVG3Auj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVG3Auj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVG2TSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:18:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:19375 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262758AbVG2TRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:01 -0400
Date: Fri, 29 Jul 2005 12:16:31 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, abbotti@mev.co.uk
Subject: [patch 17/29] USB: ftdi_sio: new microHAM and Evolution Robotics devices
Message-ID: <20050729191631.GS5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ftdi_sio-new-devices.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

The attached patch adds the following new devices to the ftdi_sio driver:

* microHAM USB-Y6 and USB-Y8 devices submitted by Justin Burket (KL1RL).
* Evolution Robotics ER1 Control Module submitted by Shawn M.  Lavelle.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/ftdi_sio.c |    3 +++
 drivers/usb/serial/ftdi_sio.h |   14 ++++++++++++++
 2 files changed, 17 insertions(+)

--- gregkh-2.6.orig/drivers/usb/serial/ftdi_sio.c	2005-07-29 11:29:48.000000000 -0700
+++ gregkh-2.6/drivers/usb/serial/ftdi_sio.c	2005-07-29 11:36:25.000000000 -0700
@@ -429,6 +429,9 @@
 	{ USB_DEVICE(FTDI_VID, FTDI_4N_GALAXY_DE_2_PID) },
 	{ USB_DEVICE(MOBILITY_VID, MOBILITY_USB_SERIAL_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ACTIVE_ROBOTS_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_MHAM_Y6_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_MHAM_Y8_PID) },
+	{ USB_DEVICE(EVOLUTION_VID, EVOLUTION_ER1_PID) },
 	{ }						/* Terminating entry */
 };
 
--- gregkh-2.6.orig/drivers/usb/serial/ftdi_sio.h	2005-07-29 11:29:48.000000000 -0700
+++ gregkh-2.6/drivers/usb/serial/ftdi_sio.h	2005-07-29 11:36:25.000000000 -0700
@@ -265,10 +265,24 @@
 #define MOBILITY_USB_SERIAL_PID		0x0202	/* EasiDock USB 200 serial */
 
 /*
+ * microHAM product IDs (http://www.microham.com).
+ * Submitted by Justin Burket (KL1RL) <zorton@jtan.com>.
+ */
+#define FTDI_MHAM_Y6_PID 0xEEEA		/* USB-Y6 interface */
+#define FTDI_MHAM_Y8_PID 0xEEEB		/* USB-Y8 interface */
+
+/*
  * Active Robots product ids.
  */
 #define FTDI_ACTIVE_ROBOTS_PID	0xE548	/* USB comms board */
 
+/*
+ * Evolution Robotics products (http://www.evolution.com/).
+ * Submitted by Shawn M. Lavelle.
+ */
+#define EVOLUTION_VID		0xDEEE	/* Vendor ID */
+#define EVOLUTION_ER1_PID	0x0300	/* ER1 Control Module */
+
 /* Commands */
 #define FTDI_SIO_RESET 		0 /* Reset the port */
 #define FTDI_SIO_MODEM_CTRL 	1 /* Set the modem control register */

--
