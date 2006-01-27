Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWA0GjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWA0GjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWA0GjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:39:05 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:9934 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750935AbWA0GjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:39:03 -0500
Date: Fri, 27 Jan 2006 15:39:09 +0900
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH] parisc: add ()-pair in __ffs()
Message-ID: <20060127063909.GA8166@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com> <20060126033156.GB11138@miraclelinux.com> <43D886A5.8010309@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D886A5.8010309@tls.msk.ru>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found by Michael Tokarev

Add missing ()-pair in ffz() macro.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

Index: 2.6-git/include/asm-parisc/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-parisc/bitops.h	2006-01-26 18:33:40.000000000 +0900
+++ 2.6-git/include/asm-parisc/bitops.h	2006-01-26 19:32:07.000000000 +0900
@@ -220,7 +220,7 @@
 }
 
 /* Undefined if no bit is zero. */
-#define ffz(x)	__ffs(~x)
+#define ffz(x)	__ffs(~(x))
 
 /*
  * ffs: find first bit set. returns 1 to BITS_PER_LONG or 0 (if none set)
