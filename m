Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbTBQStA>; Mon, 17 Feb 2003 13:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTBQStA>; Mon, 17 Feb 2003 13:49:00 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:41132 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267350AbTBQSs7>; Mon, 17 Feb 2003 13:48:59 -0500
Date: Mon, 17 Feb 2003 14:10:56 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.61-ac1 : fixes 'make mrproper'
Message-ID: <Pine.LNX.4.44.0302171408430.19276-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch fixes a 'make mrproper' compile error. The Makefiles 
within arch/i386/boot98 include (TOPDIR)/Rules.make , which no longer is 
there. Please review for inclusion.

Regards,
Frank

--- linux/arch/i386/boot98/Makefile.old	2003-02-17 14:05:08.000000000 -0500
+++ linux/arch/i386/boot98/Makefile	2003-02-17 14:05:18.000000000 -0500
@@ -36,8 +36,6 @@
 
 boot: bzImage
 
-include $(TOPDIR)/Rules.make
-
 # ---------------------------------------------------------------------------
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000
--- linux/arch/i386/boot98/compressed/Makefile.old	2003-02-17 14:05:52.000000000 -0500
+++ linux/arch/i386/boot98/compressed/Makefile	2003-02-17 14:05:56.000000000 -0500
@@ -7,8 +7,6 @@
 EXTRA_TARGETS	:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS	:= -traditional
 
-include $(TOPDIR)/Rules.make
-
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
 
 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE



