Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265801AbUFTRf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUFTRf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUFTRdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:33:07 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com.243.46.213.in-addr.arpa ([213.46.243.17]:53347 "EHLO amsfep12-int.chello.nl")
	by vger.kernel.org with ESMTP id S265887AbUFTR1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:27:03 -0400
Date: Sun, 20 Jun 2004 19:27:04 +0200
Message-Id: <200406201727.i5KHR4Su001549@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 456] M68k sparse
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Make sparse work

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/arch/m68k/Makefile	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.7/arch/m68k/Makefile	2004-06-20 10:49:05.000000000 +0200
@@ -28,6 +28,8 @@ ifdef CONFIG_SUN3
 LDFLAGS_vmlinux = -N
 endif
 
+CHECK := $(CHECK) -D__mc68000__=1 -I$(shell $(CC) -print-file-name=include)
+
 # without -fno-strength-reduce the 53c7xx.c driver fails ;-(
 CFLAGS += -pipe -fno-strength-reduce -ffixed-a2
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
