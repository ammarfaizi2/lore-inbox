Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTAGAzd>; Mon, 6 Jan 2003 19:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTAGAzd>; Mon, 6 Jan 2003 19:55:33 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:57042 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267221AbTAGAzc>; Mon, 6 Jan 2003 19:55:32 -0500
Date: Mon, 6 Jan 2003 17:55:26 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK FBDEV updates]
Message-ID: <Pine.LNX.4.33.0301061753120.2196-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull http://fbdev.bkbits.net:8080/fbdev-2.5

This will update the following files:

 include/video/font.h            |   24
 arch/m68k/kernel/m68k_defs.c    |    2
 drivers/video/Makefile          |    3
 drivers/video/aty/atyfb_base.c  |    4
 drivers/video/console/fbcon.c   |   90 +-
 drivers/video/console/sticon.c  |   40 -
 drivers/video/console/sticore.c |    8
 drivers/video/fbmem.c           |    1
 drivers/video/i810/i810.h       |    2
 drivers/video/i810/i810_accel.c |   11
 drivers/video/i810/i810_dvt.c   |    2
 drivers/video/i810/i810_main.c  |   51 -
 drivers/video/i810/i810_main.h  |   79 --
 drivers/video/riva/Makefile     |    2
 drivers/video/riva/fbdev.c      | 1468 +++++++++++++++++++---------------------
 drivers/video/riva/nv_driver.c  |  212 +++++
 drivers/video/riva/riva_hw.c    |  350 +++++++--
 drivers/video/riva/rivafb.h     |   15
 drivers/video/sstfb.c           |  707 +++++++++----------
 drivers/video/sstfb.h           |   31
 include/linux/font.h            |   30
 21 files changed, 1725 insertions(+), 1407 deletions(-)

through these ChangeSets:

<jsimmons@maxwell.earthlink.net> (03/01/06 1.972)
   [RIVA FBDEV] Driver now uses its own fb_open and fb_release function again.
   It has no ill effects. The drivers uses strickly hardware acceleration
   so we don't need cfb_fillrect and cfb_copyarea.

   Cleaned up font.h. Geerts orignal pacth broke them up into a font.h in
   video and one in linux. Now I put them back together again in
   include/linux. The m68k platform has been updated for this change.

<jsimmons@maxwell.earthlink.net> (03/01/06 1.971)
   Added resize support for the framebuffer console. Now you can change the
   console size via stty. Also support for color palette changing on VC
   switch is supported.

<jsimmons@maxwell.earthlink.net> (03/01/06 1.970)
   I810 fbdev updates. Cursor fix for ati mach 64 cards on big endian machines.
   Buffer over flow fix for fbcon putcs function. C99 initializers for the
   STI console drivers. Voodoo 1/2 and NVIDIA driver updates.


