Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbTC0RBD>; Thu, 27 Mar 2003 12:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbTC0RBC>; Thu, 27 Mar 2003 12:01:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50821
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262876AbTC0RA1>; Thu, 27 Mar 2003 12:00:27 -0500
Date: Thu, 27 Mar 2003 18:17:56 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271817.h2RIHuH6019658@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik

The ide fixes for the VIA8235 obsolete this hack

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/drivers/ide/ide-timing.h linux-2.5.66-ac1/drivers/ide/ide-timing.h
--- linux-2.5.66-bk3/drivers/ide/ide-timing.h	2003-03-27 17:13:18.000000000 +0000
+++ linux-2.5.66-ac1/drivers/ide/ide-timing.h	2003-03-07 17:35:09.000000000 +0000
@@ -245,14 +245,6 @@
 	}
 
 /*
- * If the drive is an ATAPI device it may need slower address setup timing,
- * so we stay on the safe side.
- */
-
-	if (drive->media != ide_disk)
-		p.setup = 120;
-
-/*
  * Convert the timing to bus clock counts.
  */
 
