Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUBXVOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbUBXVOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:14:22 -0500
Received: from intra.cyclades.com ([64.186.161.6]:54432 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262431AbUBXVOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:14:19 -0500
Date: Tue, 24 Feb 2004 19:08:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: akpm@osdl.org
Cc: Russell King <rmk+pcmcia@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Message-ID: <Pine.LNX.4.58L.0402241906590.19727@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Subject: Remove unused tty CALLOUT defines
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

The callout code has been removed long ago from 2.6.

I believe it is safe to remove some of its unused defines.

Please apply it if rmk is ok with it.

diff -Naur -p -X /home/marcelo/lib/dontdiff linux-2.6.3.orig/drivers/char/rocket_int.h linux-2.6.3/drivers/char/rocket_int.h
--- linux-2.6.3.orig/drivers/char/rocket_int.h	2004-02-24 20:51:48.000000000 +0000
+++ linux-2.6.3/drivers/char/rocket_int.h	2004-02-24 21:29:33.000000000 +0000
@@ -1231,11 +1231,9 @@ struct r_port {
 #define ROCKET_INITIALIZED	0x80000000	/* Port is active */
 #define ROCKET_CLOSING		0x40000000	/* Serial port is closing */
 #define ROCKET_NORMAL_ACTIVE	0x20000000	/* Normal port is active */
-#define ROCKET_CALLOUT_ACTIVE	0x10000000	/* Callout port is active */

 /* tty subtypes */
 #define SERIAL_TYPE_NORMAL 1
-#define SERIAL_TYPE_CALLOUT 2

 /*
  * Assigned major numbers for the Comtrol Rocketport
diff -Naur -p -X /home/marcelo/lib/dontdiff linux-2.6.3.orig/include/linux/isdn.h linux-2.6.3/include/linux/isdn.h
--- linux-2.6.3.orig/include/linux/isdn.h	2004-02-24 20:52:14.000000000 +0000
+++ linux-2.6.3/include/linux/isdn.h	2004-02-24 21:32:19.000000000 +0000
@@ -238,7 +238,6 @@ typedef struct {

 #define ISDN_ASYNC_MAGIC          0x49344C01 /* for paranoia-checking        */
 #define ISDN_ASYNC_INITIALIZED	  0x80000000 /* port was initialized         */
-#define ISDN_ASYNC_CALLOUT_ACTIVE 0x40000000 /* Call out device active       */
 #define ISDN_ASYNC_NORMAL_ACTIVE  0x20000000 /* Normal device active         */
 #define ISDN_ASYNC_CLOSING	  0x08000000 /* Serial port is closing       */
 #define ISDN_ASYNC_CTS_FLOW	  0x04000000 /* Do CTS flow control          */
diff -Naur -p -X /home/marcelo/lib/dontdiff linux-2.6.3.orig/include/linux/isicom.h linux-2.6.3/include/linux/isicom.h
--- linux-2.6.3.orig/include/linux/isicom.h	2004-02-24 20:52:13.000000000 +0000
+++ linux-2.6.3/include/linux/isicom.h	2004-02-24 21:28:46.000000000 +0000
@@ -73,7 +73,6 @@ typedef	struct	{
 #define		PORT_COUNT	(BOARD_COUNT*16)

 #define		SERIAL_TYPE_NORMAL	1
-#define		SERIAL_TYPE_CALLOUT	2

 /*   character sizes  */

diff -Naur -p -X /home/marcelo/lib/dontdiff linux-2.6.3.orig/include/linux/serial.h linux-2.6.3/include/linux/serial.h
--- linux-2.6.3.orig/include/linux/serial.h	2004-02-24 20:52:13.000000000 +0000
+++ linux-2.6.3/include/linux/serial.h	2004-02-24 21:32:05.000000000 +0000
@@ -131,7 +131,6 @@ struct serial_uart_config {

 /* Internal flags used only by kernel/chr_drv/serial.c */
 #define ASYNC_INITIALIZED	0x80000000 /* Serial port was initialized */
-#define ASYNC_CALLOUT_ACTIVE	0x40000000 /* Call out device is active */
 #define ASYNC_NORMAL_ACTIVE	0x20000000 /* Normal device is active */
 #define ASYNC_BOOT_AUTOCONF	0x10000000 /* Autoconfigure port on bootup */
 #define ASYNC_CLOSING		0x08000000 /* Serial port is closing */
diff -Naur -p -X /home/marcelo/lib/dontdiff linux-2.6.3.orig/include/linux/tty_driver.h linux-2.6.3/include/linux/tty_driver.h
--- linux-2.6.3.orig/include/linux/tty_driver.h	2004-02-24 20:52:13.000000000 +0000
+++ linux-2.6.3/include/linux/tty_driver.h	2004-02-24 21:29:05.000000000 +0000
@@ -270,6 +270,5 @@ void tty_set_operations(struct tty_drive

 /* serial subtype definitions */
 #define SERIAL_TYPE_NORMAL	1
-#define SERIAL_TYPE_CALLOUT	2

 #endif /* #ifdef _LINUX_TTY_DRIVER_H */
