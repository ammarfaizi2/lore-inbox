Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263703AbTCUSQA>; Fri, 21 Mar 2003 13:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263700AbTCUSPN>; Fri, 21 Mar 2003 13:15:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45187
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263693AbTCUSNw>; Fri, 21 Mar 2003 13:13:52 -0500
Date: Fri, 21 Mar 2003 19:29:07 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211929.h2LJT7tL025801@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove old style probe from other legacy ide
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/legacy/pdc4030.c linux-2.5.65-ac2/drivers/ide/legacy/pdc4030.c
--- linux-2.5.65/drivers/ide/legacy/pdc4030.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/legacy/pdc4030.c	2003-03-20 18:23:19.000000000 +0000
@@ -256,12 +256,11 @@
 		if (!ident.current_tm[i+2].cyl)
 			hwif2->drives[i].noprobe = 1;
 	}
-#ifndef HWIF_PROBE_CLASSIC_METHOD
+
 	probe_hwif_init(&ide_hwifs[hwif->index]);
 	probe_hwif_init(&ide_hwifs[hwif2->index]);
-#endif /* HWIF_PROBE_CLASSIC_METHOD */
 
-        return 1;
+	return 1;
 }
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/legacy/qd65xx.c linux-2.5.65-ac2/drivers/ide/legacy/qd65xx.c
--- linux-2.5.65/drivers/ide/legacy/qd65xx.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/legacy/qd65xx.c	2003-03-20 18:23:19.000000000 +0000
@@ -359,9 +359,7 @@
 	hwif->drives[0].io_32bit =
 	hwif->drives[1].io_32bit = 1;
 	hwif->tuneproc = tuneproc;
-#ifndef HWIF_PROBE_CLASSIC_METHOD
 	probe_hwif_init(hwif);
-#endif /* HWIF_PROBE_CLASSIC_METHOD */
 }
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/legacy/umc8672.c linux-2.5.65-ac2/drivers/ide/legacy/umc8672.c
--- linux-2.5.65/drivers/ide/legacy/umc8672.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/legacy/umc8672.c	2003-03-20 18:23:19.000000000 +0000
@@ -162,10 +162,8 @@
 	ide_hwifs[1].mate = &ide_hwifs[0];
 	ide_hwifs[1].channel = 1;
 
-#ifndef HWIF_PROBE_CLASSIC_METHOD
 	probe_hwif_init(&ide_hwifs[0]);
 	probe_hwif_init(&ide_hwifs[1]);
-#endif /* HWIF_PROBE_CLASSIC_METHOD */
 
 	return 0;
 }
