Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272611AbTHKOGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272612AbTHKNmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:42:45 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:37259 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272611AbTHKNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:58 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: [PATCH] Remove EXPORT_NO_SYMBOLS from meth driver.
Message-Id: <E19mCuQ-0003dy-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/meth.c linux-2.5/drivers/net/meth.c
--- bk-linus/drivers/net/meth.c	2003-06-27 06:01:45.000000000 +0100
+++ linux-2.5/drivers/net/meth.c	2003-07-15 18:24:24.000000000 +0100
@@ -844,10 +844,7 @@ int meth_init_module(void)
 		printk("meth: error %i registering device \"%s\"\n",
 		       result, meth_devs->name);
 	else device_present++;
-#ifndef METH_DEBUG
-	EXPORT_NO_SYMBOLS;
-#endif
-	
+
 	return device_present ? 0 : -ENODEV;
 }
 
