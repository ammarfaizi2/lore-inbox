Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTHWMvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTHWMvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:51:54 -0400
Received: from [203.145.184.221] ([203.145.184.221]:15371 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263618AbTHWMvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:51:53 -0400
Subject: [PATCH 2.6.0-test4][NET] 3c509.c: remove device.name field
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: netdev@oss.sgi.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Aug 2003 18:43:29 +0530
Message-Id: <1061644409.1141.18.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch removes the device name field which is no longer present.


--- linux-2.6.0-test4/drivers/net/3c509.c	2003-08-23 13:14:30.000000000 +0530
+++ linux-2.6.0-test4-nvk/drivers/net/3c509.c	2003-08-23 18:34:35.000000000 +0530
@@ -629,8 +629,6 @@
 			   el3_mca_adapter_names[mdev->index], slot + 1);
 
 		/* claim the slot */
-		strncpy(device->name, el3_mca_adapter_names[mdev->index],
-				sizeof(device->name));
 		mca_device_set_claim(mdev, 1);
 
 		if_port = pos4 & 0x03;

