Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbTCHAPs>; Fri, 7 Mar 2003 19:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbTCHAPr>; Fri, 7 Mar 2003 19:15:47 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:28679 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261924AbTCHAPh>; Fri, 7 Mar 2003 19:15:37 -0500
Date: Sat, 8 Mar 2003 00:26:10 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK updates]
Message-ID: <Pine.LNX.4.44.0303080024130.20304-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!!!

  More updates. Lots of fixes in drivers and in the upper layers. Its 
starting to really shape up. You can get the standard diff at

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

For the BK users just do a pull

bk pull http://fbdev.bkbits.net/fbdev-2.5

This will update the following files:

 drivers/video/aty128fb.c                   | 2353 -----
 drivers/video/maxinefb.h                   |   37 
 drivers/video/pm2fb.h                      |  218 
 drivers/video/pm3fb.h                      | 1284 --
 drivers/video/pmag-ba-fb.h                 |   24 
 drivers/video/pmagb-b-fb.h                 |   32 
 drivers/video/sis/325vtbl.h                | 2335 -----
 drivers/video/sis/sisfb.h                  |  153 
 drivers/video/sstfb.h                      |  355 
 include/asm-alpha/linux_logo.h             |   27 
 include/asm-arm/linux_logo.h               |   19 
 include/asm-i386/linux_logo.h              |   27 
 include/asm-ia64/linux_logo.h              |   28 
 include/asm-m68k/linux_logo.h              |  924 --
 include/asm-m68knommu/linux_logo.h         |   13 
 include/asm-mips/linux_logo.h              |   43 
 include/asm-mips/linux_logo_dec.h          |  907 -
 include/asm-mips/linux_logo_sgi.h          |  919 --
 include/asm-mips64/linux_logo.h            |  919 --
 include/asm-parisc/linux_logo.h            | 1438 ---
 include/asm-ppc64/linux_logo.h             |   26 
 include/asm-sh/linux_logo.h                | 1418 ---
 include/asm-sparc/linux_logo.h             |  934 --
 include/asm-sparc64/linux_logo.h           |  934 --

 include/asm-um/linux_logo.h                |    6 
 include/asm-x86_64/linux_logo.h            |   29 
 include/linux/sisfb.h                      |  169 
 arch/mips64/Kconfig                        |    4 
 arch/ppc/syslib/prom.c                     |    3 
 arch/ppc/syslib/prom_init.c                |   28 
 arch/ppc64/kernel/prom.c                   |   27 
 drivers/char/vt.c                          |    8 
 drivers/video/Kconfig                      |   23 
 drivers/video/Makefile                     |    9 
 drivers/video/aty/Makefile                 |    2 
 drivers/video/aty/aty128fb.c               | 2362 +++++
 drivers/video/aty/atyfb.h                  |  133 
 drivers/video/aty/atyfb_base.c             | 2124 ++--
 drivers/video/aty/mach64_accel.c           |   51 
 drivers/video/aty/mach64_ct.c              |  846 +
 drivers/video/aty/mach64_cursor.c          |    4 
 drivers/video/aty/mach64_gx.c              |   18 
 drivers/video/aty/xlinit.c                 |  367 
 drivers/video/aty128fb.c                   |  162 
 drivers/video/cfbcopyarea.c                |  218 
 drivers/video/cfbfillrect.c                |   12 
 drivers/video/cfbimgblt.c                  |  255 
 drivers/video/cg6.c                        |    8 
 drivers/video/console/fbcon.c              |  944 --
 drivers/video/console/fbcon.h              |    4 
 drivers/video/console/newport_con.c        |   69 
 drivers/video/console/vgacon.c             |  801 -
 drivers/video/dnfb.c                       |    9 
 drivers/video/fbmem.c                      |  340 
 drivers/video/fbmon.c                      |    3 
 drivers/video/ffb.c                        |   12 
 drivers/video/hgafb.c                      |   15 
 drivers/video/hitfb.c                      |    2 
 drivers/video/hpfb.c                       |    2 
 drivers/video/i810/i810.h                  |    9 
 drivers/video/i810/i810_accel.c            |  150 
 drivers/video/i810/i810_main.c             |  486 -
 drivers/video/i810/i810_main.h             |   14 
 drivers/video/imsttfb.c                    | 1616 +--
 drivers/video/logo/Kconfig                 |   75 
 drivers/video/logo/Makefile                |   27 
 drivers/video/logo/clut_vga16.ppm          |   20 
 drivers/video/logo/logo.c                  |  100 
 drivers/video/logo/logo_dec_clut224.ppm    | 1604 +++
 drivers/video/logo/logo_linux_clut224.ppm  | 1604 +++
 drivers/video/logo/logo_linux_mono.pbm     |  203 
 drivers/video/logo/logo_linux_vga16.ppm    | 1604 +++
 drivers/video/logo/logo_mac_clut224.ppm    | 1604 +++
 drivers/video/logo/logo_parisc_clut224.ppm | 1604 +++
 drivers/video/logo/logo_sgi_clut224.ppm    | 1604 +++
 drivers/video/logo/logo_sun_clut224.ppm    | 1604 +++
 drivers/video/logo/logo_superh_clut224.ppm | 1604 +++
 drivers/video/logo/logo_superh_mono.pbm    |  203 
 drivers/video/logo/logo_superh_vga16.ppm   | 1604 +++
 drivers/video/maxinefb.c                   |    2 
 drivers/video/modedb.c                     |    8 
 drivers/video/neofb.c                      |  113 
 drivers/video/pm2fb.c                      |    2 
 drivers/video/pm3fb.c                      |    3 
 drivers/video/pmag-ba-fb.c                 |    2 
 drivers/video/pmagb-b-fb.c                 |    2 
 drivers/video/q40fb.c                      |    1 
 drivers/video/radeonfb.c                   |    1 
 drivers/video/riva/fbdev.c                 |  405 
 drivers/video/riva/nv_driver.c             |  156 
 drivers/video/riva/rivafb.h                |    2 
 drivers/video/sgivwfb.c                    |  192 
 drivers/video/sis/300vtbl.h                | 1555 ++-
 drivers/video/sis/310vtbl.h                | 3373 +++++--
 drivers/video/sis/init.c                   | 6345 ++++++++-----
 drivers/video/sis/init.h                   |  310 
 drivers/video/sis/init301.c                |13192 ++++++++++++++++++-----------
 drivers/video/sis/init301.h                |  529 -
 drivers/video/sis/initdef.h                |  114 
 drivers/video/sis/oem300.h                 |  468 -
 drivers/video/sis/oem310.h                 |  239 
 drivers/video/sis/osdef.h                  |   13 
 drivers/video/sis/sis.h                    |   10 
 drivers/video/sis/sis_accel.c              |  176 
 drivers/video/sis/sis_accel.h              |  513 +
 drivers/video/sis/sis_main.c               | 4743 ++++++----
 drivers/video/sis/sis_main.h               |  686 -
 drivers/video/sis/vgatypes.h               |   26 
 drivers/video/sis/vstruct.h                |  687 -
 drivers/video/skeletonfb.c                 |    6 
 drivers/video/softcursor.c                 |   72 
 drivers/video/sstfb.c                      |   16 
 drivers/video/tdfxfb.c                     |   31 
 drivers/video/tgafb.c                      |   18 
 drivers/video/tridentfb.c                  |    4 
 drivers/video/vga16fb.c                    |  145 
 include/linux/fb.h                         |   43 
 include/linux/linux_logo.h                 | 1435 ---
 include/video/mach64.h                     |   75 
 include/video/maxinefb.h                   |   37 
 include/video/pm3fb.h                      | 1284 ++
 include/video/pmag-ba-fb.h                 |   24 
 include/video/pmagb-b-fb.h                 |   32 
 include/video/sgivw.h                      |   40 
 include/video/sisfb.h                      |  191 
 include/video/sstfb.h                      |  355 
 include/video/vga.h                        |   23 
 scripts/Makefile                           |    4 
 scripts/pnmtologo                          |binary
 scripts/pnmtologo.c                        |  523 +
 130 files changed, 46575 insertions(+), 33426 deletions(-)

