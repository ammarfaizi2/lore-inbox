Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWIMPNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWIMPNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWIMPNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:13:07 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:61403 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750880AbWIMPNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:13:06 -0400
Message-Id: <200609131510.k8DFAvIM004159@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       76306.1226@compuserve.com, ak@muc.de, jeremy@xensource.com,
       rusty@rustcorp.com.au, zach@vmware.com
Subject: [PATCH] Properly export ptrace-abi.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Sep 2006 11:10:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ptrace.h splitting patch neglected to add the new, userspace-usable
header to the appropriate header export lists.

This patch does so.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/include/asm-i386/Kbuild
===================================================================
--- linux-2.6.18-mm.orig/include/asm-i386/Kbuild	2006-09-12 10:43:40.000000000 -0400
+++ linux-2.6.18-mm/include/asm-i386/Kbuild	2006-09-13 11:03:48.000000000 -0400
@@ -1,5 +1,5 @@
 include include/asm-generic/Kbuild.asm
 
-header-y += boot.h debugreg.h ldt.h ucontext.h
+header-y += boot.h debugreg.h ldt.h ptrace-abi.h ucontext.h
 
 unifdef-y += mtrr.h setup.h vm86.h
Index: linux-2.6.18-mm/include/asm-x86_64/Kbuild
===================================================================
--- linux-2.6.18-mm.orig/include/asm-x86_64/Kbuild	2006-09-11 10:47:53.000000000 -0400
+++ linux-2.6.18-mm/include/asm-x86_64/Kbuild	2006-09-13 11:04:03.000000000 -0400
@@ -5,7 +5,7 @@ ARCHDEF := defined __x86_64__
 ALTARCHDEF := defined __i386__
 
 header-y += boot.h bootsetup.h cpufeature.h debugreg.h ldt.h \
-	 msr.h prctl.h setup.h sigcontext32.h ucontext.h \
+	 msr.h prctl.h ptrace-abi.h setup.h sigcontext32.h ucontext.h \
 	 vsyscall32.h
 
 unifdef-y += mce.h mtrr.h vsyscall.h

