Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSLML7p>; Fri, 13 Dec 2002 06:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSLML6F>; Fri, 13 Dec 2002 06:58:05 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3588 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262804AbSLML5f>;
	Fri, 13 Dec 2002 06:57:35 -0500
Date: Thu, 12 Dec 2002 21:38:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: ACPI/S3: fix gcc3.2 compatibility
Message-ID: <20021212203823.GA1511@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

gcc3.2 is a bit more pedantic... Please apply,
								Pavel

--- clean/arch/i386/kernel/suspend_asm.S	2002-12-11 23:33:53.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend_asm.S	2002-12-06 17:52:18.000000000 +0100
@@ -6,7 +6,7 @@
 #include <asm/segment.h>
 #include <asm/page.h>
 
-ENTRY(do_magic):
+ENTRY(do_magic)
 	pushl %ebx
 	cmpl $0,8(%esp)
 	jne .L1450
@@ -66,7 +66,7 @@
 .L1453:
 	movl $104,%eax
 
-	movw %eax, %ds
+	movw %ax, %ds
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_eax, %eax

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
