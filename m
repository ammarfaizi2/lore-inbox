Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWCXUTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWCXUTp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWCXUTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:19:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60825 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751417AbWCXUTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:19:45 -0500
Message-Id: <20060324192732.PS73189600000@infradead.org>
Date: Fri, 24 Mar 2006 16:27:32 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/29] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from v4l-dvb master branch at
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

There are some big patches here, since:

1) All v4l and dvb drivers are moving to a common place;
2) There were some architectural issues with the way V4L were handling
   audio input routing. These series separates user input selection from
   internal board connections;
3) A virtual v4l driver is introduced here to help v4l2 driver and applications
   development. This driver is being used to identify common V4L2 code that will
   be merged into v4l2 core, aiding major code cleanups.

Cheers,
Mauro.

git cherry:

+ f13ce9ccc53dcc82e369a4e9c5ea59ac2aa796c6 V4L/DVB (3516): Make video_buf more generic
+ 4dd1b9231623df6212bbf621aad99a43c9e73569 V4L/DVB (3518): Creates a virtual video device driver
+ a1afe2bf6f859250a1d1f2c85cb13150f1976b2a V4L/DVB (3519): Corrects MODULE_AUTHOR
+ 395ca7c0b4a94c7d4fd142b69be7099d51666b48 V4L/DVB (3539): Move bttv fragments to bt8xx/
+ af393067875bc7b86ee6edcf69f6b5352abddf05 V4L/DVB (3543): Fix Makefile to adapt to bt8xx/ conversion
+ adc36e3d5eae62207e8ca21f136aba1b90423dc3 V4L/DVB (3546): Fix Compilation after moving bttv code
+ 2ed9bd362904e73ed3e0f4a6806c3cc1365b300c V4L/DVB (3547): Tvaudio.h are just i2c addresses. Merged into i2c-addr.h
+ b2c8c613ccf3765598cd85c46c6f56aa04cf31f4 V4L/DVB (3548): Renamed I2C_foo addresses to I2C_ADDR_foo
+ 42581e5fe43224c87593c65ecc7395ff246fb476 V4L/DVB (3549): Make hotplug automatically load the b2c2-flexcop-usb module
+ baa7068cbd28fed794a66f2f156c08f48621ab0f V4L/DVB (3551): Fix saturation bug. Fix NTSC->PAL standard change. Detect NTSC-KR standard.
+ ae34cd1ad29248a63c07b3731cbbc7e81a297db5 V4L/DVB (3557): Kconfig: fix title and description for VIDEO_CX88_ALSA
+ 35132f201cda985497ddeab2761d6e69ad47a1cd V4L/DVB (3569): PATCH: switch cpia2 to mutexes and use ioctl 32 compat lib func
+ 19fa8ae1692d94584ed00c19ff9cb02d6a5031b0 V4L/DVB (3571): Printk warning fixes
+ 3681505e2df142fc0170196ef8b6b92f3e728e82 V4L/DVB (3572): Cxusb: conditionalize gpio write for the medion box
+ 9f76cd829406d0ae11712e472aa4768fdbe675f4 V4L/DVB (3573): Cxusb: remove FIXME: comment in bluebird_patch_dvico_firmware_download
+ 0b6c42f9f1edc7d4b8b1d33ab04d6ecf0a9f1097 V4L/DVB (3574): Cxusb: fix debug messages
+ 0934b4d869717d6bfb1a508b8faf94651276e2f4 V4L/DVB (3575): Cxusb: fix i2c debug messages for bluebird devices
+ 9ea7c07c57a6314da55cfe05e84a354d4ff33959 V4L/DVB (3577): Cleanup audio input handling
+ 9d32667cb31f8d17110af3fa98731b2c221d3d47 V4L/DVB (3578): Make scart definitions easier to handle
+ 118ad4cf90ea85d362399cec6d15867afb3d4c4e V4L/DVB (3579): Move msp_modus to msp3400-kthreads, add JP and KR std detection
+ 268b16ae75243fc2640f71107530d30ae79526f0 V4L/DVB (3580): Last round of msp3400 cleanups before adding routing commands
+ 019b38bd0ba5c497721ec55ae61cc066fa7f1c6d V4L/DVB (3581): Add new media/msp3400.h header containing the routing macros
+ 72d1f1c821f5d279cdf076a53565aeee096b6615 V4L/DVB (3582): Implement correct msp3400 input/output routing
+ 02ad0726e9722a474235ae171b03958e97c30b47 V4L/DVB (3584): Implement V4L2_TUNER_MODE_LANG1_LANG2 audio mode
+ 27a19f759c74adb4ddcbc4a551bc3b3ac4084403 V4L/DVB (3587): Always wake thread after routing change.
+ 588acc93e91c09c35a5bf92573bf76b2e9c84e67 V4L/DVB (3588): Remove VIDIOC_G/S_AUDOUT from msp3400
+ b21c564c94c5a0b6e7af9651bd72c843e89c5e42 V4L/DVB (3597): Vivi: fix warning: implicit declaration of function 'in_interrupt'
+ 78cbf3a4f55eddb5fd8cfab670076488dfb71577 V4L/DVB (3598): Add bit algorithm adapter for the Conexant CX2341X boards.
+ dfb171d4084c0c829eaa339fe042610cdad5710d V4L/DVB (3599): Implement new routing commands for wm8775 and cs53l32a.

