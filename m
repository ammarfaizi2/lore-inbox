Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUAHWE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266313AbUAHWE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:04:28 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:44050 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266274AbUAHWD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:03:57 -0500
Date: Thu, 8 Jan 2004 22:03:54 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New FBDev patch
Message-ID: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the latest patch against 2.6.0-rc3. Give it a try.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Here are the changes.

 Documentation/fb/modedb.txt           |    4 
 Documentation/fb/neofb.txt            |   27 
 MAINTAINERS                           |    5 
 drivers/char/vt.c                     |   47 
 drivers/char/vt_ioctl.c               |   12 
 drivers/video/Kconfig                 |  130 
 drivers/video/Makefile                |   15 
 drivers/video/acornfb.c               |    1 
 drivers/video/asiliantfb.c            |  619 
 drivers/video/aty/Makefile            |    1 
 drivers/video/aty/aty128fb.c          |  349 
 drivers/video/aty/atyfb.h             |  155 
 drivers/video/aty/atyfb_base.c        | 1842 +-
 drivers/video/aty/mach64_ct.c         |  732 -
 drivers/video/aty/mach64_cursor.c     |  324 
 drivers/video/aty/mach64_gx.c         |   20 
 drivers/video/aty/xlinit.c            |   68 
 drivers/video/bw2.c                   |   74 
 drivers/video/cfbimgblt.c             |    2 
 drivers/video/cg14.c                  |   98 
 drivers/video/cg3.c                   |   79 
 drivers/video/cg6.c                   |   89 
 drivers/video/chipsfb.c               |    4 
 drivers/video/cirrusfb.c              |   32 
 drivers/video/clients.c               |  108 
 drivers/video/console/Makefile        |   29 
 drivers/video/console/fbcon.c         |  703 -
 drivers/video/console/fbcon.h         |    3 
 drivers/video/controlfb.c             |   10 
 drivers/video/cyber2000fb.c           |  198 
 drivers/video/epson1355fb.c           |  967 -
 drivers/video/fbmem.c                 |  443 
 drivers/video/fbmon.c                 |   10 
 drivers/video/ffb.c                   |  110 
 drivers/video/fm2fb.c                 |    1 
 drivers/video/g364fb.c                |   78 
 drivers/video/i810/Makefile           |    7 
 drivers/video/i810/i810_main.c        |   21 
 drivers/video/igafb.c                 |    5 
 drivers/video/imsttfb.c               |   17 
 drivers/video/leo.c                   |   78 
 drivers/video/logo/Kconfig            |    2 
 drivers/video/logo/Makefile           |   49 
 drivers/video/logo/logo.c             |   10 
 drivers/video/macfb.c                 |   34 
 drivers/video/matrox/matroxfb_base.c  |    8 
 drivers/video/matrox/matroxfb_crtc2.c |    3 
 drivers/video/modedb.c                |    4 
 drivers/video/neofb.c                 |  446 
 drivers/video/p9100.c                 |   62 
 drivers/video/platinumfb.c            |   10 
 drivers/video/pm2fb.c                 | 3010 +---
 drivers/video/pvr2fb.c                |  846 -
 drivers/video/radeonfb.c              |    5 
 drivers/video/riva/fbdev.c            |  189 
 drivers/video/riva/nv_type.h          |   12 
 drivers/video/sa1100fb.c              |    1 
 drivers/video/sgivwfb.c               |   14 
 drivers/video/sis/300vtbl.h           | 2455 ---
 drivers/video/sis/310vtbl.h           | 3515 +----
 drivers/video/sis/init.c              | 8364 +++++-------
 drivers/video/sis/init.h              | 2874 +++-
 drivers/video/sis/init301.c           |21991 +++++++++++++++++-----------------
 drivers/video/sis/init301.h           |  535 
 drivers/video/sis/initdef.h           |  357 
 drivers/video/sis/oem300.h            |  502 
 drivers/video/sis/oem310.h            |  181 
 drivers/video/sis/osdef.h             |  122 
 drivers/video/sis/sis_accel.c         |   68 
 drivers/video/sis/sis_accel.h         |   27 
 drivers/video/sis/sis_main.c          | 4594 +++----
 drivers/video/sis/sis_main.h          |  713 -
 drivers/video/sis/vgatypes.h          |  267 
 drivers/video/sis/vstruct.h           |  218 
 drivers/video/skeletonfb.c            |   74 
 drivers/video/softcursor.c            |  206 
 drivers/video/sstfb.c                 |    4 
 drivers/video/stifb.c                 |    1 
 drivers/video/tcx.c                   |  115 
 drivers/video/tdfxfb.c                |   98 
 drivers/video/tgafb.c                 |  177 
 drivers/video/tridentfb.c             |    3 
 drivers/video/valkyriefb.c            |  548 
 drivers/video/vesafb.c                |   17 
 drivers/video/vgastate.c              |    1 
 include/linux/fb.h                    |  153 
 include/linux/linux_logo.h            |    4 
 include/linux/pci_ids.h               |  109 
 include/video/aty128.h                |    3 
 include/video/cirrus.h                |    1 
 include/video/cvisionppc.h            |   51 
 include/video/epson1355.h             |   64 
 include/video/mach64.h                |  229 
 include/video/neomagic.h              |  261 
 include/video/sisfb.h                 |  105 
 include/video/tdfx.h                  |    1 
 96 files changed, 30792 insertions(+), 30438 deletions(-)

