Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272525AbTGZOlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272526AbTGZOkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:40:08 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:63003 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S272527AbTGZOcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:50 -0400
Date: Sat, 26 Jul 2003 16:51:54 +0200
Message-Id: <200307261451.h6QEpswE002418@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Kill zorro_check_device
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill zorro_check_device(), it's deprecated and unused (from Christoph Hellwig).

--- linux-2.6.x/Documentation/zorro.txt	Tue Feb  5 18:40:38 2002
+++ linux-m68k-2.6.x/Documentation/zorro.txt	Sat Jun 28 11:00:50 2003
@@ -57,13 +57,11 @@
 functions:
 
     request_mem_region()
-    check_mem_region()		(deprecated)
     release_mem_region()
 
 Shortcuts to claim the whole device's address space are provided as well:
 
     zorro_request_device
-    zorro_check_device		(deprecated)
     zorro_release_device
 
 
--- linux-2.6.x/include/linux/zorro.h	Wed Oct  2 02:08:35 2002
+++ linux-m68k-2.6.x/include/linux/zorro.h	Sat Jun 28 10:59:41 2003
@@ -182,9 +182,6 @@
 #define zorro_request_device(z, name) \
     request_mem_region((z)->resource.start, \
 		       (z)->resource.end-(z)->resource.start+1, (name))
-#define zorro_check_device(z) \
-    check_mem_region((z)->resource.start, \
-		     (z)->resource.end-(z)->resource.start+1)
 #define zorro_release_device(z) \
     release_mem_region((z)->resource.start, \
 		       (z)->resource.end-(z)->resource.start+1)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
