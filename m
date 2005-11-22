Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVKVP7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVKVP7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 10:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbVKVP7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 10:59:13 -0500
Received: from peabody.ximian.com ([130.57.169.10]:41954 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S964971AbVKVP7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 10:59:12 -0500
Subject: [patch] hdaps: missing an axis.
From: Robert Love <rml@novell.com>
To: greg@kroah.com
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 10:57:21 -0500
Message-Id: <1132675041.29496.2.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

Trivial patch to report both hdaps axises to the joystick device, not
just the X axis.

Patch originally by Eugeniy Meshcheryakov <eugen@univ.kiev.ua>.

Signed-off-by: Robert Love <rml@novell.com>

	Robert Love


diff -urN a/drivers/hwmon/hdaps.c b/drivers/hwmon/hdaps.c
--- a/drivers/hwmon/hdaps.c	Wed Nov 16 17:18:55 2005
+++ b/drivers/hwmon/hdaps.c	Tue Nov 22 14:24:25 2005
@@ -570,7 +570,7 @@
 	hdaps_idev->evbit[0] = BIT(EV_ABS);
 	input_set_abs_params(hdaps_idev, ABS_X,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
-	input_set_abs_params(hdaps_idev, ABS_X,
+	input_set_abs_params(hdaps_idev, ABS_Y,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
 
 	input_register_device(hdaps_idev);


