Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTIHElL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 00:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTIHElL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 00:41:11 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:38275
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261909AbTIHElJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 00:41:09 -0400
Date: Mon, 8 Sep 2003 00:40:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH][2.6] asm-arm/tlbflush.h needs some extra headers
Message-ID: <Pine.LNX.4.53.0309080026100.14426@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this whilst building for an SA1100

In file included from arch/arm/kernel/setup.c:31:
include/asm/tlbflush.h: In function `flush_tlb_mm':
include/asm/tlbflush.h:261: warning: implicit declaration of function `ASID'
include/asm/tlbflush.h:267: `current' undeclared (first use in this function)
include/asm/tlbflush.h:267: (Each undeclared identifier is reported only once
include/asm/tlbflush.h:267: for each function it appears in.)
include/asm/tlbflush.h: In function `flush_tlb_page':
include/asm/tlbflush.h:292: dereferencing pointer to incomplete type
include/asm/tlbflush.h:297: dereferencing pointer to incomplete type
include/asm/tlbflush.h:297: `current' undeclared (first use in this function)
arch/arm/kernel/setup.c: In function `request_standard_resources':
arch/arm/kernel/setup.c:437: `init_mm' undeclared (first use in this function)
arch/arm/kernel/setup.c: In function `setup_arch':
arch/arm/kernel/setup.c:690: `init_mm' undeclared (first use in this function)
make[1]: *** [arch/arm/kernel/setup.o] Error 1

Index: linux-2.6.0-test4-mm6-arm/include/asm-arm/tlbflush.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm6/include/asm-arm/tlbflush.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 tlbflush.h
--- linux-2.6.0-test4-mm6-arm/include/asm-arm/tlbflush.h	7 Sep 2003 20:27:38 -0000	1.1.1.1
+++ linux-2.6.0-test4-mm6-arm/include/asm-arm/tlbflush.h	8 Sep 2003 03:34:33 -0000
@@ -11,7 +11,9 @@
 #define _ASMARM_TLBFLUSH_H
 
 #include <linux/config.h>
+#include <linux/mm.h>
 #include <asm/glue.h>
+#include <asm/mmu.h>
 
 #define TLB_V3_PAGE	(1 << 0)
 #define TLB_V4_U_PAGE	(1 << 1)
