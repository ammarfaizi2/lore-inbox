Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315328AbSEAHU0>; Wed, 1 May 2002 03:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315329AbSEAHUZ>; Wed, 1 May 2002 03:20:25 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:2566 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315328AbSEAHUY>; Wed, 1 May 2002 03:20:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] TRIVIAL 2.5.12 WP security warning
Date: Wed, 01 May 2002 17:23:47 +1000
Message-Id: <E172oSp-0007ot-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz>: Warn users about machines with non-working WP bit:
  Hi!
  
  This might be good idea, as those machines are not safe for multiuser
  systems.
  

--- trivial-2.5.12/arch/i386/mm/init.c.orig	Wed May  1 17:15:10 2002
+++ trivial-2.5.12/arch/i386/mm/init.c	Wed May  1 17:15:10 2002
@@ -384,7 +384,7 @@
 	local_flush_tlb();
 
 	if (!boot_cpu_data.wp_works_ok) {
-		printk("No.\n");
+		printk("No (that's security hole).\n");
 #ifdef CONFIG_X86_WP_WORKS_OK
 		panic("This kernel doesn't support CPU's with broken WP. Recompile it for a 386!");
 #endif

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
