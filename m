Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbULVLwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbULVLwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbULVLux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:50:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58897 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261964AbULVLuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:50:06 -0500
Date: Wed, 22 Dec 2004 12:50:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/genrt: make a struct static (fwd)
Message-ID: <20041222115003.GM5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 5 Dec 2004 17:57:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/genrt: make a struct static

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

