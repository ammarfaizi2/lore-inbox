Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268843AbTGRPCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271804AbTGROyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:54:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35461
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271589AbTGROPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:15:14 -0400
Date: Fri, 18 Jul 2003 15:29:35 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181429.h6IETZSQ017856@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: illegal->invalid for dmasound
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/sound/oss/dmasound/dmasound_core.c linux-2.6.0-test1-ac2/sound/oss/dmasound/dmasound_core.c
--- linux-2.6.0-test1/sound/oss/dmasound/dmasound_core.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/sound/oss/dmasound/dmasound_core.c	2003-07-15 18:01:30.000000000 +0100
@@ -1660,13 +1660,13 @@
 #ifdef HAS_RECORD
         case 5:
                 if ((ints[5] < 0) || (ints[5] > MAX_CATCH_RADIUS))
-                        printk("dmasound_setup: illegal catch radius, using default = %d\n", catchRadius);
+                        printk("dmasound_setup: invalid catch radius, using default = %d\n", catchRadius);
                 else
                         catchRadius = ints[5];
                 /* fall through */
         case 4:
                 if (ints[4] < MIN_BUFFERS)
-                        printk("dmasound_setup: illegal number of read buffers, using default = %d\n",
+                        printk("dmasound_setup: invalid number of read buffers, using default = %d\n",
                                  numReadBufs);
                 else
                         numReadBufs = ints[4];
@@ -1675,21 +1675,21 @@
 		if ((size = ints[3]) < 256)  /* check for small buffer specs */
 			size <<= 10 ;
                 if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
-                        printk("dmasound_setup: illegal read buffer size, using default = %d\n", readBufSize);
+                        printk("dmasound_setup: invalid read buffer size, using default = %d\n", readBufSize);
                 else
                         readBufSize = size;
                 /* fall through */
 #else
 	case 3:
 		if ((ints[3] < 0) || (ints[3] > MAX_CATCH_RADIUS))
-			printk("dmasound_setup: illegal catch radius, using default = %d\n", catchRadius);
+			printk("dmasound_setup: invalid catch radius, using default = %d\n", catchRadius);
 		else
 			catchRadius = ints[3];
 		/* fall through */
 #endif
 	case 2:
 		if (ints[1] < MIN_BUFFERS)
-			printk("dmasound_setup: illegal number of buffers, using default = %d\n", numWriteBufs);
+			printk("dmasound_setup: invalid number of buffers, using default = %d\n", numWriteBufs);
 		else
 			numWriteBufs = ints[1];
 		/* fall through */
@@ -1697,13 +1697,13 @@
 		if ((size = ints[2]) < 256) /* check for small buffer specs */
 			size <<= 10 ;
                 if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
-                        printk("dmasound_setup: illegal write buffer size, using default = %d\n", writeBufSize);
+                        printk("dmasound_setup: invalid write buffer size, using default = %d\n", writeBufSize);
                 else
                         writeBufSize = size;
 	case 0:
 		break;
 	default:
-		printk("dmasound_setup: illegal number of arguments\n");
+		printk("dmasound_setup: invalid number of arguments\n");
 		return 0;
 	}
 	return 1;
