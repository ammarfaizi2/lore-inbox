Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263944AbTCVWjH>; Sat, 22 Mar 2003 17:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263942AbTCVWjH>; Sat, 22 Mar 2003 17:39:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10117
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263940AbTCVWjG>; Sat, 22 Mar 2003 17:39:06 -0500
Date: Sat, 22 Mar 2003 23:54:47 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222354.h2MNslNC020691@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: eisa reports "0 device" not "0 devices"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since it gets 1 device right it wasnt hard to fix 8)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/eisa/eisa-bus.c linux-2.5.65-ac3/drivers/eisa/eisa-bus.c
--- linux-2.5.65-bk3/drivers/eisa/eisa-bus.c	2003-03-22 19:33:35.000000000 +0000
+++ linux-2.5.65-ac3/drivers/eisa/eisa-bus.c	2003-03-22 17:33:05.000000000 +0000
@@ -191,7 +191,7 @@
 			eisa_register_device (root, str, i);
                 }
         }
-        printk (KERN_INFO "EISA: Detected %d card%s.\n", c, c < 2 ? "" : "s");
+        printk (KERN_INFO "EISA: Detected %d card%s.\n", c, c == 1 ? "" : "s");
 
 	return 0;
 }
