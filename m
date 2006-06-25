Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWFYF72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWFYF72 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 01:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWFYF72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 01:59:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750881AbWFYF71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 01:59:27 -0400
Message-Id: <20060625054747.PS476808000000@infradead.org>
Date: Sun, 25 Jun 2006 02:47:47 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 000/244] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It contains the following stuff:

   - Clean up some cruft in or51132 frontend
   - Improve line-in handling
   - Add support for VIDIOC_INT_S_CRYSTAL_FREQ internal command.
   - Fix video input setting of em28xx, use _INT_S_VIDEO_ROUTING in tvp5150
   - Change all emails to the currently used one.
   - Removed trailing newlines
   - Fix spelling error / typo in comments
   - Fix spelling
   - Avoid unnecessary firmware re-loads in or51132 frontend
   - Remove a wee bit of cruft
   - Remove DMX_GET_EVENT and associated data structures
   - Add support for pcHDTV HD5500 ATSC/QAM
   - Cx88 cleanup: move CX88_BOARD_PCHDTV_HD5500 to the end of the cards array
   - Add support for FE_GET_FRONTEND to or51132 frontend
   - Budget-core doesn't check if register adapter fails
   - Whitespace cleanups at media/radio
   - Silence some dprintk's in cx88-mpeg
   - Add sysfs device links to dvb devices
   - Lgdt330x: update supported cards list in comments
   - Dvb-bt8xx: add support for DViCO FusionHDTV DVB-T Lite 2nd revision
   - Fix a tab error in cx14110.c, dprintk
   - Fix a type error in dvb_frontend.c
   - Kill drivers/media/common/saa7146_vv_ksyms.c
   - Fix alignment after the replacement from semaphore to muxex
   - Cx88: added support for KWorld MCE 200 Deluxe
   - Cx88-tvaudio: replace 'if' with 'switch..case'
   - Fix KNC1 card frontend detection
   - Cx88-blackbird: allow proper detection of PAL vs. NTSC video standard
   - Cx88-blackbird: fix typo
   - Remove compat stuff for DMX_GET_EVENT
   - Remove DMX_GET_EVENT and associated data structures
   - KWorld HardwareMpegTV XPert: Enable Blackbird MPEG encoder support
   - Cxusb: lgh064f: set auxiliary byte in pll_set
   - Add support for Samsung TCPG 6121P30A PAL tuner.
   - KWorld HardwareMpegTV XPert: set encoder video standard based on tvnorm
   - Drivers/media/dvb/dvb-usb/: possible cleanups
   - Cx88-blackbird: clean up the buffers when closing the MPEG stream
   - Fix display name for LG TDVS-H06xF
   - [PATCH] update pwc driver
   - ZC0301 driver updates
   - Create standalone fe_lgh064f header
   - Dvb-bt8xx: use fe_lgh06xf.h
   - Cx88-dvb: use fe_lgh06xf.h
   - Cxusb: use fe_lgh06xf.h
   - B2c2-flexcop: use fe_lgh06xf.h
   - DVB core changes for PLL refactoring
   - Convert cx22700 to refactored tuner code
   - Convert cx22702 to refactored tuner code
   - Convert mt312 to refactored tuner code
   - Convert stv0297 to refactored tuner code
   - Convert tda8083 to refactored tuner code
   - Convert ves1820 to refactored tuner code
   - Convert ves1x93 to refactored tuner code
   - Convert stv0299 to refactored tuner code
   - Convert sp887x to refactored tuner code
   - Convert sp8870 to refactored tuner code
   - Convert tda1004x to refactored tuner code
   - Convert s5h1420 to refactored tuner code
   - Convert l64871 to refactored tuner code
   - Convert mt352 to refactored tuner code
   - Convert tda10021 to refactored tuner code
   - Convert cx24110 to refactored tuner code
   - Convert dvb_dummy_fe to refactored tuner code
   - Convert or51132 to refactored tuner code
   - Convert nxt200x to refactored tuner code
   - Convert nxt6000 to refactored tuner code
   - Convert zl10353 to refactored tuner code
   - Convert cx24123 to refactored tuner code
   - Convert dib3000* to refactored tuner code
   - Convert lgdt330x to refactored tuner code
   - Convert bsbe1/bsru6 to refactored tuner code
   - Convert pluto2 to refactored tuner code
   - Convert ttpci/av7110 to refactored tuner code
   - Convert ttpci/budget to refactored tuner code
   - Convert ttpci/budget-ci to refactored tuner code
   - Convert ttpci/budget-av to refactored tuner code
   - Convert ttpci/budget-patch to refactored tuner code
   - Convert saa7134-dvb to refactored tuner code
   - Convert dvb-ttusb-budget to refactored tuner code
   - Convert core dvb-usb pll code to refactored tuner code
   - Convert dvb-usb/umt-010 to refactored tuner code
   - Convert digtv to refactored tuner code
   - Convert dibusb* to refactored tuner code
   - Convert dvb-pll to be a refactored tuner
   - Convert bt8xx to refactored tuner code
   - Sort out support for non-attached tuners on mt352
   - Add support for non-attached tuners to zl10353
   - Convert cx88-dvb to refactored tuner code
   - Trim documentation
   - Fix dvb-usb tuner code
   - Rename fe_lgh06xf.h to lg_h06xf.h
   - ZC0301 driver updates
   - AverMedia 6 Eyes AVS6EYES support
   - V4l: rename TUNER_LG_TDVS_H062F to TUNER_LG_TDVS_H06XF
   - Dvb: rename dvb_pll_tdvs_tua6034 to dvb_pll_lg_tdvs_h06xf
   - Convert flexcop-fe-tuner to refactored tuner code
   - Convert cxusb to refactored tuner code
   - Convert calls from _pllbuf() to _calc_reg()
   - Fix tda10046 tuning
   - Additional frontend_init safety checks
   - Compilation for DVB_AV7110_FIRMWARE seems to be weird
   - Vivi.c: possible cleanups
   - Convert lnbp21 to a module
   - Add isl6421 module
   - Support new dvb-ttusb-budget boards with stv0297
   - Added missing docs at kernel tree
   - Added cx2341x header file
   - Add missing pll gate control calls
   - Em28xx/: possible cleanups
   - Core: ULE fixes and RFC4326 additions
   - Pwc-dec23 oops fix
   - Remove compatibility check for I2C_PEC
   - Fix checking logic for a broken xawtv version
   - Cx88-blackbird: use firmware api commands defined in cx2341x.h
   - Cx88-blackbird: use standard filename for cx23416 firmware
   - Return value is ssize_t
   - Cx88-blackbird: pause the encoder during frequency change
   - Cx88-blackbird: use encoder firmware filename defined in cx2341x.h
   - Fix CI interface on KNC1 DVBT and DVBC cards
   - Add math routines required by DVB demods
   - Cx88: add autodetection for another Twinhan VP-3054 board.
   - Add missing include
   - Make the table static
   - Cx88 NTSC VBI fixes
   - Adjust VBI offset to match value reported in VBI format
   - Add support for the cx25836/7 video decoder.
   - Stop/start microcontroller when changing sampling frequency
   - Audio soft reset improvements
   - Fix PLL refactoring breakage to WinTV NOVA T USB 2 driver
   - Fix cx24123 diseqc
   - Change the sweeprate for TT C1500 using QAM64
   - Remove the spagetti code gotos that aren't useful
   - Cx88-blackbird: add support for ProLink Pixelview Playtv@P7000
   - Usbvideo/quickcam_messenger driver v4l
   - Subject: Pinnacle PCTV grey remote control support
   - Bttv-gpio-irq is no longer used, remove it
   - [PATCH] Genpix 8PSK->USB driver (Take 2)
   - Minor code cleanup on the genpix-module
   - Fix Pinnacle 300i
   - Fix some compilation warnings
   - New cx88 card #50: NPG Tech RealTV
   - Documentation: whitespace cleanup
   - Miropcm20: fix sub-optimal header inclusion for sound/oss/aci.h
   - Fixes after dvb_tuner_ops-conversion
   - Change dvb_frontend_ops to be a real field instead of a pointer field inside dvb_frontend
   - Trivial videodev2.h patch
   - Doc. sources: expose video4linux/
   - Add support for the Texas Instruments TLV320AIC23B audio codec
   - Add NTSC sliced VBI support to the cx25840 module.
   - Wrong syntax: instead of bool, it was written boolean
   - KWorld HardwareMpegTV XPert: enable s-video/composite video inputs
   - Cx88: Add basic support for Leadtek Winfast DTV2000H card
   - Cx88: IR remote support for DTV2000H
   - Bttv: add autodetection support for Osprey 230
   - Make dvb/b2c2/flexcop-fe-tuner.c:alps_tdee4_stv0297_tuner_set_params() static
   - No drivers should use VIDIOC_*_OLD
   - Several improvements at videodev.c
   - Vivi.c were ported to the newer videodev2 format.
   - Fixed cx25840 to work with PAL/M
   - Removed all references to kernel stuff from videodev.h and videodev2.h
   - Zoran strncpy() fix
   - Cx88: whitespace cleanup
   - Support for new version of Satelco EasyWatch DVB-S light
   - There were a cross-reference on cpia and cpia_pp/cpia_usb
   - Fixes for card cx88 #50
   - Fix cinergyt2_poll() to allow non-blocking IO on frontend
   - PATCH cx88-mpeg: cx8802_restart_queue() for blackbird
   - Cxusb: add support for DViCO FusionHDTV DVB-T Dual USB based on zl10353
   - CinergyT2: whitespace cleanup
   - Cx88: add support for DViCO FusionHDTV DVB-T Dual PCI based on zl10353
   - Cx88: #ifdef cleanups
   - Cx88-dvb: clean up long linewraps
   - Default "yes", no.  default y, yes.
   - Remove uneeded prototype
   - Fix problems with AV7110 firmware building
   - Fixes some userspace dependencies at V4L2 public api header
   - Small bug in saa7127.c
   - Fix: videodev.c were cleaning the pointer, not the values
   - Saa7134 card (LifeView3000 NTSC)
   - Whitespace cleanups
   - Ovcamship position at Kconfig changed
   - Update cardlist documentation
   - Lgdt330x: fix missing line in VSB snr decoding logic
   - Kconfig: fix description for saa7115 module
   - Fix card cx88 #50 remote
   - Fix cx88-alsa vs IRQ remote conflict
   - Don't kill cx88 DMA sound on channel change
   - Cx88-tvaudio.c must #include <linux/config.h>
   - Cx88: add support for FusionHDTV 3 Gold (original revision)
   - Drivers/media/video/vivi.c: make 2 functions static
   - Drivers/media/video/pwc/: make code static
   - Fix userbits debug prints
   - Fix up funky logic in dvb
   - Cx88: clear EN_I2SIN_ENABLE bit for ASUS PVR-416 to enable audio
   - Fix use-after-free bug in cpia2 driver
   - ATSC frontend support
   - Add basic ATSC support to DST
   - Add support for VP-3250 ATSC card
   - Make ASIC RESET Conditional
   - Implement tuning algorithm as a module parameter
   - Use device specific algorithms
   - Utilize the device specific algorithm callbacks
   - Explicit defining of type is not necessary with MULTI_FE
   - Initialize ATSC frontend
   - Add DVB-S specific demod names
   - Add in tuner names
   - Fix string length
   - Add Board Names
   - ATSC tuner doesn't have variable length field
   - Add more Firmware and Tuner names
   - ATSC typecheck bugfix
   - Fix Daughterboard detection
   - Remove spurious newlines in dprintk's. Add dst(card-num) as prefix in dprintk
   - Dprintk macro beautification
   - Distinguish between STV0299 and MB86A15 based NIM's
   - Fix a bug in tuner detection
   - Bug-fix: Fix memory overflow
   - DCTNEW and ATSC fixes
   - Replace NEWTUNE with TS188
   - VLF fixes for DCT
   - Initial go at MMI
   - Fix CA Info and Application Info
   - Comment out MMI functions for now
   - Static variables mustn't be EXPORT_SYMBOL 'ed
   - Conditionally enable 5 byte diseqc commands
   - Add support for the DNTV Live! mini DVB-T card.
   - Add new MPEG control/ioctl definitions to videodev2.h
   - Add videodev support for VIDIOC_S/G/TRY_EXT_CTRLS.
   - Add helper functions for control processing to v4l2-common.
   - Add CX2341X MPEG encoder module.
   - Use control helpers for saa7115, cx25840, msp3400.
   - Update cx2341x fw encoding API doc.
   - Port cx88-blackbird to the new MPEG API.
   - Port new MPEG API to saa7134-empress with saa6752hs
   - Avoid newer usages of obsoleted experimental MPEGCOMP API
   - Add cx2341x-specific control array to cx2341x.c
   - Disable bitrate_mode when encoding mpeg-1.
   - allow selecting CX2341x port mode
   - Explicitly set the enum values.
   - Merge tda9887 module into tuner.
   - Cx88-blackbird: always set encoder height based on tvnorm->id
   - Added some BTTV PCI IDs for newer boards
   - git-dvb versus matroxfb
   - git-dvb: tea575x-tuner build fix

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/video4linux/CARDLIST.bttv                    |    4 
 Documentation/video4linux/CARDLIST.cx88                    |   11 
 Documentation/video4linux/CARDLIST.saa7134                 |    1 
 Documentation/video4linux/CARDLIST.tuner                   |    3 
 Documentation/video4linux/CQcam.txt                        |  203 -
 Documentation/video4linux/Zoran                            |   23 
 Documentation/video4linux/bttv/CONTRIBUTORS                |    8 
 Documentation/video4linux/cx2341x/fw-calling.txt           |   69 
 Documentation/video4linux/cx2341x/fw-decoder-api.txt       |  327 ++
 Documentation/video4linux/cx2341x/fw-dma.txt               |   94 
 Documentation/video4linux/cx2341x/fw-encoder-api.txt       |  780 +++++
 Documentation/video4linux/cx2341x/fw-memory.txt            |  143 +
 Documentation/video4linux/cx2341x/fw-osd-api.txt           |  342 ++
 Documentation/video4linux/cx2341x/fw-upload.txt            |   49 
 Documentation/video4linux/cx88/hauppauge-wintv-cx88-ir.txt |   54 
 Documentation/video4linux/et61x251.txt                     |   52 
 Documentation/video4linux/ibmcam.txt                       |  168 -
 Documentation/video4linux/ov511.txt                        |   32 
 Documentation/video4linux/sn9c102.txt                      |   78 
 Documentation/video4linux/v4lgrab.c                        |  192 +
 Documentation/video4linux/w9968cf.txt                      |  162 -
 Documentation/video4linux/zc0301.txt                       |   80 
 drivers/media/Kconfig                                      |    7 
 drivers/media/common/Makefile                              |    2 
 drivers/media/common/ir-functions.c                        |    1 
 drivers/media/common/ir-keymaps.c                          |   84 
 drivers/media/common/saa7146_fops.c                        |    4 
 drivers/media/common/saa7146_hlp.c                         |    1 
 drivers/media/common/saa7146_video.c                       |    2 
 drivers/media/common/saa7146_vv_ksyms.c                    |   12 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c                  |  144 -
 drivers/media/dvb/b2c2/flexcop-pci.c                       |   19 
 drivers/media/dvb/b2c2/flexcop-usb.c                       |   10 
 drivers/media/dvb/b2c2/flexcop.c                           |   12 
 drivers/media/dvb/bt8xx/bt878.c                            |   11 
 drivers/media/dvb/bt8xx/dst.c                              |  792 ++++-
 drivers/media/dvb/bt8xx/dst_ca.c                           |  492 ++-
 drivers/media/dvb/bt8xx/dst_common.h                       |   43 
 drivers/media/dvb/bt8xx/dvb-bt8xx.c                        |  158 -
 drivers/media/dvb/bt8xx/dvb-bt8xx.h                        |    4 
 drivers/media/dvb/cinergyT2/Kconfig                        |    2 
 drivers/media/dvb/cinergyT2/cinergyT2.c                    |   10 
 drivers/media/dvb/dvb-core/Makefile                        |    6 
 drivers/media/dvb/dvb-core/dmxdev.c                        |    3 
 drivers/media/dvb/dvb-core/dvb_ca_en50221.c                |   25 
 drivers/media/dvb/dvb-core/dvb_demux.c                     |    4 
 drivers/media/dvb/dvb-core/dvb_frontend.c                  |  177 -
 drivers/media/dvb/dvb-core/dvb_frontend.h                  |  201 -
 drivers/media/dvb/dvb-core/dvb_math.c                      |  147 +
 drivers/media/dvb/dvb-core/dvb_math.h                      |   58 
 drivers/media/dvb/dvb-core/dvb_net.c                       |  230 +
 drivers/media/dvb/dvb-core/dvbdev.c                        |    5 
 drivers/media/dvb/dvb-core/dvbdev.h                        |    4 
 drivers/media/dvb/dvb-usb/Kconfig                          |   10 
 drivers/media/dvb/dvb-usb/Makefile                         |    3 
 drivers/media/dvb/dvb-usb/cxusb.c                          |  156 -
 drivers/media/dvb/dvb-usb/dibusb-common.c                  |   17 
 drivers/media/dvb/dvb-usb/dibusb-mb.c                      |   11 
 drivers/media/dvb/dvb-usb/digitv.c                         |   23 
 drivers/media/dvb/dvb-usb/dtt200u-fe.c                     |    8 
 drivers/media/dvb/dvb-usb/dvb-usb-dvb.c                    |   17 
 drivers/media/dvb/dvb-usb/dvb-usb-i2c.c                    |   42 
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h                    |    4 
 drivers/media/dvb/dvb-usb/dvb-usb.h                        |    8 
 drivers/media/dvb/dvb-usb/gp8psk-fe.c                      |  272 ++
 drivers/media/dvb/dvb-usb/gp8psk.c                         |  282 +-
 drivers/media/dvb/dvb-usb/gp8psk.h                         |   79 
 drivers/media/dvb/dvb-usb/umt-010.c                        |    8 
 drivers/media/dvb/dvb-usb/vp702x-fe.c                      |    7 
 drivers/media/dvb/dvb-usb/vp7045-fe.c                      |    9 
 drivers/media/dvb/frontends/Kconfig                        |   18 
 drivers/media/dvb/frontends/Makefile                       |    2 
 drivers/media/dvb/frontends/bcm3510.c                      |    4 
 drivers/media/dvb/frontends/bsbe1.h                        |   10 
 drivers/media/dvb/frontends/bsru6.h                        |   10 
 drivers/media/dvb/frontends/cx22700.c                      |   37 
 drivers/media/dvb/frontends/cx22700.h                      |    4 
 drivers/media/dvb/frontends/cx22702.c                      |   35 
 drivers/media/dvb/frontends/cx22702.h                      |    7 
 drivers/media/dvb/frontends/cx24110.c                      |   32 
 drivers/media/dvb/frontends/cx24110.h                      |    5 
 drivers/media/dvb/frontends/cx24123.c                      |  195 -
 drivers/media/dvb/frontends/cx24123.h                      |   13 
 drivers/media/dvb/frontends/dib3000-common.h               |    2 
 drivers/media/dvb/frontends/dib3000.h                      |    4 
 drivers/media/dvb/frontends/dib3000mb.c                    |   17 
 drivers/media/dvb/frontends/dib3000mc.c                    |   20 
 drivers/media/dvb/frontends/dvb-pll.c                      |  205 +
 drivers/media/dvb/frontends/dvb-pll.h                      |   18 
 drivers/media/dvb/frontends/dvb_dummy_fe.c                 |   21 
 drivers/media/dvb/frontends/fe_lgh06xf.h                   |  120 
 drivers/media/dvb/frontends/isl6421.c                      |  163 +
 drivers/media/dvb/frontends/isl6421.h                      |   46 
 drivers/media/dvb/frontends/l64781.c                       |   17 
 drivers/media/dvb/frontends/l64781.h                       |    4 
 drivers/media/dvb/frontends/lg_h06xf.h                     |   74 
 drivers/media/dvb/frontends/lgdt330x.c                     |   25 
 drivers/media/dvb/frontends/lgdt330x.h                     |    1 
 drivers/media/dvb/frontends/lnbp21.c                       |  159 +
 drivers/media/dvb/frontends/lnbp21.h                       |  102 
 drivers/media/dvb/frontends/mt312.c                        |   52 
 drivers/media/dvb/frontends/mt312.h                        |    4 
 drivers/media/dvb/frontends/mt352.c                        |   79 
 drivers/media/dvb/frontends/mt352.h                        |    6 
 drivers/media/dvb/frontends/nxt200x.c                      |   28 
 drivers/media/dvb/frontends/nxt200x.h                      |    4 
 drivers/media/dvb/frontends/nxt6000.c                      |   35 
 drivers/media/dvb/frontends/nxt6000.h                      |    4 
 drivers/media/dvb/frontends/or51132.c                      |  167 -
 drivers/media/dvb/frontends/or51132.h                      |    2 
 drivers/media/dvb/frontends/or51211.c                      |    4 
 drivers/media/dvb/frontends/s5h1420.c                      |   61 
 drivers/media/dvb/frontends/s5h1420.h                      |    4 
 drivers/media/dvb/frontends/sp8870.c                       |   37 
 drivers/media/dvb/frontends/sp8870.h                       |    4 
 drivers/media/dvb/frontends/sp887x.c                       |   50 
 drivers/media/dvb/frontends/sp887x.h                       |    6 
 drivers/media/dvb/frontends/stv0297.c                      |   79 
 drivers/media/dvb/frontends/stv0297.h                      |    8 
 drivers/media/dvb/frontends/stv0299.c                      |   51 
 drivers/media/dvb/frontends/stv0299.h                      |    5 
 drivers/media/dvb/frontends/tda10021.c                     |   45 
 drivers/media/dvb/frontends/tda10021.h                     |    6 
 drivers/media/dvb/frontends/tda1004x.c                     |   61 
 drivers/media/dvb/frontends/tda1004x.h                     |    5 
 drivers/media/dvb/frontends/tda8083.c                      |   18 
 drivers/media/dvb/frontends/tda8083.h                      |    4 
 drivers/media/dvb/frontends/ves1820.c                      |   25 
 drivers/media/dvb/frontends/ves1820.h                      |    4 
 drivers/media/dvb/frontends/ves1x93.c                      |   35 
 drivers/media/dvb/frontends/ves1x93.h                      |    4 
 drivers/media/dvb/frontends/zl10353.c                      |   50 
 drivers/media/dvb/frontends/zl10353.h                      |    8 
 drivers/media/dvb/pluto2/pluto2.c                          |   21 
 drivers/media/dvb/ttpci/Kconfig                            |    3 
 drivers/media/dvb/ttpci/Makefile                           |    8 
 drivers/media/dvb/ttpci/av7110.c                           |  205 -
 drivers/media/dvb/ttpci/budget-av.c                        |  349 +-
 drivers/media/dvb/ttpci/budget-ci.c                        |  103 
 drivers/media/dvb/ttpci/budget-core.c                      |    6 
 drivers/media/dvb/ttpci/budget-patch.c                     |   57 
 drivers/media/dvb/ttpci/budget.c                           |  103 
 drivers/media/dvb/ttusb-budget/Kconfig                     |    2 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c          |  314 +-
 drivers/media/dvb/ttusb-dec/ttusb_dec.c                    |    6 
 drivers/media/dvb/ttusb-dec/ttusbdecfe.c                   |    8 
 drivers/media/radio/Kconfig                                |    2 
 drivers/media/radio/Makefile                               |    2 
 drivers/media/radio/miropcm20-radio.c                      |   17 
 drivers/media/radio/miropcm20-rds-core.c                   |   34 
 drivers/media/radio/miropcm20-rds.c                        |    2 
 drivers/media/radio/radio-aimslab.c                        |   51 
 drivers/media/radio/radio-aztech.c                         |   45 
 drivers/media/radio/radio-cadet.c                          |  317 +-
 drivers/media/radio/radio-gemtek-pci.c                     |   47 
 drivers/media/radio/radio-gemtek.c                         |   33 
 drivers/media/radio/radio-maestro.c                        |   10 
 drivers/media/radio/radio-maxiradio.c                      |   81 
 drivers/media/radio/radio-rtrack2.c                        |   35 
 drivers/media/radio/radio-sf16fmi.c                        |   41 
 drivers/media/radio/radio-sf16fmr2.c                       |    5 
 drivers/media/radio/radio-terratec.c                       |   63 
 drivers/media/radio/radio-trust.c                          |   27 
 drivers/media/radio/radio-typhoon.c                        |    5 
 drivers/media/radio/radio-zoltrix.c                        |   31 
 drivers/media/video/Kconfig                                |   79 
 drivers/media/video/Makefile                               |    7 
 drivers/media/video/arv.c                                  |    3 
 drivers/media/video/bt866.c                                |  377 ++
 drivers/media/video/bt8xx/bttv-cards.c                     |   10 
 drivers/media/video/bt8xx/bttv-gpio.c                      |   14 
 drivers/media/video/bt8xx/bttv-input.c                     |    2 
 drivers/media/video/bt8xx/bttv.h                           |    1 
 drivers/media/video/bt8xx/bttvp.h                          |    2 
 drivers/media/video/bw-qcam.c                              |    3 
 drivers/media/video/c-qcam.c                               |    1 
 drivers/media/video/cpia.c                                 |   22 
 drivers/media/video/cpia.h                                 |    3 
 drivers/media/video/cpia2/cpia2.h                          |    1 
 drivers/media/video/cpia2/cpia2_v4l.c                      |    6 
 drivers/media/video/cpia_pp.c                              |    8 
 drivers/media/video/cpia_usb.c                             |    6 
 drivers/media/video/cx2341x.c                              |  917 ++++++
 drivers/media/video/cx25840/cx25840-audio.c                |   62 
 drivers/media/video/cx25840/cx25840-core.c                 |  328 +-
 drivers/media/video/cx25840/cx25840-core.h                 |    8 
 drivers/media/video/cx25840/cx25840-vbi.c                  |  179 -
 drivers/media/video/cx88/Kconfig                           |    3 
 drivers/media/video/cx88/cx88-alsa.c                       |    5 
 drivers/media/video/cx88/cx88-blackbird.c                  |  987 +------
 drivers/media/video/cx88/cx88-cards.c                      |  204 +
 drivers/media/video/cx88/cx88-core.c                       |    8 
 drivers/media/video/cx88/cx88-dvb.c                        |  362 +-
 drivers/media/video/cx88/cx88-i2c.c                        |    8 
 drivers/media/video/cx88/cx88-input.c                      |   40 
 drivers/media/video/cx88/cx88-mpeg.c                       |   50 
 drivers/media/video/cx88/cx88-tvaudio.c                    |   20 
 drivers/media/video/cx88/cx88-vbi.c                        |    4 
 drivers/media/video/cx88/cx88.h                            |   29 
 drivers/media/video/dsbr100.c                              |    1 
 drivers/media/video/em28xx/em28xx-cards.c                  |   64 
 drivers/media/video/em28xx/em28xx-core.c                   |   12 
 drivers/media/video/em28xx/em28xx-i2c.c                    |   31 
 drivers/media/video/em28xx/em28xx-input.c                  |    8 
 drivers/media/video/em28xx/em28xx-video.c                  |   22 
 drivers/media/video/em28xx/em28xx.h                        |    8 
 drivers/media/video/et61x251/et61x251_core.c               |    3 
 drivers/media/video/ir-kbd-i2c.c                           |   60 
 drivers/media/video/ks0127.c                               |  846 ++++++
 drivers/media/video/ks0127.h                               |   53 
 drivers/media/video/meye.c                                 |    5 
 drivers/media/video/msp3400-driver.c                       |  112 
 drivers/media/video/msp3400-kthreads.c                     |   40 
 drivers/media/video/ov511.c                                |    4 
 drivers/media/video/ov511.h                                |    1 
 drivers/media/video/planb.c                                |    1 
 drivers/media/video/pms.c                                  |    3 
 drivers/media/video/pwc/Kconfig                            |   13 
 drivers/media/video/pwc/Makefile                           |   11 
 drivers/media/video/pwc/pwc-ctrl.c                         |  703 ++---
 drivers/media/video/pwc/pwc-dec1.c                         |   50 
 drivers/media/video/pwc/pwc-dec1.h                         |   43 
 drivers/media/video/pwc/pwc-dec23.c                        |  947 +++++++
 drivers/media/video/pwc/pwc-dec23.h                        |   67 
 drivers/media/video/pwc/pwc-if.c                           | 1347 ++++------
 drivers/media/video/pwc/pwc-kiara.c                        |  575 ++++
 drivers/media/video/pwc/pwc-kiara.h                        |    8 
 drivers/media/video/pwc/pwc-misc.c                         |   67 
 drivers/media/video/pwc/pwc-timon.c                        | 1132 ++++++++
 drivers/media/video/pwc/pwc-timon.h                        |    8 
 drivers/media/video/pwc/pwc-uncompress.c                   |  154 -
 drivers/media/video/pwc/pwc-uncompress.h                   |    4 
 drivers/media/video/pwc/pwc-v4l.c                          | 1252 +++++++++
 drivers/media/video/pwc/pwc.h                              |  180 -
 drivers/media/video/saa5246a.c                             |    1 
 drivers/media/video/saa5249.c                              |    1 
 drivers/media/video/saa7110.c                              |    1 
 drivers/media/video/saa7115.c                              |  137 -
 drivers/media/video/saa7127.c                              |    2 
 drivers/media/video/saa7134/saa6752hs.c                    |  321 +-
 drivers/media/video/saa7134/saa7134-alsa.c                 |    2 
 drivers/media/video/saa7134/saa7134-cards.c                |   58 
 drivers/media/video/saa7134/saa7134-dvb.c                  |  535 ++-
 drivers/media/video/saa7134/saa7134-empress.c              |   24 
 drivers/media/video/saa7134/saa7134-input.c                |   13 
 drivers/media/video/saa7134/saa7134.h                      |    3 
 drivers/media/video/se401.h                                |    1 
 drivers/media/video/sn9c102/sn9c102_core.c                 |    3 
 drivers/media/video/stradis.c                              |    1 
 drivers/media/video/stv680.c                               |    1 
 drivers/media/video/tda9875.c                              |    3 
 drivers/media/video/tda9887.c                              |  461 ---
 drivers/media/video/tea5767.c                              |    2 
 drivers/media/video/tlv320aic23b.c                         |  217 +
 drivers/media/video/tuner-3036.c                           |    1 
 drivers/media/video/tuner-core.c                           |   34 
 drivers/media/video/tuner-simple.c                         |    2 
 drivers/media/video/tuner-types.c                          |   38 
 drivers/media/video/tveeprom.c                             |    2 
 drivers/media/video/tvmixer.c                              |    8 
 drivers/media/video/tvp5150.c                              |   45 
 drivers/media/video/usbvideo/Kconfig                       |   12 
 drivers/media/video/usbvideo/Makefile                      |    1 
 drivers/media/video/usbvideo/quickcam_messenger.c          | 1122 ++++++++
 drivers/media/video/usbvideo/quickcam_messenger.h          |  126 
 drivers/media/video/usbvideo/usbvideo.h                    |    1 
 drivers/media/video/v4l1-compat.c                          |    1 
 drivers/media/video/v4l2-common.c                          |  533 +++
 drivers/media/video/video-buf-dvb.c                        |    5 
 drivers/media/video/videodev.c                             | 1282 +++++++++
 drivers/media/video/vino.c                                 |    2 
 drivers/media/video/vivi.c                                 |  672 ++--
 drivers/media/video/vpx3220.c                              |    1 
 drivers/media/video/w9966.c                                |    1 
 drivers/media/video/zc0301/Kconfig                         |    6 
 drivers/media/video/zc0301/Makefile                        |    2 
 drivers/media/video/zc0301/zc0301_core.c                   |   26 
 drivers/media/video/zc0301/zc0301_pas202bcb.c              |    4 
 drivers/media/video/zc0301/zc0301_pb0330.c                 |  187 +
 drivers/media/video/zc0301/zc0301_sensor.h                 |   26 
 drivers/media/video/zoran.h                                |    8 
 drivers/media/video/zoran_card.c                           |   88 
 drivers/media/video/zoran_device.c                         |    2 
 drivers/media/video/zoran_driver.c                         |   27 
 drivers/media/video/zoran_procfs.c                         |    1 
 drivers/video/matrox/matroxfb_base.c                       |   52 
 fs/compat_ioctl.c                                          |   33 
 include/linux/dvb/dmx.h                                    |   26 
 include/linux/i2c-id.h                                     |    3 
 include/linux/videodev.h                                   |   69 
 include/linux/videodev2.h                                  |  578 ++--
 include/media/cx2341x.h                                    |  195 +
 include/media/ir-common.h                                  |    5 
 include/media/ir-kbd-i2c.h                                 |    3 
 include/media/ovcamchip.h                                  |    1 
 include/media/pwc-ioctl.h                                  |  325 ++
 include/media/saa7115.h                                    |   11 
 include/media/saa7146_vv.h                                 |    2 
 include/media/tuner.h                                      |   13 
 include/media/tvp5150.h                                    |   34 
 include/media/v4l2-common.h                                |   32 
 include/media/v4l2-dev.h                                   |  385 ++
 include/media/video-buf-dvb.h                              |    3 
 include/media/video-buf.h                                  |    1 
 include/sound/tea575x-tuner.h                              |    3 
 305 files changed, 22424 insertions(+), 7856 deletions(-)

