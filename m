Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266787AbSKHIbr>; Fri, 8 Nov 2002 03:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbSKHIbq>; Fri, 8 Nov 2002 03:31:46 -0500
Received: from dp.samba.org ([66.70.73.150]:39878 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266787AbSKHIbp>;
	Fri, 8 Nov 2002 03:31:45 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Fix BUG() decl warning in smp.h for UP
Date: Fri, 08 Nov 2002 19:28:34 +1100
Message-Id: <20021108083827.98FC62C2D5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Rusty Russell <rusty@rustcorp.com.au>

  x86 always seems to include asm/page.h, PPC (and presumably others) don't.
  

--- trivial-2.5-bk/include/linux/smp.h.orig	2002-11-08 18:47:06.000000000 +1100
+++ trivial-2.5-bk/include/linux/smp.h	2002-11-08 18:47:06.000000000 +1100
@@ -79,6 +79,7 @@
 
 int cpu_up(unsigned int cpu);
 #else /* !SMP */
+#include <asm/page.h> /* For BUG() */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
-- 
  Don't blame me: the Monkey is driving
  File: Rusty Russell <rusty@rustcorp.com.au>: [PATCH] Fix BUG() decl warning in smp.h for UP
