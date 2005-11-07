Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVKGVUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVKGVUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbVKGVTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:19:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14340 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965091AbVKGVTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:19:07 -0500
Date: Mon, 7 Nov 2005 22:19:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [RFC: 2.6 patch] i386: EXPORT_SYMBOL(screen_info) even #ifndef CONFIG_VT
Message-ID: <20051107211906.GD3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The folllowing modules require screen_info but don't depend
on CONFIG_VT:
- vga16fb.ko
- intelfb.ko

This patch was already ACK'ed by Antonino A. Daplas.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 Nov 2005

--- linux-2.6.14-rc5-mm1-modular-2.95/arch/i386/kernel/setup.c.old	2005-11-01 16:10:52.000000000 +0100
+++ linux-2.6.14-rc5-mm1-modular-2.95/arch/i386/kernel/setup.c	2005-11-01 16:11:25.000000000 +0100
@@ -129,9 +129,7 @@
 EXPORT_SYMBOL(drive_info);
 #endif
 struct screen_info screen_info;
-#ifdef CONFIG_VT
 EXPORT_SYMBOL(screen_info);
-#endif
 struct apm_info apm_info;
 EXPORT_SYMBOL(apm_info);
 struct sys_desc_table_struct {

