Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVEVXyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVEVXyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVEVXyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 19:54:32 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:33412 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261825AbVEVXy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 19:54:27 -0400
Message-Id: <20050522235336.445659000@abc>
References: <20050522235233.190143000@abc>
Date: Mon, 23 May 2005 01:52:36 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-dibcom-init-fix.patch
X-SA-Exim-Connect-IP: 84.189.216.198
Subject: [DVB patch 3/5] dvb-usb: fix init error checking
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error checking during initialization.
Thanks to Gerolf Wendland for discovering.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---
 drivers/media/dvb/dvb-usb/dibusb-mb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4-git3/drivers/media/dvb/dvb-usb/dibusb-mb.c
===================================================================
--- linux-2.6.12-rc4-git3.orig/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-05-23 00:56:12.000000000 +0200
+++ linux-2.6.12-rc4-git3/drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-05-23 00:56:57.000000000 +0200
@@ -81,7 +81,7 @@ static int dibusb_probe(struct usb_inter
 		const struct usb_device_id *id)
 {
 	if (dvb_usb_device_init(intf,&dibusb1_1_properties,THIS_MODULE) == 0 ||
-		dvb_usb_device_init(intf,&dibusb1_1_an2235_properties,THIS_MODULE) ||
+		dvb_usb_device_init(intf,&dibusb1_1_an2235_properties,THIS_MODULE) == 0 ||
 		dvb_usb_device_init(intf,&dibusb2_0b_properties,THIS_MODULE) == 0)
 		return 0;
 

--

