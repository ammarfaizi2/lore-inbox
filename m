Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274534AbRIVJWj>; Sat, 22 Sep 2001 05:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274543AbRIVJW3>; Sat, 22 Sep 2001 05:22:29 -0400
Received: from line167.adsl.actcom.co.il ([192.117.101.167]:8714 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S274534AbRIVJWT>; Sat, 22 Sep 2001 05:22:19 -0400
Date: Sat, 22 Sep 2001 12:19:57 +0300 (IDT)
From: mulix <mulix@actcom.co.il>
X-X-Sender: <mulix@alhambra.merseine.nu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.10pre14 unresolved symbol 'tty_register_ldisc'
Message-ID: <Pine.LNX.4.33.0109221216210.17933-100000@alhambra.merseine.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch by Mohammad A. Haque at
http://uwsg.iu.edu/hypermail/linux/kernel/0109.2/0777.html
fixes it for me.

(patch reproduced here for convenience)

--- linux/drivers/char/tty_io.c.orig Wed Sep 19 15:59:09 2001
+++ linux/drivers/char/tty_io.c Wed Sep 19 15:59:20 2001
@@ -270,6 +270,8 @@
         return 0;
 }

+EXPORT_SYMBOL(tty_register_ldisc);
+
 /* Set the discipline of a tty line. */
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 {

-- 
mulix

http://www.advogato.com/person/mulix
http://www.sf.net/projects/syscalltrack