through these ChangeSets:

<jsimmons@maxwell.earthlink.net> (03/03/07 1.946)
   [SIS FBDEV] More sisfb driver updates.
   
   [FBCON] Many fixes dealing with reszing the screen.

<jsimmons@maxwell.earthlink.net> (03/03/06 1.943)
   [SIS FBDEV] Make it compile as a module.

<jsimmons@maxwell.earthlink.net> (03/03/05 1.941)
   [TWIN TURBO FBDEV] Ported over to new api.

<jsimmons@maxwell.earthlink.net> (03/03/05 1.940)
   [FBCON] Help clear margins for modes where the resolution does quite fit the console size.

<jsimmons@maxwell.earthlink.net> (03/03/05 1.939)
   [FBDEV] Updates for the SIS fbdev driver to the new api. Removed poll. We wil use signals in the future instead.

<jsimmons@maxwell.earthlink.net> (03/03/03 1.936)
   [FBDEV] Accelerated functions pass in const structs.
   
   [ATY128 FBDEV] Gcc compile issue fixes.

<jsimmons@maxwell.earthlink.net> (03/03/03 1.935)
   [GENRIC ACCEL] Megred David Millers changes with my own. 
   
   [FBCON] Small scrolling fix. 

<jsimmons@maxwell.earthlink.net> (03/02/28 1.931)
   [FRAMEBUFFER]: cfbcopyarea accesses fb without using FB_{READ,WRITE}L.

