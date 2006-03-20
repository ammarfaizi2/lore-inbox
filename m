Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbWCTPoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbWCTPoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWCTPWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:22:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49122 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965266AbWCTPVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:52 -0500
Message-Id: <20060320150819.PS760228000000@infradead.org>
Date: Mon, 20 Mar 2006 12:08:19 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 000/141] V4L/DVB updates part 1
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is also available under v4l-dvb.git tree at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

Linus, please pull these from master branch.

It contains the following stuff:

   - Add PCI ID for DigitalNow DVB-T Dual, rebranded DViCO FusionHDTV DVB-T Dual.
   - Hauppauge Grey Remote support
   - Move all IR keymaps to ir-common module
   - Remove duplicated keymaps and add keymap for KWorld LTV883IR.
   - Fix handling of VIDIOC_G_TUNER audmode in msp3400
   - Add probe check for the tda9840.
   - VIDEO_CX88_ALSA must select SND_PCM
   - Fixes tvp5150a/am1 detection.
   - Added credits for em28xx-video.c
   - added some code for VBI processing and cleanup debug dump
   - Included new sliced VBI types to videodev2.h and tvp5150
   - Mark Typhoon cards as Lifeview OEM's
   - Implemented sliced VBI set on VIDIOC_S_FMT
   - group dvb-bt8xx Subsystem ID's together, in order.
   - Kill nxt2002 in favor of the nxt200x module
   - rename dvb_pll_tbmv30111in to dvb_pll_samsung_tbmv
   - Recognise Hauppauge card #34519
   - make VP-3054 Secondary I2C Bus Support a Kconfig option.
   - Cause tda9887 to use I2C_DRIVERID_TDA9887
   - added some VBI macros and moved minor definitions to header file
   - Added iocls to configure VBI on tvp5150
   - Several fixes to prepare for VBI
   - Implemented VIDIOC_G_FMT/S_FMT for sliced VBI
   - CodingStyle fixes.
   - audmode and rxsubchans fixes (VIDIOC_G/S_TUNER)
   - drivers/media/dvb/ possible cleanups
   - Missing break statement on tuner-core
   - Add new internal VIDIOC_INT commands
   - fixed spelling error, exectuted --> executed.
   - Hauppauge HVR 900 Composite support
   - Fix printk type warning
   - changed comment in tuner-core.c
   - rename cb variable names in tuner structures for global consistency
   - move config byte from tuner_params to tuner_range struct.
   - removed duplicated tuner_ranges
   - media video stradis memory fix
   - Allow tristate build for cx88-vp3054-i2c
   - Alters MAINTAINERS file to point to newer v4l-dvb email
   - Add count to tunertype struct
   - Fix NICAM buzz on analog sound
   - Add support for the Avermedia 777 DVB-T card
   - Move video std detection to top of set_tv_freq function
   - Allow multiple tuner params in each tuner definition
   - Tuner_dbg will show tuner param and range selected
   - Update tuner comments
   - Allow SAA7134 to fall back to AM sound when there is NICAM-L
   - Added terratec hybrid xs and kworld 2800rf support
   - Use default tuner_params if desired_type not available
   - Show debug for tuners trying to use unsupported video standards
   - Changed description of KWorld PVR TV 2800RF
   - Added signal detection support to tvp5150
   - Fix [Bug 5895] to correct snd_87x autodetect
   - Add IR support to KWorld DVB-T (cx22702-based)
   - Kconfig: DVB_USB_CXUSB depends on DVB_LGDT330X and DVB_MT352
   - Add standard for South Korean NTSC-M using A2 audio.
   - Added support for the LifeView FlyDVB-T LR301 card
   - TDA8290 update
   - TDA10046 Driver update
   - Added support for the ADS Instant TV DUO Cardbus PTV331
   - Fixed i2c return value, conversion mdelay to msleep
   - Support for Galaxis DVB-S rev1.3
   - Use parallel transport for FusionHDTV Dual Digital USB
   - Use MT352 parallel transport function for all Bluebird FusionHDTV DVB-T boxes.
   - FIX: Multiple usage of VP7045-based devices
   - FIX: Check if FW was downloaded or not + new firmware file
   - Fixed em28xx based system lockup 
   - Added support for the Tevion DVB-T 220RF card
   - Add initial support for KWorld HardwareMpegTV XPert
   - Makes Some symbols static.
   - sem2mutex: drivers/media/, #2
   - fix saa7146 kobject register failure
   - DVB: remove the at76c651/tda80xx frontends
   - Fix Samsung tuner frequency ranges
   - Disabled debug on by default in tvp5150
   - Adding support for Terratec Prodigy XS
   - Removing personal email from DVB maintainers
   - .gitignore should also ignore StGit generated dirs
   - Added support for xc3028 analogue tuner  (Hauppauge HVR900, Terratec Hybrid XS)
   - Fixed xc3028 firmware extractor, added terratec fw support
   - Fixed amux hauppauge hvr900/terratec hybrid xs
   - XC3028 code marked with an special define option
   - Added ET61X251 fourcc type
   - Fix in-kernel build
   - Bt8xx documentation authors fix
   - Drivers/media/dvb/frontends/mt312.c: cleanups
   - Make a struct static
   - Upstream sync - make 2 structs static
   - KWorld HardwareMpegTV XPert: Add radio support
   - KWorld HardwareMpegTV XPert must set gpio2
   - Add saa713x card: ELSA EX-VISION 700TV (saa7130)
   - Pinnacle PCTV 40i: add filtered Composite2 input
   - Fixed saa7134 ALSA initialization with multiple cards
   - Remote control codes for BTTV_BOARD_CONTVFMI
   - Cxusb: fix lgdt3303 naming
   - Fix maximum for the saturation and contrast controls.
   - Add support for Kworld ATSC110
   - KWorld ATSC110: implement set_pll_input
   - Kworld ATSC110: enable composite and svideo inputs
   - Kworld ATSC110: cleanups
   - Kworld ATSC110: initialize the tuner for analog mode on module load
   - KWorld HardwareMpegTV XPert: update comments
   - LifeView FlyDVB-T Duo: add support for remote control
   - Add debug to ioctl arguments.
   - Fix a small bug when constructing fps and line numbers
   - Debug messages for ioctl improved
   - Adds debuging v4l2_memory enum
   - Add AUDIO_GET_PTS and VIDEO_GET_PTS ioctls
   - Add cpia2 camera support
   - Support for Satelco EasyWatch DVB-S light
   - Restore power on defaults of tda9887 after tda8290 probe
   - TUV1236d: declare buffer as static const
   - Fix stv0297 for qam128 on tt c1500 (saa7146)
   - Dvb: fix __init/__exit section references in av7110 driver
   - Dvb-core: remove dead code
   - Ignore DiSEqC messages > 6 and < 3
   - Fix broken IF-OUT Relay handling
   - Fix module parameters
   - Documentation update
   - Do a RESYNC for all cards
   - XC3028 code removed from -git versions
   - Cx88: reduce excessive logging
   - Bttv: correct bttv_risc_packed buffer size
   - Fixed Pinnacle 300i DVB-T support
   - Add DVB-T support for the LifeView DVB Trio PCI card
   - ELSA EX-VISION 700TV: fix incorrect PCI subsystem ID
   - ELSA EX-VISION 500TV: fix incorrect PCI subsystem ID
   - IR keymaps are exported by the ir-common module now
   - cpia2/cpia2_v4l.c cleanups
   - Fixes for Lifeview Trio non fatal bugs
   - Coding style fixes in saa7134-dvb.c
   - Workaround to fix initialization for Nexus CA
   - Refactored LNBP21 and BSBE1 support
   - TechnoTrend S-1500 card handling moved from budget.c to budget-ci.c
   - Use refactored LNBP21 and BSBE1 code
   - DViCO FusionHDTV DVB-T Hybrid and ZL10353-based FusionHDTV DVB-T Plus support
   - Kconfig: fix in-kernel build for cx88-dvb: zl10353 frontend
   - Move DViCO hybrid initialisation data from stack.
   - FE6600 is a Thomson tuner
   - Typos grab bag of the month
   - Saa7134: document that there's also a 220RF from KWorld
   - Msp3400-kthreads.c: make 3 functions static

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
Development Mercurial trees are available at http://linuxtv.org/hg
---

 .gitignore                                        |    2 
 Documentation/dvb/avermedia.txt                   |   10 
 Documentation/dvb/bt8xx.txt                       |    6 
 Documentation/dvb/get_dvb_firmware                |   23 
 Documentation/dvb/readme.txt                      |   32 
 Documentation/video4linux/CARDLIST.cx88           |    4 
 Documentation/video4linux/CARDLIST.em28xx         |    3 
 Documentation/video4linux/CARDLIST.saa7134        |   22 
 Documentation/video4linux/CARDLIST.tuner          |    4 
 Documentation/video4linux/README.cpia2            |  132 
 Documentation/video4linux/cpia2_overview.txt      |   38 
 MAINTAINERS                                       |   12 
 drivers/media/common/Makefile                     |    1 
 drivers/media/common/ir-common.c                  |  519 --
 drivers/media/common/ir-functions.c               |  272 +
 drivers/media/common/ir-keymaps.c                 | 1731 ++++++++-
 drivers/media/common/saa7146_core.c               |    6 
 drivers/media/common/saa7146_fops.c               |   18 
 drivers/media/common/saa7146_i2c.c                |    4 
 drivers/media/common/saa7146_vbi.c                |    2 
 drivers/media/common/saa7146_video.c              |   30 
 drivers/media/dvb/b2c2/Kconfig                    |    2 
 drivers/media/dvb/b2c2/flexcop-common.h           |    6 
 drivers/media/dvb/b2c2/flexcop-dma.c              |   35 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c         |   13 
 drivers/media/dvb/b2c2/flexcop-i2c.c              |    6 
 drivers/media/dvb/b2c2/flexcop-misc.c             |    6 
 drivers/media/dvb/b2c2/flexcop-pci.c              |    6 
 drivers/media/dvb/b2c2/flexcop-reg.h              |    4 
 drivers/media/dvb/bt8xx/bt878.c                   |   50 
 drivers/media/dvb/bt8xx/bt878.h                   |   21 
 drivers/media/dvb/bt8xx/dst.c                     |   16 
 drivers/media/dvb/bt8xx/dst_ca.c                  |    6 
 drivers/media/dvb/bt8xx/dst_common.h              |    3 
 drivers/media/dvb/bt8xx/dvb-bt8xx.c               |   47 
 drivers/media/dvb/bt8xx/dvb-bt8xx.h               |    3 
 drivers/media/dvb/cinergyT2/cinergyT2.c           |   47 
 drivers/media/dvb/dvb-core/demux.h                |    2 
 drivers/media/dvb/dvb-core/dmxdev.c               |  105 
 drivers/media/dvb/dvb-core/dmxdev.h               |   14 
 drivers/media/dvb/dvb-core/dvb_demux.c            |  104 
 drivers/media/dvb/dvb-core/dvb_demux.h            |    4 
 drivers/media/dvb/dvb-core/dvb_frontend.c         |   21 
 drivers/media/dvb/dvb-core/dvb_frontend.h         |    1 
 drivers/media/dvb/dvb-core/dvb_net.c              |   14 
 drivers/media/dvb/dvb-usb/Kconfig                 |   12 
 drivers/media/dvb/dvb-usb/cxusb.c                 |   24 
 drivers/media/dvb/dvb-usb/dibusb-common.c         |    4 
 drivers/media/dvb/dvb-usb/digitv.c                |   17 
 drivers/media/dvb/dvb-usb/dvb-usb-firmware.c      |    8 
 drivers/media/dvb/dvb-usb/dvb-usb-init.c          |    6 
 drivers/media/dvb/dvb-usb/dvb-usb-urb.c           |    4 
 drivers/media/dvb/dvb-usb/dvb-usb.h               |   12 
 drivers/media/dvb/dvb-usb/vp702x.c                |   10 
 drivers/media/dvb/dvb-usb/vp702x.h                |    2 
 drivers/media/dvb/dvb-usb/vp7045-fe.c             |    6 
 drivers/media/dvb/dvb-usb/vp7045.c                |    4 
 drivers/media/dvb/frontends/Kconfig               |   32 
 drivers/media/dvb/frontends/Makefile              |    4 
 drivers/media/dvb/frontends/at76c651.c            |  450 --
 drivers/media/dvb/frontends/at76c651.h            |   47 
 drivers/media/dvb/frontends/bcm3510.c             |    9 
 drivers/media/dvb/frontends/bsbe1.h               |  123 
 drivers/media/dvb/frontends/cx24110.c             |   13 
 drivers/media/dvb/frontends/cx24110.h             |    1 
 drivers/media/dvb/frontends/dvb-pll.c             |   75 
 drivers/media/dvb/frontends/dvb-pll.h             |   11 
 drivers/media/dvb/frontends/lnbp21.h              |  139 
 drivers/media/dvb/frontends/mt312.c               |  116 
 drivers/media/dvb/frontends/mt312.h               |    6 
 drivers/media/dvb/frontends/nxt2002.c             |  706 ---
 drivers/media/dvb/frontends/nxt2002.h             |   23 
 drivers/media/dvb/frontends/nxt200x.c             |   58 
 drivers/media/dvb/frontends/stv0297.c             |    4 
 drivers/media/dvb/frontends/tda1004x.c            |   25 
 drivers/media/dvb/frontends/tda1004x.h            |    3 
 drivers/media/dvb/frontends/tda80xx.c             |  734 ----
 drivers/media/dvb/frontends/tda80xx.h             |   51 
 drivers/media/dvb/frontends/zl10353.c             |  311 +
 drivers/media/dvb/frontends/zl10353.h             |   43 
 drivers/media/dvb/frontends/zl10353_priv.h        |   42 
 drivers/media/dvb/ttpci/av7110.c                  |  160 
 drivers/media/dvb/ttpci/av7110.h                  |    9 
 drivers/media/dvb/ttpci/av7110_hw.c               |   43 
 drivers/media/dvb/ttpci/av7110_ir.c               |   30 
 drivers/media/dvb/ttpci/budget-av.c               |    4 
 drivers/media/dvb/ttpci/budget-ci.c               |   18 
 drivers/media/dvb/ttpci/budget.c                  |  156 
 drivers/media/dvb/ttpci/budget.h                  |    4 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   32 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |   31 
 drivers/media/radio/miropcm20-rds-core.c          |   11 
 drivers/media/radio/radio-aimslab.c               |   20 
 drivers/media/radio/radio-aztech.c                |   12 
 drivers/media/radio/radio-maestro.c               |   11 
 drivers/media/radio/radio-maxiradio.c             |   11 
 drivers/media/radio/radio-sf16fmi.c               |   22 
 drivers/media/radio/radio-sf16fmr2.c              |   22 
 drivers/media/radio/radio-typhoon.c               |   12 
 drivers/media/radio/radio-zoltrix.c               |   26 
 drivers/media/video/Kconfig                       |   10 
 drivers/media/video/Makefile                      |    5 
 drivers/media/video/arv.c                         |   16 
 drivers/media/video/bttv-cards.c                  |    6 
 drivers/media/video/bttv-driver.c                 |   50 
 drivers/media/video/bttv-input.c                  |  248 -
 drivers/media/video/bttv-risc.c                   |   12 
 drivers/media/video/bw-qcam.c                     |   16 
 drivers/media/video/bw-qcam.h                     |    2 
 drivers/media/video/c-qcam.c                      |   19 
 drivers/media/video/cpia.c                        |  104 
 drivers/media/video/cpia.h                        |    5 
 drivers/media/video/cpia2/Makefile                |    3 
 drivers/media/video/cpia2/cpia2.h                 |  497 ++
 drivers/media/video/cpia2/cpia2_core.c            | 2525 ++++++++++++++
 drivers/media/video/cpia2/cpia2_registers.h       |  476 ++
 drivers/media/video/cpia2/cpia2_usb.c             |  907 +++++
 drivers/media/video/cpia2/cpia2_v4l.c             | 2135 +++++++++++
 drivers/media/video/cpia2/cpia2dev.h              |   50 
 drivers/media/video/cpia2/cpia2patch.h            |  233 +
 drivers/media/video/cx25840/cx25840-core.c        |  100 
 drivers/media/video/cx25840/cx25840-vbi.c         |    6 
 drivers/media/video/cx25840/cx25840.h             |    1 
 drivers/media/video/cx88/Kconfig                  |   23 
 drivers/media/video/cx88/Makefile                 |    6 
 drivers/media/video/cx88/cx88-alsa.c              |    6 
 drivers/media/video/cx88/cx88-cards.c             |  114 
 drivers/media/video/cx88/cx88-core.c              |   16 
 drivers/media/video/cx88/cx88-dvb.c               |  110 
 drivers/media/video/cx88/cx88-input.c             |  339 -
 drivers/media/video/cx88/cx88-video.c             |   40 
 drivers/media/video/cx88/cx88.h                   |    6 
 drivers/media/video/em28xx/em28xx-cards.c         |  250 -
 drivers/media/video/em28xx/em28xx-core.c          |   17 
 drivers/media/video/em28xx/em28xx-i2c.c           |    9 
 drivers/media/video/em28xx/em28xx-input.c         |   85 
 drivers/media/video/em28xx/em28xx-video.c         | 1561 ++++----
 drivers/media/video/em28xx/em28xx.h               |   11 
 drivers/media/video/hexium_orion.c                |    2 
 drivers/media/video/ir-kbd-i2c.c                  |   52 
 drivers/media/video/meye.c                        |  112 
 drivers/media/video/meye.h                        |    4 
 drivers/media/video/msp3400-driver.c              |   80 
 drivers/media/video/msp3400-kthreads.c            |  361 --
 drivers/media/video/msp3400.h                     |   12 
 drivers/media/video/mxb.c                         |    4 
 drivers/media/video/planb.c                       |    8 
 drivers/media/video/planb.h                       |    2 
 drivers/media/video/pms.c                         |   28 
 drivers/media/video/saa5246a.c                    |   10 
 drivers/media/video/saa5249.c                     |   10 
 drivers/media/video/saa7115.c                     |   10 
 drivers/media/video/saa7134/saa7134-alsa.c        |   10 
 drivers/media/video/saa7134/saa7134-cards.c       |  289 +
 drivers/media/video/saa7134/saa7134-core.c        |    2 
 drivers/media/video/saa7134/saa7134-dvb.c         |  198 +
 drivers/media/video/saa7134/saa7134-empress.c     |    8 
 drivers/media/video/saa7134/saa7134-input.c       |  513 --
 drivers/media/video/saa7134/saa7134-oss.c         |   40 
 drivers/media/video/saa7134/saa7134-tvaudio.c     |   14 
 drivers/media/video/saa7134/saa7134-video.c       |   40 
 drivers/media/video/saa7134/saa7134.h             |   14 
 drivers/media/video/stradis.c                     |   15 
 drivers/media/video/tda8290.c                     |   16 
 drivers/media/video/tda9887.c                     |    9 
 drivers/media/video/tuner-core.c                  |   92 
 drivers/media/video/tuner-simple.c                |  179 
 drivers/media/video/tuner-types.c                 |  679 +--
 drivers/media/video/tvaudio.c                     |   35 
 drivers/media/video/tvp5150.c                     |  829 ++--
 drivers/media/video/tvp5150_reg.h                 |  125 
 drivers/media/video/v4l2-common.c                 |  592 +++
 drivers/media/video/video-buf-dvb.c               |   10 
 drivers/media/video/video-buf.c                   |   42 
 drivers/media/video/videocodec.h                  |    2 
 drivers/media/video/videodev.c                    |   22 
 drivers/media/video/vino.c                        |   33 
 drivers/media/video/zr36050.c                     |    2 
 drivers/media/video/zr36060.c                     |    2 
 drivers/media/video/zr36120_i2c.c                 |    2 
 include/linux/dvb/audio.h                         |   13 
 include/linux/dvb/video.h                         |   13 
 include/linux/videodev2.h                         |   97 
 include/media/ir-common.h                         |   48 
 include/media/saa7146.h                           |   21 
 include/media/tuner-types.h                       |    3 
 include/media/tuner.h                             |    8 
 include/media/v4l2-common.h                       |   65 
 include/media/video-buf-dvb.h                     |    2 
 include/media/video-buf.h                         |    2 
 190 files changed, 14518 insertions(+), 7458 deletions(-)

