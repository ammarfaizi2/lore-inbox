Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263384AbTDCNEv>; Thu, 3 Apr 2003 08:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263385AbTDCNEv>; Thu, 3 Apr 2003 08:04:51 -0500
Received: from c150240.vh.plala.or.jp ([210.150.150.240]:12693 "EHLO
	mps7.plala.or.jp") by vger.kernel.org with ESMTP id <S263384AbTDCNEs>;
	Thu, 3 Apr 2003 08:04:48 -0500
Date: Thu, 3 Apr 2003 22:16:03 +0900
From: Tomoya TAKA <tomoya@olive.plala.or.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.21-pre6] small fix of arch/alpha/kernel/entry.S
Message-Id: <20030403221603.620cd096.tomoya@olive.plala.or.jp>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Build of 2.4.21-pre6 kernel for Alpha results in linkage errors
because of a name change of kernel_thread in arch/alpha/kernel/entry.S.

-- 
Tomoya TAKA <tomoya@olive.plala.or.jp>

diff -uNr 2.4.21-pre6/arch/alpha/kernel/entry.S linux/arch/alpha/kernel/entry.S
--- 2.4.21-pre6/arch/alpha/kernel/entry.S	2003-04-03 11:56:29.000000000 +0900
+++ linux/arch/alpha/kernel/entry.S	2003-04-03 12:00:46.000000000 +0900
@@ -234,8 +234,8 @@
  * arch_kernel_thread(fn, arg, clone_flags)
  */
 .align 3
-.globl	kernel_thread
-.ent	kernel_thread
+.globl	arch_kernel_thread
+.ent	arch_kernel_thread
 arch_kernel_thread:
 	ldgp	$29,0($27)	/* we can be called from a module */
 	.frame $30, 4*8, $26




