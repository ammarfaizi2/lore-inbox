Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTHUMLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 08:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbTHUMLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 08:11:34 -0400
Received: from gate.perex.cz ([194.212.165.105]:21002 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262653AbTHUML1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:11:27 -0400
Date: Thu, 21 Aug 2003 14:10:12 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update 2003-08-21
Message-ID: <Pine.LNX.4.44.0308211404320.19864-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-08-21.patch.gz

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   22 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   12 
 include/sound/ac97_codec.h                                   |   17 
 include/sound/emu10k1.h                                      |    8 
 include/sound/version.h                                      |    2 
 sound/arm/sa11xx-uda1341.c                                   |    4 
 sound/core/oss/pcm_oss.c                                     |    8 
 sound/core/oss/pcm_plugin.c                                  |   88 --
 sound/core/oss/pcm_plugin.h                                  |    5 
 sound/drivers/opl3/opl3_lib.c                                |    2 
 sound/isa/gus/gusclassic.c                                   |    2 
 sound/isa/gus/gusextreme.c                                   |    2 
 sound/isa/gus/gusmax.c                                       |    2 
 sound/isa/opl3sa2.c                                          |    1 
 sound/pci/ac97/ac97_codec.c                                  |   23 
 sound/pci/ac97/ac97_patch.c                                  |   13 
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/azt3328.c                                          |   14 
 sound/pci/cs4281.c                                           |    6 
 sound/pci/cs46xx/cs46xx_lib.c                                |    2 
 sound/pci/emu10k1/emufx.c                                    |   12 
 sound/pci/ens1370.c                                          |    6 
 sound/pci/es1938.c                                           |   12 
 sound/pci/es1968.c                                           |  376 +++++------
 sound/pci/ice1712/ice1712.c                                  |   10 
 sound/pci/ice1712/ice1724.c                                  |   14 
 sound/pci/intel8x0.c                                         |  246 +++++--
 sound/pci/rme9652/hdsp.c                                     |    1 
 sound/pci/sonicvibes.c                                       |   10 
 sound/pci/trident/trident_main.c                             |    4 
 sound/pci/via82xx.c                                          |   18 
 sound/pci/ymfpci/ymfpci_main.c                               |    9 
 sound/sparc/amd7930.c                                        |    2 
 sound/sparc/cs4231.c                                         |    2 
 sound/usb/usbaudio.c                                         |   20 
 sound/usb/usbaudio.h                                         |    1 
 sound/usb/usbmixer.c                                         |    2 
 37 files changed, 522 insertions(+), 457 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/08/20 1.1221)
   ALSA update
     - updated documentation and timestamp

<perex@suse.cz> (03/08/20 1.1046.561.26)
   ALSA CVS update
   D:2003/08/20 10:59:59
   A:Jaroslav Kysela <perex@suse.cz>
   F:usb/usbaudio.c:1.62->1.63 
   F:usb/usbaudio.h:1.20->1.21 
   F:usb/usbmixer.c:1.21->1.22 
   L:Synced USB audio driver with the latest 2.6 code

<perex@suse.cz> (03/08/20 1.1046.561.25)
   ALSA CVS update
   D:2003/08/16 10:54:09
   A:Jaroslav Kysela <perex@suse.cz>
   F:core/oss/pcm_oss.c:1.45->1.46 
   L:Fixed open for O_RDWR when capture is not available

<perex@suse.cz> (03/08/20 1.1046.561.24)
   ALSA CVS update
   D:2003/08/14 17:05:13
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/ac97/ac97_codec.c:1.100->1.101 
   L:fix by James Courtier-Dutton <James@superbug.demon.co.uk>:
   L:
   L:Fixes ac3 passthru non-audio bit setting for AC97 codecs.
   L:
   L:I have :-
   L:Card: Intel ICH5
   L:Chip: Avance Logic ALC650 rev 0
   L:
   L:The problem I was having was that the spdif non-audio bit was not
   L:being set.
   L:This patch fixes that problem.

<perex@suse.cz> (03/08/20 1.1046.561.23)
   ALSA CVS update
   D:2003/08/14 12:05:38
   A:Takashi Iwai <tiwai@suse.de>
   F:drivers/opl3/opl3_lib.c:1.17->1.18 
   F:isa/gus/gusclassic.c:1.10->1.11 
   F:isa/gus/gusextreme.c:1.10->1.11 
   F:isa/gus/gusmax.c:1.11->1.12 
   F:pci/azt3328.c:1.2->1.3 
   F:pci/cs4281.c:1.43->1.44 
   F:pci/ens1370.c:1.47->1.48 
   F:pci/es1938.c:1.26->1.27 
   F:pci/es1968.c:1.51->1.52 
   F:pci/sonicvibes.c:1.25->1.26 
   F:pci/via82xx.c:1.45->1.46 
   F:pci/cs46xx/cs46xx_lib.c:1.62->1.63 
   F:pci/ice1712/ice1712.c:1.32->1.33 
   F:pci/ice1712/ice1724.c:1.14->1.15 
   F:pci/trident/trident_main.c:1.45->1.46 
   F:pci/ymfpci/ymfpci_main.c:1.40->1.41 
   F:sparc/amd7930.c:1.6->1.7 
   F:sparc/cs4231.c:1.8->1.9 
   L:fixed the wrong order of object destruction:
   L:  a released object is referred after the *_free() call.

<perex@suse.cz> (03/08/20 1.1046.561.22)
   ALSA CVS update
   D:2003/08/14 11:55:18
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/ymfpci/ymfpci_main.c:1.39->1.40 
   L:register dump in the proc file.

