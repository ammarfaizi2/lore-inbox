Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTIYVTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTIYVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:19:44 -0400
Received: from gate.perex.cz ([194.212.165.105]:8091 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261894AbTIYVTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:19:32 -0400
Date: Thu, 25 Sep 2003 23:19:13 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update 0.9.7
Message-ID: <Pine.LNX.4.53.0309252317360.1362@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-09-25.patch.gz

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt |   33 +-
 Documentation/sound/alsa/OSS-Emulation.txt      |    9
 include/sound/ac97_codec.h                      |   43 +++
 include/sound/asound.h                          |    3
 include/sound/emu10k1.h                         |    2
 include/sound/hdsp.h                            |    5
 include/sound/pcm_oss.h                         |    4
 include/sound/sscape_ioctl.h                    |    6
 include/sound/version.h                         |    6
 sound/core/hwdep.c                              |   23 +-
 sound/core/info.c                               |   18 -
 sound/core/ioctl32/ioctl32.c                    |    1
 sound/core/ioctl32/pcm32.c                      |    1
 sound/core/memalloc.c                           |    1
 sound/core/oss/pcm_oss.c                        |   82 ++++---
 sound/core/oss/pcm_plugin.c                     |    1
 sound/core/oss/pcm_plugin.h                     |    4
 sound/core/pcm_native.c                         |   10
 sound/core/sound.c                              |    1
 sound/drivers/dummy.c                           |    1
 sound/i2c/other/ak4xxx-adda.c                   |   28 +-
 sound/isa/cs423x/cs4236.c                       |    2
 sound/isa/cs423x/pc98.c                         |    2
 sound/isa/sscape.c                              |   44 +--
 sound/pci/Kconfig                               |   14 -
 sound/pci/ac97/ac97_codec.c                     |  270 ++++++++++++++----------
 sound/pci/ac97/ac97_local.h                     |    2
 sound/pci/ac97/ac97_patch.c                     |   76 +++++-
 sound/pci/ac97/ac97_proc.c                      |   26 ++
 sound/pci/cs46xx/cs46xx_lib.c                   |   12 -
 sound/pci/cs46xx/dsp_spos.c                     |    6
 sound/pci/emu10k1/emu10k1.c                     |    5
 sound/pci/emu10k1/emufx.c                       |   34 ++-
 sound/pci/emu10k1/emupcm.c                      |    5
 sound/pci/ens1370.c                             |    6
 sound/pci/es1968.c                              |   68 +++---
 sound/pci/ice1712/aureon.c                      |    4
 sound/pci/ice1712/ice1724.c                     |   39 ++-
 sound/pci/ice1712/revo.c                        |    5
 sound/pci/intel8x0.c                            |   56 ++++
 sound/pci/rme9652/hdsp.c                        |   43 ++-
 sound/pci/trident/trident_main.c                |   61 +++--
 sound/pci/via82xx.c                             |   93 ++++++--
 sound/pcmcia/vx/vx_entry.c                      |   12 -
 sound/ppc/daca.c                                |    8
 sound/ppc/pmac.c                                |    2
 sound/ppc/tumbler.c                             |   66 ++++-
 sound/usb/usbaudio.c                            |   16 -
 sound/usb/usbmixer.c                            |    3
 sound/usb/usbquirks.h                           |   13 +
 50 files changed, 851 insertions(+), 424 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/09/25 1.1342)
   ALSA CVS update
   D:2003/09/25 19:55:42
   C:RME HDSP driver,Sound Scape driver,ALSA Version
   A:Jaroslav Kysela <perex@suse.cz>
   F:include/hdsp.h:1.2->1.3
   F:include/sscape_ioctl.h:1.1->1.2
   F:include/version.h:1.23->1.24
   F:isa/sscape.c:1.4->1.5
   F:pci/rme9652/hdsp.c:1.43->1.44
   L:- fixed firmware ioctls for sscape and hdsp drivers (ioctl out of range)
   L:- updated ALSA version to 0.9.7

<perex@suse.cz> (03/09/25 1.1153.54.43)
   ALSA CVS update
   D:2003/09/24 17:47:04
   C:Digigram VX Pocket driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pcmcia/vx/vx_entry.c:1.2->1.3
   L:remove timer and clean up for 2.6 kernel.

