Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129263AbQJ0JzM>; Fri, 27 Oct 2000 05:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129264AbQJ0JzC>; Fri, 27 Oct 2000 05:55:02 -0400
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:3519 "EHLO
	styx.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S129263AbQJ0Jyr>; Fri, 27 Oct 2000 05:54:47 -0400
Date: Thu, 26 Oct 2000 22:54:33 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: IO-mapping.txt and ISA memory space
Message-ID: <Pine.LNX.4.10.10010262249530.440-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

We have isa_*() functions to access ISA memory space since a while.

I'm still missing isa_{request,release}_mem_region(), though.

--- linux-2.4.0-test10-pre5/Documentation/IO-mapping.txt.orig	Sat Aug  5 13:21:13 2000
+++ linux-2.4.0-test10-pre5/Documentation/IO-mapping.txt	Thu Oct 26 22:49:30 2000
@@ -141,7 +141,7 @@
 	 * read first 32 bits from ISA memory at 0xC0000, aka
 	 * C000:0000 in DOS terms
 	 */
-	unsigned int signature = readl(0xC0000);
+	unsigned int signature = isa_readl(0xC0000);
 
  - remapping and writing:
 	/*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
