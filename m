Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289670AbSAWElX>; Tue, 22 Jan 2002 23:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289668AbSAWElO>; Tue, 22 Jan 2002 23:41:14 -0500
Received: from [202.135.142.194] ([202.135.142.194]:56583 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289667AbSAWElC>; Tue, 22 Jan 2002 23:41:02 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] One-liner typo 2.5.3-pre3 in ppc/kernel/idle.c
Date: Wed, 23 Jan 2002 15:41:12 +1100
Message-Id: <E16TFDk-0007wc-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like need_resched conversion error.

Cheers!
Rusty.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.3-pre3/arch/ppc/kernel/idle.c linux-2.5.3-pre3.28518.updated/arch/ppc/kernel/idle.c
--- linux-2.5.3-pre3/arch/ppc/kernel/idle.c	Wed Jan 23 15:38:36 2002
+++ linux-2.5.3-pre3.28518.updated/arch/ppc/kernel/idle.c	Wed Jan 23 15:39:08 2002
@@ -66,7 +67,7 @@
 			int oldval = xchg(&current->need_resched, -1);
 
 			if (!oldval) {
-				while (need_resched())
+				while (!need_resched())
 					barrier(); /* Do Nothing */
 			}
 		}

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
