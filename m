Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTBTA7d>; Wed, 19 Feb 2003 19:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTBTA7d>; Wed, 19 Feb 2003 19:59:33 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:56842 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261448AbTBTA7a>; Wed, 19 Feb 2003 19:59:30 -0500
Date: Thu, 20 Feb 2003 01:09:33 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: FBdev updates.
Message-ID: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


New updates to the fbdev layer. You can grab the diff from 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

or do a pull

	bk pull http://gkernel.bkbits.net/fbdev-2.5

This will update the following files:

 drivers/video/maxinefb.h                   |   37 
 drivers/video/pm2fb.h                      |  218 ---
 drivers/video/pm3fb.h                      | 1284 --------------------
 drivers/video/pmag-ba-fb.h                 |   24 
 drivers/video/pmagb-b-fb.h                 |   32 
 drivers/video/sstfb.h                      |  355 -----
 arch/mips64/Kconfig                        |    4 
 arch/ppc/syslib/prom.c                     |    3 
 arch/ppc/syslib/prom_init.c                |   28 
 arch/ppc64/kernel/prom.c                   |   27 
 drivers/char/vt.c                          |    8 
 drivers/video/Kconfig                      |   17 
 drivers/video/Makefile                     |    3 
 drivers/video/aty/atyfb.h                  |   86 -
 drivers/video/aty/atyfb_base.c             | 1804 ++++++++++++++---------------
 drivers/video/aty/mach64_accel.c           |   51 
 drivers/video/aty/mach64_ct.c              |  356 +++--
 drivers/video/aty/mach64_cursor.c          |    4 
 drivers/video/aty/mach64_gx.c              |   18 
 drivers/video/aty128fb.c                   |  162 +-
 drivers/video/cfbcopyarea.c                |   42 
 drivers/video/cfbfillrect.c                |   12 
 drivers/video/cfbimgblt.c                  |  100 -
 drivers/video/console/fbcon.c              |  333 -----
 drivers/video/console/fbcon.h              |    3 
 drivers/video/console/newport_con.c        |   69 -
 drivers/video/console/vgacon.c             |  673 +++++-----
 drivers/video/fbmem.c                      |  306 ++--
 drivers/video/fbmon.c                      |    3 
 drivers/video/hgafb.c                      |    9 
 drivers/video/i810/i810.h                  |    9 
 drivers/video/i810/i810_accel.c            |  150 +-
 drivers/video/i810/i810_main.c             |  486 ++-----
 drivers/video/i810/i810_main.h             |   14 
 drivers/video/logo/Kconfig                 |   67 +
 drivers/video/logo/Makefile                |   27 
 drivers/video/logo/logo.c                  |  100 +
 drivers/video/logo/logo_dec_clut224.ppm    | 1603 +++++++++++++++++++++++++
 drivers/video/logo/logo_linux_clut224.ppm  | 1603 +++++++++++++++++++++++++
 drivers/video/logo/logo_linux_mono.pbm     |  202 +++
 drivers/video/logo/logo_linux_vga16.ppm    | 1603 +++++++++++++++++++++++++
 drivers/video/logo/logo_mac_clut224.ppm    | 1603 +++++++++++++++++++++++++
 drivers/video/logo/logo_parisc_clut224.ppm | 1603 +++++++++++++++++++++++++
 drivers/video/logo/logo_sgi_clut224.ppm    | 1603 +++++++++++++++++++++++++
 drivers/video/logo/logo_sun_clut224.ppm    | 1603 +++++++++++++++++++++++++
 drivers/video/logo/logo_superh_clut224.ppm | 1603 +++++++++++++++++++++++++
 drivers/video/logo/logo_superh_mono.pbm    |  202 +++
 drivers/video/logo/logo_superh_vga16.ppm   | 1603 +++++++++++++++++++++++++
 drivers/video/maxinefb.c                   |    2 
 drivers/video/modedb.c                     |    8 
 drivers/video/neofb.c                      |   81 -
 drivers/video/pm2fb.c                      |    2 
 drivers/video/pm3fb.c                      |    3 
 drivers/video/pmag-ba-fb.c                 |    2 
 drivers/video/pmagb-b-fb.c                 |    2 
 drivers/video/radeonfb.c                   |    1 
 drivers/video/riva/fbdev.c                 |  323 ++---
 drivers/video/riva/nv_driver.c             |  156 ++
 drivers/video/riva/rivafb.h                |    2 
 drivers/video/sgivwfb.c                    |  192 ++-
 drivers/video/skeletonfb.c                 |    6 
 drivers/video/sstfb.c                      |   14 
 drivers/video/tdfxfb.c                     |    6 
 drivers/video/tgafb.c                      |    2 
 drivers/video/tridentfb.c                  |    2 
 drivers/video/vga16fb.c                    |  127 +-
 include/linux/fb.h                         |   19 
 include/linux/linux_logo.h                 | 1435 -----------------------
 include/video/mach64.h                     |   61 
 include/video/maxinefb.h                   |   37 
 include/video/pm3fb.h                      | 1284 ++++++++++++++++++++
 include/video/pmag-ba-fb.h                 |   24 
 include/video/pmagb-b-fb.h                 |   32 
 include/video/sgivw.h                      |   40 
 include/video/sstfb.h                      |  355 +++++
 include/video/vga.h                        |   16 
 scripts/Makefile                           |    4 
 scripts/pnmtologo                          |binary
 scripts/pnmtologo.c                        |  498 ++++++++
 79 files changed, 20264 insertions(+), 6227 deletions(-)

