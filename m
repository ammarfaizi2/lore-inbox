Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVKAPWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVKAPWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVKAPWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:22:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20755 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750755AbVKAPWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:22:15 -0500
Date: Tue, 1 Nov 2005 16:22:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net
Subject: [RFC: 2.6 patch] i386: EXPORT_SYMBOL(screen_info) even #ifndef CONFIG_VT
Message-ID: <20051101152207.GT8009@stusta.de>
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


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Is this patch OK or should the drivers depend on VT?

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