<jsimmons@maxwell.earthlink.net> (03/02/27 1.929)
   [ATY FBDEV] Rage XL cards can now be booted with needed the BIOS :-)
   
   [FBCON] Moving to use ring buffers and DMA cards.

<jsimmons@kozmo.(none)> (03/02/26 1.926)
   [ATY128 FBDEV] Moved aty128fb to aty/ and a few minor changes so aty128fb.c compiles with the newest compiler standards.

<jsimmons@kozmo.(none)> (03/02/26 1.925)
   [FBCON] More struct display cleanup. Also killed off static buffer for accel_putcs.

<jsimmons@maxwell.earthlink.net> (03/02/24 1.923)
   [FBDEV] Minor fixes for logo code.
   
   [FBCON] More optimizations for drawing a string of characters.
   
   [VGACON] Using more code from video/vga.h.
   [VGA] Changes membase to unsigned long to support 64 bit platforms.
   

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

<jsimmons@maxwell.earthlink.net> (03/01/28 1.889.53.3)
   [RADEON FBDEV] Add cursor support. Now the cursor is back.
   [RIVA FBDEV] Added support for interlace mode and are now using TRUECOLOR instead of DIRECTCOLOR. Setting the graphics card in DIRECTCOLOR confusses the X server.

<jsimmons@maxwell.earthlink.net> (03/01/26 1.889.53.2)
   Accel rountines pass in constant data into each function. The reason being was some of the code in the upper layers depended on the data being passed to the low level function not be altered because the upper layers was altering the data themselves.
   
   Pan display fix for fbcon.c. p->vrow needed to be updated.
   
   PPC build fix for fbmon.c
   
   I810 fbdev updates. 

<jsimmons@maxwell.earthlink.net> (03/01/17 1.889.53.1)
   [GENERIC ACCELERATION] Fixed the generic image drawing function tfor 64 bit machines.
   
   [RIVA FBDEV] The cursor and imageblit functions have been fixed.