<perex@suse.cz> (03/08/20 1.1046.561.21)
   ALSA CVS update
   D:2003/08/13 14:14:31
   A:Takashi Iwai <tiwai@suse.de>
   F:arm/sa11xx-uda1341.c:1.11->1.12 
   L:fixed missing spin_lock_init().

<perex@suse.cz> (03/08/20 1.1046.561.20)
   ALSA CVS update
   D:2003/08/13 14:01:22
   A:Takashi Iwai <tiwai@suse.de>
   F:isa/opl3sa2.c:1.28->1.29 
   L:fixed the uninitialized spin_lock.

<perex@suse.cz> (03/08/20 1.1046.561.19)
   ALSA CVS update
   D:2003/08/11 13:37:56
   A:Takashi Iwai <tiwai@suse.de>
   F:Documentation/DocBook/writing-an-alsa-driver.tmpl:1.12->1.13 
   L:fix typos

<perex@suse.cz> (03/08/20 1.1046.561.18)
   ALSA CVS update
   D:2003/08/11 13:37:36
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/intel8x0.c:1.87->1.88 
   L:fix mixed up vendor/device ID's for Asus P4P800

<perex@suse.cz> (03/08/20 1.1046.561.17)
   ALSA CVS update
   D:2003/08/11 10:20:00
   A:Jaroslav Kysela <perex@suse.cz>
   F:pci/es1968.c:1.49->1.50 
   L:Removed bob_lock spinlock

<perex@suse.cz> (03/08/20 1.1046.561.16)
   ALSA CVS update
   D:2003/08/07 15:18:56
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/es1968.c:1.48->1.49 
   L:- hopefully fixed the capture.
   L:- align the buffers in 4k.
   L:- a bit code clean up.

<perex@suse.cz> (03/08/20 1.1046.561.15)
   ALSA CVS update
   D:2003/08/06 18:45:09
   A:Takashi Iwai <tiwai@suse.de>
   F:core/oss/pcm_plugin.c:1.15->1.16 
   F:core/oss/pcm_plugin.h:1.4->1.5 
   L:removed unused functions.

<perex@suse.cz> (03/08/20 1.1046.561.14)
   ALSA CVS update
   D:2003/08/06 18:44:50
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/es1968.c:1.47->1.48 
   L:removed buggy copy callback.
   L:the standard copy routine works properly.

<perex@suse.cz> (03/08/20 1.1046.561.13)
   ALSA CVS update
   D:2003/08/06 12:13:57
   A:Takashi Iwai <tiwai@suse.de>
   F:Documentation/ALSA-Configuration.txt:1.13->1.14 
   L:more descriptions for vx drivers.

<perex@suse.cz> (03/08/20 1.1046.561.12)
   ALSA CVS update
   D:2003/08/05 13:45:12
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/es1968.c:1.46->1.47 
   L:- fixed corruption of stream linked list in the interrupt handler.
   L:- clean up the unnecessary atomic_t and spinlocks.

<perex@suse.cz> (03/08/20 1.1046.561.11)
   ALSA CVS update
   D:2003/08/05 13:43:10
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/es1968.c:1.45->1.46 
   L:- rewritten the pm whitelist as a static list.
   L:- added more pci subsystem ids to the whitelist.

<perex@suse.cz> (03/08/20 1.1046.561.10)
   ALSA CVS update
   D:2003/08/05 13:42:23
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/emu10k1/emufx.c:1.36->1.37 
   L:fixed typos.

<perex@suse.cz> (03/08/20 1.1046.561.9)
   ALSA CVS update
   D:2003/07/30 19:54:01
   A:Jaroslav Kysela <perex@suse.cz>
   F:include/emu10k1.h:1.29->1.30 
   L:Fixed typos (GRP->GPR)

<perex@suse.cz> (03/08/20 1.1046.561.8)
   ALSA CVS update
   D:2003/07/30 16:35:33
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/es1968.c:1.44->1.45 
   L:added use_pm to the kernel boot parameter.

<perex@suse.cz> (03/08/20 1.1046.561.7)
   ALSA CVS update
   D:2003/07/30 15:39:38
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/intel8x0.c:1.86->1.87 
   L:- improved the probe/resume function.
   L:  check only the valid codec bits in chip_init() during resume.

<perex@suse.cz> (03/08/20 1.1046.561.6)
   ALSA CVS update
   D:2003/07/30 11:54:03
   A:Takashi Iwai <tiwai@suse.de>
   F:include/ac97_codec.h:1.30->1.31 
   F:pci/intel8x0.c:1.85->1.86 
   F:pci/via82xx.c:1.43->1.44 
   F:pci/ac97/ac97_codec.c:1.99->1.100 
   F:pci/ac97/ac97_patch.c:1.17->1.18 
   F:pci/ac97/ac97_patch.h:1.8->1.9 
   L:- added quirk type AC97_TUNE_AD_SHARING.
   L:- added mask field to snd_ac97_quirk.
   L:- new patch for AD1985.  set more config bits for line/mic sharing.
   L:- rewritten quirk table in C99 init style.
   L:- more quirks for intel ICH5/AD1985 boards.

<perex@suse.cz> (03/08/20 1.1046.561.5)
   ALSA CVS update
   D:2003/07/29 16:16:43
   A:Jaroslav Kysela <perex@suse.cz>
   F:pci/ice1712/ice1724.c:1.12->1.13 
   L:Fixed 192kHz support

<perex@suse.cz> (03/08/20 1.1046.561.4)
   ALSA CVS update
   D:2003/07/28 14:50:51
   A:Takashi Iwai <tiwai@suse.de>
   F:pci/rme9652/hdsp.c:1.41->1.42 
   L:added the support for rev 50 cards.

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

