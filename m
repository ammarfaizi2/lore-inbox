Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTDWNr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTDWNr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:47:56 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:44439 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264037AbTDWNrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:47:53 -0400
Date: Wed, 23 Apr 2003 15:49:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Better docs for boot-up code
Message-ID: <20030423134940.GA308@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds some nice docs for boot-up code. Please apply,

							Pavel
Index: linux/arch/i386/boot/setup.S
===================================================================
--- linux.orig/arch/i386/boot/setup.S	2003-04-22 00:04:32.000000000 +0200
+++ linux/arch/i386/boot/setup.S	2003-04-21 22:40:53.000000000 +0200
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
Index: linux/arch/i386/kernel/trampoline.S
===================================================================
--- linux.orig/arch/i386/kernel/trampoline.S	2003-04-22 00:04:32.000000000 +0200
+++ linux/arch/i386/kernel/trampoline.S	2003-03-30 20:01:55.000000000 +0200
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
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
