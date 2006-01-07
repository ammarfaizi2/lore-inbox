Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030592AbWAGV65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbWAGV65 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbWAGV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:58:57 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:19470 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1030592AbWAGV65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:58:57 -0500
Date: Sat, 7 Jan 2006 22:58:56 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Subject: [PATCH] vr41xx: ARRAY_SIZE cleanup
Message-Id: <20060107225856.30eb651b.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Can you please pick this patch for -mm? I sent it to Yoichi Yuasa one
month ago but didn't get any answer. Thanks.

Content-Disposition: inline; filename=vr41xx-array-size-cleanup.patch

Possible ARRAY_SIZE cleanup for the vr41xx_rtc driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/char/vr41xx_rtc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.15-rc2.orig/drivers/char/vr41xx_rtc.c	2005-11-13 21:02:32.000000000 +0100
+++ linux-2.6.15-rc2/drivers/char/vr41xx_rtc.c	2005-12-05 22:25:48.000000000 +0100
@@ -127,8 +127,6 @@
 		.flags	= IORESOURCE_MEM,	},
 };
 
-#define RTC_NUM_RESOURCES	sizeof(rtc_resource) / sizeof(struct resource)
-
 static inline unsigned long read_elapsed_second(void)
 {
 	unsigned long first_low, first_mid, first_high;
@@ -686,7 +684,8 @@
 		break;
 	}
 
-	rtc_platform_device = platform_device_register_simple("RTC", -1, rtc_resource, RTC_NUM_RESOURCES);
+	rtc_platform_device = platform_device_register_simple("RTC", -1,
+			      rtc_resource, ARRAY_SIZE(rtc_resource));
 	if (IS_ERR(rtc_platform_device))
 		return PTR_ERR(rtc_platform_device);
 


-- 
Jean Delvare
