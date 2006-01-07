Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030607AbWAGWD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030607AbWAGWD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWAGWD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:03:28 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:32015 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1030607AbWAGWD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:03:27 -0500
Date: Sat, 7 Jan 2006 23:03:28 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Subject: [PATCH] vr41xx: section tags fix
Message-Id: <20060107230328.1ce0da37.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Can you please pick this patch for -mm? I sent it to Yoichi Yuasa one
month ago but didn't get any answer. Thanks.

Content-Disposition: inline; filename=vr41xx-section-tags-fix.patch

module_init functions must be tagged __init rather than __devinit;
likewise, module_exit functions must be tagged __exit rather than
__devexit.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/char/vr41xx_giu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/char/vr41xx_giu.c	2005-11-12 15:49:50.000000000 +0100
+++ linux-2.6.15-rc5/drivers/char/vr41xx_giu.c	2005-12-11 17:12:58.000000000 +0100
@@ -718,7 +718,7 @@
 	},
 };
 
-static int __devinit vr41xx_giu_init(void)
+static int __init vr41xx_giu_init(void)
 {
 	int retval;
 
@@ -733,7 +733,7 @@
 	return retval;
 }
 
-static void __devexit vr41xx_giu_exit(void)
+static void __exit vr41xx_giu_exit(void)
 {
 	platform_driver_unregister(&giu_device_driver);
 


-- 
Jean Delvare
