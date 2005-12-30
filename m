Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVL3DfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVL3DfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVL3DfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:35:15 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:31332 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750838AbVL3DfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:35:14 -0500
Message-Id: <20051230032636.448212000.dtor_core@ameritech.net>
References: <20051230031906.503919000.dtor_core@ameritech.net>
Date: Thu, 29 Dec 2005 22:19:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 1/3] Input: kbtab - fix Y axis setup
Content-Disposition: inline; filename=kbtab-axis-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo introduced by conversion to dynamic input_dev
allocation.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Index: work/drivers/usb/input/kbtab.c
===================================================================
--- work.orig/drivers/usb/input/kbtab.c
+++ work/drivers/usb/input/kbtab.c
@@ -159,7 +159,7 @@ static int kbtab_probe(struct usb_interf
 	input_dev->keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOUCH);
 	input_dev->mscbit[0] |= BIT(MSC_SERIAL);
 	input_set_abs_params(input_dev, ABS_X, 0, 0x2000, 4, 0);
-	input_set_abs_params(input_dev, ABS_X, 0, 0x1750, 4, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, 0x1750, 4, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 0xff, 0, 0);
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;

