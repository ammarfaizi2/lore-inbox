Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbTC0WkE>; Thu, 27 Mar 2003 17:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbTC0WkE>; Thu, 27 Mar 2003 17:40:04 -0500
Received: from hera.cwi.nl ([192.16.191.8]:49656 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261449AbTC0WkD>;
	Thu, 27 Mar 2003 17:40:03 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 27 Mar 2003 23:51:14 +0100 (MET)
Message-Id: <UTC200303272251.h2RMpEr03699.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] make redirect static
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Mar 25 04:54:31 2003
+++ b/drivers/char/tty_io.c	Thu Mar 27 23:05:09 2003
@@ -136,7 +136,7 @@
  * redirect is the pseudo-tty that console output
  * is redirected to if asked by TIOCCONS.
  */
-struct tty_struct * redirect;
+static struct tty_struct *redirect;
 
 static void initialize_tty_struct(struct tty_struct *tty);
 
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h	Tue Mar 18 11:48:23 2003
+++ b/include/linux/tty.h	Thu Mar 27 23:14:31 2003
@@ -342,7 +342,6 @@
 extern void tty_write_flush(struct tty_struct *);
 
 extern struct termios tty_std_termios;
-extern struct tty_struct * redirect;
 extern struct tty_ldisc ldiscs[];
 extern int fg_console, last_console, want_console;
 
