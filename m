Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTDGXuz (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263892AbTDGX3T (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:29:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11393
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263898AbTDGXRQ (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:17:16 -0400
Date: Tue, 8 Apr 2003 01:36:11 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080036.h380aBFH009252@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: jiffies is UL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/time.h linux-2.5.67-ac1/include/linux/time.h
--- linux-2.5.67/include/linux/time.h	2003-03-06 17:04:37.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/time.h	2003-03-07 14:57:13.000000000 +0000
@@ -31,7 +31,7 @@
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
  */
-#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
+#define INITIAL_JIFFIES ((unsigned long) (-300*HZ))
 
 /*
  * Change timeval to jiffies, trying to avoid the
