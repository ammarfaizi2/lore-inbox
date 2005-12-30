Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVL3Dfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVL3Dfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVL3DfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:35:17 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:54390 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750841AbVL3DfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:35:15 -0500
Message-Id: <20051230032636.674001000.dtor_core@ameritech.net>
References: <20051230031906.503919000.dtor_core@ameritech.net>
Date: Thu, 29 Dec 2005 22:19:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Denny Priebe <spamtrap@siglost.org>
Subject: [patch 3/3] Input: wacom - fix X axis setup
Content-Disposition: inline; filename=wacom-axis-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denny Priebe <spamtrap@siglost.org>

This patch fixes a typo introduced by conversion to dynamic input_dev
allocation.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Index: work/drivers/usb/input/wacom.c
===================================================================
--- work.orig/drivers/usb/input/wacom.c
+++ work/drivers/usb/input/wacom.c
@@ -854,7 +854,7 @@ static int wacom_probe(struct usb_interf
 
 	input_dev->evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS);
 	input_dev->keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOUCH) | BIT(BTN_STYLUS);
-	input_set_abs_params(input_dev, ABS_X, 0, wacom->features->y_max, 4, 0);
+	input_set_abs_params(input_dev, ABS_X, 0, wacom->features->x_max, 4, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0, wacom->features->y_max, 4, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, wacom->features->pressure_max, 0, 0);
 

