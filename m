Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbTC0RAB>; Thu, 27 Mar 2003 12:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbTC0RAB>; Thu, 27 Mar 2003 12:00:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50053
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261944AbTC0Q77>; Thu, 27 Mar 2003 11:59:59 -0500
Date: Thu, 27 Mar 2003 18:17:27 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271817.h2RIHRcD019652@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure hdparm errors to the user when the request isnt allowed
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/drivers/ide/ide-taskfile.c linux-2.5.66-ac1/drivers/ide/ide-taskfile.c
--- linux-2.5.66-bk3/drivers/ide/ide-taskfile.c	2003-03-27 17:13:18.000000000 +0000
+++ linux-2.5.66-ac1/drivers/ide/ide-taskfile.c	2003-03-26 20:22:22.000000000 +0000
@@ -1670,7 +1670,7 @@
 
 #else
 
-	int err = 0;
+	int err = -EIO;
 	u8 args[4], *argbuf = args;
 	u8 xfer_rate = 0;
 	int argsize = 0;


(Jens Axboe)