through these ChangeSets:

<jsimmons@infradead.org> (04/01/08 1.1406)
   [IMSTT FBDEV] No longer need these special macros.

<jsimmons@infradead.org> (04/01/08 1.1404)
   [NEOMAGIC FBDEV] Fixed the nasty bug causing a oops. I needed to call neofb_check_var at bootup to fix the yres_virtual value. Updated the still not functional cursor code. The hardware imageblit code has a problem.

<jsimmons@debian.(none)> (04/01/07 1.1402)
   [MACH 64] Hardware info from the specs.

<jsimmons@debian.(none)> (04/01/07 1.1400)
   [VT CONSOLE] Pavel patch to fix the trailing cursor bug. The fix is to first hide the cursor _then_ hide the software cursor. A very old bug never discovered until now.

<jsimmons@infradead.org> (04/01/06 1.1398)
   [FBCON] Needed fix for resizing. Cols and rows where reversed.

<jsimmons@infradead.org> (04/01/06 1.1397)
   [ATY FBDEV] More PCI ids for more Mach 64 cards out there.

<jsimmons@infradead.org> (04/01/06 1.1396)
   [CONSOLE] Don't let a monochrome display stomp all over the color values.

<jsimmons@infradead.org> (04/01/06 1.1395)
   [FBDEV] Changed docs to reflect commandline change.

<jsimmons@infradead.org> (04/01/06 1.1394)
   [FM2 FBDEV] Removed old comment.

<jsimmons@infradead.org> (04/01/06 1.1393)
   [CIRRUS FBDEV] 16 bpp color mode fix.

<jsimmons@infradead.org> (03/12/19 1.1389)
   [FBCON] Fixed the order of which driver is used for the console. Before the api changes the last driver loaded became the default one. Now that is not the case. 

<jsimmons@infradead.org> (03/12/03 1.1380)
   [FBCON] Need to clear the cursor mask data.

<jsimmons@infradead.org> (03/11/06 1.1364)
   [ATY FBDEV] Sparc compile fixes.

<jsimmons@debian.(none)> (03/10/31 1.1358)
   [FBDEV] Fixed the cursor ioctl. It was placing the image and mask data in cursor instead of info->cursor.

<jsimmons@debian.(none)> (03/10/31 1.1357)
   [MACH64 FBDEV] Latest LCD support code.

<jsimmons@debian.(none)> (03/10/30 1.1354)
   [FBCON] cur_height might not be initialized. SO we use vc->vc_font.height instead. Fixed overflow issues with mask.

<jsimmons@infradead.org> (03/10/29 1.1350)
   [FBCON] Accidentally disabled flashing cursor.

