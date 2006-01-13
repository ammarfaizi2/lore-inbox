Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161655AbWAMDUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161655AbWAMDUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161668AbWAMDU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:20:28 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44416 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161655AbWAMDTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:51 -0500
Message-Id: <20060113032246.922044000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:51 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 13/17] [SPARC64]: Fix sys_fstat64() entry in 64-bit syscall table.
Content-Disposition: inline; filename=sparc64-fix-sys_fstat64-entry-in-64-bit-syscall-table.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Noticed by Jakub Jelinek.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/sparc64/kernel/systbls.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15.y/arch/sparc64/kernel/systbls.S
===================================================================
--- linux-2.6.15.y.orig/arch/sparc64/kernel/systbls.S
+++ linux-2.6.15.y/arch/sparc64/kernel/systbls.S
@@ -98,7 +98,7 @@ sys_call_table:
 	.word sys_umount, sys_setgid, sys_getgid, sys_signal, sys_geteuid
 /*50*/	.word sys_getegid, sys_acct, sys_memory_ordering, sys_nis_syscall, sys_ioctl
 	.word sys_reboot, sys_nis_syscall, sys_symlink, sys_readlink, sys_execve
-/*60*/	.word sys_umask, sys_chroot, sys_newfstat, sys_stat64, sys_getpagesize
+/*60*/	.word sys_umask, sys_chroot, sys_newfstat, sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys_pread64, sys_pwrite64, sys_nis_syscall
 /*70*/	.word sys_nis_syscall, sys_mmap, sys_nis_syscall, sys64_munmap, sys_mprotect
 	.word sys_madvise, sys_vhangup, sys_nis_syscall, sys_mincore, sys_getgroups

--
