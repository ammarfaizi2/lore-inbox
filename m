Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUCKUVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUCKUVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:21:45 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:43856 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261634AbUCKUVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:21:41 -0500
Date: Thu, 11 Mar 2004 21:21:37 +0100
Message-Id: <200403112021.i2BKLbUm000824@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 419] m68k __test_and_set_bit()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing implementation for non-atomic __test_and_set_bit()

--- linux-2.6.4/include/asm-m68k/bitops.h	2004-01-21 22:03:53.000000000 +0100
+++ linux-m68k-2.6.4/include/asm-m68k/bitops.h	2004-02-29 13:37:03.000000000 +0100
@@ -21,6 +21,8 @@
    __constant_test_and_set_bit(nr, vaddr) : \
    __generic_test_and_set_bit(nr, vaddr))
 
+#define __test_and_set_bit(nr,vaddr) test_and_set_bit(nr,vaddr)
+
 static inline int __constant_test_and_set_bit(int nr,
 					      volatile unsigned long *vaddr)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
