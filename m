Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSGHVVY>; Mon, 8 Jul 2002 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSGHVVX>; Mon, 8 Jul 2002 17:21:23 -0400
Received: from www.transvirtual.com ([206.14.214.140]:36623 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317165AbSGHVVW>; Mon, 8 Jul 2002 17:21:22 -0400
Date: Mon, 8 Jul 2002 14:23:52 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev updates.
Message-ID: <Pine.LNX.4.44.0207081420020.7699-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the updates to the fbdev layer. I removed a few driver
modification for the authors that requested. Please note I removed th eold
fbgen code. It will break some drivers. They are responsible for updating
the drivers. Here are changes against the latest Linus BK tree.

Updates to several drivers form the m68k platform and removal of the PPC
VT excess code.

 Documentation/fb/README-sstfb.txt        |   87 +
 arch/i386/boot/compressed/vmlinux.bin.gz |binary
 arch/ppc/Config.help                     |    6
 arch/ppc/config.in                       |    3
 drivers/char/vt.c                        |   66 -
 drivers/video/Config.help                |   22
 drivers/video/Config.in                  |   80 -
 drivers/video/Makefile                   |   15
 drivers/video/S3triofb.c                 |   19
 drivers/video/amifb.c                    |   81 -
 drivers/video/atafb.c                    |  376 ++++----
 drivers/video/aty/atyfb.h                |   18
 drivers/video/aty/atyfb_base.c           |  348 ++-----
 drivers/video/aty/mach64.h               | 1158 -------------------------
 drivers/video/aty/mach64_accel.c         |    2
 drivers/video/aty/mach64_ct.c            |    4
 drivers/video/aty/mach64_cursor.c        |   12
 drivers/video/aty/mach64_gx.c            |    2
 drivers/video/aty128.h                   |  352 -------
 drivers/video/aty128fb.c                 |   32
 drivers/video/chipsfb.c                  |   29
 drivers/video/controlfb.c                |   21
 drivers/video/dnfb.c                     |   19
 drivers/video/fbcon-mac.c                |  483 ----------
 drivers/video/fbcon-vga.c                |  213 ----
 drivers/video/fbgen.c                    |  347 -------
 drivers/video/fbmem.c                    |    2
 drivers/video/fm2fb.c                    |    3
 drivers/video/fonts.c                    |    4
 drivers/video/hpfb.c                     |    3
 drivers/video/imsttfb.c                  |   56 -
 drivers/video/macfb.c                    |  463 ++--------
 drivers/video/macmodes.c                 |  171 ---
 drivers/video/matrox/matroxfb_base.c     |   27
 drivers/video/matrox/matroxfb_base.h     |    6
 drivers/video/modedb.c                   |    4
 drivers/video/neofb.c                    |    7
 drivers/video/offb.c                     | 1130 +++++++++---------------
 drivers/video/platinumfb.c               |   26
 drivers/video/q40fb.c                    |    8
 drivers/video/retz3fb.c                  |    4
 drivers/video/sgivwfb.c                  | 1432 +++++++++++++------------------
 drivers/video/sgivwfb.h                  |  660 --------------
 drivers/video/sstfb.c                    |  958 +++++++++++---------
 drivers/video/sstfb.h                    |   73 +
 drivers/video/tdfxfb.c                   |   55 -
 drivers/video/tx3912fb.c                 |    2
 drivers/video/valkyriefb.c               |   26
 drivers/video/vesafb.c                   |   12
 drivers/video/vfb.c                      |    4
 include/asm-ppc/vc_ioctl.h               |   46
 include/asm-ppc64/vc_ioctl.h             |   50 -
 include/linux/pci_ids.h                  |    1
 include/linux/tty.h                      |    3
 include/video/aty128.h                   |  419 +++++++++
 include/video/mach64.h                   | 1158 +++++++++++++++++++++++++
 include/video/sgivw.h                    |  660 ++++++++++++++
 58 files changed, 4571 insertions(+), 6697 deletions(-)

BK:
   http://fbdev-2.5.bkbits.net/fbdev-2.5

diff:

   http://www.transvirtual.com/~jsimmons/fbdev.diff.gz

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/




