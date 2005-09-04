Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVIDXdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVIDXdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVIDXbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:10 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:39041 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932125AbVIDXa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:29 -0400
Message-Id: <20050904232326.452095000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:26 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-dtt200u-naming-and-formatting-changes.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 27/54] usb: dtt200u: add proper device names
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Added names for clones of the DVB-T stick.
Whitespace cleanups.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dtt200u.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dtt200u.c	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dtt200u.c	2005-09-04 22:28:20.000000000 +0200
@@ -106,12 +106,11 @@ static int dtt200u_usb_probe(struct usb_
 }
 
 static struct usb_device_id dtt200u_usb_table [] = {
-//		{ USB_DEVICE(0x04b4,0x8613) },
-	    { USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_COLD) },
-	    { USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_WARM) },
-		{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_COLD)  },
-		{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_WARM)  },
-	    { 0 },
+	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_COLD) },
+	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_WARM) },
+	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_COLD)  },
+	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_WARM)  },
+	{ 0 },
 };
 MODULE_DEVICE_TABLE(usb, dtt200u_usb_table);
 
@@ -189,7 +188,7 @@ static struct dvb_usb_properties wt220u_
 
 	.num_device_descs = 1,
 	.devices = {
-		{ .name = "WideView WT-220U PenType Receiver (and clones)",
+		{ .name = "WideView WT-220U PenType Receiver (Typhoon/Freecom)",
 		  .cold_ids = { &dtt200u_usb_table[2], NULL },
 		  .warm_ids = { &dtt200u_usb_table[3], NULL },
 		},
@@ -201,9 +200,9 @@ static struct dvb_usb_properties wt220u_
 static struct usb_driver dtt200u_usb_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "dvb_usb_dtt200u",
-	.probe 		= dtt200u_usb_probe,
+	.probe		= dtt200u_usb_probe,
 	.disconnect = dvb_usb_device_exit,
-	.id_table 	= dtt200u_usb_table,
+	.id_table	= dtt200u_usb_table,
 };
 
 /* module stuff */

--

