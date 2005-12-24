Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVLXVm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVLXVm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVLXVm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:42:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63700 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750729AbVLXVm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:42:26 -0500
Date: Sat, 24 Dec 2005 22:42:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Have menuconfig use ncursesw
Message-ID: <Pine.LNX.4.61.0512242240000.29877@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


on vgacon (standard tty1 stuff) with UTF8 enabled, running make menuconfig 
gives ascii-art lines `a la + - and |. I use the following patch to get 
back the line graphics from the upper part of the font. AFAICS this should 
have no impact on non-utf consoles. Include it in mainline?


Signed-off-by: Jan Engelhardt <jengelh@linux01.gwdg.de>

diff -Pdpru linux-2.6.15-rc6-20051219230006/scripts/lxdialog/Makefile linux-2.6-AS22/scripts/lxdialog/Makefile
--- linux-2.6.15-rc6-20051219230006/scripts/lxdialog/Makefile	2005-07-07 20:53:51.000000000 +0200
+++ linux-2.6-AS22/scripts/lxdialog/Makefile	2005-07-09 11:31:08.000000000 +0200
@@ -2,7 +2,7 @@ HOST_EXTRACFLAGS := -DLOCALE 
 ifeq ($(shell uname),SunOS)
 HOST_LOADLIBES   := -lcurses
 else
-HOST_LOADLIBES   := -lncurses
+HOST_LOADLIBES   := -lncursesw
 endif
 
 ifeq (/usr/include/ncurses/ncurses.h, $(wildcard /usr/include/ncurses/ncurses.h))
# eof


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
