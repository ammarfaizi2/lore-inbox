Return-Path: <linux-kernel-owner+w=401wt.eu-S936642AbWLIJuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936642AbWLIJuS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936649AbWLIJuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:50:18 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:57856 "EHLO
	astra.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936642AbWLIJuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:50:16 -0500
Date: Sat, 9 Dec 2006 10:50:15 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: EXPORT_SYMBOL(cache_{clear,push}) bogus comment
Message-ID: <Pine.LNX.4.64.0612091049360.17694@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bogus comments about unexporting cache_{push,clear}(), as inline
dma_cache_maintenance() (used by at least bionet and pamsnet) calls them.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 arch/m68k/mm/memory.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-m68k-2.6.19.orig/arch/m68k/mm/memory.c
+++ linux-m68k-2.6.19/arch/m68k/mm/memory.c
@@ -238,7 +238,7 @@ void cache_clear (unsigned long paddr, i
 	mach_l2_flush(0);
 #endif
 }
-EXPORT_SYMBOL(cache_clear);	/* probably can be unexported */
+EXPORT_SYMBOL(cache_clear);
 
 
 /*
@@ -291,5 +291,5 @@ void cache_push (unsigned long paddr, in
 	mach_l2_flush(1);
 #endif
 }
-EXPORT_SYMBOL(cache_push);	/* probably can be unexported */
+EXPORT_SYMBOL(cache_push);
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