<perex@suse.cz> (03/09/25 1.1153.54.42)
   ALSA CVS update
   D:2003/09/24 14:12:50
   C:USB generic driver
   A:Takashi Iwai <tiwai@suse.de>
   F:usb/usbaudio.c:1.64->1.65
   F:usb/usbmixer.c:1.22->1.23
   L:- don't create controls from selector units with a single content.
   L:- suppress the error if async-out or adaptive-in has only one EP.
   L:  don't create a sync pipe in this case.

<perex@suse.cz> (03/09/25 1.1153.54.41)
   ALSA CVS update
   D:2003/09/23 15:31:44
   C:Intel8x0 driver,VIA82xx driver,AC97 Codec Core,CS46xx driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/intel8x0.c:1.91->1.92
   F:pci/via82xx.c:1.51->1.52
   F:pci/ac97/ac97_patch.c:1.22->1.23
   F:pci/cs46xx/cs46xx_lib.c:1.63->1.64
   F:pci/cs46xx/dsp_spos.c:1.21->1.22
   L:added ac97 quirks:
   L:
   L:- Dell Precision 530 and Dimension 8300 (by Simon Munton <simon-alsa@munton.demon.co.uk>)
   L:- HP onboard

<perex@suse.cz> (03/09/25 1.1153.54.40)
   ALSA CVS update
   D:2003/09/23 15:17:21
   C:CS4236+ driver,PC98(CS423x) driver
   A:Takashi Iwai <tiwai@suse.de>
   F:isa/cs423x/cs4236.c:1.35->1.36
   F:isa/cs423x/pc98.c:1.4->1.5
   L:fixes by Uros Bizjak <uros@kss-loka.si>:
   L:
   L:- fixed the wrong DMA channel check in card->longname string
   L:  composition.

<perex@suse.cz> (03/09/25 1.1153.54.39)
   ALSA CVS update
   D:2003/09/17 14:34:33
   C:Documentation,ES1968 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:Documentation/ALSA-Configuration.txt:1.17->1.18
   F:pci/es1968.c:1.52->1.53
   L:- added enable_mpu option to enable/disable MPU401.
   L:- added the blacklist for MPU401.
   L:- removed the obsolete codes.

<perex@suse.cz> (03/09/25 1.1153.54.38)
   ALSA CVS update
   D:2003/09/17 13:42:05
   C:VIA82xx driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/via82xx.c:1.50->1.51
   L:- allow VAR for multi-channel stream.
   L:- use 48k only for DXS #3 on VIA8233A.

<perex@suse.cz> (03/09/25 1.1153.54.37)
   ALSA CVS update
   D:2003/09/16 17:34:48
   C:ALSA<-OSS emulation
   A:Takashi Iwai <tiwai@suse.de>
   F:core/oss/pcm_plugin.c:1.16->1.17
   F:core/oss/pcm_plugin.h:1.5->1.6
   L:- fixed the debug print for the recent gcc.
   L:- fixed the missing initialization of the recording frame size through
   L:  plugin.  the problem of zero-size read with the rate plugin should
   L:  be fixed now.

<perex@suse.cz> (03/09/25 1.1153.54.36)
   ALSA CVS update
   D:2003/09/16 16:09:35
   C:VIA82xx driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/via82xx.c:1.49->1.50
   L:don't restrict the capture sample rate even with dxs 48k fixed is given.

<perex@suse.cz> (03/09/25 1.1153.54.35)
   ALSA CVS update
   D:2003/09/16 07:57:34
   C:PCI drivers
   A:Jaroslav Kysela <perex@suse.cz>
   F:pci/Kconfig:1.7->1.8
   L:Replaced SOUND_GAMEPORT -> GAMEPORT

<perex@suse.cz> (03/09/25 1.1153.54.34)
   ALSA CVS update
   D:2003/09/16 07:55:18
   C:USB generic driver
   A:Jaroslav Kysela <perex@suse.cz>
   F:usb/usbaudio.c:1.63->1.64
   L:Clemens Ladisch <clemens@ladisch.de>
   L:All AUDIO_FORMAT_PCM formats are signed, even 8 bits.

