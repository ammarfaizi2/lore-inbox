Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272654AbTG1CTC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271032AbTG1ABG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272869AbTG0XCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:10 -0400
Date: Sun, 27 Jul 2003 21:02:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272002.h6RK2Q7v029592@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: more typo/invalid bits
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/n_r3964.c linux-2.6.0-test2-ac1/drivers/char/n_r3964.c
--- linux-2.6.0-test2/drivers/char/n_r3964.c	2003-07-10 21:14:51.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/n_r3964.c	2003-07-15 18:01:29.000000000 +0100
@@ -669,7 +669,7 @@
          }
          else
          {
-            TRACE_PE("TRANSMITTING - got illegal char");
+            TRACE_PE("TRANSMITTING - got invalid char");
  
             pInfo->state = R3964_WAIT_ZVZ_BEFORE_TX_RETRY;
 	    mod_timer(&pInfo->tmr, jiffies + R3964_TO_ZVZ);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/char/pcmcia/synclink_cs.c linux-2.6.0-test2-ac1/drivers/char/pcmcia/synclink_cs.c
--- linux-2.6.0-test2/drivers/char/pcmcia/synclink_cs.c	2003-07-10 21:07:39.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/char/pcmcia/synclink_cs.c	2003-07-15 18:01:29.000000000 +0100
@@ -2814,7 +2814,7 @@
 	/* verify range of specified line number */	
 	line = tty->index;
 	if ((line < 0) || (line >= mgslpc_device_count)) {
-		printk("%s(%d):mgslpc_open with illegal line #%d.\n",
+		printk("%s(%d):mgslpc_open with invalid line #%d.\n",
 			__FILE__,__LINE__,line);
 		return -ENODEV;
 	}
