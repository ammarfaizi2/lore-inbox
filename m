Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312326AbSDCV4j>; Wed, 3 Apr 2002 16:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312314AbSDCV43>; Wed, 3 Apr 2002 16:56:29 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8329 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312305AbSDCV4V>;
	Wed, 3 Apr 2002 16:56:21 -0500
Date: Wed, 3 Apr 2002 23:54:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Warn users about machines with non-working WP bit
Message-ID: <20020403215457.GA1050@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This might be good idea, as those machines are not safe for multiuser
systems.

--- clean.2.5/arch/i386/mm/init.c	Sun Mar 10 20:06:31 2002
+++ linux/arch/i386/mm/init.c	Mon Mar 11 21:49:14 2002
@@ -383,7 +383,7 @@
 	local_flush_tlb();
 
 	if (!boot_cpu_data.wp_works_ok) {
-		printk("No.\n");
+		printk("No (that's security hole).\n");
 #ifdef CONFIG_X86_WP_WORKS_OK
 		panic("This kernel doesn't support CPU's with broken WP. Recompile it for a 386!");
 #endif

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
