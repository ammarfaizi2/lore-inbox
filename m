Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318980AbSHFDwx>; Mon, 5 Aug 2002 23:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318985AbSHFDww>; Mon, 5 Aug 2002 23:52:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:2216 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318980AbSHFDwq>;
	Mon, 5 Aug 2002 23:52:46 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Warn users about machines with non-working WP bit
Date: Tue, 06 Aug 2002 13:49:40 +1000
Message-Id: <20020806035808.710134B71@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Truth in advertising? ]

From:  Pavel Machek <pavel@ucw.cz>

  Hi!
  
  This might be good idea, as those machines are not safe for multiuser
  systems.
  

--- trivial-2.5.30/arch/i386/mm/init.c.orig	2002-08-06 13:18:12.000000000 +1000
+++ trivial-2.5.30/arch/i386/mm/init.c	2002-08-06 13:18:12.000000000 +1000
@@ -397,7 +397,7 @@
 	local_flush_tlb();
 
 	if (!boot_cpu_data.wp_works_ok) {
-		printk("No.\n");
+		printk("No (that's security hole).\n");
 #ifdef CONFIG_X86_WP_WORKS_OK
 		panic("This kernel doesn't support CPU's with broken WP. Recompile it for a 386!");
 #endif
-- 
  Don't blame me: the Monkey is driving
