Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTASGXe>; Sun, 19 Jan 2003 01:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTASGXe>; Sun, 19 Jan 2003 01:23:34 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:46978 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265414AbTASGXd>; Sun, 19 Jan 2003 01:23:33 -0500
Date: Sun, 19 Jan 2003 15:32:24 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 sub-arch (2/29) ac-update
Message-ID: <20030119063224.GA2965@yuzuki.cinet.co.jp>
References: <20030119051043.GA2662@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119051043.GA2662@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.59 (2/29).

Updates drivers/char/Kconfig in 2.5.50-ac1.

diff -Nru linux-2.5.50-ac1/drivers/char/Kconfig linux98-2.5.58/drivers/char/Kconfig
--- linux-2.5.50-ac1/drivers/char/Kconfig	2003-01-14 22:18:18.000000000 +0900
+++ linux98-2.5.58/drivers/char/Kconfig	2003-01-14 22:35:34.000000000 +0900
@@ -577,7 +577,7 @@
 
 config PC9800_OLDLP
 	tristate "NEC PC-9800 old-style printer port support"
-	depends on PC9800 && !PARPORT
+	depends on X86_PC9800 && !PARPORT
 	---help---
 	  If you intend to attach a printer to the parallel port of NEC PC-9801
 	  /PC-9821 with OLD compatibility mode, Say Y.
@@ -785,7 +785,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !PC9800
+	depends on !PPC32 && !PARISC && !IA64 && !X86_PC9800
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -846,7 +846,7 @@
 
 config RTC98
 	tristate "NEC PC-9800 Real Time Clock Support"
-	depends on PC9800
+	depends on X86_PC9800
 	default y
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
