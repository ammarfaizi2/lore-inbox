Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTHWNAo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTHWNAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:00:44 -0400
Received: from [203.145.184.221] ([203.145.184.221]:20235 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263379AbTHWNAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:00:43 -0400
Subject: [PATCH 2.6.0-test4][NET] sk_mca.c: fix linker error
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: netdev@oss.sgi.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Aug 2003 18:52:18 +0530
Message-Id: <1061644938.2787.22.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes the following linker error due to a typo:

*** Warning: "spin_lock_irqrestore" [drivers/net/sk_mca.ko] undefined!

--- linux-2.6.0-test4/drivers/net/sk_mca.c	2003-07-28 10:43:57.000000000 +0530
+++ linux-2.6.0-test4-nvk/drivers/net/sk_mca.c	2003-08-23 18:47:55.000000000 +0530
@@ -280,7 +280,7 @@
 
 	/* reenable interrupts */
 
-	spin_lock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 /* get LANCE register */

