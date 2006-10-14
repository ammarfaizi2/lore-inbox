Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWJNMLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWJNMLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWJNMLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:11:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8909 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932186AbWJNMIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:08:01 -0400
Message-Id: <20061014115356.PS36551000000@infradead.org>
Date: Sat, 14 Oct 2006 08:53:56 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/18] V4L/DVB fixes
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 'master' from:
        git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master

It contains the following:

   - Add WinTV-HVR3000 DVB-T support
   - Fix vivi compile on parisc
   - Support status readout for saa713x based FM radio
   - Fix VIDIOC_G_FMT for NTSC in cx25840.
   - Kconfig: restore pvrusb2 menu items
   - Fix spelling error in Kconfig help text for DVB_CORE_ATTACH
   - Tda10086: fix frontend selection for dvb_attach
   - Tda826x: fix frontend selection for dvb_attach
   - Bt8xx/dvb-bt8xx.c: check kmalloc() return value.
   - SECAM support for saa7113 into saa7115
   - Fixed an if-block to avoid floating with debug-messages
   - {ov511,stv680}: handle sysfs errors
   - Drivers/media/video: handle sysfs errors
   - Fix oops in VIDIOC_G_PARM
   - The Samsung TCPN2121P30A does not have a tda9887
   - HM12 is YUV 4:2:0, not YUV 4:1:1
   - Fixed oops for Nova-T USB2
   - AGC command1/2 is board specific

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/video4linux/CARDLIST.cx88      |    2 -
 drivers/media/dvb/bt8xx/dvb-bt8xx.c          |    4 +
 drivers/media/dvb/dvb-core/Kconfig           |    2 -
 drivers/media/dvb/dvb-usb/dibusb-common.c    |   11 +++-
 drivers/media/dvb/dvb-usb/dibusb.h           |    2 +
 drivers/media/dvb/dvb-usb/nova-t-usb2.c      |    3 +
 drivers/media/dvb/frontends/dib3000mc.c      |    2 -
 drivers/media/dvb/frontends/dib3000mc.h      |    3 +
 drivers/media/dvb/frontends/tda10086.h       |    9 +++
 drivers/media/dvb/frontends/tda826x.h        |   19 ++++++-
 drivers/media/video/Kconfig                  |    2 +
 drivers/media/video/cx25840/cx25840-vbi.c    |   25 +++++++--
 drivers/media/video/cx88/cx88-cards.c        |   21 ++++++++
 drivers/media/video/cx88/cx88-dvb.c          |   17 ++++++
 drivers/media/video/cx88/cx88-input.c        |    2 +
 drivers/media/video/et61x251/et61x251_core.c |   37 +++++++++++---
 drivers/media/video/ov511.c                  |   58 +++++++++++++++++----
 drivers/media/video/pwc/pwc-if.c             |   41 ++++++++++++---
 drivers/media/video/saa7115.c                |    2 +
 drivers/media/video/saa7134/saa7134-video.c  |    6 ++
 drivers/media/video/sn9c102/sn9c102_core.c   |   71 ++++++++++++++++++++------
 drivers/media/video/stv680.c                 |   53 ++++++++++++++++---
 drivers/media/video/tuner-types.c            |    1 
 drivers/media/video/videodev.c               |   16 ++++--
 drivers/media/video/vivi.c                   |   12 ++--
 include/linux/videodev2.h                    |    2 -
 26 files changed, 342 insertions(+), 81 deletions(-)

