Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTBNXQd>; Fri, 14 Feb 2003 18:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbTBNXQd>; Fri, 14 Feb 2003 18:16:33 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:48902 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267499AbTBNXQc>; Fri, 14 Feb 2003 18:16:32 -0500
Date: Fri, 14 Feb 2003 23:26:22 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FBDEV patch] More updates.
Message-ID: <Pine.LNX.4.44.0302142321320.7167-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

 Here is the new fbdev patch. It is big because of the new logo code.Many 
bug fixes. 

You can do a pull at bk://fbdev.bkbits.net/fbdev-2.5

The diff is at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

The changes are

 arch/mips64/Kconfig                        |    4 
 arch/ppc/syslib/prom.c                     |    3 
 arch/ppc/syslib/prom_init.c                |   28 
 arch/ppc64/kernel/prom.c                   |   27 
 drivers/char/vt.c                          |    8 
 drivers/video/Kconfig                      |    1 
 drivers/video/Makefile                     |    3 
 drivers/video/aty/atyfb_base.c             |    6 
 drivers/video/aty/mach64_accel.c           |   45 
 drivers/video/aty/mach64_ct.c              |  356 +++---
 drivers/video/aty/mach64_cursor.c          |    4 
 drivers/video/aty/mach64_gx.c              |   18 
 drivers/video/cfbcopyarea.c                |   42 
 drivers/video/cfbfillrect.c                |   12 
 drivers/video/cfbimgblt.c                  |   90 -
 drivers/video/console/fbcon.c              |   60 -
 drivers/video/console/newport_con.c        |   69 -
 drivers/video/fbmem.c                      |  142 +-
 drivers/video/fbmon.c                      |    3 
 drivers/video/hgafb.c                      |    9 
 drivers/video/i810/i810.h                  |    7 
 drivers/video/i810/i810_accel.c            |   64 -
 drivers/video/i810/i810_main.c             |  392 +------
 drivers/video/i810/i810_main.h             |    2 
 drivers/video/logo/Kconfig                 |   67 +
 drivers/video/logo/Makefile                |   27 
 drivers/video/logo/logo.c                  |  100 +
 drivers/video/logo/logo_dec_clut224.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_linux_clut224.ppm  | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_linux_mono.pbm     |  202 +++
 drivers/video/logo/logo_linux_vga16.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_mac_clut224.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_parisc_clut224.ppm | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_sgi_clut224.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_sun_clut224.ppm    | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_superh_clut224.ppm | 1603 +++++++++++++++++++++++++++++
 drivers/video/logo/logo_superh_mono.pbm    |  202 +++
 drivers/video/logo/logo_superh_vga16.ppm   | 1603 +++++++++++++++++++++++++++++
 drivers/video/maxinefb.c                   |    2 
 drivers/video/maxinefb.h                   |   37 
 drivers/video/modedb.c                     |    8 
 drivers/video/neofb.c                      |   81 +
 drivers/video/pmag-ba-fb.c                 |    2 
 drivers/video/pmag-ba-fb.h                 |   24 
 drivers/video/pmagb-b-fb.c                 |    2 
 drivers/video/pmagb-b-fb.h                 |   32 
 drivers/video/radeonfb.c                   |    1 
 drivers/video/riva/fbdev.c                 |  274 ++--
 drivers/video/skeletonfb.c                 |    6 
 drivers/video/sstfb.c                      |   14 
 drivers/video/sstfb.h                      |  355 ------
 drivers/video/tdfxfb.c                     |    4 
 drivers/video/tridentfb.c                  |    2 
 drivers/video/vga16fb.c                    |  100 -
 include/linux/fb.h                         |   18 
 include/linux/linux_logo.h                 | 1435 -------------------------
 include/video/mach64.h                     |   61 +
 include/video/maxinefb.h                   |   37 
 include/video/pmag-ba-fb.h                 |   24 
 include/video/pmagb-b-fb.h                 |   32 
 include/video/sstfb.h                      |  355 ++++++
 include/video/vga.h                        |   16 
 62 files changed, 16488 insertions(+), 2854 deletions(-)


