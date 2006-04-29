Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWD2XrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWD2XrF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWD2Xqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:46:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:3525 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750837AbWD2XnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:43:11 -0400
Message-Id: <20060429233920.561256000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:17 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 05/13] cell: enable CPU_FTR_CI_LARGE_PAGE
Content-Disposition: inline; filename=64k-page-enable.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reflect the fact that the Cell Broadband Engine supports 64k
pages by adding the bit to the CPU features.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/include/asm-powerpc/cputable.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/cputable.h	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/include/asm-powerpc/cputable.h	2006-04-29 22:53:42.000000000 +0200
@@ -329,7 +329,7 @@
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO)
+	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 #endif

--

