Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264283AbTCXREh>; Mon, 24 Mar 2003 12:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264288AbTCXQtk>; Mon, 24 Mar 2003 11:49:40 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:50666 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264287AbTCXQa7>; Mon, 24 Mar 2003 11:30:59 -0500
Message-Id: <200303241642.h2OGg935008320@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:57 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: fix asm constraints in ffs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another brought forward from 2.4.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/asm-i386/bitops.h linux-2.5/include/asm-i386/bitops.h
--- bk-linus/include/asm-i386/bitops.h	2003-03-08 09:57:46.000000000 +0000
+++ linux-2.5/include/asm-i386/bitops.h	2003-03-17 23:42:49.000000000 +0000
@@ -458,7 +458,7 @@ static __inline__ int ffs(int x)
 	__asm__("bsfl %1,%0\n\t"
 		"jnz 1f\n\t"
 		"movl $-1,%0\n"
-		"1:" : "=r" (r) : "g" (x));
+		"1:" : "=r" (r) : "rm" (x));
 	return r+1;
 }
 
