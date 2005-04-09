Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVDITjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVDITjm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 15:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVDITjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 15:39:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5637 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261330AbVDITjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 15:39:32 -0400
Date: Sat, 9 Apr 2005 21:39:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/x86_64 early_printk.c: make a variable static
Message-ID: <20050409193931.GL3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm2-full/arch/x86_64/kernel/early_printk.c.old	2005-04-09 20:51:23.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/arch/x86_64/kernel/early_printk.c	2005-04-09 20:51:33.000000000 +0200
@@ -155,7 +155,7 @@
 };
 
 /* Direct interface for emergencies */
-struct console *early_console = &early_vga_console;
+static struct console *early_console = &early_vga_console;
 static int early_console_initialized = 0;
 
 void early_printk(const char *fmt, ...)