<perex@suse.cz> (03/09/25 1.1153.54.33)
   ALSA CVS update
   D:2003/09/15 17:19:42
   C:IOCTL32 emulation
   A:Takashi Iwai <tiwai@suse.de>
   F:core/ioctl32/pcm32.c:1.14->1.15
   L:added missing SND_PCM_IOCTL_TSTAMP ioctl.

<perex@suse.cz> (03/09/25 1.1153.54.32)
   ALSA CVS update
   D:2003/09/15 08:38:00
   C:ENS1370/1+ driver
   A:Jaroslav Kysela <perex@suse.cz>
   F:pci/ens1370.c:1.48->1.49
   L:Distinguish the ENS1371+ and ENS1370 cards for pci_driver

<perex@suse.cz> (03/09/25 1.1153.54.31)
   ALSA CVS update
   D:2003/09/11 10:34:48
   C:Serial BUS drivers,ICE1724 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:i2c/other/ak4xxx-adda.c:1.5->1.6
   F:pci/ice1712/revo.c:1.3->1.4
   L:- fixed the reset of AK4355 codec.
   L:  the surround sounds on m-audio revo 7.1 should work now.
   L:- write to only the register image instead of i/o writing in
   L:  change the clock mode on AK codecs of revo board.
   L:- fixed the non-cleared memory.

<perex@suse.cz> (03/09/25 1.1153.54.30)
   ALSA CVS update
   D:2003/09/10 19:01:16
   C:ICE1724 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/ice1712/ice1724.c:1.17->1.18
   L:fixed the rate locking bug: the rate locking couldn't be changed any more
   L:once if iec958 input is chosen.

<perex@suse.cz> (03/09/25 1.1153.54.29)
   ALSA CVS update
   D:2003/09/10 17:26:26
   C:ICE1724 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/ice1712/ice1724.c:1.16->1.17
   L:use SIZE register to get the current DMA position.
   L:this register seems more reliable than BASE register.

<perex@suse.cz> (03/09/25 1.1153.54.28)
   ALSA CVS update
   D:2003/09/10 14:51:30
   C:ALSA<-OSS emulation
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/oss/pcm_oss.c:1.48->1.49
   F:include/pcm_oss.h:1.6->1.7
   L:Fixed comments in pcm_oss.h
   L:Fixed sync() routine for the partial playback transfers

<perex@suse.cz> (03/09/25 1.1153.54.27)
   ALSA CVS update
   D:2003/09/08 11:58:07
   C:ALSA Core
   A:Takashi Iwai <tiwai@suse.de>
   F:include/asound.h:1.31->1.32
   L:- added hwdep entry for usb-us428 driver.

<perex@suse.cz> (03/09/25 1.1153.54.26)
   ALSA CVS update
   D:2003/09/08 10:32:23
   C:VIA82xx driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/via82xx.c:1.48->1.49
   L:- added device mask bits to DXS channel check.
   L:- added an entry for DXS channel check.

<perex@suse.cz> (03/09/25 1.1153.54.25)
   ALSA CVS update
   D:2003/09/08 08:14:17
   C:ALSA<-OSS emulation
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/oss/pcm_oss.c:1.47->1.48
   L:Added handling for -EPIPE and -ESTRPIPE error codes in get_ptr and get_space
   L:functions.

<perex@suse.cz> (03/09/25 1.1153.54.24)
   ALSA CVS update
   D:2003/09/05 18:46:42
   C:Intel8x0 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/intel8x0.c:1.90->1.91
   L:- check CIV register to sync the current index position.
   L:  this may fix the noisy output on machines with sloppy interrupts.

<perex@suse.cz> (03/09/25 1.1153.54.23)
   ALSA CVS update
   D:2003/09/04 19:45:26
   C:HWDEP Midlevel
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/hwdep.c:1.19->1.20
   L:Use try_module_get() and module_put() to block the toplevel module
   L:Fixed returned error code in the release() callback

<perex@suse.cz> (03/09/25 1.1153.54.22)
   ALSA CVS update
   D:2003/09/04 19:12:30
   C:HWDEP Midlevel
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/hwdep.c:1.18->1.19
   L:Karsten Wiese <annabellesgarden@yahoo.de>
   L:Fixed hwdep hotplug problem

