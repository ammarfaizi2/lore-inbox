Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbSL1Wa7>; Sat, 28 Dec 2002 17:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbSL1Wa7>; Sat, 28 Dec 2002 17:30:59 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:15093 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266310AbSL1Wa4>; Sat, 28 Dec 2002 17:30:56 -0500
Date: Sat, 28 Dec 2002 15:30:41 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [fbdev updates] 
Message-ID: <Pine.LNX.4.33.0212281528330.1994-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are a bunch of fixes and driver updates for the fbdev layer. The
patch applies against 2.5.53. You can also do a bk pull at

bk://fbdev.bkbits.net:8080/fbdev-2.5

The diff is at

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 CREDITS                                |    1
 Documentation/fb/intel810.txt          |  272 +++
 MAINTAINERS                            |    2
 arch/m68k/kernel/head.S                |   34
 arch/m68k/kernel/m68k_defs.c           |   16
 drivers/char/vt.c                      |    2
 drivers/video/Kconfig                  |   68
 drivers/video/Makefile                 |   20
 drivers/video/aty/atyfb_base.c         |   33
 drivers/video/aty128fb.c               |  102 -
 drivers/video/cfbcopyarea.c            |    2
 drivers/video/cfbimgblt.c              |   15
 drivers/video/chipsfb.c                |  572 ++------
 drivers/video/console/Kconfig          |   36
 drivers/video/console/Makefile         |   38
 drivers/video/console/dummycon.c       |    6
 drivers/video/console/fbcon-sti.c      |  289 ----
 drivers/video/console/fbcon.c          |  304 ----
 drivers/video/console/fbcon.h          |   17
 drivers/video/console/font.h           |   53
 drivers/video/console/font_6x11.c      |    2
 drivers/video/console/font_8x16.c      |    2
 drivers/video/console/font_8x8.c       |    2
 drivers/video/console/font_acorn_8x8.c |    3
 drivers/video/console/font_mini_4x6.c  |    2
 drivers/video/console/font_pearl_8x8.c |    2
 drivers/video/console/font_sun12x22.c  |    2
 drivers/video/console/font_sun8x16.c   |    2
 drivers/video/console/fonts.c          |    2
 drivers/video/console/mdacon.c         |   24
 drivers/video/console/newport_con.c    |    2
 drivers/video/console/sti.h            |  289 ----
 drivers/video/console/sticon.c         |  390 ++++-
 drivers/video/console/sticore.c        | 1132 +++++++++++-----
 drivers/video/controlfb.c              |   37
 drivers/video/fbmem.c                  |  364 ++++-
 drivers/video/fbmon.c                  |  334 ++++
 drivers/video/i810/Makefile            |   22
 drivers/video/i810/i810.h              |  300 ++++
 drivers/video/i810/i810_accel.c        |  513 +++++++
 drivers/video/i810/i810_dvt.c          |  308 ++++
 drivers/video/i810/i810_gtf.c          |  275 ++++
 drivers/video/i810/i810_main.c         | 2245 +++++++++++++++++++++++++++++++++
 drivers/video/i810/i810_main.h         |  205 +++
 drivers/video/i810/i810_regs.h         |  274 ++++
 drivers/video/igafb.c                  |  100 +
 drivers/video/offb.c                   |    5
 drivers/video/radeonfb.c               |   38
 drivers/video/riva/fbdev.c             |  310 +++-
 drivers/video/riva/nv_type.h           |   58
 drivers/video/riva/riva_hw.c           |  128 +
 drivers/video/riva/riva_hw.h           |  110 +
 drivers/video/riva/riva_tbl.h          |   99 +
 drivers/video/riva/rivafb.h            |    7
 drivers/video/skeletonfb.c             |  220 ++-
 drivers/video/sstfb.c                  | 2076 ++++++++++++------------------
 drivers/video/sstfb.h                  |   68
 drivers/video/sticore.h                |    5
 drivers/video/stifb.c                  |  136 -
 drivers/video/tdfxfb.c                 |   11
 drivers/video/tgafb.c                  | 1544 +++++++++-------------
 drivers/video/vga16fb.c                |   70 -
 drivers/video/vgastate.c               |    7
 include/linux/fb.h                     |   10
 include/linux/font.h                   |   53
 include/linux/pci_ids.h                |   37
 include/video/radeon.h                 |  144 +-
 include/video/tgafb.h                  |  210 +++
 68 files changed, 9296 insertions(+), 4765 deletions(-)

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

