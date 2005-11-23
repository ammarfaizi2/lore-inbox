Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVKWXrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVKWXrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVKWXqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:27074 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751332AbVKWXqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:32 -0500
Date: Wed, 23 Nov 2005 15:45:23 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       abbotti@mev.co.uk
Subject: [patch 15/22] USB: ftdi_sio: new IDs for KOBIL devices
Message-ID: <20051123234523.GP527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ftdi_sio-new-ids-for-kobil-devices.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

This patch adds two new devices to the ftdi_sio driver's device ID
table.  The device IDs were supplied by Stefan Nies of KOBIL Systems for
two of their devices using the FTDI chip.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/serial/ftdi_sio.c |    2 ++
 drivers/usb/serial/ftdi_sio.h |    7 +++++++
 2 files changed, 9 insertions(+)

--- usb-2.6.orig/drivers/usb/serial/ftdi_sio.c
+++ usb-2.6/drivers/usb/serial/ftdi_sio.c
@@ -475,6 +475,8 @@ static struct usb_device_id id_table_com
 	{ USB_DEVICE(FTDI_VID, FTDI_ARTEMIS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ATIK_ATK16_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ATIK_ATK16HR_PID) },
+	{ USB_DEVICE(KOBIL_VID, KOBIL_CONV_B1_PID) },
+	{ USB_DEVICE(KOBIL_VID, KOBIL_CONV_KAAN_PID) },
 	{ },					/* Optional parameter entry */
 	{ }					/* Terminating entry */
 };
--- usb-2.6.orig/drivers/usb/serial/ftdi_sio.h
+++ usb-2.6/drivers/usb/serial/ftdi_sio.h
@@ -128,6 +128,13 @@
 #define SEALEVEL_2803_8_PID	0X2883 	/* SeaLINK+8 (2803) Port 8 */
 
 /*
+ * The following are the values for two KOBIL chipcard terminals.
+ */
+#define KOBIL_VID		0x0d46	/* KOBIL Vendor ID */
+#define KOBIL_CONV_B1_PID	0x2020	/* KOBIL Konverter for B1 */
+#define KOBIL_CONV_KAAN_PID	0x2021	/* KOBIL_Konverter for KAAN */
+
+/*
  * DSS-20 Sync Station for Sony Ericsson P800
  */
  

--
