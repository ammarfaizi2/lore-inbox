Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272531AbTGZOlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272525AbTGZOkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:40:01 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:39249 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S272526AbTGZOcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:50 -0400
Date: Sat, 26 Jul 2003 16:51:57 +0200
Message-Id: <200307261451.h6QEpvTQ002454@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Kill erroneous `inline' (found by gcc 3.2)

--- linux-2.6.x/include/asm-m68k/motorola_pgtable.h	Thu Mar 27 10:58:42 2003
+++ linux-m68k-2.6.x/include/asm-m68k/motorola_pgtable.h	Fri Jul 11 16:03:17 2003
@@ -264,7 +264,7 @@
 	return pte.pte >> 4;
 }
 
-static inline pte_t pgoff_to_pte(inline unsigned off)
+static inline pte_t pgoff_to_pte(unsigned off)
 {
 	pte_t pte = { (off << 4) + _PAGE_FILE };
 	return pte;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
