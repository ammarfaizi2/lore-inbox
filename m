Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSENOyh>; Tue, 14 May 2002 10:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315750AbSENOyg>; Tue, 14 May 2002 10:54:36 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:41438 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315746AbSENOyf>;
	Tue, 14 May 2002 10:54:35 -0400
Date: Wed, 15 May 2002 00:53:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>, bjornw@axis.com,
        ralf@gnu.org, linux-kernel@vger.kernel.org
Subject: [PATCH] small typo in signal code for cris, mips and mips64
Message-Id: <20020515005319.4a770161.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This looks very obvious to me but I may be mistaken.

I haven't even attempted to build this as I don't have machines
of any of the affected archs.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.15/arch/cris/mm/fault.c 2.5.15-si.2/arch/cris/mm/fault.c
--- 2.5.15/arch/cris/mm/fault.c	Thu Jan 31 09:59:34 2002
+++ 2.5.15-si.2/arch/cris/mm/fault.c	Wed May 15 00:00:31 2002
@@ -440,7 +440,7 @@
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	info.si_code = SIGBUS;
+	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *)address;
diff -ruN 2.5.15/arch/mips/mm/fault.c 2.5.15-si.2/arch/mips/mm/fault.c
--- 2.5.15/arch/mips/mm/fault.c	Mon Aug 13 10:02:11 2001
+++ 2.5.15-si.2/arch/mips/mm/fault.c	Wed May 15 00:19:48 2002
@@ -191,7 +191,7 @@
 	 * or user mode.
 	 */
 	tsk->thread.cp0_badvaddr = address;
-	info.si_code = SIGBUS;
+	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *) address;
diff -ruN 2.5.15/arch/mips64/mm/fault.c 2.5.15-si.2/arch/mips64/mm/fault.c
--- 2.5.15/arch/mips64/mm/fault.c	Mon Sep 24 05:12:39 2001
+++ 2.5.15-si.2/arch/mips64/mm/fault.c	Wed May 15 00:20:50 2002
@@ -247,7 +247,7 @@
 	 * or user mode.
 	 */
 	tsk->thread.cp0_badvaddr = address;
-	info.si_code = SIGBUS;
+	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *) address;
