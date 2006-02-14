Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWBNFYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWBNFYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWBNFWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:22:20 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:9935 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030365AbWBNFFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:03 -0500
Message-Id: <20060214050443.468528000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:00 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
       Hirokazu Takata <takata@linux-m32r.org>,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 09/47] generic ffz()
Content-Disposition: inline; filename=ffz-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalent of the function:
unsigned long ffz(unsigned long word);

In include/asm-generic/bitops/ffz.h

This code largely copied from:
include/asm-parisc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ffz.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/ffz.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/ffz.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_GENERIC_BITOPS_FFZ_H_
+#define _ASM_GENERIC_BITOPS_FFZ_H_
+
+/*
+ * ffz - find first zero in word.
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+#define ffz(x)  __ffs(~(x))
+
+#endif /* _ASM_GENERIC_BITOPS_FFZ_H_ */

--
