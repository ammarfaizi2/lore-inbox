Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVFVMA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVFVMA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVFVMA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 08:00:59 -0400
Received: from gate.perex.cz ([82.113.61.162]:14819 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261215AbVFVL7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:59:22 -0400
Date: Wed, 22 Jun 2005 13:59:16 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] Update to ALSA 1.0.9+
Message-ID: <Pine.LNX.4.58.0506221357200.2454@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2005-06-22.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt              |  127 
 Documentation/sound/alsa/CMIPCI.txt                          |   41 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    6 
 Documentation/sound/alsa/emu10k1-jack.txt                    |   74 
 Documentation/sound/alsa/hdspm.txt                           |  362 +
 include/sound/ac97_codec.h                                   |    8 
 include/sound/asound.h                                       |   16 
 include/sound/control.h                                      |    2 
 include/sound/emu10k1.h                                      |   42 
 include/sound/gus.h                                          |   23 
 include/sound/hdspm.h                                        |  131 
 include/sound/pcm.h                                          |   32 
 include/sound/seq_midi_event.h                               |    2 
 include/sound/seq_virmidi.h                                  |    1 
 include/sound/timer.h                                        |    2 
 include/sound/version.h                                      |    4 
 sound/Kconfig                                                |    5 
 sound/arm/Kconfig                                            |    6 
 sound/arm/Makefile                                           |    3 
 sound/arm/aaci.c                                             |  968 ++
 sound/arm/aaci.h                                             |  246 
 sound/arm/devdma.c                                           |   81 
 sound/arm/devdma.h                                           |    3 
 sound/core/control.c                                         |    4 
 sound/core/memalloc.c                                        |  201 
 sound/core/oss/pcm_oss.c                                     |   33 
 sound/core/oss/pcm_plugin.c                                  |    5 
 sound/core/pcm.c                                             |    3 
 sound/core/pcm_lib.c                                         |   52 
 sound/core/pcm_memory.c                                      |    1 
 sound/core/pcm_misc.c                                        |   16 
 sound/core/pcm_native.c                                      |   74 
 sound/core/seq/oss/seq_oss_synth.c                           |   24 
 sound/core/seq/seq_dummy.c                                   |    5 
 sound/core/seq/seq_midi.c                                    |    2 
 sound/core/seq/seq_midi_event.c                              |    6 
 sound/core/seq/seq_queue.c                                   |    3 
 sound/core/seq/seq_queue.h                                   |    1 
 sound/core/seq/seq_timer.c                                   |    3 
 sound/core/seq/seq_timer.h                                   |    2 
 sound/core/seq/seq_virmidi.c                                 |    8 
 sound/core/sound.c                                           |    1 
 sound/core/timer.c                                           |  100 
 sound/core/timer_compat.c                                    |    5 
 sound/drivers/vx/vx_pcm.c                                    |   12 
 sound/i2c/tea6330t.c                                         |    3 
 sound/isa/Kconfig                                            |    1 
 sound/isa/ad1816a/ad1816a.c                                  |    2 
 sound/isa/cs423x/cs4236.c                                    |    3 
 sound/isa/gus/gus_io.c                                       |   14 
 sound/isa/gus/gus_main.c                                     |    3 
 sound/isa/gus/gus_mem.c                                      |   12 
 sound/isa/gus/gus_pcm.c                                      |    3 
 sound/isa/gus/gus_reset.c                                    |    3 
 sound/isa/gus/gus_synth.c                                    |    3 
 sound/isa/gus/gus_tables.h                                   |    4 
 sound/isa/gus/gus_volume.c                                   |    8 
 sound/pci/Kconfig                                            |   13 
 sound/pci/ac97/ac97_codec.c                                  |   71 
 sound/pci/ac97/ac97_patch.c                                  |  585 +
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/ali5451/ali5451.c                                  |  283 
 sound/pci/als4000.c                                          |    4 
 sound/pci/atiixp.c                                           |    6 
 sound/pci/atiixp_modem.c                                     |   42 
 sound/pci/au88x0/au88x0.c                                    |    2 
 sound/pci/azt3328.c                                          |    2 
 sound/pci/bt87x.c                                            |    2 
 sound/pci/ca0106/ca0106.h                                    |   72 
 sound/pci/ca0106/ca0106_main.c                               |  211 
 sound/pci/ca0106/ca0106_mixer.c                              |   76 
 sound/pci/ca0106/ca0106_proc.c                               |   31 
 sound/pci/cmipci.c                                           |  159 
 sound/pci/cs4281.c                                           |   10 
 sound/pci/cs46xx/cs46xx.c                                    |    2 
 sound/pci/cs46xx/cs46xx_lib.c                                |    3 
 sound/pci/emu10k1/emu10k1.c                                  |    2 
 sound/pci/emu10k1/emu10k1_main.c                             |  192 
 sound/pci/emu10k1/emu10k1x.c                                 |    8 
 sound/pci/emu10k1/emufx.c                                    |   56 
 sound/pci/emu10k1/emumixer.c                                 |   14 
 sound/pci/emu10k1/emupcm.c                                   |    6 
 sound/pci/emu10k1/emuproc.c                                  |   89 
 sound/pci/emu10k1/irq.c                                      |   46 
 sound/pci/emu10k1/p16v.c                                     |  367 +
 sound/pci/ens1370.c                                          |    2 
 sound/pci/es1938.c                                           |    2 
 sound/pci/es1968.c                                           |    3 
 sound/pci/fm801.c                                            |    3 
 sound/pci/hda/Makefile                                       |    2 
 sound/pci/hda/hda_codec.c                                    |  206 
 sound/pci/hda/hda_codec.h                                    |   30 
 sound/pci/hda/hda_generic.c                                  |   14 
 sound/pci/hda/hda_intel.c                                    |  119 
 sound/pci/hda/hda_local.h                                    |   37 
 sound/pci/hda/hda_patch.h                                    |    3 
 sound/pci/hda/hda_proc.c                                     |   56 
 sound/pci/hda/patch_analog.c                                 |  693 +-
 sound/pci/hda/patch_cmedia.c                                 |  218 
 sound/pci/hda/patch_realtek.c                                | 2787 +++++---
 sound/pci/hda/patch_sigmatel.c                               |  666 +
 sound/pci/ice1712/amp.c                                      |   30 
 sound/pci/ice1712/amp.h                                      |   16 
 sound/pci/ice1712/ice1712.c                                  |    2 
 sound/pci/ice1712/ice1712.h                                  |    5 
 sound/pci/ice1712/ice1724.c                                  |    2 
 sound/pci/ice1712/phase.c                                    |  728 ++
 sound/pci/ice1712/phase.h                                    |   19 
 sound/pci/ice1712/vt1720_mobo.c                              |    9 
 sound/pci/ice1712/vt1720_mobo.h                              |    4 
 sound/pci/intel8x0.c                                         |  156 
 sound/pci/intel8x0m.c                                        |   80 
 sound/pci/korg1212/korg1212.c                                |    2 
 sound/pci/maestro3.c                                         |  222 
 sound/pci/mixart/mixart.c                                    |    2 
 sound/pci/nm256/nm256.c                                      |    2 
 sound/pci/rme32.c                                            |    2 
 sound/pci/rme96.c                                            |    2 
 sound/pci/rme9652/Makefile                                   |    2 
 sound/pci/rme9652/hdsp.c                                     |   30 
 sound/pci/rme9652/hdspm.c                                    | 3671 +++++++++++
 sound/pci/rme9652/rme9652.c                                  |   16 
 sound/pci/sonicvibes.c                                       |    2 
 sound/pci/trident/trident.c                                  |    5 
 sound/pci/via82xx.c                                          |  145 
 sound/pci/via82xx_modem.c                                    |   38 
 sound/pci/vx222/vx222.c                                      |    2 
 sound/pci/ymfpci/ymfpci.c                                    |    2 
 sound/pci/ymfpci/ymfpci_main.c                               |   35 
 sound/pcmcia/vx/vx_entry.c                                   |    3 
 sound/synth/emux/emux_effect.c                               |    6 
 sound/usb/Kconfig                                            |    1 
 sound/usb/usbaudio.c                                         |  308 
 sound/usb/usbaudio.h                                         |   11 
 sound/usb/usbmidi.c                                          |  128 
 sound/usb/usbmixer.c                                         |  588 +
 sound/usb/usbmixer_maps.c                                    |  126 
 sound/usb/usbquirks.h                                        |  298 
 sound/usb/usx2y/usbusx2y.c                                   |    2 
 sound/usb/usx2y/usbusx2yaudio.c                              |    6 
 140 files changed, 13941 insertions(+), 2768 deletions(-)

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
