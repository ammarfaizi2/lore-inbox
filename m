Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbUJXLKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUJXLKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUJXLKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:10:41 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:55616 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261441AbUJXLKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:10:01 -0400
Date: Sun, 24 Oct 2004 13:09:54 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cyclades assignment warning
Message-ID: <Pine.LNX.4.61.0410241308380.27036@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cyclades: Remove unneeded cast that causes a warning (cy_isa_addresses is an
array of unsigned ints).

--- linux-2.6.10-rc1/drivers/char/cyclades.c.orig	2004-10-23 10:33:00.000000000 +0200
+++ linux-2.6.10-rc1/drivers/char/cyclades.c	2004-10-24 12:47:52.000000000 +0200
@@ -5551,7 +5551,7 @@ cy_setup(char *str, int *ints)
     }
     for (j = 1; j <= ints[0]; j++){
         if ( i < NR_ISA_ADDRS ){
-            cy_isa_addresses[i++] = (unsigned char *)(ints[j]);
+            cy_isa_addresses[i++] = ints[j];
         }
     }
 #endif /* CONFIG_ISA */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
