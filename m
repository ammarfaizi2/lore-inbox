Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbULEQ7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbULEQ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 11:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbULEQ5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:57:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13578 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261316AbULEQ5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:57:39 -0500
Date: Sun, 5 Dec 2004 17:57:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/genrt: make a struct static
Message-ID: <20041205165737.GN2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global struct static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/genrtc.c.old	2004-11-07 00:09:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/genrtc.c	2004-11-07 00:09:10.000000000 +0100
@@ -83,7 +83,7 @@
 static int irq_active;
 
 #ifdef CONFIG_GEN_RTC_X
-struct work_struct genrtc_task;
+static struct work_struct genrtc_task;
 static struct timer_list timer_task;
 
 static unsigned int oldsecs;

