Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSHBObM>; Fri, 2 Aug 2002 10:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSHBObM>; Fri, 2 Aug 2002 10:31:12 -0400
Received: from www.transvirtual.com ([206.14.214.140]:12814 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S314938AbSHBObL>; Fri, 2 Aug 2002 10:31:11 -0400
Date: Fri, 2 Aug 2002 07:34:38 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] console fixes and updates.
Message-ID: <Pine.LNX.4.44.0208020732430.8182-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch brings the console system up to date with the DJ tree. Still
more to come. It fixes several bugs including the devfs one. Please apply.

http://linuxconsole.bkbits.net/dev

 arch/mips/au1000/common/serial.c |    2
 arch/parisc/kernel/pdc_cons.c    |    3
 arch/ppc/4xx_io/serial_sicc.c    |    2
 arch/ppc/8xx_io/uart.c           |    2
 arch/ppc64/kernel/ioctl32.c      |   64
 arch/sparc64/kernel/ioctl32.c    |   23
 arch/x86_64/ia32/ia32_ioctl.c    |   20
 drivers/char/Makefile            |   12
 drivers/char/console.c           | 3032 ---------------------------------------
 drivers/char/console_macros.h    |  161 +-
 drivers/char/consolemap.c        |  136 -
 drivers/char/decvte.c            | 2054 ++++++++++++++++++++++++++
 drivers/char/hvc_console.c       |    2
 drivers/char/keyboard.c          |  605 ++++---
 drivers/char/misc.c              |    1
 drivers/char/selection.c         |   63
 drivers/char/sysrq.c             |   22
 drivers/char/tty_io.c            |    7
 drivers/char/vc_screen.c         |  115 +
 drivers/char/vt.c                | 2756 +++++++++++++++++++++--------------
 drivers/char/vt_ioctl.c          | 1441 ++++++++++++++++++
 drivers/s390/char/ctrlchar.c     |    2
 drivers/tc/zs.c                  |    2
 drivers/video/dummycon.c         |    1
 drivers/video/fbcon.c            |   55
 drivers/video/mdacon.c           |   21
 drivers/video/newport_con.c      |    1
 drivers/video/promcon.c          |   33
 drivers/video/sticon-bmode.c     |    2
 drivers/video/sticon.c           |    3
 drivers/video/vgacon.c           |   21
 include/linux/console.h          |   17
 include/linux/console_struct.h   |  110 -
 include/linux/consolemap.h       |    6
 include/linux/kbd_kern.h         |   27
 include/linux/selection.h        |   23
 include/linux/tty.h              |    8
 include/linux/vt_kern.h          |  275 ++-
 include/video/fbcon.h            |    2
 39 files changed, 6214 insertions(+), 4918 deletions(-)

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

