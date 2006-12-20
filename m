Return-Path: <linux-kernel-owner+w=401wt.eu-S964939AbWLTIwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWLTIwc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 03:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWLTIwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 03:52:32 -0500
Received: from gate.perex.cz ([212.20.107.50]:42530 "EHLO gate.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964939AbWLTIwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 03:52:31 -0500
Date: Wed, 20 Dec 2006 09:52:28 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] alsa-git merge request
Message-ID: <Pine.LNX.4.61.0612200936460.13335@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
  (linus branch)

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-12-20.patch.gz

Additional notes:

  The GIT tree contains only small fixes.


The following files will be updated:

 .../sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    8 ++-
 include/sound/pcm_oss.h                            |    1 
 include/sound/version.h                            |    4 +-
 include/sound/ymfpci.h                             |    5 +-
 sound/aoa/codecs/snd-aoa-codec-onyx.h              |    1 
 sound/aoa/codecs/snd-aoa-codec-tas.c               |    1 
 sound/core/control.c                               |    2 -
 sound/core/oss/pcm_oss.c                           |   52 +++++++++++++++-----
 sound/core/pcm.c                                   |    4 ++
 sound/core/pcm_lib.c                               |    8 +--
 sound/core/rawmidi.c                               |    4 +-
 sound/core/seq/seq_memory.c                        |    2 -
 sound/core/sgbuf.c                                 |    2 -
 sound/isa/gus/gus_mem.c                            |    7 +--
 sound/isa/sb/sb_common.c                           |    2 -
 sound/isa/wavefront/wavefront_synth.c              |    2 -
 sound/pci/ac97/ac97_codec.c                        |   10 ++--
 sound/pci/ac97/ac97_patch.c                        |    7 ++-
 sound/pci/ad1889.c                                 |    4 +-
 sound/pci/ali5451/ali5451.c                        |    5 +-
 sound/pci/als300.c                                 |    6 +-
 sound/pci/atiixp.c                                 |    2 -
 sound/pci/atiixp_modem.c                           |    2 -
 sound/pci/au88x0/au88x0.c                          |    2 -
 sound/pci/azt3328.c                                |    5 +-
 sound/pci/bt87x.c                                  |    4 +-
 sound/pci/ca0106/ca0106.h                          |    2 -
 sound/pci/ca0106/ca0106_main.c                     |   37 +++++++++++---
 sound/pci/cmipci.c                                 |    2 -
 sound/pci/cs4281.c                                 |    2 -
 sound/pci/cs46xx/cs46xx_lib.c                      |    2 -
 sound/pci/cs5535audio/cs5535audio.c                |    2 -
 sound/pci/echoaudio/echoaudio.c                    |    6 +-
 sound/pci/emu10k1/emu10k1_main.c                   |    5 +-
 sound/pci/emu10k1/emu10k1x.c                       |    9 ++-
 sound/pci/ens1370.c                                |    2 -
 sound/pci/es1938.c                                 |    4 +-
 sound/pci/es1968.c                                 |    8 ++-
 sound/pci/fm801.c                                  |    2 -
 sound/pci/hda/hda_codec.c                          |    3 -
 sound/pci/hda/hda_intel.c                          |    3 +
 sound/pci/hda/hda_proc.c                           |   53 ++++++++++++++++++--
 sound/pci/hda/patch_analog.c                       |    8 ++-
 sound/pci/hda/patch_realtek.c                      |    4 +-
 sound/pci/hda/patch_si3054.c                       |    3 +
 sound/pci/ice1712/ice1712.c                        |    2 -
 sound/pci/ice1712/ice1724.c                        |    2 -
 sound/pci/intel8x0.c                               |    4 +-
 sound/pci/intel8x0m.c                              |    4 +-
 sound/pci/korg1212/korg1212.c                      |    2 -
 sound/pci/maestro3.c                               |    4 +-
 sound/pci/mixart/mixart.c                          |    5 +-
 sound/pci/nm256/nm256.c                            |    2 -
 sound/pci/pcxhr/pcxhr.c                            |    2 -
 sound/pci/riptide/riptide.c                        |    5 +-
 sound/pci/rme32.c                                  |    3 +
 sound/pci/rme96.c                                  |    3 +
 sound/pci/rme9652/hdsp.c                           |    9 ++-
 sound/pci/rme9652/hdspm.c                          |    3 -
 sound/pci/rme9652/rme9652.c                        |    7 ++-
 sound/pci/sonicvibes.c                             |    5 +-
 sound/pci/trident/trident_main.c                   |    6 +-
 sound/pci/via82xx.c                                |    6 +-
 sound/pci/via82xx_modem.c                          |    2 -
 sound/pci/vx222/vx222.c                            |    4 +-
 sound/pci/ymfpci/ymfpci.c                          |    5 --
 sound/pci/ymfpci/ymfpci_main.c                     |   39 ++++++++-------
 sound/usb/usbaudio.c                               |    3 -
 68 files changed, 270 insertions(+), 166 deletions(-)


The following things were done:

Adrian Bunk:
      [ALSA] sound/core/control.c: remove dead code

Akinobu Mita:
      [ALSA] sound: initialize rawmidi substream list
      [ALSA] sound: fix PCM substream list

Andreas Mohr:
      [ALSA] via82xx: add __devinitdata

Christian Hesse:
      [ALSA] hda-codec - fix typo in PCI IDs

Clemens Ladisch:
      [ALSA] use the ALIGN macro
      [ALSA] use the roundup macro
      [ALSA] pcm core: fix silence_start calculations

Glen Masgai:
      [ALSA] ymfpci: fix swap_rear for S/PDIF passthrough

James C Georgas:
      [ALSA] ac97_codec - trivial fix for bit update functions

James Courtier-Dutton:
      [ALSA] snd-ca0106: Add new card variant.
      [ALSA] snd-ca0106: Fix typos.
      [ALSA] ac97: Identify CMI9761 chips.

Jaroslav Kysela:
      [ALSA] ac97_codec (ALC655): add EAPD hack for MSI L725 laptop
      [ALSA] version 1.0.14rc1

Jean Delvare:
      [ALSA] sound: Don't include i2c-dev.h

Nickolay V. Shmyrev:
      [ALSA] snd_hda_intel 3stack mode for ASUS P5P-L2

Remy Bruno:
      [ALSA] hdsp: precise_ptr control switched off by default

Takashi Iwai:
      [ALSA] hda-codec - Fix wrong error checks in patch_{realtek,analog}.c
      [ALSA] hda-codec - Don't return error at initialization of modem codec
      [ALSA] hda-codec - Fix a typo
      [ALSA] hda-codec - Add model for HP q965
      [ALSA] hda-codec - Fix model for ASUS V1j laptop
      [ALSA] hda-codec - Fix detection of supported sample rates
      [ALSA] hda-codec - Verbose proc output for PCM parameters
      [ALSA] ac97 - Fix potential negative array index
      [ALSA] Fix races in PCM OSS emulation
      [ALSA] Fix invalid assignment of PCI revision
      [ALSA] Remove IRQF_DISABLED for shared PCI irqs

Tobias Klauser:
      [ALSA] sound/usb/usbaudio: Handle return value of usb_register()

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