<jsimmons@infradead.org> (03/10/29 1.1349)
   [FBCON] State management added.

<jsimmons@debian.(none)> (03/10/28 1.1344.1.13)
   [FBCON] Final fix to the cursor issues when the cursor wasn't divisible evenly by 8.

<jsimmons@debian.(none)> (03/10/28 1.1344.1.11)
   [FBDEV] Major fixes to the cursor code.

<jsimmons@debian.(none)> (03/10/27 1.1344.1.9)
   [FBDEV] The passed in data was in the wrong order.

<jsimmons@infradead.org> (03/10/17 1.1337.50.2)
   [FBDEV RADEON} The return of fb_setup.
   
   [FBDEV SGIVW] Match info to code.

<jsimmons@infradead.org> (03/10/16 1.1337.25.21)
   [FBDEV] Fixed Radeon PCI IDs so the agp driver could compile as well.

<jsimmons@infradead.org> (03/10/16 1.1337.25.19)
   [ATY128 FBDEV] ATI 128 Rage updates.
   
   [FBDEV] Sysfs updates

<jsimmons@infradead.org> (03/10/15 1.1337.25.18)
   [RADEON FBDEV] Fixed the pitch size.

<jsimmons@infradead.org> (03/10/15 1.1337.25.16)
   [FBDEV SOFT CURSOR] Fixed size bug.
   [FBDEV] Increased size for 64 bit platforms.

<jsimmons@infradead.org> (03/10/15 1.1337.25.15)
   [FBDEV SOFTWARE CURSOR] We always save the maximum are under the cursor. This way we don't have to worry about cursor resizing.

<jsimmons@infradead.org> (03/10/14 1.1337.25.14)
   [FBDEV] Implemented the first round of saving and restoring the area under the cursor.

<jsimmons@infradead.org> (03/10/14 1.1337.25.12)
   [FBDEV] Moved kernel header files to be visible only when compiling for the kernel. Userland doesn't need these header files. It also makes shifting from kernel version to kernel version easier.

<jsimmons@infradead.org> (03/10/14 1.1337.25.11)
   [SIS FBDEV] Compile fix.

<jsimmons@infradead.org> (03/10/13 1.1337.30.2)
   [SIS FBDEV] SIS updates. FIxed CRT1 detection.

<jsimmons@infradead.org> (03/10/03 1.1296.47.4)
   [SGIVW FBDEV] Fixed 16 bpp color mode.

<jsimmons@infradead.org> (03/09/29 1.1296.32.2)
   [FBDEV] Patch fixes get_std_timing. Current code doesn't search the  VESA modedb. Instead it exits after the first  iteration  with  mode calculated  by  calc_mode_timings.

<jsimmons@infradead.org> (03/09/22 1.1267.1.26)
   [FBDEV] Better makefile.

<jsimmons@infradead.org> (03/09/22 1.1267.1.25)
   pm2fb-2.6.patch

<jsimmons@debian.(none)> (03/09/19 1.1267.47.2)
   [TGA FBDEV] Updates to the tga famebuffer. Added color imageblit support. Added using dec logo for TGA fbdev. Color palette fix.

<kronos@kronoz.cjb.net> (03/09/18 1.1267.1.20)
   Update driver with the new API

<kronos@kronoz.cjb.net> (03/09/18 1.1267.1.19)
   Update sisfb driver:
   - merge with driver version version 090903-1 (from Thomas Winischhofer)
   - port driver to the new framebuffer_{alloc,release} API

<kronos@kronoz.cjb.net> (03/09/17 1.1267.1.18)
   Update sparc framebuffer drivers to the new API.

<kronos@kronoz.cjb.net> (03/09/17 1.1267.40.1)
   Add new API framebuffer_alloc and framebuffer_release.
   
   Framebuffer info structure (ie. struct fb_info) must be obtained from
   framebuffer_alloc. When it is no longer needed (after unregister_framebuffer
   and clean up) it can be released using framebuffer_release.
   
   If the framebuffer is not registered yet (eg. on error path) then fb_info must
   be released via kfree. 

