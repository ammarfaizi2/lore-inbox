Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTEEEvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTEEEvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:51:49 -0400
Received: from dp.samba.org ([66.70.73.150]:19667 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261927AbTEEEvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:51:44 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Better docs for boot-up code
Date: Mon, 05 May 2003 14:58:39 +1000
Message-Id: <20030505050414.500542C111@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Pavel Machek <pavel@ucw.cz>

  Hi!
  
  This adds some nice docs for boot-up code. Please apply,
  
  							Pavel
  Index: linux/arch/i386/boot/setup.S
  ===================================================================

--- trivial-2.5.69/arch/i386/boot/setup.S.orig	2003-05-05 14:46:23.000000000 +1000
+++ trivial-2.5.69/arch/i386/boot/setup.S	2003-05-05 14:46:23.000000000 +1000
@@ -893,6 +893,9 @@
 	movw	%cs, %si
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
+
+# jump to startup_32 in arch/i386/kernel/head.S
+#	
 # NOTE: For high loaded big kernels we need a
 #	jmpi    0x100000,__BOOT_CS
 #
--- trivial-2.5.69/arch/i386/kernel/trampoline.S.orig	2003-05-05 14:46:23.000000000 +1000
+++ trivial-2.5.69/arch/i386/kernel/trampoline.S	2003-05-05 14:46:23.000000000 +1000
@@ -4,6 +4,8 @@
  *
  *	4 Jan 1997 Michael Chastain: changed to gnu as.
  *
+ *	This is only used for booting secondary CPUs in SMP machine
+ *
  *	Entry: CS:IP point to the start of our code, we are 
  *	in real mode with no stack, but the rest of the 
  *	trampoline page to make our stack and everything else
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Pavel Machek <pavel@ucw.cz>: Better docs for boot-up code
