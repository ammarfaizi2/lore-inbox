Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbTCGFeP>; Fri, 7 Mar 2003 00:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTCGFeP>; Fri, 7 Mar 2003 00:34:15 -0500
Received: from dp.samba.org ([66.70.73.150]:5356 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261358AbTCGFeO>;
	Fri, 7 Mar 2003 00:34:14 -0500
Date: Fri, 7 Mar 2003 16:43:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>,
       Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL] Squash warnings in usb-serial.c
Message-ID: <20030307054352.GD1161@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

This squashes (gcc-3.2) "label and end of compound statement
deprecated" warnings in usb-serial.c.

diff -urN pmac-2.5-pristine/drivers/usb/serial/usb-serial.c linux-2.5-zax/drivers/usb/serial/usb-serial.c
--- pmac-2.5-pristine/drivers/usb/serial/usb-serial.c	2003-02-19 19:15:51.000000000 +1100
+++ linux-2.5-zax/drivers/usb/serial/usb-serial.c	2003-03-07 16:31:07.000000000 +1100
@@ -634,6 +634,7 @@
 		serial->type->throttle(port);
 
 exit:
+	;
 }
 
 static void serial_unthrottle (struct tty_struct * tty)
@@ -656,6 +657,7 @@
 		serial->type->unthrottle(port);
 
 exit:
+	;
 }
 
 static int serial_ioctl (struct tty_struct *tty, struct file * file, unsigned int cmd, unsigned long arg)
@@ -704,6 +706,7 @@
 		serial->type->set_termios(port, old);
 
 exit:
+	;
 }
 
 static void serial_break (struct tty_struct *tty, int break_state)
@@ -726,6 +729,7 @@
 		serial->type->break_ctl(port, break_state);
 
 exit:
+	;
 }
 
 static void serial_shutdown (struct usb_serial *serial)


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
