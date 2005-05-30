Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVE3VI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVE3VI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVE3U5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:57:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21518 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261748AbVE3U4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:41 -0400
Date: Mon, 30 May 2005 22:56:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: michael@mihu.de, kraxel@bytesex.org, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/common/saa7146_fops.c: make a function static
Message-ID: <20050530205638.GS10441@stusta.de>
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
- 2 May 2005
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
 	

