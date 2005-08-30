Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVH3MMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVH3MMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVH3MMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:12:36 -0400
Received: from gate.perex.cz ([82.113.61.162]:44177 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751399AbVH3MMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:12:36 -0400
Date: Tue, 30 Aug 2005 14:12:34 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA GIT SYNC] ALSA version 1.0.10rc1+
Message-ID: <Pine.LNX.4.61.0508301409110.9772@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2005-08-30.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt              |    1 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   15 
 include/linux/sound.h                                        |    2 
 include/sound/ac97_codec.h                                   |    9 
 include/sound/ad1816a.h                                      |    1 
 include/sound/asound.h                                       |    6 
 include/sound/cs46xx.h                                       |    2 
 include/sound/emu10k1.h                                      |    2 
 include/sound/gus.h                                          |    8 
 include/sound/pcm.h                                          |    1 
 include/sound/version.h                                      |    4 
 include/sound/ymfpci.h                                       |    6 
 sound/arm/pxa2xx-ac97.c                                      |   12 
 sound/core/memalloc.c                                        |    5 
 sound/core/memory.c                                          |    2 
 sound/core/oss/pcm_oss.c                                     |   11 
 sound/core/pcm_compat.c                                      |   49 -
 sound/core/pcm_lib.c                                         |   20 
 sound/core/pcm_native.c                                      |   14 
 sound/core/sound_oss.c                                       |    7 
 sound/core/timer.c                                           |   16 
 sound/drivers/vx/vx_mixer.c                                  |    4 
 sound/drivers/vx/vx_pcm.c                                    |    8 
 sound/isa/ad1816a/ad1816a.c                                  |    5 
 sound/isa/ad1816a/ad1816a_lib.c                              |   14 
 sound/isa/ad1848/ad1848_lib.c                                |    1 
 sound/isa/cmi8330.c                                          |    4 
 sound/isa/cs423x/cs4231_lib.c                                |    2 
 sound/isa/gus/gus_io.c                                       |    6 
 sound/isa/opl3sa2.c                                          |  114 ++
 sound/isa/sb/sb16_main.c                                     |    2 
 sound/pci/Kconfig                                            |   10 
 sound/pci/ac97/Makefile                                      |    2 
 sound/pci/ac97/ac97_bus.c                                    |   79 +
 sound/pci/ac97/ac97_codec.c                                  |   85 +-
 sound/pci/ac97/ac97_patch.c                                  |  455 ++++++++---
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/ali5451/ali5451.c                                  |    6 
 sound/pci/atiixp.c                                           |   10 
 sound/pci/au88x0/au88x0_pcm.c                                |   10 
 sound/pci/ca0106/ca0106_main.c                               |    8 
 sound/pci/ca0106/ca0106_mixer.c                              |    4 
 sound/pci/cmipci.c                                           |    2 
 sound/pci/cs46xx/cs46xx.c                                    |    2 
 sound/pci/cs46xx/cs46xx_lib.c                                |   18 
 sound/pci/emu10k1/emu10k1.c                                  |    2 
 sound/pci/emu10k1/emu10k1_main.c                             |    8 
 sound/pci/emu10k1/emu10k1x.c                                 |    4 
 sound/pci/emu10k1/emufx.c                                    |   26 
 sound/pci/emu10k1/emumixer.c                                 |   23 
 sound/pci/emu10k1/emupcm.c                                   |    7 
 sound/pci/ens1370.c                                          |    2 
 sound/pci/fm801.c                                            |    8 
 sound/pci/hda/Makefile                                       |    2 
 sound/pci/hda/hda_codec.c                                    |   97 +-
 sound/pci/hda/hda_codec.h                                    |    1 
 sound/pci/hda/hda_generic.c                                  |    5 
 sound/pci/hda/hda_intel.c                                    |  157 ++-
 sound/pci/hda/hda_patch.h                                    |    3 
 sound/pci/hda/patch_analog.c                                 |    4 
 sound/pci/hda/patch_cmedia.c                                 |    1 
 sound/pci/hda/patch_realtek.c                                |    9 
 sound/pci/hda/patch_si3054.c                                 |  300 +++++++
 sound/pci/ice1712/delta.c                                    |   10 
 sound/pci/ice1712/ice1712.c                                  |   10 
 sound/pci/ice1712/ice1724.c                                  |    6 
 sound/pci/intel8x0.c                                         |   57 +
 sound/pci/korg1212/korg1212.c                                |    4 
 sound/pci/nm256/nm256.c                                      |   93 +-
 sound/pci/rme32.c                                            |    4 
 sound/pci/rme96.c                                            |    4 
 sound/pci/rme9652/hdsp.c                                     |   55 -
 sound/pci/rme9652/hdspm.c                                    |   33 
 sound/pci/rme9652/rme9652.c                                  |   24 
 sound/pci/trident/trident_main.c                             |   10 
 sound/pci/via82xx.c                                          |   17 
 sound/pci/via82xx_modem.c                                    |    3 
 sound/pci/ymfpci/ymfpci_main.c                               |  232 +++--
 sound/pcmcia/vx/vxpocket.c                                   |   12 
 sound/sound_core.c                                           |   27 
 sound/synth/emux/emux_synth.c                                |    1 
 sound/usb/usbaudio.c                                         |  320 ++++---
 sound/usb/usbmidi.c                                          |  111 ++
 sound/usb/usx2y/usx2yhwdeppcm.c                              |    2 
 84 files changed, 2036 insertions(+), 703 deletions(-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
