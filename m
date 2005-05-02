Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVEBCST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVEBCST (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVEBCRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 22:17:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24592 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261627AbVEBBqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:31 -0400
Date: Mon, 2 May 2005 03:46:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: michael@mihu.de
Cc: kraxel@bytesex.org, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/common/saa7146_fops.c: make a function static
Message-ID: <20050502014629.GN3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Apr 2005

--- linux-2.6.12-rc2-mm3-full/drivers/media/common/saa7146_fops.c.old	2005-04-19 01:21:37.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/common/saa7146_fops.c	2005-04-19 01:21:50.000000000 +0200
@@ -403,7 +403,7 @@
 	.llseek		= no_llseek,
 };
 
-void vv_callback(struct saa7146_dev *dev, unsigned long status)
+static void vv_callback(struct saa7146_dev *dev, unsigned long status)
 {
 	u32 isr = status;
 	

