Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTAFEEw>; Sun, 5 Jan 2003 23:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbTAFEDb>; Sun, 5 Jan 2003 23:03:31 -0500
Received: from dp.samba.org ([66.70.73.150]:51936 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266091AbTAFEDP>;
	Sun, 5 Jan 2003 23:03:15 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Fix BUG() decl warning in smp.h for UP
Date: Mon, 06 Jan 2003 15:02:02 +1100
Message-Id: <20030106041151.F2DF62C2A9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Rusty Russell <rusty@rustcorp.com.au>

  x86 always seems to include asm/page.h, PPC (and presumably others) don't.
  

--- trivial-2.5-bk/include/linux/smp.h.orig	2003-01-06 14:10:59.000000000 +1100
+++ trivial-2.5-bk/include/linux/smp.h	2003-01-06 14:10:59.000000000 +1100
@@ -86,6 +86,7 @@
 void smp_prepare_boot_cpu(void);
 
 #else /* !SMP */
+#include <asm/page.h> /* For BUG() */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
-- 
  Don't blame me: the Monkey is driving
  File: Rusty Russell <rusty@rustcorp.com.au>: [PATCH] Fix BUG() decl warning in smp.h for UP
