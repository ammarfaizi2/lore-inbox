Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUB2QPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 11:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUB2QPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 11:15:46 -0500
Received: from witte.sonytel.be ([80.88.33.193]:30861 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262064AbUB2QPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 11:15:45 -0500
Date: Sun, 29 Feb 2004 17:15:35 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Kai Germaschewski <kai.germaschewski@gmx.de>,
       Paul Russell <rusty@rustcorp.com.au>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] scripts/modpost warning
Message-ID: <Pine.GSO.4.58.0402291713230.7483@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I need the following patch to kill a warning (__endian() may be unused) when
cross-compiling m68k kernels on an ia32 box.

--- linux-2.6.4-rc1/scripts/modpost.h	2004-02-29 09:33:41.000000000 +0100
+++ linux-m68k-2.6.4-rc1/scripts/modpost.h	2004-02-29 10:39:56.000000000 +0100
@@ -31,7 +31,7 @@

 #if KERNEL_ELFDATA != HOST_ELFDATA

-static void __endian(const void *src, void *dest, unsigned int size)
+static inline void __endian(const void *src, void *dest, unsigned int size)
 {
 	unsigned int i;
 	for (i = 0; i < size; i++)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
