Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264005AbTCUWai>; Fri, 21 Mar 2003 17:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263969AbTCUW1e>; Fri, 21 Mar 2003 17:27:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42115
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263688AbTCUSMW>; Fri, 21 Mar 2003 13:12:22 -0500
Date: Fri, 21 Mar 2003 19:27:37 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211927.h2LJRbj1025777@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove legacy probe code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/legacy/ali14xx.c linux-2.5.65-ac2/drivers/ide/legacy/ali14xx.c
--- linux-2.5.65/drivers/ide/legacy/ali14xx.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/legacy/ali14xx.c	2003-03-20 18:23:19.000000000 +0000
@@ -229,10 +229,8 @@
 		return 1;
 	}
 
-#ifndef HWIF_PROBE_CLASSIC_METHOD
 	probe_hwif_init(&ide_hwifs[0]);
 	probe_hwif_init(&ide_hwifs[1]);
-#endif /* HWIF_PROBE_CLASSIC_METHOD */
 
 	return 0;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/legacy/dtc2278.c linux-2.5.65-ac2/drivers/ide/legacy/dtc2278.c
--- linux-2.5.65/drivers/ide/legacy/dtc2278.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/legacy/dtc2278.c	2003-03-20 18:23:19.000000000 +0000
@@ -138,11 +138,8 @@
 	ide_hwifs[1].mate = &ide_hwifs[0];
 	ide_hwifs[1].channel = 1;
 
-#ifndef HWIF_PROBE_CLASSIC_METHOD
 	probe_hwif_init(&ide_hwifs[0]);
 	probe_hwif_init(&ide_hwifs[1]);
-#endif /* HWIF_PROBE_CLASSIC_METHOD */
-
 }
 
 void __init dtc2278_release (void)
