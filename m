Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTEODVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEODSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:23 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:65003 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263766AbTEODSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:14 -0400
Date: Thu, 15 May 2003 04:31:02 +0100
Message-Id: <200305150331.h4F3V2VH000536@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Fix types on inflate.c constants
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch from Alan went into 2.4 last august with the comment
"get the types right on the lib/inflate.c constants"

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/lib/inflate.c linux-2.5/lib/inflate.c
--- bk-linus/lib/inflate.c	2003-05-08 13:46:23.000000000 +0100
+++ linux-2.5/lib/inflate.c	2003-05-08 14:26:47.000000000 +0100
@@ -1015,7 +1015,7 @@ STATIC int inflate(void)
 
 static ulg crc_32_tab[256];
 static ulg crc;		/* initialized in makecrc() so it'll reside in bss */
-#define CRC_VALUE (crc ^ 0xffffffffL)
+#define CRC_VALUE (crc ^ 0xffffffffUL)
 
 /*
  * Code to compute the CRC-32 table. Borrowed from 
@@ -1055,7 +1055,7 @@ makecrc(void)
   }
 
   /* this is initialized here so this code could reside in ROM */
-  crc = (ulg)0xffffffffL; /* shift register contents */
+  crc = (ulg)0xffffffffUL; /* shift register contents */
 }
 
 /* gzip flag byte */
