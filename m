Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSFTSMP>; Thu, 20 Jun 2002 14:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSFTSMO>; Thu, 20 Jun 2002 14:12:14 -0400
Received: from www.transvirtual.com ([206.14.214.140]:23814 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315372AbSFTSMM>; Thu, 20 Jun 2002 14:12:12 -0400
Date: Thu, 20 Jun 2002 11:11:44 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: dhd@debian.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       Ani Joshi <ajoshi@shell.unixbox.com>
Subject: [UPDATES] fbdev ports and fixes
Message-ID: <Pine.LNX.4.44.0206201105200.16635-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  I managed to port over the RIVA framebuffer driver to the new api as
well as the Macintosh one. The RIVA driver has been tested on my system.
I also placed in BK the newest Voodoo1 driver. Another big change from
Franz Sirl and approved by BenH is the removal of the VC_IOCTL stuff on
the PPC platform. Please test these patches before I submit them.

Thank you.

Here is a diffstat of the changes:

 drivers/video/riva/accel.c                     |  427 -------
 fbdev-2.5/arch/i386/boot/video.S               |    4
 fbdev-2.5/drivers/char/vt.c                    |   66 -
 fbdev-2.5/drivers/video/Config.help            |   17
 fbdev-2.5/drivers/video/Config.in              |   68 -
 fbdev-2.5/drivers/video/Makefile               |    4
 fbdev-2.5/drivers/video/S3triofb.c             |   19
 fbdev-2.5/drivers/video/aty/atyfb_base.c       |   28
 fbdev-2.5/drivers/video/aty128fb.c             |   33
 fbdev-2.5/drivers/video/chipsfb.c              |   29
 fbdev-2.5/drivers/video/controlfb.c            |   21
 fbdev-2.5/drivers/video/fbcon-mac.c            |  483 --------
 fbdev-2.5/drivers/video/imsttfb.c              |   56
 fbdev-2.5/drivers/video/macfb.c                |  463 ++-----
 fbdev-2.5/drivers/video/macmodes.c             |  171 --
 fbdev-2.5/drivers/video/matrox/matroxfb_base.c |   27
 fbdev-2.5/drivers/video/matrox/matroxfb_base.h |    6
 fbdev-2.5/drivers/video/modedb.c               |    4
 fbdev-2.5/drivers/video/neofb.c                |    7
 fbdev-2.5/drivers/video/offb.c                 |   26
 fbdev-2.5/drivers/video/platinumfb.c           |   26
 fbdev-2.5/drivers/video/riva/Makefile          |    2
 fbdev-2.5/drivers/video/riva/fbdev.c           | 1500 +++++++++----------------
 fbdev-2.5/drivers/video/riva/riva_hw.c         |   38
 fbdev-2.5/drivers/video/riva/riva_hw.h         |    2
 fbdev-2.5/drivers/video/riva/riva_tbl.h        |  203 +--
 fbdev-2.5/drivers/video/riva/rivafb.h          |   60 -
 fbdev-2.5/drivers/video/sstfb.c                |  958 +++++++++------
 fbdev-2.5/drivers/video/sstfb.h                |   73 -
 fbdev-2.5/drivers/video/tdfxfb.c               |   55
 fbdev-2.5/drivers/video/valkyriefb.c           |   26
 fbdev-2.5/drivers/video/vesafb.c               |    8
 fbdev-2.5/include/asm-ppc/vc_ioctl.h           |   46
 fbdev-2.5/include/asm-ppc64/vc_ioctl.h         |   50
 fbdev-2.5/include/linux/pci_ids.h              |    1
 fbdev-2.5/include/linux/tty.h                  |    3
 36 files changed, 1516 insertions(+), 3494 deletions(-)

The URL to grab the diff is

http://www.transvirtual.com/~jsimmons/fbdev.diff.gz

and the BK link is

http://fbdev.bkbits.net:8080/fbdev-2.5

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/


