Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUHISho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUHISho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266816AbUHISe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:34:59 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:27031 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266837AbUHISdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:33:31 -0400
Date: Mon, 9 Aug 2004 19:32:01 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.7-rc3-mm2 inlining failures.
Message-ID: <20040809183201.GC19195@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/mach-generic/summit.c: In function `send_IPI_all':
include/asm/mach-summit/mach_ipi.h:4: sorry, unimplemented: inlining failed in call to 'send_IPI_mask_sequence': function body not available
arch/i386/mach-generic/summit.c:8: sorry, unimplemented: called from here
make[1]: *** [arch/i386/mach-generic/summit.o] Error 1
make: *** [arch/i386/mach-generic] Error 2

arch/i386/mach-generic/bigsmp.c: In function `send_IPI_all':
include/asm/mach-bigsmp/mach_ipi.h:4: sorry, unimplemented: inlining failed in call to 'send_IPI_mask_sequence': function body not available
arch/i386/mach-generic/bigsmp.c:8: sorry, unimplemented: called from here
make[1]: *** [arch/i386/mach-generic/bigsmp.o] Error 1
make: *** [arch/i386/mach-generic] Error 2

arch/i386/mach-generic/es7000.c: In function `send_IPI_all':
include/asm/mach-es7000/mach_ipi.h:4: sorry, unimplemented: inlining failed in call to 'send_IPI_mask_sequence': function body not available
arch/i386/mach-generic/es7000.c:8: sorry, unimplemented: called from here
make[1]: *** [arch/i386/mach-generic/es7000.o] Error 1
make: *** [arch/i386/mach-generic] Error 2


gcc version 3.4.1 20040714 (Red Hat 3.4.1-7)


--- linux-2.6.7/include/asm/mach-summit/mach_ipi.h~	2004-08-09 19:30:02.639882888 +0100
+++ linux-2.6.7/include/asm/mach-summit/mach_ipi.h	2004-08-09 19:30:07.432154352 +0100
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-inline void send_IPI_mask_sequence(cpumask_t mask, int vector);
+void send_IPI_mask_sequence(cpumask_t mask, int vector);
 
 static inline void send_IPI_mask(cpumask_t mask, int vector)
 {
--- linux-2.6.7/include/asm/mach-bigsmp/mach_ipi.h~	2004-08-09 19:30:18.660447392 +0100
+++ linux-2.6.7/include/asm/mach-bigsmp/mach_ipi.h	2004-08-09 19:30:21.603000056 +0100
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-inline void send_IPI_mask_sequence(cpumask_t mask, int vector);
+void send_IPI_mask_sequence(cpumask_t mask, int vector);
 
 static inline void send_IPI_mask(cpumask_t mask, int vector)
 {
--- linux-2.6.7/include/asm/mach-es7000/mach_ipi.h~	2004-08-09 19:30:43.086734032 +0100
+++ linux-2.6.7/include/asm/mach-es7000/mach_ipi.h	2004-08-09 19:30:45.324393856 +0100
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-inline void send_IPI_mask_sequence(cpumask_t mask, int vector);
+void send_IPI_mask_sequence(cpumask_t mask, int vector);
 
 static inline void send_IPI_mask(cpumask_t mask, int vector)
 {
