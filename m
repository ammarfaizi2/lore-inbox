Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTBLErv>; Tue, 11 Feb 2003 23:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTBLEru>; Tue, 11 Feb 2003 23:47:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:29116 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S263039AbTBLErr>;
	Tue, 11 Feb 2003 23:47:47 -0500
Date: Wed, 12 Feb 2003 15:57:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org
Subject: [PATCH][COMPAT] compat_sys_futex 4/7 ppc64
Message-Id: <20030212155721.69363325.sfr@canb.auug.org.au>
In-Reply-To: <20030212154716.7c101942.sfr@canb.auug.org.au>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Anton asked me to send this directly to you since it is so trivial.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-32bit.1/arch/ppc64/kernel/misc.S 2.5.60-32bit.2/arch/ppc64/kernel/misc.S
--- 2.5.60-32bit.1/arch/ppc64/kernel/misc.S	2003-02-11 09:39:15.000000000 +1100
+++ 2.5.60-32bit.2/arch/ppc64/kernel/misc.S	2003-02-11 12:21:56.000000000 +1100
@@ -724,7 +724,7 @@
 	.llong .sys_removexattr
 	.llong .sys_lremovexattr
 	.llong .sys_fremovexattr	/* 220 */
-	.llong .sys_futex
+	.llong .compat_sys_futex
 	.llong .sys32_sched_setaffinity
 	.llong .sys32_sched_getaffinity
 	.llong .sys_ni_syscall
