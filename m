Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVCVELM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVCVELM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVCVCVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:21:01 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:48779 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262350AbVCVBgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:20 -0500
Message-Id: <20050322013459.508677000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:11 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibusb-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 38/48] dibusb: remove useless ifdef
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

removed useless ifdef: dvb_register_adapter always takes 3 parameters in this tree
(Andreas Oberritter)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-dibusb-dvb.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-03-22 00:17:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-03-22 00:27:41.000000000 +0100
@@ -125,12 +125,8 @@ int dibusb_dvb_init(struct usb_dibusb *d
 
 	urb_compl_count = 0;
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,4)
-    if ((ret = dvb_register_adapter(&dib->adapter, DRIVER_DESC)) < 0) {
-#else
-    if ((ret = dvb_register_adapter(&dib->adapter, DRIVER_DESC , 
+	if ((ret = dvb_register_adapter(&dib->adapter, DRIVER_DESC,
 			THIS_MODULE)) < 0) {
-#endif
 		deb_info("dvb_register_adapter failed: error %d", ret);
 		goto err;
 	}

--

