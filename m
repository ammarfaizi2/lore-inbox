Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWBAJV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWBAJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWBAJUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:20:07 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:5450 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932117AbWBAJDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:25 -0500
Message-Id: <20060201090322.900876000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:32 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       David Howells <dhowells@redhat.com>,
       Hirokazu Takata <takata@linux-m32r.org>,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 08/44] generic ffz()
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

Index: 2.6-git/include/asm-generic/bitops/ffz.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/ffz.h
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
