Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVCKELd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVCKELd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVCKEKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:10:06 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:24763 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263192AbVCKEAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:00:16 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 15:00:10 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.6090.637127.541151@berry.gelato.unsw.EDU.AU>
Subject: Microstate Accounting for 2.6.11, patch 5/6
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Microstate accounting: Add the I386 system call.

 arch/i386/kernel/entry.S  |    2 +-
 include/asm-i386/unistd.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ustate/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6-ustate.orig/arch/i386/kernel/entry.S	2005-03-10 09:16:14.888575341 +1100
+++ linux-2.6-ustate/arch/i386/kernel/entry.S	2005-03-10 09:16:15.446188457 +1100
@@ -876,7 +876,7 @@
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
 	.long sys_waitid
-	.long sys_ni_syscall		/* 285 */ /* available */
+	.long sys_msa			/* 285 */ /* available */
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
Index: linux-2.6-ustate/include/asm-i386/unistd.h
===================================================================
--- linux-2.6-ustate.orig/include/asm-i386/unistd.h	2005-03-10 09:13:00.813843194 +1100
+++ linux-2.6-ustate/include/asm-i386/unistd.h	2005-03-10 09:16:15.448141568 +1100
@@ -290,7 +290,7 @@
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
 #define __NR_waitid		284
-/* #define __NR_sys_setaltroot	285 */
+#define __NR_sys_msa		285
 #define __NR_add_key		286
 #define __NR_request_key	287
 #define __NR_keyctl		288
