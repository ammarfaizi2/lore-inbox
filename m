Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263978AbTCUW0u>; Fri, 21 Mar 2003 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263682AbTCUSLT>; Fri, 21 Mar 2003 13:11:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37507
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263674AbTCUSJ2>; Fri, 21 Mar 2003 13:09:28 -0500
Date: Fri, 21 Mar 2003 19:24:37 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211924.h2LJObKX025741@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: newer boards put other hw at rtc + 0x08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rtc.c linux-2.5.65-ac2/drivers/char/rtc.c
--- linux-2.5.65/drivers/char/rtc.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rtc.c	2003-03-18 16:58:24.000000000 +0000
@@ -47,7 +47,7 @@
 
 #define RTC_VERSION		"1.11"
 
-#define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/
+#define RTC_IO_EXTENT	0x8
 
 /*
  *	Note that *all* calls to CMOS_READ and CMOS_WRITE are done with
