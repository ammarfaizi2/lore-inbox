Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVIDXeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVIDXeW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVIDXbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:08 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:37761 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932123AbVIDXa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:27 -0400
Message-Id: <20050904232325.661105000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:24 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-remove-empty-module_init-calls.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 25/54] usb: removed empty module_init/exit calls
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Removed empty module_init/exit calls.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dvb-usb-init.c |   13 -------------
 1 file changed, 13 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-09-04 22:28:17.000000000 +0200
@@ -196,19 +196,6 @@ void dvb_usb_device_exit(struct usb_inte
 }
 EXPORT_SYMBOL(dvb_usb_device_exit);
 
-/* module stuff */
-static int __init dvb_usb_module_init(void)
-{
-	return 0;
-}
-
-static void __exit dvb_usb_module_exit(void)
-{
-}
-
-module_init (dvb_usb_module_init);
-module_exit (dvb_usb_module_exit);
-
 MODULE_VERSION("0.3");
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@desy.de>");
 MODULE_DESCRIPTION("A library module containing commonly used USB and DVB function USB DVB devices");

--

