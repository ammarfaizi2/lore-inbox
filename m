Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVKAT5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVKAT5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVKAT5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:57:05 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:30929 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751249AbVKAT5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:57:04 -0500
Message-Id: <20051101193453.894677000@localhost>
Date: Tue, 01 Nov 2005 17:34:53 -0200
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Cc: Mauro Carvalho Chehab <mauro_chehab@yahoo.com.br>
Subject: [patch 000/176] Video4Linux Updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
	Lots of changes on V4L since 2.6.13. 

	As we have 2 Mb on 176 patches, I'll not send all of these to the LKML list. These are available at: 
http://www.linuxtv.org/downloads/video4linux/patches/2.6.14/

	Patch v4l_896.patch depends on DVB patchset series.

	Relevant changes:
		Support for em28xx based usb2 boards;
		Several new boards added;
		Several cleanups;
		Newer decoders added;
		Newer audio processors added.

	We are also preparing to integrate ivtv drivers on kernel. Some changes are made to prepare for this integration.

Cheers, 
Mauro.

-------------------------

Summary of changes:

-Added support for OEM version of FlyTV Platinum mini
-Added new Avermedia card 550
-Added Behold TV 409 FM
-Capitalized hex A-F changed to lowercase in pci subsystem id constants
-Implemented the v4l2 mpeg api for blackbird cards.
-Climov's previous patch <missing changelog entry>:
-Implemented TUNER_SET_STANDBY on cx88 init.
-Add bttv card 137 - Conceptronic CTVFMi v2
-Don't enable gpioirq until after card probe.
-Added new card GoTView PCI 7135
-Fixed typos
-Strip trailing whitespace
-Use KEY_MEDIA instead of KEY_VIDEOMODESWITCH
-Lower switch from VHF_LO to VHF_HI for Philips 1216ME MK3
-Refine input handling for Manli/Beholder.
-Enable DVB support for DViCO FusionHDTV5 Lite.
-Included CB3 structures on tda8290 that should be changed
-Some clean up in cx88-tvaudio.c
-Fixed gcc 4.0 compile warnings by moving var declarations to the top of the function or block.
-Fix a number of sparse warnings.
-TS DMA buffer synchronization was inverted
-Strip trailing whitespace
-Added support for the Philips TD1316 tuner
-Added support for the following cards:
-Update documentation
-Small fixes.
-I've reverted a patch by mistake. fixing it
-Add new RTD cards
-Improved coding style for timer settings
-Fix for problem with audio register setup via DSP access
-Remove some #if 0 which doesn't have any sense
-Cardlist update.
-Fix build for 2.6.14
-Initial code for Texas Instruments TVP5150A and TVP5150AM1
-Move some #if kernel version into compat.h
-Tvp5150 included on makefile.
-Increased eeprom dump to 128 bytes
-Fixed input selection.
-Some V4L2 API calls implemented on msp3400.c.
-Update the tveeprom tuner list with the tuner
-Change the number of lines in the input signal
-Fix source charset. Make symbols UTF-8.
-Add remote for DVB-T300 Remote.
-Cx88 cardlist updated. Now, it also includes PCI subsystem IDs.
-Added support for LifeView FlyTV Platinum Mini2.
-Set IF of tda8275 according to tv norm.
-BTTV Boards now use the same CodingStyle as cx88 and saa7134.
-Included missing card numbers
-Boards renamed to BTTV_BOARD_xxx
-Updated an entry to reflect changes on tuner-simple.c
-Added more PCI ID.
-DVB/V4L bt8xx tree-merge is currently broken.
-Added IR for LifeView FlyTV Platinum Mini2.
-Included audio chips enum
-Added new card: Prolink PixelView PlayTV MPEG2 PV-M4900
-Enable support for the IR Remote on Compro Videomate T200
-Added Kworld Vstream ExpertDVD.
-Reindent cx88-tvaudio.c to keep coding style.
-Remote for KWorld Terminator.
-Full mute of saa7134 on mute command.
-Added Osprey 440 card.
-Changed { .pll = 1, } to { .pll = PLL_28, }
-Added analog support for ATI HDTV Wonder
-Corrected settings for SECAM-L
-Fix typo.
-Enable S-Video input on DViCO FusionHDTV5 Lite
-Added scripts and CARDLIST for em2820.
-Fixed build.
-Implement some differences in video output port
-Alsa support for saa7134 that should work. Wonderful
-Check ->kthread correctly
-Removed trailing whitespace
-Fix build for 2.6.14
-Fixed kernel oops when hotswapping PC Cards
-Fix compile with gcc-2.95
-Fixed a bug that caused some saa7133 code to run on saa7134 boards
-VIDIOCSFREQ and VIDIOCGFREQ expect an unsigned long as argument.
-Fixed include when compiling at kernel tree
-Created make changelog to make easier to generate patches.
-Add the adapter/address prefix to the tda9887 kernel messages.
-Some improvements at msp3400.c from ivtv code.
-More improvements at msp3400.c from ivtv code.
-Fixed registry value in em2820-i2c.c which corrects a tuner setting (also removed that call from em2820-video.c)
-Added support for the terratec cinergy 250 usb tv remote
-Include newer I2C ID at  ../linux/include/media/id.h:
-Add DVB card WinFast DTV1000-T
-Included support for em2800.
-Don't bother Gerd with bttv-cards patches.
-The wm8775 is a Wolfson Microelectronics 24-bit, 96kHz ADC with 4
-Be sure to enable video-buf-dvb in kernel build.
-Fix build warnings:
-Added card 75 AVerMedia AVerTVHD MCE A180
-Whitespace cleanups
-Fixed typo in module param description
-2005-10-12 07:02  mrechberger
-Fixed bad em2820 remote layout values, set KNC One and
-Several Improvement on I2C IR handling for em2820:
-Chip_id removed since it isn't required anymore.
-Added support for saa7113.
-Added support for Terratec Cinergy 250 USB
-CodingStyle fixes
-Remotes for the Cinergy 200 USB and Cinergy 250 USB are the same.
-Added Asound Skyeye bttv card.
-New config option for tda9887 to specifically set intercarrier
-Add SKNet Monster TV Mobile card.
-More intellect on clearing in bits on irq lock.
-This patch adds the VIDIOC_LOG_STATUS to videodev2.h and adds
-Don't request GPINT on Avermedia TV Capture 98.
-Whitespace Cleanups.
-Whitespaces Cleanups.
-Replaced kmalloc/kfree with usb_buffer_alloc/usb_buffer_free to get
-After msp34xxg_reset, msp_wake_thread should be called to
-Add support for tda8275a
-Some changes to allow compiling cx88 and saa7134 without
-VIDIOC_LOG_STATUS is added to videodev2.h this can be enabled
-Strip trailing whitespaces.
-Supports the Pinnacle PCTV 110i board, video inputs, and remote.
-Replaced obsolete video_get_drvdata and video_set_drvdata
-Cleanup dev assignment
-Commented obsoleted stuff at videodev headers.
-Added driver for Cirrus Logic Low Voltage Stereo A/D Converter.
-SAA713x keymaps and key builders were moved from ir-kbd-i2c.c
-Cleanup some unnecessary ALSA memory (de/)allocations
-Added autodetection code to tda8290, to avoid conflicts with
-Fixed log for tveeprom on em28xx cards.
-Set tuner type in VIDIOC_G_TUNER.
-Corrected probing code for tda8290
-Unify whitespaces.
-Fixed user mode compiling.
-Rearranged print order to present a correct answer.
-Analog support for Asus P7131 Dual - TDA8275A
-Add card: PCTV Cardbus TV/Radio (ITO25 Rev:2B)
-Modified settings for MSI VOX USB 2.0
-Fixed settings for MSI Vox USB 2.0 (saa7114 is missing atm)
-Added saa7114 initcode for MSI Vox USB 2.0
-Create Kconfig files for cx88 and saa7134 directories.
-Added saa7114 support on i2c address 0x42
-Fix bug 5484: ASUS digimatrix card doesnt work with PAL tuner
-Fixed tda8290 autodetection
-Update em2800 scaler code and comments based on info from empiatech
-Fixed broken API link and indentation.
-Move cx88 and saa7134 configuration out of
-Improve Kconfig user-friendliness for hybrid dvb/v4l boards.
-Some module rename and small fixes
-Fix compilation with 2.6.8.
-Added Pinnacle Dazzle DVC 90
-Improved isoc error detection.
-Fixed bttv to accept radio devices like tea5767.
-Fix bug with setting mt2050 radio frequency
-Correcting fixes to accept radio devices like tea5767.
-Added support for NXT200X based cards (ATI HDTV Wonder)
-ISO C90 forbids mixed declarations and code
-Added DVB support for AVerMedia AVerTVHD MCE A180
-Fixed bttv to accept radio devices like tea5767
-Updated comments for AVerTVHD A180
-Quick and dirty fix for AUDC_CONFIG_PINNACLE.
-Some cleanups at I2C stuff and fixing when tuner addr is set.
-Moved some user defines to be out of __KERNEL__ define.
-Module em2820 renamed to em28xx and moved to V4L dir.
-VIDEO_CX88 need not depend on EXPERIMENTAL
-Second round of i2c IDs redefinition cleanup.
-Renamed common structures to em28xx
-I2c-id.h Updated to reflect the newer drivers.
-Saa7113 renamed to saa711x
-Add em28xx to kernel build.
-Fixed typo.
-Change CONFIG_EM28XX to CONFIG_VIDEO_EM28XX
-Correct nicam audio settings to match dscaler
-Rollback recent i2c change to solve tuner detection breakage
-Work-around to allow hybrid DVB card to autoload the tda9887
-New Avermedia 303 card (without radio).
Adaptto changes in v4l tree:
renameBTTV_FOO --> BTTV_BOARD_FOO
-Fixing headers to compile cleanly.
-Miscelaneous fixes for em28xx
-I2C hardware named changed to wright value.
-utsname included to em28xx-video.c
-Makefile fixes for compiling em28xx.

 Documentation/video4linux/API.html            |    2
 Documentation/video4linux/CARDLIST.bttv       |  329 -
 Documentation/video4linux/CARDLIST.cx88       |   71
 Documentation/video4linux/CARDLIST.em28xx     |   22
 Documentation/video4linux/CARDLIST.saa7134    |   26
 Documentation/video4linux/CARDLIST.tuner      |    4
 Documentation/video4linux/README.cx88         |    7
 Documentation/video4linux/README.saa7134      |    1
 Documentation/video4linux/bttv/Cards          |   18
 Documentation/video4linux/bttv/README         |    6
 Documentation/video4linux/bttv/Sound-FAQ      |   11
 Documentation/video4linux/bttv/Tuners         |    4
 Documentation/video4linux/lifeview.txt        |   64
 drivers/media/common/ir-common.c              |    4
 drivers/media/dvb/bt8xx/dvb-bt8xx.c           |   48
 drivers/media/video/Kconfig                   |   65
 drivers/media/video/Makefile                  |    2
 drivers/media/video/bt832.c                   |   93
 drivers/media/video/bt832.h                   |    4
 drivers/media/video/bttv-cards.c              | 5807 ++++++++++++------------
 drivers/media/video/bttv-driver.c             |  381 -
 drivers/media/video/bttv-gpio.c               |    2
 drivers/media/video/bttv-i2c.c                |  143
 drivers/media/video/bttv-if.c                 |    4
 drivers/media/video/bttv-risc.c               |  114
 drivers/media/video/bttv.h                    |  564 +-
 drivers/media/video/bttvp.h                   |   14
 drivers/media/video/cs53l32a.c                |  234
 drivers/media/video/cx88/Kconfig              |   93
 drivers/media/video/cx88/Makefile             |    6
 drivers/media/video/cx88/cx88-blackbird.c     |  693 ++
 drivers/media/video/cx88/cx88-cards.c         |  522 +-
 drivers/media/video/cx88/cx88-core.c          |   59
 drivers/media/video/cx88/cx88-dvb.c           |   51
 drivers/media/video/cx88/cx88-i2c.c           |   22
 drivers/media/video/cx88/cx88-input.c         |    2
 drivers/media/video/cx88/cx88-mpeg.c          |   25
 drivers/media/video/cx88/cx88-reg.h           |   12
 drivers/media/video/cx88/cx88-tvaudio.c       | 1606 +++---
 drivers/media/video/cx88/cx88-video.c         |   38
 drivers/media/video/cx88/cx88.h               |   55
 drivers/media/video/em28xx/Kconfig            |   14
 drivers/media/video/em28xx/Makefile           |   12
 drivers/media/video/em28xx/em28xx-cards.c     |  439 +
 drivers/media/video/em28xx/em28xx-core.c      | 1243 ++++-
 drivers/media/video/em28xx/em28xx-i2c.c       |  866 +++
 drivers/media/video/em28xx/em28xx-input.c     |  354 +
 drivers/media/video/em28xx/em28xx-video.c     | 2667 +++++++++--
 drivers/media/video/em28xx/em28xx.h           |  825 ++-
 drivers/media/video/ir-kbd-gpio.c             |  103
 drivers/media/video/ir-kbd-i2c.c              |  932 +--
 drivers/media/video/msp3400.c                 |  742 ++-
 drivers/media/video/mt20xx.c                  |  206
 drivers/media/video/saa6588.c                 |    9
 drivers/media/video/saa711x.c                 |  809 ++-
 drivers/media/video/saa7134/Kconfig           |   70
 drivers/media/video/saa7134/Makefile          |    6
 drivers/media/video/saa7134/saa6752hs.c       |  193
 drivers/media/video/saa7134/saa7134-alsa.c    | 2483 +++++++---
 drivers/media/video/saa7134/saa7134-cards.c   |  839 ++-
 drivers/media/video/saa7134/saa7134-core.c    |   88
 drivers/media/video/saa7134/saa7134-dvb.c     |  178
 drivers/media/video/saa7134/saa7134-empress.c |    6
 drivers/media/video/saa7134/saa7134-i2c.c     |   28
 drivers/media/video/saa7134/saa7134-input.c   |  380 +
 drivers/media/video/saa7134/saa7134-oss.c     |   73
 drivers/media/video/saa7134/saa7134-reg.h     |   27
 drivers/media/video/saa7134/saa7134-ts.c      |   39
 drivers/media/video/saa7134/saa7134-tvaudio.c |   24
 drivers/media/video/saa7134/saa7134-video.c   |  187
 drivers/media/video/saa7134/saa7134.h         |   59
 drivers/media/video/tda7432.c                 |   17
 drivers/media/video/tda8290.c                 |  722 ++
 drivers/media/video/tda9875.c                 |   57
 drivers/media/video/tda9887.c                 |  187
 drivers/media/video/tea5767.c                 |    8
 drivers/media/video/tuner-core.c              |  100
 drivers/media/video/tuner-simple.c            |  151
 drivers/media/video/tvaudio.c                 |   31
 drivers/media/video/tveeprom.c                |  500 +-
 drivers/media/video/tvmixer.c                 |   54
 drivers/media/video/tvp5150.c                 | 1429 ++++-
 drivers/media/video/tvp5150_reg.h             |  173
 drivers/media/video/v4l1-compat.c             |    6
 drivers/media/video/video-buf.c               |   18
 drivers/media/video/wm8775.c                  |  266 +
 include/linux/i2c-id.h                        |   18
 include/linux/videodev.h                      |  102
 include/linux/videodev2.h                     |  260 -
 include/media/audiochip.h                     |   31
 include/media/id.h                            |   15
 include/media/ir-common.h                     |    6
 include/media/ir-kbd-i2c.h                    |   22
 include/media/saa7146_vv.h                    |    2
 include/media/tuner.h                         |   24
 include/media/video-buf.h                     |    4
 96 files changed, 19951 insertions(+), 9381 deletions(-)


