Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932776AbWFWBxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbWFWBxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWFWBxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:53:05 -0400
Received: from mo32.po.2iij.net ([210.128.50.17]:33068 "EHLO mo32.po.2iij.net")
	by vger.kernel.org with ESMTP id S932776AbWFWBxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:53:02 -0400
Date: Fri, 23 Jun 2006 10:52:49 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fixed the number of arguments about mremap
Message-Id: <20060623105249.35338d8b.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes the number of arguments about mremap.
mremap syscall takes 5 arguments.

MIPS fixed by Ralf Baechle.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X 2.6.17/Documentation/dontdiff 2.6.17-orig/arch/mips/kernel/scall32-o32.S 2.6.17/arch/mips/kernel/scall32-o32.S
--- 2.6.17-orig/arch/mips/kernel/scall32-o32.S	2006-06-23 10:37:08.983801000 +0900
+++ 2.6.17/arch/mips/kernel/scall32-o32.S	2006-06-23 10:38:43.525709500 +0900
@@ -497,7 +497,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_sched_get_priority_min 1
 	sys	sys_sched_rr_get_interval 2	/* 4165 */
 	sys	sys_nanosleep,		2
-	sys	sys_mremap,		4
+	sys	sys_mremap,		5
 	sys	sys_accept		3
 	sys	sys_bind		3
 	sys	sys_connect		3	/* 4170 */
diff -pruN -X 2.6.17/Documentation/dontdiff 2.6.17-orig/arch/xtensa/kernel/syscalls.h 2.6.17/arch/xtensa/kernel/syscalls.h
--- 2.6.17-orig/arch/xtensa/kernel/syscalls.h	2006-06-23 10:37:09.603839750 +0900
+++ 2.6.17/arch/xtensa/kernel/syscalls.h	2006-06-23 10:40:31.772474500 +0900
@@ -191,7 +191,7 @@ SYSCALL(sys_sched_get_priority_max,1)
 SYSCALL(sys_sched_get_priority_min,1)
 SYSCALL(sys_sched_rr_get_interval,2)	/* 165 */
 SYSCALL(sys_nanosleep,2)
-SYSCALL(sys_mremap,4)
+SYSCALL(sys_mremap,5)
 SYSCALL(sys_accept, 3)
 SYSCALL(sys_bind, 3)
 SYSCALL(sys_connect, 3)			/* 170 */
