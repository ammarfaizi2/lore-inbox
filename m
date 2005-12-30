Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbVL3DfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbVL3DfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVL3DfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:35:16 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:7834 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750840AbVL3DfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:35:14 -0500
Message-Id: <20051230032636.560353000.dtor_core@ameritech.net>
References: <20051230031906.503919000.dtor_core@ameritech.net>
Date: Thu, 29 Dec 2005 22:19:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 2/3] Input: warrior - fix HAT0Y axis setup
Content-Disposition: inline; filename=warrior-axis-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo introduced by conversion to dynamic input_dev
allocation.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Index: work/drivers/input/joystick/warrior.c
===================================================================
--- work.orig/drivers/input/joystick/warrior.c
+++ work/drivers/input/joystick/warrior.c
@@ -172,7 +172,7 @@ static int warrior_connect(struct serio 
 	input_set_abs_params(input_dev, ABS_Y, -64, 64, 0, 8);
 	input_set_abs_params(input_dev, ABS_THROTTLE, -112, 112, 0, 0);
 	input_set_abs_params(input_dev, ABS_HAT0X, -1, 1, 0, 0);
-	input_set_abs_params(input_dev, ABS_HAT0X, -1, 1, 0, 0);
+	input_set_abs_params(input_dev, ABS_HAT0Y, -1, 1, 0, 0);
 
 	serio_set_drvdata(serio, warrior);
 

