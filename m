Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUDFL2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUDFL2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:28:55 -0400
Received: from witte.sonytel.be ([80.88.33.193]:10882 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263775AbUDFL2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:28:33 -0400
Date: Tue, 6 Apr 2004 13:28:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial unused vars
Message-ID: <Pine.GSO.4.58.0404061328020.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recent serial changes moved some code, causing unused variable warnings.

--- linux-2.6.5/drivers/char/isicom.c.orig	2004-03-04 11:30:38.000000000 +0100
+++ linux-2.6.5/drivers/char/isicom.c	2004-04-02 10:59:33.000000000 +0200
@@ -1312,7 +1313,6 @@
 			   unsigned int set, unsigned int clear)
 {
 	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	unsigned int arg;
 	unsigned long flags;

 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
--- linux-2.6.5/drivers/char/istallion.c.orig	2004-02-29 09:31:29.000000000 +0100
+++ linux-2.6.5/drivers/char/istallion.c	2004-03-31 13:28:53.000000000 +0200
@@ -2050,7 +2050,6 @@
 {
 	stliport_t	*portp;
 	stlibrd_t	*brdp;
-	unsigned long	lval;
 	unsigned int	ival;
 	int		rc;

--- linux-2.6.5/drivers/char/moxa.c.orig	2004-03-04 11:30:38.000000000 +0100
+++ linux-2.6.5/drivers/char/moxa.c	2004-03-31 13:36:50.000000000 +0200
@@ -778,7 +778,7 @@
 {
 	struct moxa_str *ch = (struct moxa_str *) tty->driver_data;
 	int port;
-	int flag = 0, dtr, rts;
+	int dtr, rts;

 	port = PORTNO(tty);
 	if ((port != MAX_PORTS) && (!ch))
@@ -802,8 +802,7 @@
 {
 	struct moxa_str *ch = (struct moxa_str *) tty->driver_data;
 	register int port;
-	int retval, dtr, rts;
-	unsigned long flag;
+	int retval;

 	port = PORTNO(tty);
 	if ((port != MAX_PORTS) && (!ch))
--- linux-2.6.5/drivers/char/mxser.c.orig	2004-02-29 09:31:30.000000000 +0100
+++ linux-2.6.5/drivers/char/mxser.c	2004-03-31 13:30:11.000000000 +0200
@@ -2150,7 +2150,6 @@
 {
 	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
 	unsigned char control, status;
-	unsigned int result;
 	unsigned long flags;

 	if (PORTNO(tty) == MXSER_PORTS)
@@ -2177,7 +2176,6 @@
 			  unsigned int set, unsigned int clear)
 {
 	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
-	unsigned int arg;
 	unsigned long flags;

 	if (PORTNO(tty) == MXSER_PORTS)
--- linux-2.6.5/drivers/char/specialix.c.orig	2004-02-29 09:31:31.000000000 +0100
+++ linux-2.6.5/drivers/char/specialix.c	2004-03-31 13:28:26.000000000 +0200
@@ -1696,8 +1696,6 @@
 		       unsigned int set, unsigned int clear)
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
-	int error;
-	unsigned int arg;
 	unsigned long flags;
 	struct specialix_board *bp;


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
