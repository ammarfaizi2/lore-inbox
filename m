Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269744AbTGKA5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269745AbTGKA5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:57:36 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:3534 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S269744AbTGKA5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:57:35 -0400
Date: Fri, 11 Jul 2003 03:12:14 +0200 (MEST)
Message-Id: <200307110112.h6B1CEfR006510@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH] fix x86-64 FIOQSIZE compile error in 2.4.22-pre4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.22-pre4 added a FIOQSIZE ioctl but the x86-64 ioctls.h
wasn't updated: the result is a compile error is fs/ somewhere
(sorry I forgot exactly where). Fix below.

/Mikael

--- linux-2.4.22-pre4/include/asm-x86_64/ioctls.h.~1~   2002-11-30 17:12:31.000000000 +0100
+++ linux-2.4.22-pre4/include/asm-x86_64/ioctls.h       2003-07-11 02:04:05.159562760 +0200
@@ -67,6 +67,7 @@
 #define TIOCGICOUNT    0x545D  /* read serial port inline interrupt counts */
 #define TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
+#define FIOQSIZE       0x5460
 
 /* Used for packet mode */
 #define TIOCPKT_DATA            0
