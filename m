Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbTI1NJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbTI1NI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:08:28 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:52260 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262576AbTI1NG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:28 -0400
Date: Sun, 28 Sep 2003 14:55:42 +0200
Message-Id: <200309281255.h8SCtgsb005684@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 336] Generic serial warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generic serial: jiffies are unsigned long

--- linux-2.6.0-test6/drivers/char/generic_serial.c	Tue Sep  9 10:12:33 2003
+++ linux-m68k-2.6.0-test6/drivers/char/generic_serial.c	Sun Sep 28 14:27:37 2003
@@ -348,7 +348,7 @@
 static int gs_wait_tx_flushed (void * ptr, int timeout) 
 {
 	struct gs_port *port = ptr;
-	long end_jiffies;
+	unsigned long end_jiffies;
 	int jiffies_to_transmit, charsleft = 0, rv = 0;
 	int rcib;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
