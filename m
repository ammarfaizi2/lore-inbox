Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWIZQV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWIZQV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWIZQV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:21:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33692 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932345AbWIZQV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:21:28 -0400
Message-Id: <20060926153309.PS292898000000@infradead.org>
Date: Tue, 26 Sep 2006 12:33:09 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000/180] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

This series contains lots of improvements, including:

   - [PATCH] Freecom DVB-T stick with ID 14aa:0225
   - Added support for the md8800 quadro board
   - Added PCI ID for AverMedia DVB-T 777 with SAA7133
   - Added PCI ID of the Genius VideoWonder Dual Cardbus
   - Removed the remaining config.h stuff
   - V4L2 conversion: radio_aimslab
   - V4L2 conversion: radio_aztech
   - Fix: compile for radio aimslab and aztech with V4L2 only
   - V4L2 conversion: radio_gemtek
   - V4L2 conversion: radio_gemtek-pci
   - V4L2 conversion: radio-maestro
   - V4L2 conversion: radio-rtrack2
   - V4L2 conversion: radio-sf16fmi
   - A small fix at fmi->flags logic
   - V4L2 conversion: radio-sf16fmr2
   - V4L2 conversion: radio-terratec
   - V4L2 conversion: radio-typhoon
   - V4L2 conversion: radio-zoltrix
   - Cx88: add initial support for Hauppauge HVR3000 trimode card
   - Cx88: add autodetection support for AverMedia M150-D
   - Cx88: add support for Norwood PCI TV Tuner (non-pro)
   - Cx88: Shenzhen Tungsten Ages Tech TE-DTV-250 / Swann PCI TV Tuner card support
   - V4L2 conversion: radio-trust
   - V4L2 conversion: radio-maxiradio
   - Remove of couple of useless lines
   - Fix some typos on ioctl handling function
   - Included missing linux/version.h
   - Clean up some post mpeg-controls issues in pvrusb2
   - Eliminate hardcoded limits in VIDIOC_[S|TRY]_FMT for pvrusb2
   - Make it possible for run-time calculation of control min/max in pvrusb2
   - Force horizontal resolution limits in the pvrusb2 driver
   - Ttpci/: remove unneeded #include <linux/byteorder/swabb.h>'s
   - Dvb_attach modifications to dvb frontend structures
   - Convert SEC drivers to new frontend API
   - Remove remaining static function calls
   - Add dvb_attach() macro and supporting routines
   - Convert DVB devices to use dvb_attach()
   - Add Kconfig infrastructure for dvb_attach
   - Remove frontend selection from cx88/saa7134 drivers
   - Remove duplication _release() op.
   - Refactor dvb_detach calls into a single dvb_frontend_detach function.
   - Fix dst_ca attach
   - Git-dvb: radio-sf16fmi build fix
   - Add drivers for tda10086 + tda826x chips
   - Add tda10086 support for TT DVB-S-1401
   - Add support for Acorp TV134DS + FlyDVB-S cards.
   - Tda826x: Remove 0-byte I2C write; put tuner_ops info in static struct
   - Disable tda10086 debug by default.
   - Fix budget-ci to use dvb_frontend_detach()
   - Use dprintk in tda826x.
   - Add missing KConfig I2C dependencies
   - Convert radio-cadet to V4L2 API
   - Cleanups and fixes for dsbr100
   - Konicawc - handle errors from input_register_device()
   - Add support for PAL-Nc in cx24850.
   - V4L2 Conversion: saa5246a, saa5249, vino, hexium_orion, hexium_gemini
   - Improved comment for AR device and fix some typos
   - Add missing dvb-pll Kconfig infrastructure
   - Fix tda826x detection
   - Fix Circular dependencies
   - Soft decision threshold
   - Change BER config
   - HW algo
   - Dvb-pll support for MT352/ZL10353 based tuners.
   - Fix dvb_pll_attach for nxt2004-based cards
   - Whitespace cleanups for cx88-dvb and saa7134-dvb
   - Flexcop/nxt200x attach fix
   - Adding support for MT2060 and thus for some DVB-USB-devices based on it
   - Cleanups for mt2060-integration
   - Add support for the Artec T14
   - Added support for LeadTek DVB-T USB clone
   - MT2060: IF1 Offset from EEPROM, several updates
   - [PATCH] dibcom mod3000p + mt2060 -- remote control
   - MT2060: Code cleanups, adding to new build-mechanism
   - Corrected debugging output of the mt2060
   - Update for MT2060 to use dvb_tuner_ops
   - Remove dib3000-common-module
   - Complete rewrite of the DiB3000mc-driver
   - Added missing dibx000-common code and headers
   - Attach the dib3000mc correctly
   - New firmware for Nova-t-usb2
   - FIX_ AverTV A800 trouble
   - DiB3000MC: set FE to NULL after being freed
   - Another fix for attaching the DiB3000MC
   - MT2060: turn on the VGA
   - Remove debug-print from dib3000mc
   - On some cases, depth were not returned.
   - Fix most Compat32 stuff on V4L2
   - Improve hardware algorithm by setting the appropriate registers
   - [av7110] Support Grundig DVB-T tuner for sub-system 13c2:0001
   - LNB voltage control was inverted for the benefit of geniatech cards on Kworld
   - Remove null chars from dvb names
   - Make the dibx000-common-module GPL
   - Git-dvb: cadet build fix
   - Fix a warning on PPC64
   - Fix possible crash in Hauppauge eeprom reading
   - Whitespace cleanup
   - [dvb_attach] dvb_frontend_detach fix
   - [lnbp21] release callback fixed
   - Fix "no data from ZL10353 based USB tuner" problem
   - Tuning tweaks for ZL10353
   - Reset USB part of DViCO Dual Digital during PCI driver attach
   - Offset parameter permission were 0x666, instead of 0x664
   - CONFIG_PM=n slim: drivers/media/video/*
   - Fix KNC1 DVBC support
   - Add support for knc one dvb-s plus with 1894:0011
   - Enable audio DMA restart on channel change even when cx88-alsa is compiled
   - TVP5150 routing logic were broken.
   - Make tvp5150 an independent Kconfig item
   - Fix an array overflow on bt866
   - Added missing copyright
   - Fix signedness error in drivers/media/video/vivi.c
   - Ks0127: wire up i2c_add_driver() return value
   - Split audio decoders from bttv
   - Add some comments for Kconfig encoders/decoders itens
   - Fixed module name, since it is, in fact, a decoder.
   - Split audio/video encoders/decoders from main drivers
   - Allow manually selecting the proper helper drivers
   - Added missing KS0197 Kconfig item
   - Fixes Helper module dependencies against V4L APIs
   - Fix a warning caused by a typo (comma instead of dot-comma)
   - Drivers/media/dvb/dvb-usb/dibusb-mb.c: NULL dereference
   - PATCH: Club 3D zap250mini
   - Keep the PID parse bit when resetting the output mode
   - Another fix for the PID parsing
   - Isl6421: Release callback installed incorrectly
   - Tda9887: add configuration setting for L standard PLL gating
   - Add missing v4l2_buf_type to struct v4l2_sliced_vbi_cap.
   - Add u32 argument to VIDIOC_INT_RESET.
   - Add YUV HM12 and VBI IVTV format documentation.
   - Better temporal filter handling.
   - Make saa7115 to report the complete chipset name
   - Added register aliases for saa711x registers, instead of using reg numbers
   - Add support for saa7111 and partial support for saa7118
   - Renamed several common structs/functions to saa711x instead of saa7115
   - Cleanup: removed hardcoded tables
   - Fix a typo.
   - Sync'ing dvb-usb-remote with changes in USB input subsystem
   - Fix scaling calculus
   - Fix: There were some missing breaks at register check routine
   - VIDIOC_INT_S_REGISTER is IOW, not IOR.
   - Fix VIDIOC_S_FMT min/max check in pvrusb2
   - VIDIOC_G_SLICED_VBI_CAP now accepts a v4l2_buf_type, make it IOWR
   - Code were preventing saa7111 and saa7118 to work
   - Fixes some troubles on saa7115
   - Remove some dead data elements from pvrusb2 driver
   - Remove CONFIG_VIDEO_PVRUSB2_24XXX from pvrusb2 driver
   - Fix saa7115 miscalculation that breaks NTSC
   - Improve resolution limit enforcements in pvrusb2
   - Fix a typo: VRES, instead o HRES
   - Adds Compro PS39U USB ID to Vicam driver
   - Fix DVB Front-End Signal Strength Inconsistency
   - Fix broken pvrusb2 build
   - Add driver for TUA6100
   - Port budget-av to use the new tua6100 driver
   - V4L1 API conversion not finished yet
   - Improved i2c performance on software bitbang algoritm
   - Add tua6100 config wrapper
   - Add module-init-tools version comment.
   - Unmute/mute saa7134 when opening/closing the audio capture device.
   - Export symbol saa7134_tvaudio_setmute from saa7134 for saa7134-alsa
   - [PATCH] Nebula DigiTV USB RC support
   - Problem with dibusb-mb.c USB IDs
   - Fixes some I2C dependencies on V4L devices
   - Fix AGC configuration for MOD3000P-based boards
   - Copy-paste bug in videodev.c
   - Tvaudio: Replaced kernel_thread() with kthread_run()
   - On saa7111/7113, LUMA_CTRL need a different value
   - Vivi crashes with mplayer
   - Fix VIDIOC_ENUMSTD ioctl in videodev.c
   - Saa7134: add card support for Proteus Pro 2309
   - Av7110: FW_LOADER depemdency fixed
   - Av7110: remove V4L2_CAP_VBI_CAPTURE flag
   - Zoran: Implement pcipci failure check
   - Zr36120: implement pcipci checks
   - Extend bttv and saa7134 to check for both AGP and PCI PCI failure case
   - Add a default method for VIDIOC_G_PARM
   - Basic DVB-T and analog TV support for the HVR1300.
   - Cx88: add autodetection for alternate revision of Leadtek PVR
   - Trivial: use lowercase letters in hex subsystem ids

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/feature-removal-schedule.txt         |    2 
 Documentation/video4linux/CARDLIST.cx88            |    8 
 Documentation/video4linux/CARDLIST.saa7134         |    7 
 Documentation/video4linux/bttv/Insmod-options      |    6 
 Documentation/video4linux/cx2341x/README.hm12      |  116 ++
 Documentation/video4linux/cx2341x/README.vbi       |   45 +
 drivers/media/common/Kconfig                       |    1 
 drivers/media/common/ir-keymaps.c                  |   79 +
 drivers/media/common/saa7146_fops.c                |    1 
 drivers/media/dvb/b2c2/Kconfig                     |   14 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c          |   24 
 drivers/media/dvb/bt8xx/Kconfig                    |   14 
 drivers/media/dvb/bt8xx/dst.c                      |    9 
 drivers/media/dvb/bt8xx/dst_ca.c                   |   11 
 drivers/media/dvb/bt8xx/dst_common.h               |    3 
 drivers/media/dvb/bt8xx/dvb-bt8xx.c                |   37 -
 drivers/media/dvb/dvb-core/Kconfig                 |   13 
 drivers/media/dvb/dvb-core/dvb_frontend.c          |   42 -
 drivers/media/dvb/dvb-core/dvb_frontend.h          |    7 
 drivers/media/dvb/dvb-core/dvbdev.h                |   22 
 drivers/media/dvb/dvb-usb/Kconfig                  |   17 
 drivers/media/dvb/dvb-usb/a800.c                   |    8 
 drivers/media/dvb/dvb-usb/cxusb.c                  |   11 
 drivers/media/dvb/dvb-usb/dibusb-common.c          |  200 +++
 drivers/media/dvb/dvb-usb/dibusb-mb.c              |   18 
 drivers/media/dvb/dvb-usb/dibusb-mc.c              |   41 +
 drivers/media/dvb/dvb-usb/dibusb.h                 |    3 
 drivers/media/dvb/dvb-usb/digitv.c                 |   86 +
 drivers/media/dvb/dvb-usb/dtt200u.c                |   50 +
 drivers/media/dvb/dvb-usb/dvb-usb-dvb.c            |   20 
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h            |  124 +-
 drivers/media/dvb/dvb-usb/dvb-usb-remote.c         |    5 
 drivers/media/dvb/dvb-usb/nova-t-usb2.c            |    2 
 drivers/media/dvb/dvb-usb/umt-010.c                |    2 
 drivers/media/dvb/frontends/Kconfig                |   71 +
 drivers/media/dvb/frontends/Makefile               |    8 
 drivers/media/dvb/frontends/bcm3510.h              |    9 
 drivers/media/dvb/frontends/cx22700.h              |    9 
 drivers/media/dvb/frontends/cx22702.c              |    4 
 drivers/media/dvb/frontends/cx22702.h              |    9 
 drivers/media/dvb/frontends/cx24110.c              |   17 
 drivers/media/dvb/frontends/cx24110.h              |   19 
 drivers/media/dvb/frontends/cx24123.c              |   98 +
 drivers/media/dvb/frontends/cx24123.h              |   12 
 drivers/media/dvb/frontends/dib3000-common.c       |   83 -
 drivers/media/dvb/frontends/dib3000-common.h       |  135 --
 drivers/media/dvb/frontends/dib3000.h              |   11 
 drivers/media/dvb/frontends/dib3000mb.c            |   76 +
 drivers/media/dvb/frontends/dib3000mb_priv.h       |   93 +
 drivers/media/dvb/frontends/dib3000mc.c            | 1432 ++++++++++----------
 drivers/media/dvb/frontends/dib3000mc.h            |   58 +
 drivers/media/dvb/frontends/dib3000mc_priv.h       |  428 ------
 drivers/media/dvb/frontends/dibx000_common.c       |  152 ++
 drivers/media/dvb/frontends/dibx000_common.h       |  166 ++
 drivers/media/dvb/frontends/dvb-pll.c              |   11 
 drivers/media/dvb/frontends/dvb-pll.h              |    4 
 drivers/media/dvb/frontends/isl6421.c              |   30 
 drivers/media/dvb/frontends/isl6421.h              |   11 
 drivers/media/dvb/frontends/l64781.h               |   10 
 drivers/media/dvb/frontends/lgdt330x.h             |    9 
 drivers/media/dvb/frontends/lnbp21.c               |   30 
 drivers/media/dvb/frontends/lnbp21.h               |   12 
 drivers/media/dvb/frontends/mt2060.c               |  367 +++++
 drivers/media/dvb/frontends/mt2060.h               |   35 
 drivers/media/dvb/frontends/mt2060_priv.h          |  105 +
 drivers/media/dvb/frontends/mt312.h                |   10 
 drivers/media/dvb/frontends/mt352.c                |   16 
 drivers/media/dvb/frontends/mt352.h                |   16 
 drivers/media/dvb/frontends/nxt200x.h              |    9 
 drivers/media/dvb/frontends/nxt6000.h              |    9 
 drivers/media/dvb/frontends/or51132.h              |    9 
 drivers/media/dvb/frontends/or51211.h              |    9 
 drivers/media/dvb/frontends/s5h1420.h              |    9 
 drivers/media/dvb/frontends/sp8870.h               |    9 
 drivers/media/dvb/frontends/sp887x.h               |    9 
 drivers/media/dvb/frontends/stv0297.h              |    9 
 drivers/media/dvb/frontends/stv0299.c              |    9 
 drivers/media/dvb/frontends/stv0299.h              |   19 
 drivers/media/dvb/frontends/tda10021.c             |   63 -
 drivers/media/dvb/frontends/tda10021.h             |   19 
 drivers/media/dvb/frontends/tda1004x.c             |   10 
 drivers/media/dvb/frontends/tda1004x.h             |   25 
 drivers/media/dvb/frontends/tda10086.c             |  740 ++++++++++
 drivers/media/dvb/frontends/tda10086.h             |   41 +
 drivers/media/dvb/frontends/tda8083.h              |    9 
 drivers/media/dvb/frontends/tda826x.c              |  173 ++
 drivers/media/dvb/frontends/tda826x.h              |   40 +
 drivers/media/dvb/frontends/tua6100.c              |  205 +++
 drivers/media/dvb/frontends/tua6100.h              |   47 +
 drivers/media/dvb/frontends/ves1820.h              |    9 
 drivers/media/dvb/frontends/ves1x93.h              |    9 
 drivers/media/dvb/frontends/zl10353.c              |   11 
 drivers/media/dvb/frontends/zl10353.h              |   14 
 drivers/media/dvb/ttpci/Kconfig                    |   57 -
 drivers/media/dvb/ttpci/av7110.c                   |   58 -
 drivers/media/dvb/ttpci/av7110_av.c                |    1 
 drivers/media/dvb/ttpci/av7110_ca.c                |    1 
 drivers/media/dvb/ttpci/av7110_hw.c                |    1 
 drivers/media/dvb/ttpci/av7110_v4l.c               |    3 
 drivers/media/dvb/ttpci/budget-av.c                |  184 ---
 drivers/media/dvb/ttpci/budget-ci.c                |   32 
 drivers/media/dvb/ttpci/budget-patch.c             |   17 
 drivers/media/dvb/ttpci/budget.c                   |   53 +
 drivers/media/dvb/ttusb-budget/Kconfig             |   14 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c  |   28 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c            |    6 
 drivers/media/radio/Kconfig                        |   30 
 drivers/media/radio/dsbr100.c                      |  198 ++-
 drivers/media/radio/radio-aimslab.c                |  151 +-
 drivers/media/radio/radio-aztech.c                 |  166 ++
 drivers/media/radio/radio-cadet.c                  |  250 ++-
 drivers/media/radio/radio-gemtek-pci.c             |  170 ++
 drivers/media/radio/radio-gemtek.c                 |  165 ++
 drivers/media/radio/radio-maestro.c                |  197 ++-
 drivers/media/radio/radio-maxiradio.c              |  166 +-
 drivers/media/radio/radio-rtrack2.c                |  163 ++
 drivers/media/radio/radio-sf16fmi.c                |  158 +-
 drivers/media/radio/radio-sf16fmr2.c               |  223 ++-
 drivers/media/radio/radio-terratec.c               |  154 ++
 drivers/media/radio/radio-trust.c                  |  188 ++-
 drivers/media/radio/radio-typhoon.c                |  171 ++
 drivers/media/radio/radio-zoltrix.c                |  183 ++-
 drivers/media/video/Kconfig                        |  476 +++++--
 drivers/media/video/Makefile                       |   45 -
 drivers/media/video/bt866.c                        |    2 
 drivers/media/video/bt8xx/Kconfig                  |    5 
 drivers/media/video/bt8xx/bttv-cards.c             |    2 
 drivers/media/video/bt8xx/bttv-driver.c            |   12 
 drivers/media/video/bt8xx/bttv-i2c.c               |   16 
 drivers/media/video/compat_ioctl32.c               |   59 -
 drivers/media/video/cx2341x.c                      |   25 
 drivers/media/video/cx25840/Kconfig                |    2 
 drivers/media/video/cx25840/cx25840-vbi.c          |    4 
 drivers/media/video/cx88/Kconfig                   |  109 --
 drivers/media/video/cx88/Makefile                  |    7 
 drivers/media/video/cx88/cx88-blackbird.c          |    2 
 drivers/media/video/cx88/cx88-cards.c              |  161 ++
 drivers/media/video/cx88/cx88-core.c               |   13 
 drivers/media/video/cx88/cx88-dvb.c                |  330 ++---
 drivers/media/video/cx88/cx88-i2c.c                |   13 
 drivers/media/video/cx88/cx88-input.c              |   19 
 drivers/media/video/cx88/cx88-tvaudio.c            |    5 
 drivers/media/video/cx88/cx88-video.c              |    7 
 drivers/media/video/cx88/cx88.h                    |    5 
 drivers/media/video/em28xx/Kconfig                 |    3 
 drivers/media/video/em28xx/em28xx-video.c          |    2 
 drivers/media/video/ks0127.c                       |    3 
 drivers/media/video/pvrusb2/Kconfig                |   18 
 drivers/media/video/pvrusb2/Makefile               |    6 
 drivers/media/video/pvrusb2/pvrusb2-ctrl.c         |   21 
 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c  |    2 
 drivers/media/video/pvrusb2/pvrusb2-encoder.c      |    4 
 drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h |   31 
 drivers/media/video/pvrusb2/pvrusb2-hdw.c          |   84 +
 .../media/video/pvrusb2/pvrusb2-i2c-chips-v4l2.c   |    4 
 drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c |    2 
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.c     |    6 
 drivers/media/video/pvrusb2/pvrusb2-main.c         |    1 
 drivers/media/video/pvrusb2/pvrusb2-sysfs.c        |    3 
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c         |   36 -
 drivers/media/video/saa5246a.c                     |    1 
 drivers/media/video/saa5249.c                      |    1 
 drivers/media/video/saa7115.c                      | 1250 ++++++++++-------
 drivers/media/video/saa711x_regs.h                 |  549 ++++++++
 drivers/media/video/saa7134/Kconfig                |   50 -
 drivers/media/video/saa7134/Makefile               |    3 
 drivers/media/video/saa7134/saa7134-alsa.c         |    8 
 drivers/media/video/saa7134/saa7134-cards.c        |  127 ++
 drivers/media/video/saa7134/saa7134-core.c         |    2 
 drivers/media/video/saa7134/saa7134-dvb.c          |  197 ++-
 drivers/media/video/saa7134/saa7134-input.c        |    6 
 drivers/media/video/saa7134/saa7134-tvaudio.c      |    1 
 drivers/media/video/saa7134/saa7134.h              |    3 
 drivers/media/video/tda9887.c                      |    2 
 drivers/media/video/tuner-simple.c                 |    6 
 drivers/media/video/tuner-types.c                  |    1 
 drivers/media/video/tvaudio.c                      |   42 -
 drivers/media/video/tveeprom.c                     |    2 
 drivers/media/video/tvp5150.c                      |    7 
 drivers/media/video/usbvideo/konicawc.c            |    9 
 drivers/media/video/usbvideo/vicam.c               |    4 
 drivers/media/video/v4l1-compat.c                  |   12 
 drivers/media/video/v4l2-common.c                  |    1 
 drivers/media/video/video-buf-dvb.c                |    2 
 drivers/media/video/videodev.c                     |   32 
 drivers/media/video/vino.c                         |    1 
 drivers/media/video/vivi.c                         |    5 
 drivers/media/video/vpx3220.c                      |    2 
 drivers/media/video/zoran_card.c                   |    6 
 drivers/media/video/zoran_driver.c                 |    7 
 drivers/media/video/zr36120.c                      |    6 
 include/linux/videodev2.h                          |    5 
 include/media/ir-common.h                          |    2 
 include/media/tuner-types.h                        |    3 
 include/media/tuner.h                              |    1 
 include/media/v4l2-common.h                        |   16 
 include/media/v4l2-dev.h                           |   10 
 197 files changed, 9023 insertions(+), 4211 deletions(-)
 create mode 100644 Documentation/video4linux/cx2341x/README.hm12
 create mode 100644 Documentation/video4linux/cx2341x/README.vbi
 delete mode 100644 drivers/media/dvb/frontends/dib3000-common.c
 delete mode 100644 drivers/media/dvb/frontends/dib3000-common.h
 create mode 100644 drivers/media/dvb/frontends/dib3000mc.h
 delete mode 100644 drivers/media/dvb/frontends/dib3000mc_priv.h
 create mode 100644 drivers/media/dvb/frontends/dibx000_common.c
 create mode 100644 drivers/media/dvb/frontends/dibx000_common.h
 create mode 100644 drivers/media/dvb/frontends/mt2060.c
 create mode 100644 drivers/media/dvb/frontends/mt2060.h
 create mode 100644 drivers/media/dvb/frontends/mt2060_priv.h
 create mode 100644 drivers/media/dvb/frontends/tda10086.c
 create mode 100644 drivers/media/dvb/frontends/tda10086.h
 create mode 100644 drivers/media/dvb/frontends/tda826x.c
 create mode 100644 drivers/media/dvb/frontends/tda826x.h
 create mode 100644 drivers/media/dvb/frontends/tua6100.c
 create mode 100644 drivers/media/dvb/frontends/tua6100.h
 create mode 100644 drivers/media/video/saa711x_regs.h

