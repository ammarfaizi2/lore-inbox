Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSFATrm>; Sat, 1 Jun 2002 15:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316766AbSFATrl>; Sat, 1 Jun 2002 15:47:41 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:47801 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316723AbSFATrk>; Sat, 1 Jun 2002 15:47:40 -0400
Date: Sat, 1 Jun 2002 13:47:19 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5 1/12: patched module.h
Message-ID: <Pine.LNX.4.44.0206011345340.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - patched module.h

Here we have stuff skipped that kbuild-2.5 does for us.

You will need this patch in generic for kbuild-2.5.
You should have the other patches, too! You can compile a kernel
with only this patch, but it's meaningless. I suggest retrieving
the whole kbuild-2.5 patchset.

This patch is also available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-includes.patch>

diff -Nur kbuild-2.5/include/linux/module.h kbuild-2.5/include/linux/module.h
--- kbuild-2.5/include/linux/module.h Fri May 31 15:49:39 2002
+++ kbuild-2.5/include/linux/module.h Fri May 31 15:49:39 2002 +0000 thunder (thunder-2.5/include/linux/module.h 1.1 0644)
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 
+#ifndef CONFIG_KBUILD_2_5
 #ifdef __GENKSYMS__
 #  define _set_ver(sym) sym
 #  undef  MODVERSIONS
@@ -21,6 +22,7 @@
 #   include <linux/modversions.h>
 # endif
 #endif /* __GENKSYMS__ */
+#endif /* CONFIG_KBUILD_2_5 */
 
 #include <asm/atomic.h>
 

