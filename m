Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVGYF5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVGYF5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVGYFzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:55:18 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:42109 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261668AbVGYFxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:25 -0400
Message-Id: <20050725054531.235082000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 04/24] Acecad: small cleanup
Content-Disposition: inline; filename=acecad-cleanup.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: acecad - drop unneeded cast and couple unneeded spaces.
       Noticed by Joe Perches.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Stephane VOLTZ <svoltz@numericable.fr>
---

 drivers/usb/input/acecad.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: work/drivers/usb/input/acecad.c
===================================================================
--- work.orig/drivers/usb/input/acecad.c
+++ work/drivers/usb/input/acecad.c
@@ -87,8 +87,8 @@ static void usb_acecad_irq(struct urb *u
 	if (prox) {
 		int x = data[1] | (data[2] << 8);
 		int y = data[3] | (data[4] << 8);
-		/*Pressure should compute the same way for flair and 302*/
-		int pressure = data[5] | ((int)data[6] << 8);
+		/* Pressure should compute the same way for flair and 302 */
+		int pressure = data[5] | (data[6] << 8);
 		int touch = data[0] & 0x01;
 		int stylus = (data[0] & 0x10) >> 4;
 		int stylus2 = (data[0] & 0x20) >> 5;
@@ -104,9 +104,9 @@ static void usb_acecad_irq(struct urb *u
 	input_sync(dev);
 
 resubmit:
-	status = usb_submit_urb (urb, GFP_ATOMIC);
+	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status)
-		err ("can't resubmit intr, %s-%s/input0, status %d",
+		err("can't resubmit intr, %s-%s/input0, status %d",
 			acecad->usbdev->bus->bus_name, acecad->usbdev->devpath, status);
 }
 

