Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263692AbTCUSNV>; Fri, 21 Mar 2003 13:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263690AbTCUSMZ>; Fri, 21 Mar 2003 13:12:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41347
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263687AbTCUSL6>; Fri, 21 Mar 2003 13:11:58 -0500
Date: Fri, 21 Mar 2003 19:27:12 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211927.h2LJRCJJ025771@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix ide-geometry bogus printk level
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-geometry.c linux-2.5.65-ac2/drivers/ide/ide-geometry.c
--- linux-2.5.65/drivers/ide/ide-geometry.c	2003-02-10 18:38:50.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-geometry.c	2003-03-07 17:15:21.000000000 +0000
@@ -129,7 +129,7 @@
 	set_capacity(drive->disk, current_capacity(drive));
 
 	if (ret)
-		printk(KERN_INFO "%s%s [%d/%d/%d]", msg, msg1,
+		printk("%s%s [%d/%d/%d]", msg, msg1,
 		       drive->bios_cyl, drive->bios_head, drive->bios_sect);
 	return ret;
 }
