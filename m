Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbTC0AHq>; Wed, 26 Mar 2003 19:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbTC0AHq>; Wed, 26 Mar 2003 19:07:46 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:26376 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262685AbTC0AHp>; Wed, 26 Mar 2003 19:07:45 -0500
Date: Thu, 27 Mar 2003 00:18:57 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Much better framebuffer fixes.
Message-ID: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay. Here are more framebuffer fixes. Please try these fixes and let me 
know how they work out for you.

The diff is at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 Documentation/devices.txt       |    7 -
 arch/ppc/syslib/prom_init.c     |    2 
 drivers/video/aty/aty128fb.c    |   16 +-
 drivers/video/cfbimgblt.c       |    4 
 drivers/video/console/fbcon.c   |  246 +++++++++++++++++++++-------------------
 drivers/video/controlfb.c       |   18 --
 drivers/video/fbmem.c           |   76 ++++--------
 drivers/video/i810/i810.h       |    6 
 drivers/video/i810/i810_accel.c |  140 +++++++++++-----------
 drivers/video/i810/i810_dvt.c   |    3 
 drivers/video/i810/i810_gtf.c   |    7 -
 drivers/video/i810/i810_main.c  |  135 +++++++++------------
 drivers/video/i810/i810_main.h  |    4 
 drivers/video/logo/logo.c       |   69 +++++------
 drivers/video/platinumfb.c      |   28 +---
 drivers/video/radeonfb.c        |   10 +
 drivers/video/riva/fbdev.c      |    2 
 drivers/video/softcursor.c      |   95 ++++-----------
 drivers/video/tdfxfb.c          |   18 +-
 drivers/video/tgafb.c           |    2 
 drivers/video/vga16fb.c         |    4 
 include/linux/fb.h              |    4 
 include/linux/linux_logo.h      |    2 
 23 files changed, 403 insertions(+), 495 deletions(-)

