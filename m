Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSIKHDj>; Wed, 11 Sep 2002 03:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318458AbSIKHDj>; Wed, 11 Sep 2002 03:03:39 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:43780 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318455AbSIKHDi>;
	Wed, 11 Sep 2002 03:03:38 -0400
Date: Wed, 11 Sep 2002 09:08:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/Makefile: Remove pty.o from export-objs
Message-ID: <20020911090825.B16000@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pty.o from the export-objs list, since pty.c does not export
any symbols.
A /* EXPORT_SYMBOL */ comment may have fooled the original author.

	Sam

===== drivers/char/Makefile 1.34 vs edited =====
--- 1.34/drivers/char/Makefile	Mon Sep  2 21:24:29 2002
+++ edited/drivers/char/Makefile	Wed Sep 11 08:57:46 2002
@@ -13,7 +13,7 @@
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
 export-objs     :=	busmouse.o console.o generic_serial.o ip2main.o \
-			ite_gpio.o misc.o nvram.o pty.o random.o rtc.o \
+			ite_gpio.o misc.o nvram.o random.o rtc.o \
 			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o
 
 obj-$(CONFIG_VT) += vt.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
