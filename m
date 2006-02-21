Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161303AbWBUDsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161303AbWBUDsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWBUDsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:11 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:5053 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161304AbWBUDsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:08 -0500
Message-Id: <20060221034750.050139000@localhost.localdomain>
References: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:32 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [-mm patch 4/8] fix error: __u32 undeclared
Content-Disposition: inline; filename=include-linux-types.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Build fix for s390
declare __u32 and __u64.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/asm-generic/bitops/fls64.h   |    2 ++
 include/asm-generic/bitops/hweight.h |    2 ++
 2 files changed, 4 insertions(+)

Index: 2.6-mm/include/asm-generic/bitops/fls64.h
===================================================================
--- 2.6-mm.orig/include/asm-generic/bitops/fls64.h
+++ 2.6-mm/include/asm-generic/bitops/fls64.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_GENERIC_BITOPS_FLS64_H_
 #define _ASM_GENERIC_BITOPS_FLS64_H_
 
+#include <asm/types.h>
+
 static inline int fls64(__u64 x)
 {
 	__u32 h = x >> 32;
Index: 2.6-mm/include/asm-generic/bitops/hweight.h
===================================================================
--- 2.6-mm.orig/include/asm-generic/bitops/hweight.h
+++ 2.6-mm/include/asm-generic/bitops/hweight.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_GENERIC_BITOPS_HWEIGHT_H_
 #define _ASM_GENERIC_BITOPS_HWEIGHT_H_
 
+#include <asm/types.h>
+
 extern unsigned int hweight32(unsigned int w);
 extern unsigned int hweight16(unsigned int w);
 extern unsigned int hweight8(unsigned int w);

--
