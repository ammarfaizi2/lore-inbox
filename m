Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263774AbTDGWxy (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263779AbTDGWxk (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:53:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45440
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263778AbTDGWxR (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:53:17 -0400
Date: Tue, 8 Apr 2003 01:12:07 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080012.h380C7C7008981@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: config for PC98xx floppy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/block/Kconfig linux-2.5.67-ac1/drivers/block/Kconfig
--- linux-2.5.67/drivers/block/Kconfig	2003-03-26 19:59:50.000000000 +0000
+++ linux-2.5.67-ac1/drivers/block/Kconfig	2003-03-26 20:04:13.000000000 +0000
@@ -28,6 +28,13 @@
 	tristate "Atari floppy support"
 	depends on ATARI
 
+config BLK_DEV_FD98
+	tristate "NEC PC-9800 floppy disk support"
+	depends on X86_PC9800
+	---help---
+	  If you want to use the floppy disk drive(s) of NEC PC-9801/PC-9821,
+	  say Y.
+
 config BLK_DEV_SWIM_IOP
 	bool "Macintosh IIfx/Quadra 900/Quadra 950 floppy support (EXPERIMENTAL)"
 	depends on MAC && EXPERIMENTAL
