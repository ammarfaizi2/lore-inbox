Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272616AbTG1BCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272566AbTG1AEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272722AbTG0W6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:17 -0400
Date: Sun, 27 Jul 2003 21:13:54 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272013.h6RKDrgg029697@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: phonedev handles this
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/telephony/ixj.c linux-2.6.0-test2-ac1/drivers/telephony/ixj.c
--- linux-2.6.0-test2/drivers/telephony/ixj.c	2003-07-27 19:56:28.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/telephony/ixj.c	2003-07-27 20:29:47.000000000 +0100
@@ -2250,8 +2250,6 @@
 	j->flags.cidplay = 0;
 	j->flags.cidcw_ack = 0;
 
-	MOD_INC_USE_COUNT;
-
 	if (ixjdebug & 0x0002)
 		printk(KERN_INFO "Opening board %d\n", p->board);
 
@@ -2463,7 +2461,6 @@
 
 	file_p->private_data = NULL;
 	clear_bit(board, &j->busyflags);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
