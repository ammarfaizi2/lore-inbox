Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTBLE5O>; Tue, 11 Feb 2003 23:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBLE5O>; Tue, 11 Feb 2003 23:57:14 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:50620 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266940AbTBLE5N>;
	Tue, 11 Feb 2003 23:57:13 -0500
Date: Wed, 12 Feb 2003 16:06:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Miller <davem@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus <torvalds@transmeta.com>
Subject: [PATCH][COMPAT] compat_sys_futex 6/7 sparc64
Message-Id: <20030212160644.230e3b0b.sfr@canb.auug.org.au>
In-Reply-To: <20030212154716.7c101942.sfr@canb.auug.org.au>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here is tha sparc64 part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-32bit.1/arch/sparc64/kernel/systbls.S 2.5.60-32bit.2/arch/sparc64/kernel/systbls.S
--- 2.5.60-32bit.1/arch/sparc64/kernel/systbls.S	2003-02-11 12:21:29.000000000 +1100
+++ 2.5.60-32bit.2/arch/sparc64/kernel/systbls.S	2003-02-11 12:21:56.000000000 +1100
@@ -47,7 +47,7 @@
 	.word sys_nis_syscall, sys32_setreuid16, sys32_setregid16, sys_rename, sys_truncate
 /*130*/	.word sys_ftruncate, sys_flock, sys_lstat64, sys_nis_syscall, sys_nis_syscall
 	.word sys_nis_syscall, sys_mkdir, sys_rmdir, sys32_utimes, sys_stat64
-/*140*/	.word sys32_sendfile64, sys_nis_syscall, sys_futex, sys_gettid, sys32_getrlimit
+/*140*/	.word sys32_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, sys32_getrlimit
 	.word sys32_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word sys32_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
