Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbTBLNZx>; Wed, 12 Feb 2003 08:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbTBLNY5>; Wed, 12 Feb 2003 08:24:57 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:27264 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267121AbTBLNXQ>; Wed, 12 Feb 2003 08:23:16 -0500
Date: Wed, 12 Feb 2003 22:31:58 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (7/34) kconfig
Message-ID: <20030212133158.GH1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (7/34).

Updates drivers/char/Kconfig in 2.5.50-ac1.

- Osamu Tomita

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
