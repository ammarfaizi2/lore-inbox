Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272529AbTGZOlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272523AbTGZOjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:39:55 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:1366 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272524AbTGZOct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:49 -0400
Date: Sat, 26 Jul 2003 16:51:49 +0200
Message-Id: <200307261451.h6QEpnuX002370@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Amiga serial warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga serial: Kill unused variable warning

--- linux-2.6.x/drivers/char/amiserial.c	Sun Jun 15 09:38:15 2003
+++ linux-m68k-2.6.x/drivers/char/amiserial.c	Sun Jun 15 11:41:30 2003
@@ -2145,14 +2145,14 @@
 
 static __exit void rs_exit(void) 
 {
-	int e1, e2;
+	int error;
 	struct async_struct *info = rs_table[0].info;
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
 	tasklet_kill(&info->tlet);
-	if ((e1 = tty_unregister_driver(serial_driver)))
+	if ((error = tty_unregister_driver(serial_driver)))
 		printk("SERIAL: failed to unregister serial driver (%d)\n",
-		       e1);
+		       error);
 	put_tty_driver(serial_driver);
 
 	if (info) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
