Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTIHElR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 00:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTIHElR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 00:41:17 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:49795
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261941AbTIHElO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 00:41:14 -0400
Date: Mon, 8 Sep 2003 00:40:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH][2.6] arch/arm/mm/tlb-v4wb.S needs to lose a header
Message-ID: <Pine.LNX.4.53.0309080029200.14426@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst building for an SA1100 i got the following snippets;

  AS      arch/arm/mm/tlb-v4wb.o
In file included from include/linux/spinlock.h:13,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from include/linux/mm.h:4,
                 from include/asm/tlbflush.h:14,
                 from arch/arm/mm/tlb-v4wb.S:18:
include/linux/kernel.h:32: warning: `ALIGN' redefined
include/linux/linkage.h:24: warning: this is the location of the previous definition
In file included from include/asm/tlbflush.h:14,

In file included from include/asm/tlbflush.h:14,
                 from arch/arm/mm/tlb-v4wb.S:18:
include/linux/mm.h:87: warning: `VM_EXEC' redefined
include/asm/constants.h:16: warning: this is the location of the previous 
definition

Index: linux-2.6.0-test4-mm6-arm/arch/arm/mm/tlb-v4wb.S
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm6/arch/arm/mm/tlb-v4wb.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 tlb-v4wb.S
--- linux-2.6.0-test4-mm6-arm/arch/arm/mm/tlb-v4wb.S	7 Sep 2003 20:26:24 -0000	1.1.1.1
+++ linux-2.6.0-test4-mm6-arm/arch/arm/mm/tlb-v4wb.S	8 Sep 2003 03:56:45 -0000
@@ -15,7 +15,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/constants.h>
-#include <asm/tlbflush.h>
 #include "proc-macros.S"
 
 	.align	5
