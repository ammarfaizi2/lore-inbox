Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269299AbTCDGJv>; Tue, 4 Mar 2003 01:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269300AbTCDGJv>; Tue, 4 Mar 2003 01:09:51 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:48013 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S269299AbTCDGJu>;
	Tue, 4 Mar 2003 01:09:50 -0500
Date: Tue, 4 Mar 2003 17:20:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: rth@twiddle.net
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 9/9 Alpha part
Message-Id: <20030304172008.08087ee7.sfr@canb.auug.org.au>
In-Reply-To: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
References: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

This is only partly to do with the other parts of this patch set.  All it
does is remove struct flock64 from the Alpha port.  It requires the generic
part of the patch set.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.63-32bit.1/include/asm-alpha/fcntl.h 2.5.63-32bit.2/include/asm-alpha/fcntl.h
--- 2.5.63-32bit.1/include/asm-alpha/fcntl.h	2001-09-18 06:16:30.000000000 +1000
+++ 2.5.63-32bit.2/include/asm-alpha/fcntl.h	2003-02-25 14:35:59.000000000 +1100
@@ -69,9 +69,6 @@
 	__kernel_pid_t l_pid;
 };
 
-#ifdef __KERNEL__
-#define flock64	flock
-#endif
 #define F_LINUX_SPECIFIC_BASE  1024
 
 #endif
