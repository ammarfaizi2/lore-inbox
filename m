Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263792AbTCUSrq>; Fri, 21 Mar 2003 13:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263783AbTCUSqx>; Fri, 21 Mar 2003 13:46:53 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20356
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263778AbTCUSpV>; Fri, 21 Mar 2003 13:45:21 -0500
Date: Fri, 21 Mar 2003 20:00:36 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212000.h2LK0aS9026176@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: kill off IDE_DEBUG, add pc9800 ide type
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/linux/ide.h linux-2.5.65-ac2/include/linux/ide.h
--- linux-2.5.65/include/linux/ide.h	2003-03-03 19:20:16.000000000 +0000
+++ linux-2.5.65-ac2/include/linux/ide.h	2003-03-20 18:23:19.000000000 +0000
@@ -280,9 +280,6 @@
 	return ((hwif)->chipset == chipset) ? 1 : 0;		\
 }
 
-#define IDE_DEBUG(lineno) \
-	printk("%s,%s,line=%d\n", __FILE__, __FUNCTION__, (lineno))
-
 /*
  * Check for an interrupt and acknowledge the interrupt status
  */
@@ -302,7 +299,8 @@
 		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
 		ide_pdc4030,	ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
-		ide_pmac,	ide_etrax100,	ide_acorn
+		ide_pmac,	ide_etrax100,	ide_acorn,
+		ide_pc9800
 } hwif_chipset_t;
 
 /*
