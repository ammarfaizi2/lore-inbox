Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUAVDRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 22:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266088AbUAVDRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 22:17:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:1496 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262050AbUAVDRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 22:17:32 -0500
Subject: [PATCH] ppc32: Set HZ to 1000 on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074741394.967.89.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 14:16:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew !

This patch has been in my tree for monthes and Paulus agrees that it
should be made generic, so here we go, PPC32 is now proud to run at
1000HZ :)

Please apply.

Ben.


diff -urN linux-2.5-merge/include/asm-ppc/param.h linuxppc-2.5-benh/include/asm-ppc/param.h
--- linux-2.5-merge/include/asm-ppc/param.h	2004-01-22 11:54:51.216740592 +1100
+++ linuxppc-2.5-benh/include/asm-ppc/param.h	2004-01-22 11:14:49.000000000 +1100
@@ -1,16 +1,16 @@
 #ifndef _ASM_PPC_PARAM_H
 #define _ASM_PPC_PARAM_H
 
-#ifndef HZ
-#define HZ 100
-#endif
-
 #ifdef __KERNEL__
-#define HZ		100		/* internal timer frequency */
+#define HZ		1000		/* internal timer frequency */
 #define USER_HZ		100		/* for user interfaces in "ticks" */
 #define CLOCKS_PER_SEC	(USER_HZ)	/* frequency at which times() counts */
 #endif /* __KERNEL__ */
 
+#ifndef HZ
+#define HZ 100
+#endif
+
 #define EXEC_PAGESIZE	4096
 
 #ifndef NGROUPS


