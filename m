Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVDSAwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVDSAwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVDSAvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:51:03 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40460 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261227AbVDSAun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:50:43 -0400
Date: Tue, 19 Apr 2005 02:50:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: michael@mihu.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/common/saa7146_fops.c: make a function static
Message-ID: <20050419005041.GO5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/media/common/saa7146_fops.c.old	2005-04-19 01:21:37.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/common/saa7146_fops.c	2005-04-19 01:21:50.000000000 +0200
@@ -403,7 +403,7 @@
 	.llseek		= no_llseek,
 };
 
-void vv_callback(struct saa7146_dev *dev, unsigned long status)
+static void vv_callback(struct saa7146_dev *dev, unsigned long status)
 {
 	u32 isr = status;
 	

