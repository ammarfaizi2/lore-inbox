Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317643AbSHCSN6>; Sat, 3 Aug 2002 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSHCSM4>; Sat, 3 Aug 2002 14:12:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7696 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317638AbSHCSMv>; Sat, 3 Aug 2002 14:12:51 -0400
To: Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 3: 2.5.29-exports
Message-Id: <E17b3Ro-0006wF-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

Various modules (eg, rd.c) use simple_strtol.  This patch exports the
symbol so these modules can be loaded.

 kernel/ksyms.c |    1 +
 1 files changed, 1 insertion

diff -urN orig/kernel/ksyms.c linux/kernel/ksyms.c
--- orig/kernel/ksyms.c	Sun Jul  7 23:21:28 2002
+++ linux/kernel/ksyms.c	Sun Jul  7 17:42:16 2002
@@ -508,6 +501,7 @@
 EXPORT_SYMBOL(__bdevname);
 EXPORT_SYMBOL(cdevname);
 EXPORT_SYMBOL(simple_strtoul);
+EXPORT_SYMBOL(simple_strtol);
 EXPORT_SYMBOL(system_utsname);	/* UTS data */
 EXPORT_SYMBOL(uts_sem);		/* UTS semaphore */
 #ifndef __mips__

