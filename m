Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVCKGSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVCKGSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 01:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbVCKGSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 01:18:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:23514 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262548AbVCKGSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 01:18:32 -0500
Subject: [PATCH] ppc64: Export proper version from vDSO
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 17:18:20 +1100
Message-Id: <1110521900.5751.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The ppc64 vDSO is still exporting LINUX_2.6.11 (from -mm) for symbol
versioning. The glibc folks asked me to export the first kernel version
that will contain it, so this patch fixes it to LINUX_2.6.12

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc64/vdso.h
===================================================================
--- linux-work.orig/include/asm-ppc64/vdso.h	2005-03-08 11:21:44.000000000 +1100
+++ linux-work/include/asm-ppc64/vdso.h	2005-03-11 17:16:21.000000000 +1100
@@ -11,7 +11,7 @@
 #define VDSO32_MBASE	0x100000
 #define VDSO64_MBASE	0x100000
 
-#define VDSO_VERSION_STRING	LINUX_2.6.11
+#define VDSO_VERSION_STRING	LINUX_2.6.12
 
 /* Define if 64 bits VDSO has procedure descriptors */
 #undef VDS64_HAS_DESCRIPTORS




