Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWBNFE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWBNFE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWBNFE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:04:56 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:5838 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030356AbWBNFEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:04:54 -0500
Message-Id: <20060214050442.327888000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:03:54 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Michael Tokarev <mjt@tls.msk.ru>,
       parisc-linux@parisc-linux.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 03/47] parisc: add ()-pair in __ffz() macro
Content-Disposition: inline; filename=parisc-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed by Michael Tokarev

add missing ()-pair in __ffz() macro for parisc

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-parisc/bitops.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-rc/include/asm-parisc/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-parisc/bitops.h
+++ 2.6-rc/include/asm-parisc/bitops.h
@@ -220,7 +220,7 @@ static __inline__ unsigned long __ffs(un
 }
 
 /* Undefined if no bit is zero. */
-#define ffz(x)	__ffs(~x)
+#define ffz(x)	__ffs(~(x))
 
 /*
  * ffs: find first bit set. returns 1 to BITS_PER_LONG or 0 (if none set)

--
