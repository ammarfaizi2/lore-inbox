Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWIUAy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWIUAy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWIUAy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:54:26 -0400
Received: from tinc.cathedrallabs.org ([72.9.252.66]:51908 "EHLO
	tinc.cathedrallabs.org") by vger.kernel.org with ESMTP
	id S1750893AbWIUAyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:54:25 -0400
Date: Wed, 20 Sep 2006 21:51:58 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ams: remove usage of input_dev cdev
Message-ID: <20060921005158.GB16002@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Pyzor-Results: Reported 0 times.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes usage of 'cdev' member of input_dev, not present
on that struct anymore.

Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>

--- mm.orig/drivers/hwmon/ams/ams-mouse.c	2006-09-20 13:57:59.000000000 -0300
+++ mm/drivers/hwmon/ams/ams-mouse.c	2006-09-20 21:01:59.000000000 -0300
@@ -66,7 +66,6 @@
 	ams_info.idev->name = "Apple Motion Sensor";
 	ams_info.idev->id.bustype = ams_info.bustype;
 	ams_info.idev->id.vendor = 0;
-	ams_info.idev->cdev.dev = &ams_info.of_dev->dev;
 
 	input_set_abs_params(ams_info.idev, ABS_X, -50, 50, 3, 0);
 	input_set_abs_params(ams_info.idev, ABS_Y, -50, 50, 3, 0);

