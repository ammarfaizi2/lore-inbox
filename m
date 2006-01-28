Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422796AbWA1CTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWA1CTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbWA1CTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:19:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:63160 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422796AbWA1CTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:19:10 -0500
Date: Fri, 27 Jan 2006 18:18:27 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net
Subject: [patch 4/6] [SPARC64]: Fix sys_fstat64() entry in 64-bit syscall table.
Message-ID: <20060128021827.GE10362@kroah.com>
References: <20060128015840.722214000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sparc64-fix-sys_fstat64-entry-in-64-bit-syscall-table.patch"
In-Reply-To: <20060128021749.GA10362@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "David S. Miller" <davem@davemloft.net>

Noticed by Jakub Jelinek.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/sparc64/kernel/systbls.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.6.orig/arch/sparc64/kernel/systbls.S
+++ linux-2.6.14.6/arch/sparc64/kernel/systbls.S
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
