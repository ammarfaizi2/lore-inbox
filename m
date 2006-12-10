Return-Path: <linux-kernel-owner+w=401wt.eu-S1758792AbWLJMd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbWLJMd2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 07:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759074AbWLJMd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 07:33:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55251 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758430AbWLJMd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 07:33:27 -0500
Message-Id: <20061210112430.PS733549000000@infradead.org>
Date: Sun, 10 Dec 2006 09:24:30 -0200
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       V4L <video4linux-list@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 000/116] V4L/DVB updates
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

Most relevant stuff on this series:
	- Addition of V4L usbvision driver (56 new usb devices supported);
	- Addition of DVB DiB7000M/DiB7000P drivers;
	- Addition of Webcam Marvel Cafe CCIC driver (OLPC);
	- Addition of Webcam OV7670 sensor (used on B-Test OLPC);
	- Removal of broken ZR36120 driver;
	- Miscelaneous cleanups, improvements and board aditions to existing 
	  drivers.
---

PS.1: You haven't pushed my last request, probably due to some conflicts with
      other trees like the removal of the third parameter of INIT_WORK, that 
      conflicted with some changes on cx88-input.
      I've fixed the conflicts. Everything is compiling fine.

PS.2: It seems that kernel.org is not replicating master -git to the mirrors.
      At least, some changes I did about 4 hours ago aren't still replicated.

PS.3: The entire patch series is about 1.3 Mb. Since the series is at -git, 
      IMO, there's no sense to spam LKML with those 116 big emails.
      If someone wants to review, while this is not yet replicated, I've created
      a quilt tree at:
	http://www.linuxtv.org/downloads/patches_to_2.6.20/

---

This series contains the following (including the previously asked patches):
   - Correct AVerMedia Volar USB ID
   - Cx88: Add support for VIDIOC_INT_[SR]_REGISTER ioctls
   - Initial commit for the DiB7000M-demod
   - Dynamic cx88 mpeg port management for HVR1300 MPEG2/DVB-T support.
   - Bugfix: Select the correct cx8802_dev when enumerating by CX88_MPEG_type
   - Add support for Pinnacle 310i
   - Add support for AverMedia AverTV Studio 507
   - Cx88-blackbird module is rejected during probe.
   - Fixed DVB-USB-Adapter indention
   - Cxusb: rename cxusb_lgdt3303_tuner_attach
   - Cxusb: update copyright and author email address
   - Cx88: cleanups
   - Cx88: determine whether or not to use external adc
   - Cx88: use external adc for svideo/composite
   - Cx88: use external adc for rca audio inputs on the ASUS PVR-416
   - Stv680.c: check kmalloc() return value.
   - Pvrusb2: Implement IR reception for 24xxx devices
   - Dvb-usb/vp7045.c patch for extra key
   - Add working dib7000m-module
   - Make Remote control of the Pinnacle PCTV 310i work
   - Add the Asus P7131 Dual hybrid to the new tda8290_i2c_gate_ctrl
   - Added support for a ASUSTEK P7131 Dual DVB-T variant
   - Add support for DiBcom DiB7000PC
   - Misc fixes for DiB3000 and DiB7000
   - [patch] Add Compro USB IDs
   - Adding USB IDs for Uniwill STK7700P-ref-design
   - Fixed device count
   - Tda8083: support for uncorrectable blocks and bit error rate
   - Lgdt330x: SNR and signal strength reporting
   - Added autodetected flag to the saa7134_dev structure
   - Add support for the Compro Videomate DVB-T200A
   - Dvb: dibx000_common-fix
   - A couple of V4L2 defines needed by Cafe Camara driver
   - Marvell 88ALP01 "cafe" driver
   - OmniVision OV7670 driver
   - Dib0700: Add support for Leadtek Winfast DTV Dongle (STK7700P based)
   - Saa7134: add support for Hauppauge WinTV-HVR1110 DVB-T/Hybrid
   - Detect presence of IR receiver/IR transmitter in tveeprom
   - Added information about Technisat Sky2Pc cards
   - Dib0700: Add support for new revision of Nova-T Stick
   - Add alternative device ID (0xb808) for AverMedia AverTV Volar dongles.
   - FIX bug 5760: audio were not working on some bttv drivers
   - v4l2_type_names table is incomplete
   - Patch for SATELCO EasyWatch PCI (DVB-C)
   - Cafe_ccic.c: make a function static
   - Added support for the Terratec Cinergy HT PCMCIA module
   - Added support for both DVB frontends of the Lifeview Trio
   - Fix cx88-blackbird null pointer
   - Add support ptv-305
   - Added a newer PCI ID to CARDLIST.cx88
   - Updated camera driver
   - Create new lgh06xf atsc tuner module
   - Drivers/media/dvb/frontends: kfree() cleanups
   - Lgh06xf: fix compiler error when not selected
   - Pvrusb2: Fix horizontal resolution setting problem for 24xxx devices
   - Handle errors from input_register_device()
   - Support KNC1 DVBC cards with alternative tda10021 i2c address
   - Cleans some ioctl structs before calling V4L2 counterpart
   - Fix: implement missing VIDIOCSTUNER on v4l1-compat module
   - Fix initializations on some video_ioctl2 handlers
   - Optimization of v4l1 handling
   - Remove the need of a STD array for drivers using video_ioctl2
   - Fixes uninitialized variables passed to VIDIOC_G_FBUF.
   - TDA826x I2C read with 2 messages
   - Adding support for Pinnacle PCTV 400e DVB-S
   - Whitespace cleanup
   - Dvb-pll: return frequency set by dvb_pll_configure()
   - Lgh06xf: use return value of dvb_pll_configure()
   - Fix i2c dependencies of VIDEO_TVEEPROM and VIDEO_TUNER
   - Saa7134-alsa improvements
   - budget-ci IR: groundwork for following patches
   - budget-ci IR: support EVIOCGPHYS
   - budget-ci IR: improve error checking in init and deinit functions
   - budget-ci IR: be more verbose in case of init failure
   - budget-ci IR: integrate with ir-common
   - budget-ci IR: decode rc5 device byte
   - budget-ci IR: add IR debugging information
   - budget-ci IR: make debounce logic conditional
   - Fix TD1316 tuner for DVBC
   - Remove stray IR code left from patchset
   - Minor coding style improvements
   - Remove the broken VIDEO_ZR36120 driver
   - Lgdt330x: fix signal / lock status detection bug
   - Lgdt330x: fix broken whitespace
   - Dvb-budget ci fix
   - Mxb: fix to load the proper i2c modules
   - Accept tuners on saa7146 i2c bus only on address 0x60.
   - Dvb-usb: fix vendor ID ordering
   - Saa7134: add support for remote control of Hauppauge HVR1110
   - Improve debug msgs to show fourcc and buffer length on video_ioctl2
   - Remove the fake RGB32 format from cafe_ccic
   - Add s/g_parm to cafe_ccic
   - Fix broken TUNER_LG_NTSC_TAPE radio support
   - Saa7146: Protect access to the IER register by a spinlock
   - Saa7146: Add timeout protection for I2C interrupt
   - Av7110,budget,budget-ci,budget-av: Use interrupt mode for I2C transfers
   - Saa7146: Convert SAA7146_IER_{DIS,EN}ABLE macros to inline functions
   - Budget-av: Add delay for frontend power-on
   - Budget-ci: Use SAA7146_IER_ENABLE/DISABLE to enable or disable a hardware interrupt
   - Budget-av, budget-ci: Fix MC1 register programming
   - Add usbvision driver
   - Splitted usbvision cards from usbvison.h
   - Fix some bugs on usbvision due to the merge into one module
   - Corrected and separated the Kconfig for usbvision
   - Fix USBVision handling of VIDIOC_QUERYCTRL
   - Enhancements on usbvision driver
   - Usbvision_v4l2 robustness on disconnect
   - Read() implementation + format set/get simplifications
   - Usbvision_v4l2 : mmap corrected to get all frames
   - Removed usbvision_ioctl.h, since it isn't required anymore
   - Usbvision_v4l2: fix norm setting problems
   - Usbvision_v4l2: radio interface / tda9887 problem ?
   - Usbvision radio requires GainNormal at e register
   - Added the capability of selecting fm gain by tuner
   - Make MT4049FM5 tuner to set FM Gain to Normal
   - Usbvision cleanup and code reorganization
   - Whitespace cleanups
   - Remove LINUX_VERSION_CODE and fix identations
   - Cx88: Convert lgdt3302 tuning function to use dvb_pll_attach
   - Or51132: Changed SNR and signal strength reporting
   - Or51211: Changed SNR and signal strength calculations
   - Add version.h, since it is required for VIDIOC_QUERYCAP
   - Usbvision minor fixes
   - Cx88: cleanup dvb_pll_attach for lgdt3302 tuners
   - Cx88: Convert DViCO FusionHDTV Hybrid to use dvb_pll_attach
   - Cx88: consolidate cx22702_config structs
   - Cx88: Move cx88_dvb_bus_ctrl out of the card-specific area
   - Cx88: trivial cleanups
   - Cxusb: Convert tuner functions to use dvb_pll_attach
   - Cxusb: codingstyle cleanups
   - Fix INIT_WORK

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/dvb/cards.txt                       |    4 
 Documentation/video4linux/CARDLIST.cx88           |    2 
 Documentation/video4linux/CARDLIST.saa7134        |    7 
 Documentation/video4linux/cafe_ccic               |   54 
 Documentation/video4linux/zr36120.txt             |  162 -
 drivers/media/Kconfig                             |    2 
 drivers/media/common/ir-keymaps.c                 |   55 
 drivers/media/common/saa7146_i2c.c                |   16 
 drivers/media/dvb/b2c2/Kconfig                    |    1 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c         |   10 
 drivers/media/dvb/bt8xx/Kconfig                   |    2 
 drivers/media/dvb/bt8xx/dvb-bt8xx.c               |    9 
 drivers/media/dvb/bt8xx/dvb-bt8xx.h               |    2 
 drivers/media/dvb/cinergyT2/cinergyT2.c           |   13 
 drivers/media/dvb/dvb-usb/Kconfig                 |   14 
 drivers/media/dvb/dvb-usb/Makefile                |    3 
 drivers/media/dvb/dvb-usb/a800.c                  |   36 
 drivers/media/dvb/dvb-usb/cxusb.c                 |  271 +-
 drivers/media/dvb/dvb-usb/dib0700.h               |    5 
 drivers/media/dvb/dvb-usb/dib0700_core.c          |   40 
 drivers/media/dvb/dvb-usb/dib0700_devices.c       |  200 ++
 drivers/media/dvb/dvb-usb/dibusb-mb.c             |  113 -
 drivers/media/dvb/dvb-usb/dibusb-mc.c             |   26 
 drivers/media/dvb/dvb-usb/digitv.c                |   22 
 drivers/media/dvb/dvb-usb/dtt200u.c               |   24 
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h           |   14 
 drivers/media/dvb/dvb-usb/dvb-usb-remote.c        |   37 
 drivers/media/dvb/dvb-usb/gp8psk.c                |   22 
 drivers/media/dvb/dvb-usb/nova-t-usb2.c           |   34 
 drivers/media/dvb/dvb-usb/ttusb2.c                |  270 ++
 drivers/media/dvb/dvb-usb/ttusb2.h                |   70 +
 drivers/media/dvb/dvb-usb/umt-010.c               |   24 
 drivers/media/dvb/dvb-usb/vp702x.c                |   20 
 drivers/media/dvb/dvb-usb/vp7045.c                |   40 
 drivers/media/dvb/frontends/Kconfig               |   24 
 drivers/media/dvb/frontends/Makefile              |    3 
 drivers/media/dvb/frontends/dib3000mc.c           |    7 
 drivers/media/dvb/frontends/dib7000m.c            | 1191 ++++++++++
 drivers/media/dvb/frontends/dib7000m.h            |   51 
 drivers/media/dvb/frontends/dib7000p.c            | 1019 ++++++++
 drivers/media/dvb/frontends/dib7000p.h            |   46 
 drivers/media/dvb/frontends/dibx000_common.h      |   13 
 drivers/media/dvb/frontends/dvb-pll.c             |   67 -
 drivers/media/dvb/frontends/dvb-pll.h             |    7 
 drivers/media/dvb/frontends/lg_h06xf.h            |   64 -
 drivers/media/dvb/frontends/lgdt330x.c            |  257 +-
 drivers/media/dvb/frontends/lgdt330x_priv.h       |   15 
 drivers/media/dvb/frontends/lgh06xf.c             |  134 +
 drivers/media/dvb/frontends/lgh06xf.h             |   35 
 drivers/media/dvb/frontends/or51132.c             |  176 +
 drivers/media/dvb/frontends/or51211.c             |  124 -
 drivers/media/dvb/frontends/tda1004x.c            |   10 
 drivers/media/dvb/frontends/tda1004x.h            |    5 
 drivers/media/dvb/frontends/tda8083.c             |   30 
 drivers/media/dvb/frontends/tda826x.c             |   12 
 drivers/media/dvb/frontends/tua6100.c             |    3 
 drivers/media/dvb/ttpci/Kconfig                   |    1 
 drivers/media/dvb/ttpci/av7110.c                  |    2 
 drivers/media/dvb/ttpci/av7110_ir.c               |   25 
 drivers/media/dvb/ttpci/budget-av.c               |   26 
 drivers/media/dvb/ttpci/budget-ci.c               |  334 ++-
 drivers/media/dvb/ttpci/budget.c                  |    2 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |   11 
 drivers/media/video/Kconfig                       |   31 
 drivers/media/video/Makefile                      |    6 
 drivers/media/video/bt8xx/bttv-driver.c           |    2 
 drivers/media/video/bt8xx/bttv-input.c            |  101 -
 drivers/media/video/cafe_ccic-regs.h              |  160 +
 drivers/media/video/cafe_ccic.c                   | 2228 ++++++++++++++++++
 drivers/media/video/cx88/Kconfig                  |    1 
 drivers/media/video/cx88/cx88-blackbird.c         |  179 +
 drivers/media/video/cx88/cx88-cards.c             |   86 -
 drivers/media/video/cx88/cx88-dvb.c               |  333 +--
 drivers/media/video/cx88/cx88-input.c             |   77 -
 drivers/media/video/cx88/cx88-mpeg.c              |  348 +++
 drivers/media/video/cx88/cx88-tvaudio.c           |   13 
 drivers/media/video/cx88/cx88-video.c             |   32 
 drivers/media/video/cx88/cx88.h                   |   47 
 drivers/media/video/ir-kbd-i2c.c                  |   46 
 drivers/media/video/mxb.c                         |    8 
 drivers/media/video/ov7670.c                      | 1333 +++++++++++
 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c |   16 
 drivers/media/video/pvrusb2/pvrusb2-hdw.c         |   26 
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.c    |   81 +
 drivers/media/video/saa7115.c                     |   18 
 drivers/media/video/saa7134/saa7134-alsa.c        |   63 -
 drivers/media/video/saa7134/saa7134-cards.c       |  222 ++
 drivers/media/video/saa7134/saa7134-core.c        |   11 
 drivers/media/video/saa7134/saa7134-dvb.c         |  222 ++
 drivers/media/video/saa7134/saa7134-i2c.c         |    1 
 drivers/media/video/saa7134/saa7134-input.c       |   76 +
 drivers/media/video/saa7134/saa7134.h             |    8 
 drivers/media/video/stv680.c                      |   21 
 drivers/media/video/tda9887.c                     |    6 
 drivers/media/video/tuner-core.c                  |    4 
 drivers/media/video/tuner-simple.c                |    4 
 drivers/media/video/tuner-types.c                 |   15 
 drivers/media/video/tveeprom.c                    |    9 
 drivers/media/video/usbvideo/quickcam_messenger.c |    9 
 drivers/media/video/usbvision/Kconfig             |   12 
 drivers/media/video/usbvision/Makefile            |    5 
 drivers/media/video/usbvision/usbvision-cards.c   |  157 +
 drivers/media/video/usbvision/usbvision-core.c    | 2554 +++++++++++++++++++++
 drivers/media/video/usbvision/usbvision-i2c.c     |  567 +++++
 drivers/media/video/usbvision/usbvision-video.c   | 2051 +++++++++++++++++
 drivers/media/video/usbvision/usbvision.h         |  560 +++++
 drivers/media/video/v4l1-compat.c                 |   18 
 drivers/media/video/v4l2-common.c                 |   85 +
 drivers/media/video/videodev.c                    |  173 +
 drivers/media/video/vivi.c                        |   16 
 drivers/media/video/zr36120.c                     | 2079 -----------------
 drivers/media/video/zr36120.h                     |  279 --
 drivers/media/video/zr36120_i2c.c                 |  132 -
 drivers/media/video/zr36120_mem.c                 |   78 -
 drivers/media/video/zr36120_mem.h                 |    3 
 include/linux/i2c-id.h                            |    2 
 include/linux/videodev2.h                         |    1 
 include/media/ir-common.h                         |    1 
 include/media/saa7146.h                           |   20 
 include/media/tuner-types.h                       |    4 
 include/media/tuner.h                             |    1 
 include/media/tveeprom.h                          |    2 
 include/media/v4l2-common.h                       |    7 
 include/media/v4l2-dev.h                          |   14 
 124 files changed, 15645 insertions(+), 4337 deletions(-)
 create mode 100644 Documentation/video4linux/cafe_ccic
 delete mode 100644 Documentation/video4linux/zr36120.txt
 create mode 100644 drivers/media/dvb/dvb-usb/ttusb2.c
 create mode 100644 drivers/media/dvb/dvb-usb/ttusb2.h
 create mode 100644 drivers/media/dvb/frontends/dib7000m.c
 create mode 100644 drivers/media/dvb/frontends/dib7000m.h
 create mode 100644 drivers/media/dvb/frontends/dib7000p.c
 create mode 100644 drivers/media/dvb/frontends/dib7000p.h
 delete mode 100644 drivers/media/dvb/frontends/lg_h06xf.h
 create mode 100644 drivers/media/dvb/frontends/lgh06xf.c
 create mode 100644 drivers/media/dvb/frontends/lgh06xf.h
 create mode 100644 drivers/media/video/cafe_ccic-regs.h
 create mode 100644 drivers/media/video/cafe_ccic.c
 create mode 100644 drivers/media/video/ov7670.c
 create mode 100644 drivers/media/video/usbvision/Kconfig
 create mode 100644 drivers/media/video/usbvision/Makefile
 create mode 100644 drivers/media/video/usbvision/usbvision-cards.c
 create mode 100644 drivers/media/video/usbvision/usbvision-core.c
 create mode 100644 drivers/media/video/usbvision/usbvision-i2c.c
 create mode 100644 drivers/media/video/usbvision/usbvision-video.c
 create mode 100644 drivers/media/video/usbvision/usbvision.h
 delete mode 100644 drivers/media/video/zr36120.c
 delete mode 100644 drivers/media/video/zr36120.h
 delete mode 100644 drivers/media/video/zr36120_i2c.c
 delete mode 100644 drivers/media/video/zr36120_mem.c
 delete mode 100644 drivers/media/video/zr36120_mem.h