<jsimmons@maxwell.earthlink.net> (03/09/16 1.1267.1.16)
   [MACH 64 FBDEV] Updated to new cursor api.

<jsimmons@debian.(none)> (03/09/14 1.1267.1.14)
   [FBDEV} Final cursor api.

<jsimmons@infradead.org> (03/09/04 1.1153.146.5)
   [FBDEV] Cleanup for Configuration of Mach64 driver.

<jsimmons@infradead.org> (03/09/04 1.1153.146.4)
   [FBDEV] Fixed the cursor code. Also some cleanup with move_buf_*. 

<jsimmons@infradead.org> (03/09/04 1.1153.146.3)
   [FBDEV] Currcon removal. fbcon.c does this for us.

<jsimmons@infradead.org> (03/09/04 1.1153.146.2)
   [FBDEV MODEDB] Better support for 1400x1050 modes.

<jsimmons@infradead.org> (03/08/21 1.1153.1.97)
   [FBDEV] Removed currcon from low level drivers.

<jsimmons@infradead.org> (03/08/21 1.1153.1.96)
   [FBDEV] Sysfs support.

<jsimmons@maxwell.earthlink.net> (03/08/18 1.1153.6.4)
   [RIVA FBDEV] Finally cursor api is complete. A few bugs yet but now to start on other drivers.

<jsimmons@infradead.org> (03/08/15 1.1153.6.2)
   [TDFX FBDEV] Fixed Interlace. Only for Banshee interlace wasn't supported.
                Added Double scanline mode.
   	     Fixed the foreground color value for tdfxfb_fillrect. For Truecolor modes we have to map the to the proper color value 

<jsimmons@bohr.(none)> (03/08/11 1.1123.21.2)
   [NEOMAGIC FBDEV] Add going between graphics and VGA text mode. 

<jsimmons@host-193.int.pioneer-pra.com> (03/07/21 1.1046.416.32)
   [TDFX FBDEV] Fixes to make the image blitter work. Also the color handling code was fixed. 

<jsimmons@host-193.int.pioneer-pra.com> (03/07/15 1.1046.416.28)
   [FBCON] Always turn off the cursor in fbcon_cursor. The reason is that cursor might try to blink while we are reprogramming the hardware.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/11 1.1046.416.25)
   [IMSTT FBDEV] Free up resources when it fails.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/11 1.1046.416.24)
   [FBDEV] Makefiel cleanups.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/11 1.1046.416.23)
   [ASILIANT FBDEV] Added support for the asiliant graphics chipset.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/09 1.1046.416.18)
   [RIVA FBDEV] Support for more versions of GEFORCE 4. Also some cursor cleanup to allow it to compile.

<jsimmons@host-193.int.pioneer-pra.com> (03/07/08 1.1046.416.15)
   [SIS FBDEV] Updates to the SiS framebuffer driver. Add support for 760 chipset, LCD scaling.

<jsimmons@kozmo.(none)> (03/07/03 1.1046.416.12)
   [NEOMAGIC FBDEV] Fixed a nasty bug in the copyarea function. It wasn't testing for the condition when both regions have the same y coordinates but are over lapping. This casued a corrpution of data. Also started ot used the macros in vga.h.

<jsimmons@kozmo.(none)> (03/06/30 1.1046.416.7)
   [LOGO] Display the correct logo for MIPS DEC workstations.

<jsimmons@kozmo.(none)> (03/06/25 1.1046.416.1)
   [FBCON] Removed the crappy ROP_COPY/ROP_XOR test for flashing the cursor. Now we disable and enable the cursor timer instead.

<jsimmons@kozmo.(none)> (03/06/24 1.1046.1.192)
   [FBDEV] Now we can use a specific hardware mapper for different hardware functionality.

<jsimmons@kozmo.(none)> (03/06/23 1.1046.1.188)
   [VGA CORE] Added needed vmalloc header.

