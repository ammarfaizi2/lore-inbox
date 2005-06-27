Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVF0NH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVF0NH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVF0NFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:05:44 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:12261 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262055AbVF0MQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:31 -0400
Message-Id: <20050627121418.031282000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:42 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-dibusb-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 42/51] usb: dvb_usb_properties init fix
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

There was no pid-filter-count set for some devices - led to an error.
Thanks to Gerolf Wendland.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dibusb-mb.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:24:28.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-06-27 13:26:14.000000000 +0200
@@ -209,6 +209,8 @@ static struct dvb_usb_properties dibusb1
 
 static struct dvb_usb_properties dibusb1_1_an2235_properties = {
 	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_PID_FILTER_CAN_BE_TURNED_OFF | DVB_USB_IS_AN_I2C_ADAPTER,
+	.pid_filter_count = 16,
+
 	.usb_ctrl = CYPRESS_AN2235,
 
 	.firmware = "dvb-usb-dibusb-an2235-01.fw",
@@ -263,6 +265,8 @@ static struct dvb_usb_properties dibusb1
 
 static struct dvb_usb_properties dibusb2_0b_properties = {
 	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_PID_FILTER_CAN_BE_TURNED_OFF | DVB_USB_IS_AN_I2C_ADAPTER,
+	.pid_filter_count = 32,
+
 	.usb_ctrl = CYPRESS_FX2,
 
 	.firmware = "dvb-usb-adstech-usb2-02.fw",

--

