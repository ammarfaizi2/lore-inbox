Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTI2Ilc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTI2Ijn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:39:43 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:35918 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262898AbTI2Ihx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:37:53 -0400
Date: Mon, 29 Sep 2003 10:39:10 +0200
Message-Id: <200309290839.h8T8dAvn003694@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 329] Amiga Zorro bus doc updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Zorro bus: Update the docs to match the current situation.

--- linux-2.6.0-test6/Documentation/zorro.txt	21 Oct 2001 23:54:30 -0000	1.1.1.1
+++ linux-m68k-2.6.0-test6/Documentation/zorro.txt	23 Sep 2003 13:03:44 -0000
@@ -2,7 +2,7 @@
 		----------------------------------------
 
 Written by Geert Uytterhoeven <geert@linux-m68k.org>
-Last revised: February 27, 2000
+Last revised: September 5, 2003
 
 
 1. Introduction
@@ -77,7 +77,7 @@
 The treatment of these regions depends on the type of Zorro space:
 
   - Zorro II address space is always mapped and does not have to be mapped
-    explicitly using ioremap().
+    explicitly using z_ioremap().
     
     Conversion from bus/physical Zorro II addresses to kernel virtual addresses
     and vice versa is done using:
@@ -85,22 +85,20 @@
 	virt_addr = ZTWO_VADDR(bus_addr);
 	bus_addr = ZTWO_PADDR(virt_addr);
 
-  - Zorro III address space must be mapped explicitly using ioremap() first
+  - Zorro III address space must be mapped explicitly using z_ioremap() first
     before it can be accessed:
  
-	virt_addr = ioremap(bus_addr, size);
+	virt_addr = z_ioremap(bus_addr, size);
 	...
-	iounmap(virt_addr);
+	z_iounmap(virt_addr);
 
 
 5. References
 -------------
 
 linux/include/linux/zorro.h
-linux/include/linux/ioport.h
-linux/include/asm-m68k/io.h
-linux/include/asm-m68k/amigahw.h
-linux/include/asm-ppc/io.h
+linux/include/asm-{m68k,ppc}/zorro.h
+linux/include/linux/zorro_ids.h
 linux/drivers/zorro
 /proc/bus/zorro
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
