Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbTDHAPK (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbTDHAM7 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:12:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22913
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263817AbTDGXXL (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:23:11 -0400
Date: Tue, 8 Apr 2003 01:42:06 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080042.h380g6ku009342@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix ; in mad16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/mad16.c linux-2.5.67-ac1/sound/oss/mad16.c
--- linux-2.5.67/sound/oss/mad16.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/mad16.c	2003-04-03 23:45:12.000000000 +0100
@@ -537,7 +537,7 @@
 
 	for (i = 0xf8d; i <= 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x = %02x\n", i, mad_read(i)))
+			DDB(printk("port %03x = %02x\n", i, mad_read(i)));
 		else
 			DDB(printk("port %03x = %02x\n", i-0x80, mad_read(i)));
 	}
@@ -600,7 +600,7 @@
 
 	for (i = 0xf8d; i <= 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x after init = %02x\n", i, mad_read(i)))
+			DDB(printk("port %03x after init = %02x\n", i, mad_read(i)));
 		else
 			DDB(printk("port %03x after init = %02x\n", i-0x80, mad_read(i)));
 	}
