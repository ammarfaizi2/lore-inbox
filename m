Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVDLUSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVDLUSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVDLURH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:17:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:25544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262139AbVDLKba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:30 -0400
Message-Id: <200504121031.j3CAVKb1005292@shell0.pdx.osdl.net>
Subject: [patch 042/198] ppc32: fix compilation error in include/asm/prom.h
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benoit.boissinot@ens-lyon.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

make defconfig give the following error on ppc (gcc-4):

arch/ppc/syslib/prom_init.c:120: error: static declaration of ‘prom_display_paths’ follows non-static declaration
include/asm/prom.h:17: error: previous declaration of ‘prom_display_paths’ was here
arch/ppc/syslib/prom_init.c:122: error: static declaration of ‘prom_num_displays’ follows non-static declaration
include/asm/prom.h:18: error: previous declaration of ‘prom_num_displays’ was here

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-ppc/prom.h |    3 ---
 1 files changed, 3 deletions(-)

diff -puN include/asm-ppc/prom.h~ppc32-fix-compilation-error-in-include-asm-promh include/asm-ppc/prom.h
--- 25/include/asm-ppc/prom.h~ppc32-fix-compilation-error-in-include-asm-promh	2005-04-12 03:21:13.348107680 -0700
+++ 25-akpm/include/asm-ppc/prom.h	2005-04-12 03:21:13.351107224 -0700
@@ -14,9 +14,6 @@
 typedef u32 phandle;
 typedef u32 ihandle;
 
-extern char *prom_display_paths[];
-extern unsigned int prom_num_displays;
-
 struct address_range {
 	unsigned int space;
 	unsigned int address;
_
