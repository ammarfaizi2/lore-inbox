Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSGARqY>; Mon, 1 Jul 2002 13:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSGARqX>; Mon, 1 Jul 2002 13:46:23 -0400
Received: from www.transvirtual.com ([206.14.214.140]:60177 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315946AbSGARqT>; Mon, 1 Jul 2002 13:46:19 -0400
Date: Mon, 1 Jul 2002 10:48:41 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] fbdev updates.
Message-ID: <Pine.LNX.4.44.0207011041320.23794-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here are the latest updates to the framebuffer layer. Please test it outso
I can push it as soon as possible to Linus. Here is what has changes. The
* are tested drivers. As a note there are a few issues with a few of the
drivers but time is running out so I need to push the changes then fix any
remaining bugs. Links to the chnages are:

BK:            http://www.fbdev.bkbits.net/fbdev-2.5

diff:		http://www.transvirtual.com/~jsimmons/fbdev.diff.gz


P.S
       Note I removed the old fbgen stuff so some drivers are going to
break. Well with time running out I need to push ahead. Sorry but I have
to choose.


 Documentation/fb/README-sstfb.txt     |   87
 arch/i386/boot/video.S                |    4    *
 arch/ppc/Config.help                  |    6
 arch/ppc/config.in                    |    3
 drivers/char/vt.c                     |   66    *
 drivers/video/Config.help             |   22    *
 drivers/video/Config.in               |   80    *
 drivers/video/Makefile                |   15    *
 drivers/video/S3triofb.c              |   19
 drivers/video/acornfb.c               |    3
 drivers/video/amifb.c                 |   81
 drivers/video/atafb.c                 |  376 ++-
 drivers/video/aty/atyfb.h             |   18               *
 drivers/video/aty/atyfb_base.c        |  348 +--           *
 drivers/video/aty/mach64.h            | 1158 ------------  *
 drivers/video/aty/mach64_accel.c      |    2               *
 drivers/video/aty/mach64_ct.c         |    4 		    *
 drivers/video/aty/mach64_cursor.c     |   12               *
 drivers/video/aty/mach64_gx.c         |    2 		    *
 drivers/video/aty128.h                |  352 ---	    *
 drivers/video/aty128fb.c              | 3272
++++++++++++++-------------------- *
 drivers/video/chipsfb.c               |   29
 drivers/video/controlfb.c             |   21
 drivers/video/dnfb.c                  |   19
 drivers/video/fbcon-mac.c             |  483 -----
 drivers/video/fbcon-vga.c             |  213 --
 drivers/video/fbcon.c                 |    2                	*
 drivers/video/fbgen.c                 |  347 ---		*
 drivers/video/fbmem.c                 |    2 			*
 drivers/video/fm2fb.c                 |    3
 drivers/video/fonts.c                 |    4
 drivers/video/hpfb.c                  |    3
 drivers/video/imsttfb.c               |   56
 drivers/video/macfb.c                 |  463 +---
 drivers/video/macmodes.c              |  171 -
 drivers/video/matrox/matroxfb_base.c  |   43
 drivers/video/matrox/matroxfb_base.h  |    6
 drivers/video/matrox/matroxfb_crtc2.c |   19
 drivers/video/modedb.c                |    4
 drivers/video/neofb.c                 |    7 			*
 drivers/video/offb.c                  | 1130 ++++-------
 drivers/video/platinumfb.c            |   26
 drivers/video/q40fb.c                 |    8
 drivers/video/retz3fb.c               |    4
 drivers/video/riva/Makefile           |    2 			*
 drivers/video/riva/accel.c            |  427 ----		*
 drivers/video/riva/fbdev.c            | 1531 ++++++---------	*
 drivers/video/riva/riva_hw.c          |   38 			*
 drivers/video/riva/riva_hw.h          |    2 			*
 drivers/video/riva/rivafb.h           |   60 			*
 drivers/video/sa1100fb.c              |  813 ++------		*
 drivers/video/sa1100fb.h              |   17 			*
 drivers/video/sgivwfb.c               | 1432 ++++++--------
 drivers/video/sgivwfb.h               |  660 ------
 drivers/video/sstfb.c                 |  958 +++++----
 drivers/video/sstfb.h                 |   73
 drivers/video/tdfxfb.c                |   55 			*
 drivers/video/tx3912fb.c              |    2
 drivers/video/valkyriefb.c            |   26
 drivers/video/vesafb.c                |   12 			*
 drivers/video/vfb.c                   |    4
 include/asm-ppc/vc_ioctl.h            |   46
 include/asm-ppc64/vc_ioctl.h          |   50
 include/linux/fb.h                    |   52
 include/linux/pci_ids.h               |    1
 include/linux/tty.h                   |    3
 include/video/aty128.h                |  419 ++++
 include/video/mach64.h                | 1158 ++++++++++++
 include/video/sgivw.h                 |  660 ++++++
 70 files changed, 6886 insertions(+), 10608 deletions(-)

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

