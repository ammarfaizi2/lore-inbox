Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVAPHnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVAPHnB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVAPHnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:43:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23822 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262413AbVAPHmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:42:51 -0500
Date: Sun, 16 Jan 2005 08:42:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386_ksyms.c: unexport register_die_notifier
Message-ID: <20050116074247.GV4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of register_die_notifier (kernel/kprobes.c) can't be built 
modular. Therefore, it's the EXPORT_SYMBOL is superfluous.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/i386_ksyms.c.old	2005-01-16 05:37:29.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/i386_ksyms.c	2005-01-16 05:37:37.000000000 +0100
@@ -170,7 +170,6 @@
 extern int memcmp(const void *,const void *,__kernel_size_t);
 EXPORT_SYMBOL(memcmp);
 
-EXPORT_SYMBOL(register_die_notifier);
 #ifdef CONFIG_HAVE_DEC_LOCK
 EXPORT_SYMBOL(_atomic_dec_and_lock);
 #endif