<perex@suse.cz> (03/09/25 1.1153.54.21)
   ALSA CVS update
   D:2003/09/04 18:46:56
   C:EMU10K1/EMU10K2 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/emu10k1/emufx.c:1.38->1.39
   L:fixed the buffer overlap on FX8010 PCM.

<perex@suse.cz> (03/09/25 1.1153.54.20)
   ALSA CVS update
   D:2003/09/04 10:09:21
   C:IOCTL32 emulation
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/ioctl32/ioctl32.c:1.17->1.18
   L:Removed duplicated include

<perex@suse.cz> (03/09/25 1.1153.54.19)
   ALSA CVS update
   D:2003/09/03 14:43:40
   C:Memalloc module,PCM Midlevel,ALSA Core,ALSA<-OSS emulation
   C:Generic drivers,RME9652 driver
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/memalloc.c:1.15->1.16
   F:core/pcm_native.c:1.79->1.80
   F:core/sound.c:1.47->1.48
   F:core/oss/pcm_oss.c:1.46->1.47
   F:drivers/dummy.c:1.24->1.25
   F:pci/rme9652/rme9652.c:1.36->1.37
   L:Felipe W Damasio <felipewd@terra.com.br>
   L:kill of not-required version.h inclusion

<perex@suse.cz> (03/09/25 1.1153.54.18)
   ALSA CVS update
   D:2003/09/02 19:07:31
   C:Intel8x0 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/intel8x0.c:1.89->1.90
   L:- set 48k only for the sample rate of SPDIF on nForce.

<perex@suse.cz> (03/09/25 1.1153.54.17)
   ALSA CVS update
   D:2003/09/02 19:06:40
   C:USB generic driver
   A:Takashi Iwai <tiwai@suse.de>
   F:usb/usbquirks.h:1.21->1.22
   L:Clemens Ladisch <clemens@ladisch.de>:
   L:
   L:- adds a quirk for the Midiman Ozone

<perex@suse.cz> (03/09/25 1.1153.54.16)
   ALSA CVS update
   D:2003/09/02 19:06:12
   C:Trident driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/trident/trident_main.c:1.46->1.47
   L: Clemens Ladisch <clemens@ladisch.de>:
   L:
   L:- reduces stack usage in snd_trident_mixer()

<perex@suse.cz> (03/09/25 1.1153.54.15)
   ALSA CVS update
   D:2003/09/02 15:02:34
   C:PPC DACA driver
   A:Takashi Iwai <tiwai@suse.de>
   F:ppc/daca.c:1.9->1.10
   L:Frank Murphy <murphyf+alsa@f-m.fm>:
   L:
   L:fixed left-right balance inversion on powermac DACA.

<perex@suse.cz> (03/09/25 1.1153.54.14)
   ALSA CVS update
   D:2003/09/01 10:53:26
   C:AC97 Codec Core
   A:Takashi Iwai <tiwai@suse.de>
   F:include/ac97_codec.h:1.33->1.34
   F:pci/ac97/ac97_patch.c:1.21->1.22
   F:pci/ac97/ac97_proc.c:1.1->1.2
   L:James Courtier-Dutton <James@superbug.demon.co.uk>:
   L:- enabled SPDIF input of ALC650.

<perex@suse.cz> (03/09/25 1.1153.54.13)
   ALSA CVS update
   D:2003/09/01 10:20:56
   C:ICE1712 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/ice1712/aureon.c:1.2->1.3
   L:fixed the SPDIF bit on aureon boards.
   L:spdif out should work now.

<perex@suse.cz> (03/09/25 1.1153.54.12)
   ALSA CVS update
   D:2003/08/31 20:47:16
   C:PCM Midlevel
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/pcm_native.c:1.78->1.79
   L:get_page() fix

