Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVL2QfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVL2QfD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVL2QfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:35:03 -0500
Received: from melos.informatik.uni-rostock.de ([139.30.241.22]:19979 "EHLO
	melos.informatik.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750804AbVL2QfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:35:01 -0500
From: Denny Priebe <spamtrap@siglost.org>
Date: Thu, 29 Dec 2005 17:34:46 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.6.15-rc7] Micro-patch to drivers/usb/input/wacom.c
Message-ID: <20051229163446.GA9036@nostromo.dyndns.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

there's a minor typo in wacom.c that causes the device to report the same
range of supported values for its x- and y-axis.

Attached micro-patch fixes this.

Regards,
Denny


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wacom.c-2.6.15-rc7.diff"

--- a/drivers/usb/input/wacom.c~	2005-12-29 16:51:05.740984093 +0100
+++ b/drivers/usb/input/wacom.c	2005-12-29 16:51:05.740984093 +0100
@@ -854,7 +854,7 @@
 
 	input_dev->evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS);
 	input_dev->keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOUCH) | BIT(BTN_STYLUS);
-	input_set_abs_params(input_dev, ABS_X, 0, wacom->features->y_max, 4, 0);
+	input_set_abs_params(input_dev, ABS_X, 0, wacom->features->x_max, 4, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0, wacom->features->y_max, 4, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, wacom->features->pressure_max, 0, 0);
 

--qMm9M+Fa2AknHoGS--
