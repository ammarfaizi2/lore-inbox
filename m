Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbTGJVo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbTGJVo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:44:28 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:15376 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266473AbTGJVo0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:44:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: FW: cciss updates for 2.4.22-pre3  [1 of 6]
Date: Thu, 10 Jul 2003 16:59:06 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF104052A63@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: patches
Thread-Index: AcNHKcRZhvBzmMjgS9CLFicXbaIzsgAAcBmQAAC0g5A=
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jul 2003 21:59:06.0983 (UTC) FILETIME=[7BEEEF70:01C3472E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, misspelled the name on the first go round. Sorry.

-----Original Message-----
From: Miller, Mike (OS Dev) 
Sent: Thursday, July 10, 2003 4:43 PM
To: 'axboe@suse.de'; 'marcelo@conectiva.com.br'
Cc: 'alan@lxorguk.ukuu.org.uk'; 'linuxkernel@vger.kernel.org'
Subject: cciss updates for 2.4.22-pre3 [1 of 6]


These patches can be installed in any order EXCEPT the final 2 of the 6. They are name p1* & p2* respectively.

This patch was built & tested using kernel 2.4.21 with the 2.4.22pre3 patch
applied. It is intended for inclusion in the 2.4.22 kernel.
Patch name: cciss_2447_6400_name_fix_for_lx2422p3.patch
Changes:
	1. Changes the marketing names (again) for the 6400 Smart Array base
	   controller and the U320 expansion module. Required by marketing.
	2. Corrects the subsystem device ID for the U320 Expansion Module.
	   Bug fix, thanks to Janos Farkas for pointing this out.
--------------------------------------------------------------------------------------------------------------------
diff -burN lx2422p3.test/Documentation/cciss.txt lx2422p3/Documentation/cciss.txt
--- lx2422p3.test/Documentation/cciss.txt	2003-07-07 11:18:18.000000000 -0500
+++ lx2422p3/Documentation/cciss.txt	2003-07-07 13:50:28.000000000 -0500
@@ -11,8 +11,8 @@
 	* SA 5312
 	* SA 641
 	* SA 642
-	* SA 6402
-	* SA 6404/256
+	* SA 6400
+	* SA 6400 U320 Expansion Module
 
 If nodes are not already created in the /dev/cciss directory
 
diff -burN lx2422p3.test/drivers/block/cciss.c lx2422p3/drivers/block/cciss.c
--- lx2422p3.test/drivers/block/cciss.c	2003-07-07 13:47:05.000000000 -0500
+++ lx2422p3/drivers/block/cciss.c	2003-07-07 13:49:34.000000000 -0500
@@ -92,8 +92,8 @@
 	{ 0x40830E11, "Smart Array 5312", &SA5B_access},
 	{ 0x409A0E11, "Smart Array 641", &SA5_access},
 	{ 0x409B0E11, "Smart Array 642", &SA5_access},
-	{ 0x409C0E11, "Smart Array 6402", &SA5_access},
-	{ 0x409C0E11, "Smart Array 6404/256", &SA5_access},
+	{ 0x409C0E11, "Smart Array 6400", &SA5_access},
+	{ 0x409D0E11, "Smart Array 6400 EM", &SA5_access},
 };
 
 /* How long to wait (in millesconds) for board to go into simple mode */


