Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTGGHqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 03:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266841AbTGGHqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 03:46:19 -0400
Received: from dp.samba.org ([66.70.73.150]:24499 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264797AbTGGHqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 03:46:17 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Remove extra #includes
Date: Mon, 07 Jul 2003 17:58:09 +1000
Message-Id: <20030707080051.A05B52C2BB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Tom Rini <trini@kernel.crashing.org>

  This removes two extra #includes of <linux/spinlock.h>.
  Nothing in either of these files require <linux/spinlock.h>.
  
  ===== arch/i386/kernel/i387.c 1.16 vs edited =====

--- trivial-2.5.74-bk4/arch/i386/kernel/i387.c.orig	2003-07-07 17:36:54.000000000 +1000
+++ trivial-2.5.74-bk4/arch/i386/kernel/i387.c	2003-07-07 17:36:54.000000000 +1000
@@ -10,7 +10,6 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
-#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
--- trivial-2.5.74-bk4/include/asm-i386/i387.h.orig	2003-07-07 17:36:54.000000000 +1000
+++ trivial-2.5.74-bk4/include/asm-i386/i387.h	2003-07-07 17:36:54.000000000 +1000
@@ -12,7 +12,6 @@
 #define __ASM_I386_I387_H
 
 #include <linux/sched.h>
-#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
 #include <asm/user.h>
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Tom Rini <trini@kernel.crashing.org>: [PATCH] Remove extra #includes