<jsimmons@kozmo.(none)> (03/06/23 1.1046.1.185)
   [FBCON] When using 512 characters, the mouse pointer starts using the wrong complement_mask after a console reset.

<jsimmons@kozmo.(none)> (03/06/23 1.1046.1.184)
   [FBDEV] Made chipsfb/controlfb/platinumfb use the xxfb kernel command line string.

<jsimmons@maxwell.earthlink.net> (03/06/18 1.1046.1.180)
   [MAC FBDEV] Bug fixes.

<jsimmons@maxwell.earthlink.net> (03/06/15 1.1046.1.176)
   [SIS FBDEV] More updates for the SIS driver. 

<jsimmons@maxwell.earthlink.net> (03/06/14 1.1046.1.174)
   [CONTROL/PLATINUM FBDEV] Fix to match change in fb_set_var.

<jsimmons@maxwell.earthlink.net> (03/06/10 1.1046.1.170)
   [FBDEV] Fixed a issue with soft_cursor. It only worked with drivers with a pixmap.scan_align of 1. Now it will work with any.

<jsimmons@kozmo.(none)> (03/06/07 1.1046.1.164)
   [SIS FBDEV] Fixed sysnc issue.

<jsimmons@kozmo.(none)> (03/06/05 1.1046.1.160)
   [FBCON] Cleared out the struct fb_cursor we passed in. Other wise we get random data being used.

<jsimmons@kozmo.(none)> (03/05/30 1.1046.1.155)
   [FBDEV GENERIC ACCEL] Fixed why logo was not displayed for some.

<jsimmons@maxwell.earthlink.net> (03/05/24 1.1046.155.3)
   [VALKYRUE FBDEV] Ported to new api.

<jsimmons@maxwell.earthlink.net> (03/05/23 1.1046.155.1)
   [FBDEV] Updates to explain the new cursor api.

<jsimmons@maxwell.earthlink.net> (03/05/23 1.1046.1.142)
   [EPSON FRAMEBUFFER] Ported to the new api. Added support for the arm platform.

<jsimmons@maxwell.earthlink.net> (03/05/15 1.1046.84.18)
   [SIS FBDEV] SIS Framebuffer updates.
                 - Added preliminary and untested support for SiS660
                 - Added DDC support
                 - Enhanced proprietary programming API for compatibility with X driver
                   and upcoming SDL updates and upcoming vidix driver for mplayer
                 - Fixes for video bridge output on various HW combinations
                 - Fixes in TV detection
                 - Reduced source size by removing duplicated data
                 - Updated Kconfig descriptions

<jsimmons@maxwell.earthlink.net> (03/05/14 1.1046.73.2)
   [PVR2 FBDEV] Port of the Dreamcast Frambuffer to the new api.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1046.7.19)
   [FBCON] set_con2fb_map wasn't testing to see the VC we where mapping to actually exist. Now it does. 
   
           I add code to fbcon_cursor to reset the hotspot if it was changed by userland. 

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1046.7.17)
   [RIVA FBDEV] Removal of exccess variable. Kills off a few warnings.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1046.7.16)
   [VESA FBDEV] Removed the EDID code. The results where mixed. It worked for some but not for others.

<jsimmons@maxwell.earthlink.net> (03/05/12 1.1046.7.15)
   [CONSOLE] This patch fixes the problem of not being able to set the fonts on VCs other than the first one. This also was the bug that was casuing dual head (vga and mda) to lock up.

<jsimmons@kozmo.(none)> (03/05/02 1.1042.122.2)
   [FBDEV] Synced to kdev_t change.

<jsimmons@kozmo.(none)> (03/04/22 1.1042.37.2)
   [FBDEV] Moved pixmap to the kernel side of the header. Will not be needed for ioctl calls at the present time.
   
   [FBCON] Lots more optimizations.

<jsimmons@kozmo.(none)> (03/04/21 1.1042.37.1)
   [LOGO] Removed fb_ prefix. Wil be used by other drivers such as the newport driver.
   
   [G354 FBDEV] Now use the final cursor api.


