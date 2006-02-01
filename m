Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWBAJT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWBAJT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBAJDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:03:25 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:44105 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750781AbWBAJDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:22 -0500
Message-Id: <20060201090321.223003000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:26 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, parisc-linux@parisc-linux.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 02/44] parisc: add ()-pair in __ffz() macro
Content-Disposition: inline; filename=parisc-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed by Michael Tokarev

add missing ()-pair in __ffz() macro for parisc

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-parisc/bitops.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-git/include/asm-parisc/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-parisc/bitops.h
+++ 2.6-git/include/asm-parisc/bitops.h
@@ -220,7 +220,7 @@ static __inline__ unsigned long __ffs(un
 }
 
 /* Undefined if no bit is zero. */
-#define ffz(x)	__ffs(~x)
+#define ffz(x)	__ffs(~(x))
 
 /*
  * ffs: find first bit set. returns 1 to BITS_PER_LONG or 0 (if none set)

--
