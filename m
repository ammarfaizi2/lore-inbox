Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271748AbTGRNvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271738AbTGRNvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:51:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10885
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271699AbTGRNuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:50:50 -0400
Date: Fri, 18 Jul 2003 15:05:08 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181405.h6IE58Am017658@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: POSIX doesnt guarantee head -2, only head -n 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(and some build environments are set up to be poxixly correct)

(Teemu Tervo)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/mips/ramdisk/Makefile linux-2.6.0-test1-ac2/arch/mips/ramdisk/Makefile
--- linux-2.6.0-test1/arch/mips/ramdisk/Makefile	2003-07-10 21:12:14.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/mips/ramdisk/Makefile	2003-07-15 17:24:40.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for a ramdisk image
 #
 
-O_FORMAT = $(shell $(OBJDUMP) -i | head -2 | grep elf32)
+O_FORMAT = $(shell $(OBJDUMP) -i | head -n 2 | grep elf32)
 img = $(CONFIG_EMBEDDED_RAMDISK_IMAGE)
 ramdisk.o: $(subst ",,$(img)) ld.script
 	echo "O_FORMAT:  " $(O_FORMAT)
