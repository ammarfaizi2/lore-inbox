Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbTEKKcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbTEKKYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:24:33 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:6167 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261245AbTEKKVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:40 -0400
Date: Sun, 11 May 2003 12:31:08 +0200
Message-Id: <200305111031.h4BAV8u7019748@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] times must be unsigned long
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFS and RXRPC: times must be unsigned long

--- linux-2.5.x/fs/afs/kafstimod.c	Sun Apr 20 12:28:53 2003
+++ linux-m68k-2.5.x/fs/afs/kafstimod.c	Sun Apr 20 14:45:22 2003
@@ -83,7 +83,7 @@
 
 	for (;;) {
 		unsigned long jif;
-		signed long timeout;
+		unsigned long timeout;
 
 		/* deal with the server being asked to die */
 		if (kafstimod_die) {
--- linux-2.5.x/net/rxrpc/krxtimod.c	Sun Apr 20 12:29:12 2003
+++ linux-m68k-2.5.x/net/rxrpc/krxtimod.c	Sun Apr 20 14:45:44 2003
@@ -82,7 +82,7 @@
 
 	for (;;) {
 		unsigned long jif;
-		signed long timeout;
+		unsigned long timeout;
 
 		/* deal with the server being asked to die */
 		if (krxtimod_die) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