V4L/DVB development is hosted at http://linuxtv.org
Development Mercurial trees are available at http://linuxtv.org/hg
---

 drivers/media/common/saa7146_fops.c           |    5 
 drivers/media/common/saa7146_vbi.c            |    8 
 drivers/media/common/saa7146_video.c          |    8 
 drivers/media/dvb/b2c2/flexcop-usb.c          |    1 
 drivers/media/dvb/bt8xx/Makefile              |    2 
 drivers/media/dvb/dvb-usb/cxusb.c             |   28 
 drivers/media/dvb/dvb-usb/cxusb.h             |    2 
 drivers/media/dvb/ttpci/av7110_v4l.c          |    5 
 drivers/media/video/Kconfig                   |   26 
 drivers/media/video/Makefile                  |    7 
 drivers/media/video/bt832.c                   |  266 
 drivers/media/video/bt832.h                   |  305 -
 drivers/media/video/bt848.h                   |  366 -
 drivers/media/video/bt8xx/Kconfig             |   25 
 drivers/media/video/bt8xx/Makefile            |   12 
 drivers/media/video/bt8xx/bt832.c             |  269 
 drivers/media/video/bt8xx/bt832.h             |  305 +
 drivers/media/video/bt8xx/bt848.h             |  366 +
 drivers/media/video/bt8xx/bttv-cards.c        | 5326 +++++++++++++++++-
 drivers/media/video/bt8xx/bttv-driver.c       | 4411 ++++++++++++++
 drivers/media/video/bt8xx/bttv-gpio.c         |  208 
 drivers/media/video/bt8xx/bttv-i2c.c          |  478 +
 drivers/media/video/bt8xx/bttv-if.c           |  159 
 drivers/media/video/bt8xx/bttv-input.c        |  450 +
 drivers/media/video/bt8xx/bttv-risc.c         |  795 ++
 drivers/media/video/bt8xx/bttv-vbi.c          |  221 
 drivers/media/video/bt8xx/bttv.h              |  430 +
 drivers/media/video/bt8xx/bttvp.h             |  415 +
 drivers/media/video/bttv-cards.c              | 5011 ----------------
 drivers/media/video/bttv-driver.c             | 4284 --------------
 drivers/media/video/bttv-gpio.c               |  208 
 drivers/media/video/bttv-i2c.c                |  474 -
 drivers/media/video/bttv-if.c                 |  159 
 drivers/media/video/bttv-input.c              |  450 -
 drivers/media/video/bttv-risc.c               |  799 --
 drivers/media/video/bttv-vbi.c                |  227 
 drivers/media/video/bttv.h                    |  407 -
 drivers/media/video/bttvp.h                   |  414 -
 drivers/media/video/cpia2/cpia2.h             |    2 
 drivers/media/video/cpia2/cpia2_core.c        |   40 
 drivers/media/video/cpia2/cpia2_v4l.c         |   43 
 drivers/media/video/cs53l32a.c                |   20 
 drivers/media/video/cx25840/cx25840-audio.c   |    1 
 drivers/media/video/cx25840/cx25840-core.c    |   51 
 drivers/media/video/cx88/Kconfig              |    5 
 drivers/media/video/cx88/cx88-alsa.c          |    4 
 drivers/media/video/cx88/cx88-blackbird.c     |    5 
 drivers/media/video/cx88/cx88-core.c          |    6 
 drivers/media/video/cx88/cx88-dvb.c           |    5 
 drivers/media/video/cx88/cx88-mpeg.c          |   28 
 drivers/media/video/cx88/cx88-tvaudio.c       |    3 
 drivers/media/video/cx88/cx88-vbi.c           |    7 
 drivers/media/video/cx88/cx88-video.c         |   35 
 drivers/media/video/cx88/cx88.h               |    7 
 drivers/media/video/em28xx/em28xx-cards.c     |    9 
 drivers/media/video/em28xx/em28xx-video.c     |    8 
 drivers/media/video/font.h                    |  407 +
 drivers/media/video/msp3400-driver.c          |  279 
 drivers/media/video/msp3400-driver.h          |  117 
 drivers/media/video/msp3400-kthreads.c        |  345 -
 drivers/media/video/msp3400.h                 |  133 
 drivers/media/video/mxb.c                     |   12 
 drivers/media/video/rds.h                     |   48 
 drivers/media/video/saa6588.c                 |    2 
 drivers/media/video/saa7115.c                 |    1 
 drivers/media/video/saa7134/saa7134-alsa.c    |   10 
 drivers/media/video/saa7134/saa7134-core.c    |    6 
 drivers/media/video/saa7134/saa7134-oss.c     |    6 
 drivers/media/video/saa7134/saa7134-ts.c      |    9 
 drivers/media/video/saa7134/saa7134-tvaudio.c |    2 
 drivers/media/video/saa7134/saa7134-vbi.c     |   10 
 drivers/media/video/saa7134/saa7134-video.c   |    9 
 drivers/media/video/saa7134/saa7134.h         |    3 
 drivers/media/video/tda7432.c                 |    5 
 drivers/media/video/tda9840.c                 |    2 
 drivers/media/video/tda9840.h                 |    2 
 drivers/media/video/tda9875.c                 |    9 
 drivers/media/video/tea6420.c                 |    2 
 drivers/media/video/tea6420.h                 |    4 
 drivers/media/video/tuner-core.c              |    1 
 drivers/media/video/tvaudio.c                 |  154 
 drivers/media/video/tvaudio.h                 |   14 
 drivers/media/video/tveeprom.c                |   30 
 drivers/media/video/v4l2-common.c             |   42 
 drivers/media/video/video-buf.c               |  250 
 drivers/media/video/vivi.c                    | 1456 ++++
 drivers/media/video/wm8775.c                  |   20 
 include/linux/i2c-id.h                        |    1 
 include/linux/videodev2.h                     |    1 
 include/media/audiochip.h                     |   14 
 include/media/cs53l32a.h                      |   34 
 include/media/i2c-addr.h                      |  102 
 include/media/msp3400.h                       |  226 
 include/media/rds.h                           |   44 
 include/media/saa7146_vv.h                    |    3 
 include/media/tvaudio.h                       |   30 
 include/media/v4l2-common.h                   |   19 
 include/media/video-buf.h                     |   56 
 include/media/wm8775.h                        |   35 
 99 files changed, 17015 insertions(+), 14551 deletions(-)

