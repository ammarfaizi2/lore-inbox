Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTH2OzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTH2OxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:53:09 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:24853 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261307AbTH2OwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:01 -0400
Date: Fri, 29 Aug 2003 16:51:08 +0200
Message-Id: <200308291451.h7TEp8Fl005908@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Dmasound invalid vs. illegal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmasound: Use `invalid' instead of `illegal' (from 2.5.x)

--- linux-2.4.23-pre1/drivers/sound/dmasound/dmasound_core.c	Thu Mar 27 18:26:33 2003
+++ linux-m68k-2.4.23-pre1/drivers/sound/dmasound/dmasound_core.c	Mon Jul 21 21:05:54 2003
@@ -1660,13 +1660,13 @@
 #ifdef HAS_RECORD
         case 5:
                 if ((ints[5] < 0) || (ints[5] > MAX_CATCH_RADIUS))
-                        printk("dmasound_setup: illegal catch radius, using default = %d\n", catchRadius);
+                        printk("dmasound_setup: invalid catch radius, using default = %d\n", catchRadius);
                 else
                         catchRadius = ints[5];
                 /* fall through */
         case 4:
                 if (ints[4] < MIN_BUFFERS)
-                        printk("dmasound_setup: illegal number of read buffers, using default = %d\n",
+                        printk("dmasound_setup: invalid number of read buffers, using default = %d\n",
                                  numReadBufs);
                 else
                         numReadBufs = ints[4];
@@ -1675,21 +1675,21 @@
 		if ((size = ints[3]) < 256)  /* check for small buffer specs */
 			size <<= 10 ;
                 if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
-                        printk("dmasound_setup: illegal read buffer size, using default = %d\n", readBufSize);
+                        printk("dmasound_setup: invalid read buffer size, using default = %d\n", readBufSize);
                 else
                         readBufSize = size;
                 /* fall through */
 #else
 	case 3:
 		if ((ints[3] < 0) || (ints[3] > MAX_CATCH_RADIUS))
-			printk("dmasound_setup: illegal catch radius, using default = %d\n", catchRadius);
+			printk("dmasound_setup: invalid catch radius, using default = %d\n", catchRadius);
 		else
 			catchRadius = ints[3];
 		/* fall through */
 #endif
 	case 2:
 		if (ints[1] < MIN_BUFFERS)
-			printk("dmasound_setup: illegal number of buffers, using default = %d\n", numWriteBufs);
+			printk("dmasound_setup: invalid number of buffers, using default = %d\n", numWriteBufs);
 		else
 			numWriteBufs = ints[1];
 		/* fall through */
@@ -1697,13 +1697,13 @@
 		if ((size = ints[2]) < 256) /* check for small buffer specs */
 			size <<= 10 ;
                 if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
-                        printk("dmasound_setup: illegal write buffer size, using default = %d\n", writeBufSize);
+                        printk("dmasound_setup: invalid write buffer size, using default = %d\n", writeBufSize);
                 else
                         writeBufSize = size;
 	case 0:
 		break;
 	default:
-		printk("dmasound_setup: illegal number of arguments\n");
+		printk("dmasound_setup: invalid number of arguments\n");
 		return 0;
 	}
 	return 1;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
