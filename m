Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbULHRzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbULHRzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbULHRy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:54:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60368 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261286AbULHRxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:53:14 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Get rid of EXPORT_SYMBOL_NOVERS from the FR-V arch
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.2
Date: Wed, 08 Dec 2004 17:53:03 +0000
Message-ID: <7752.1102528383@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch gets rid of EXPORT_SYMBOL_NOVERS from the FR-V arch.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-novers-2610rc2mm3-3.diff 
 frv_ksyms.c |   62 ++++++++++++++++++++++++++++++------------------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/arch/frv/kernel/frv_ksyms.c linux-2.6.10-rc2-mm3-shmem/arch/frv/kernel/frv_ksyms.c
--- linux-2.6.10-rc2-mm3-mmcleanup/arch/frv/kernel/frv_ksyms.c	2004-11-22 10:53:41.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/arch/frv/kernel/frv_ksyms.c	2004-11-29 11:55:14.000000000 +0000
@@ -57,7 +57,7 @@ EXPORT_SYMBOL(memory_start);
 EXPORT_SYMBOL(memory_end);
 #endif
 
-EXPORT_SYMBOL_NOVERS(__debug_bug_trap);
+EXPORT_SYMBOL(__debug_bug_trap);
 
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy);
@@ -66,27 +66,27 @@ EXPORT_SYMBOL(csum_partial_copy);
    explicitly (the C compiler generates them).  Fortunately,
    their interface isn't gonna change any time soon now, so
    it's OK to leave it out of version control.  */
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(strtok);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(strtok);
 
 EXPORT_SYMBOL(get_wchan);
 
 #ifdef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
-EXPORT_SYMBOL_NOVERS(atomic_test_and_ANDNOT_mask);
-EXPORT_SYMBOL_NOVERS(atomic_test_and_OR_mask);
-EXPORT_SYMBOL_NOVERS(atomic_test_and_XOR_mask);
-EXPORT_SYMBOL_NOVERS(atomic_add_return);
-EXPORT_SYMBOL_NOVERS(atomic_sub_return);
-EXPORT_SYMBOL_NOVERS(__xchg_8);
-EXPORT_SYMBOL_NOVERS(__xchg_16);
-EXPORT_SYMBOL_NOVERS(__xchg_32);
-EXPORT_SYMBOL_NOVERS(__cmpxchg_8);
-EXPORT_SYMBOL_NOVERS(__cmpxchg_16);
-EXPORT_SYMBOL_NOVERS(__cmpxchg_32);
+EXPORT_SYMBOL(atomic_test_and_ANDNOT_mask);
+EXPORT_SYMBOL(atomic_test_and_OR_mask);
+EXPORT_SYMBOL(atomic_test_and_XOR_mask);
+EXPORT_SYMBOL(atomic_add_return);
+EXPORT_SYMBOL(atomic_sub_return);
+EXPORT_SYMBOL(__xchg_8);
+EXPORT_SYMBOL(__xchg_16);
+EXPORT_SYMBOL(__xchg_32);
+EXPORT_SYMBOL(__cmpxchg_8);
+EXPORT_SYMBOL(__cmpxchg_16);
+EXPORT_SYMBOL(__cmpxchg_32);
 #endif
 
 /*
@@ -109,16 +109,16 @@ extern void __udivmoddi4(void);
 extern void __umoddi3(void);
 
         /* gcc lib functions */
-//EXPORT_SYMBOL_NOVERS(__gcc_bcmp);
-EXPORT_SYMBOL_NOVERS(__ashldi3);
-EXPORT_SYMBOL_NOVERS(__ashrdi3);
-//EXPORT_SYMBOL_NOVERS(__cmpdi2);
-//EXPORT_SYMBOL_NOVERS(__divdi3);
-EXPORT_SYMBOL_NOVERS(__lshrdi3);
-//EXPORT_SYMBOL_NOVERS(__moddi3);
-EXPORT_SYMBOL_NOVERS(__muldi3);
-EXPORT_SYMBOL_NOVERS(__negdi2);
-//EXPORT_SYMBOL_NOVERS(__ucmpdi2);
-//EXPORT_SYMBOL_NOVERS(__udivdi3);
-//EXPORT_SYMBOL_NOVERS(__udivmoddi4);
-//EXPORT_SYMBOL_NOVERS(__umoddi3);
+//EXPORT_SYMBOL(__gcc_bcmp);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+//EXPORT_SYMBOL(__cmpdi2);
+//EXPORT_SYMBOL(__divdi3);
+EXPORT_SYMBOL(__lshrdi3);
+//EXPORT_SYMBOL(__moddi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__negdi2);
+//EXPORT_SYMBOL(__ucmpdi2);
+//EXPORT_SYMBOL(__udivdi3);
+//EXPORT_SYMBOL(__udivmoddi4);
+//EXPORT_SYMBOL(__umoddi3);
