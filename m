Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbTCUVpL>; Fri, 21 Mar 2003 16:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263704AbTCUSaR>; Fri, 21 Mar 2003 13:30:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63107
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263691AbTCUSaH>; Fri, 21 Mar 2003 13:30:07 -0500
Date: Fri, 21 Mar 2003 19:45:20 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211945.h2LJjKaW025947@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix buffer overrun in aha1542
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/scsi/aha1542.c linux-2.5.65-ac2/drivers/scsi/aha1542.c
--- linux-2.5.65/drivers/scsi/aha1542.c	2003-03-06 17:04:28.000000000 +0000
+++ linux-2.5.65-ac2/drivers/scsi/aha1542.c	2003-03-06 22:15:12.000000000 +0000
@@ -1020,7 +1020,7 @@
 
 static int __init do_setup(char *str)
 {
-	int ints[4];
+	int ints[5];
 
 	int count=setup_idx;
 
