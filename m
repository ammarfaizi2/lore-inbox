Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVCVF2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVCVF2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVCVCMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:12:31 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:395 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262319AbVCVBfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:01 -0500
Message-Id: <20050322013457.435952000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:56 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttusb-kill_urb.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 23/48] ttusb-budget: s/usb_unlink_urb/usb_kill_urb/
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch by Colin Western: s/usb_unlink_urb/usb_kill_urb/

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-ttusb-budget.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-03-22 00:17:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-03-22 00:17:50.000000000 +0100
@@ -818,7 +818,7 @@ static void ttusb_stop_iso_xfer(struct t
 	int i;
 
 	for (i = 0; i < ISO_BUF_COUNT; i++)
-		usb_unlink_urb(ttusb->iso_urb[i]);
+		usb_kill_urb(ttusb->iso_urb[i]);
 
 	ttusb->iso_streaming = 0;
 }

--

