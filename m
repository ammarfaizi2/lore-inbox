Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271743AbTGRNvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271748AbTGRNv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:51:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11653
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271743AbTGRNvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:51:15 -0400
Date: Fri, 18 Jul 2003 15:05:35 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181405.h6IE5ZMZ017664@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: head -n 2 for ppc64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/ppc64/boot/Makefile linux-2.6.0-test1-ac2/arch/ppc64/boot/Makefile
--- linux-2.6.0-test1/arch/ppc64/boot/Makefile	2003-07-10 21:13:37.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/ppc64/boot/Makefile	2003-07-15 17:24:40.000000000 +0100
@@ -118,7 +118,7 @@
 	ls -l vmlinux | \
 	awk '{printf "/* generated -- do not edit! */\n" \
 		"unsigned long vmlinux_filesize = %d;\n", $$5}' > $(obj)/imagesize.c
-	$(CROSS_COMPILE)nm -n vmlinux | tail -1 | \
+	$(CROSS_COMPILE)nm -n vmlinux | tail -n 1 | \
 	awk '{printf "unsigned long vmlinux_memsize = 0x%s;\n", substr($$1,8)}' \
 		>> $(obj)/imagesize.c
 
