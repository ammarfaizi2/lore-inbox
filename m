Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVHYFYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVHYFYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVHYFVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62923 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751540AbVHYFVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:20 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (9/22) wrong ifdefs in 82596
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADy-0005c9-AR@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ifdefs around variable declaration would better match those around its uses...

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-lance/drivers/net/82596.c RC13-rc7-82596-apricot/drivers/net/82596.c
--- RC13-rc7-lance/drivers/net/82596.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-rc7-82596-apricot/drivers/net/82596.c	2005-08-25 00:54:10.000000000 -0400
@@ -614,7 +614,7 @@
 static int init_i596_mem(struct net_device *dev)
 {
 	struct i596_private *lp = dev->priv;
-#if !defined(ENABLE_MVME16x_NET) && !defined(ENABLE_BVME6000_NET)
+#if !defined(ENABLE_MVME16x_NET) && !defined(ENABLE_BVME6000_NET) || defined(ENABLE_APRICOT)
 	short ioaddr = dev->base_addr;
 #endif
 	unsigned long flags;
