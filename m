Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263789AbTCUStB>; Fri, 21 Mar 2003 13:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263790AbTCUSsG>; Fri, 21 Mar 2003 13:48:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22660
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263789AbTCUSrM>; Fri, 21 Mar 2003 13:47:12 -0500
Date: Fri, 21 Mar 2003 20:02:27 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212002.h2LK2QtZ026205@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: time is ulong
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/linux/time.h linux-2.5.65-ac2/include/linux/time.h
--- linux-2.5.65/include/linux/time.h	2003-03-06 17:04:37.000000000 +0000
+++ linux-2.5.65-ac2/include/linux/time.h	2003-03-07 14:57:13.000000000 +0000
@@ -31,7 +31,7 @@
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
  */
-#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
+#define INITIAL_JIFFIES ((unsigned long) (-300*HZ))
 
 /*
  * Change timeval to jiffies, trying to avoid the
