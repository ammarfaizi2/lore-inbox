Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270997AbTG1AAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270993AbTG1AAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:16 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272958AbTG0XCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:25 -0400
Date: Sun, 27 Jul 2003 21:02:58 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272002.h6RK2wpp029598@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: more typo fixes and dead old code removal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Adrian Bunk, Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/pcxx.c linux-2.6.0-test2-ac1/drivers/char/pcxx.c
--- linux-2.6.0-test2/drivers/char/pcxx.c	2003-07-27 19:56:23.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/pcxx.c	2003-07-27 20:07:29.000000000 +0100
@@ -110,7 +110,6 @@
 static int altpin[]       = {0, 0, 0, 0};
 static int numports[]     = {0, 0, 0, 0};
 
-# if (LINUX_VERSION_CODE > 0x020111)
 MODULE_AUTHOR("Bernhard Kaindl");
 MODULE_DESCRIPTION("Digiboard PC/X{i,e,eve} driver");
 MODULE_LICENSE("GPL");
@@ -121,7 +120,6 @@
 MODULE_PARM(memsize,     "1-4i");
 MODULE_PARM(altpin,      "1-4i");
 MODULE_PARM(numports,    "1-4i");
-# endif
 
 #endif MODULE
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/rio/riotable.c linux-2.6.0-test2-ac1/drivers/char/rio/riotable.c
--- linux-2.6.0-test2/drivers/char/rio/riotable.c	2003-07-10 21:14:51.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/rio/riotable.c	2003-07-15 18:01:29.000000000 +0100
@@ -208,7 +208,7 @@
 				return -ENXIO;
 			}
 			if ( MapP->ID > MAX_RUP ) {
-				rio_dprintk (RIO_DEBUG_TABLE, "RIO: RTA %s has been allocated an illegal ID %d\n",
+				rio_dprintk (RIO_DEBUG_TABLE, "RIO: RTA %s has been allocated an invalid ID %d\n",
 							MapP->Name, MapP->ID);
 				p->RIOError.Error = ID_NUMBER_OUT_OF_RANGE;
 				p->RIOError.Entry = Entry;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/synclink.c linux-2.6.0-test2-ac1/drivers/char/synclink.c
--- linux-2.6.0-test2/drivers/char/synclink.c	2003-07-10 21:08:07.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/synclink.c	2003-07-15 18:01:29.000000000 +0100
@@ -3487,7 +3487,7 @@
 	/* verify range of specified line number */	
 	line = tty->index;
 	if ((line < 0) || (line >= mgsl_device_count)) {
-		printk("%s(%d):mgsl_open with illegal line #%d.\n",
+		printk("%s(%d):mgsl_open with invalid line #%d.\n",
 			__FILE__,__LINE__,line);
 		return -ENODEV;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/synclinkmp.c linux-2.6.0-test2-ac1/drivers/char/synclinkmp.c
--- linux-2.6.0-test2/drivers/char/synclinkmp.c	2003-07-10 21:06:01.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/synclinkmp.c	2003-07-15 18:01:29.000000000 +0100
@@ -729,7 +729,7 @@
 
 	line = tty->index;
 	if ((line < 0) || (line >= synclinkmp_device_count)) {
-		printk("%s(%d): open with illegal line #%d.\n",
+		printk("%s(%d): open with invalid line #%d.\n",
 			__FILE__,__LINE__,line);
 		return -ENODEV;
 	}
