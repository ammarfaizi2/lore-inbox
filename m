Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbVKWXrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbVKWXrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVKWXqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:21442 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751324AbVKWXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:30 -0500
Date: Wed, 23 Nov 2005 15:44:35 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       eugen@univ.kiev.ua, rml@novell.com, khali@linux-fr.org
Subject: [patch 08/22] hwmon: hdaps missing an axis
Message-ID: <20051123234435.GI527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="hwmon-hdaps-missing-an-axis.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Meshcheryakov <eugen@univ.kiev.ua>

Trivial patch to report both hdaps axises to the joystick device, not
just the X axis.

Signed-off-by: Robert Love <rml@novell.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/hwmon/hdaps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- usb-2.6.orig/drivers/hwmon/hdaps.c
+++ usb-2.6/drivers/hwmon/hdaps.c
@@ -570,7 +570,7 @@ static int __init hdaps_init(void)
 	hdaps_idev->evbit[0] = BIT(EV_ABS);
 	input_set_abs_params(hdaps_idev, ABS_X,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
-	input_set_abs_params(hdaps_idev, ABS_X,
+	input_set_abs_params(hdaps_idev, ABS_Y,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
 
 	input_register_device(hdaps_idev);

--