through these ChangeSets:

<jsimmons@maxwell.earthlink.net> (03/02/19 1.913.1.3)
   [FBDEEV] Need to add support to build pnmtologo.

<jsimmons@maxwell.earthlink.net> (03/02/19 1.913.1.1)
   Removed obsolete functions in fbcon.c and re-enabled mapping console(s) to a framebuffer device. A few compile fixes for rivafb and using standard macros for vgacon.c.

<jsimmons@maxwell.earthlink.net> (03/02/16 1.913)
   [FBDEV] Data in struct fb_image is now const.
   
   [FBDEV] Updates to the logo code. We seperated it into two functions.
   
   [I810 FBDEV] Updates to the driver. PCI hooks for PCI supsend and resume to save the AGP GART mapping during power saving.
   
   [ATY 128] Add proper support for two graphics cards. Also added support for two more models of the Rage 128.
   
   [SGIVW FBDEV] Updates for the SGI Visual Workstation framebuffer.
   

<jsimmons@maxwell.earthlink.net> (03/02/13 1.910)
   [LOGO] New better logo code. 
   
   [FBDEV] Moved a few more header files.

<jsimmons@maxwell.earthlink.net> (03/02/11 1.909)
   [FBCON] Removal of useless code.

<jsimmons@maxwell.earthlink.net> (03/02/11 1.906)
   [ATY FBDEV] Reversed mobilty patches. They busted every other card.  

<jsimmons@maxwell.earthlink.net> (03/02/09 1.900)
   [ATY FBDEV] Updates to support Rage Mobility Chipstes.

<jsimmons@maxwell.earthlink.net> (03/01/30 1.899)
   [RIVA FBDEV] SUpprot Directcolor mode. Needed for some cards.

<jsimmons@kozmo.(none)> (03/01/28 1.897)
   [NEOMAGIC FBDEV] Fix to work with no 21xx versions of the chip.

<jsimmons@maxwell.earthlink.net> (03/01/28 1.889.52.3)
   [RADEON FBDEV] Add cursor support. Now the cursor is back.
   [RIVA FBDEV] Added support for interlace mode and are now using TRUECOLOR instead of DIRECTCOLOR. Setting the graphics card in DIRECTCOLOR confusses the X server.

<jsimmons@maxwell.earthlink.net> (03/01/26 1.889.52.2)
   Accel rountines pass in constant data into each function. The reason being was some of the code in the upper layers depended on the data being passed to the low level function not be altered because the upper layers was altering the data themselves.
   
   Pan display fix for fbcon.c. p->vrow needed to be updated.
   
   PPC build fix for fbmon.c
   
   I810 fbdev updates. 

<jsimmons@maxwell.earthlink.net> (03/01/17 1.889.52.1)
   [GENERIC ACCELERATION] Fixed the generic image drawing function tfor 64 bit machines.
   
   [RIVA FBDEV] The cursor and imageblit functions have been fixed.


