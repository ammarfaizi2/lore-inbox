Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268530AbTANCrc>; Mon, 13 Jan 2003 21:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268531AbTANCqd>; Mon, 13 Jan 2003 21:46:33 -0500
Received: from dp.samba.org ([66.70.73.150]:30348 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268532AbTANCqA>;
	Mon, 13 Jan 2003 21:46:00 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] duplicate extern char _stext
Date: Tue, 14 Jan 2003 13:35:50 +1100
Message-Id: <20030114025452.8F1792C3DE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Geert Uytterhoeven <geert@linux-m68k.org>

  
  Kill duplicate extern char _stext (already declared globally 14 lines before)
  

--- trivial-2.5.57/include/asm-i386/hw_irq.h.orig	2003-01-14 12:12:10.000000000 +1100
+++ trivial-2.5.57/include/asm-i386/hw_irq.h	2003-01-14 12:12:10.000000000 +1100
@@ -76,7 +76,6 @@
 {
 	unsigned long eip;
 	extern unsigned long prof_cpu_mask;
-	extern char _stext;
 #ifdef CONFIG_PROFILING
 	extern void x86_profile_hook(struct pt_regs *);
  
-- 
  Don't blame me: the Monkey is driving
  File: Geert Uytterhoeven <geert@linux-m68k.org>: [PATCH] duplicate extern char _stext