<perex@suse.cz> (03/09/25 1.1153.54.11)
   ALSA CVS update
   D:2003/08/29 10:22:27
   C:EMU10K1/EMU10K2 driver
   A:Takashi Iwai <tiwai@suse.de>
   F:include/emu10k1.h:1.30->1.31
   F:pci/emu10k1/emu10k1.c:1.20->1.21
   F:pci/emu10k1/emufx.c:1.37->1.38
   F:pci/emu10k1/emupcm.c:1.21->1.22
   L:Peter Zubaj <pzad@pobox.sk>:
   L:- Added the support of AC3 passthrough on Audigy.
   L:
   L:James Courtier-Dutton <James@superbug.demon.co.uk>:
   L:- Use different driver name for Audigy2.

<perex@suse.cz> (03/09/25 1.1153.54.10)
   ALSA CVS update
   D:2003/08/28 16:36:44
   C:AC97 Codec Core
   A:Takashi Iwai <tiwai@suse.de>
   F:include/ac97_codec.h:1.32->1.33
   F:pci/ac97/ac97_codec.c:1.102->1.103
   F:pci/ac97/ac97_patch.c:1.20->1.21
   L:- added the detection of revision of ALC650 chip by
   L:  James Courtier-Dutton <James@superbug.demon.co.uk>
   L:- fixed the patch_alc650() to refer to the detected revision.
   L:- detect the availability of stereo mute bits in snd_ac97_cmute_new().

<perex@suse.cz> (03/09/25 1.1153.54.9)
   ALSA CVS update
   D:2003/08/28 16:07:26
   C:Documentation,VIA82xx driver
   A:Takashi Iwai <tiwai@suse.de>
   F:Documentation/ALSA-Configuration.txt:1.16->1.17
   F:pci/via82xx.c:1.47->1.48
   L:- added the check of DXS supports (so far, empty).
   L:  the default value of dxs_support is again 0.
   L:- fixed the description.

<perex@suse.cz> (03/09/25 1.1153.54.8)
   ALSA CVS update
   D:2003/08/27 17:44:23
   C:PPC PMAC driver,PPC Tumbler driver
   A:Takashi Iwai <tiwai@suse.de>
   F:ppc/pmac.c:1.23->1.24
   F:ppc/tumbler.c:1.22->1.23
   L:- initialize tumbler/snapper audio via gpio before i2c initialization.
   L:- enabled capture on snapper.  don't know whether it works :)

<perex@suse.cz> (03/09/25 1.1153.54.7)
   ALSA CVS update
   D:2003/08/27 17:17:31
   C:AC97 Codec Core
   A:Takashi Iwai <tiwai@suse.de>
   F:include/ac97_codec.h:1.31->1.32
   F:pci/ac97/ac97_codec.c:1.101->1.102
   F:pci/ac97/ac97_local.h:1.1->1.2
   F:pci/ac97/ac97_patch.c:1.19->1.20
   L:- added the support for stereo mute switches on AD198x.
   L:- clean up of creation routines of normal stereo controls.

<perex@suse.cz> (03/09/25 1.1153.54.6)
   ALSA CVS update
   D:2003/08/27 17:12:03
   C:Documentation,VIA82xx driver
   A:Takashi Iwai <tiwai@suse.de>
   F:Documentation/ALSA-Configuration.txt:1.15->1.16
   F:pci/via82xx.c:1.46->1.47
   L:- use dxs_support=3 (48k fixed) as default, since there are so many problems
   L:  with dxs_support=0.
   L:- added kernel boot parameter for dxs_support option.

<perex@suse.cz> (03/09/25 1.1153.54.5)
   ALSA CVS update
   D:2003/08/27 17:05:36
   C:Documentation
   A:Takashi Iwai <tiwai@suse.de>
   F:Documentation/OSS-Emulation.txt:1.4->1.5
   L:added descriptions for whole-frag and no-silence commands.

<perex@suse.cz> (03/09/25 1.1153.54.4)
   ALSA CVS update
   D:2003/08/27 17:04:36
   C:AC97 Codec Core
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/ac97/ac97_patch.c:1.18->1.19
   L:- define AD198x bits.
   L:- enable AD-compatible mode on AD1985.

<perex@suse.cz> (03/09/25 1.1153.54.3)
   ALSA CVS update
   D:2003/08/25 08:53:37
   C:ALSA Core
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/info.c:1.39->1.40
   L:Jeff Muizelaar <muizelaar@rogers.com>
   L:The attached patch cleans up the usage of the size variable and removes size1.


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
