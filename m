Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVAOVkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVAOVkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVAOVkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:40:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18193 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262329AbVAOVkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:40:04 -0500
Date: Sat, 15 Jan 2005 22:39:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 cyrix.c: make a function static (fwd)
Message-ID: <20050115213959.GS4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 29 Nov 2004 00:03:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 cyrix.c: make a function static

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/cyrix.c.old	2004-11-28 21:04:34.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/arch/i386/kernel/cpu/cyrix.c	2004-11-28 21:04:42.000000000 +0100
@@ -12,7 +12,7 @@
 /*
  * Read NSC/Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
  */
-void __init do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
+static void __init do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
 {
 	unsigned char ccr2, ccr3;
 	unsigned long flags;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

