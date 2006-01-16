Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWAPUiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWAPUiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWAPUiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:38:18 -0500
Received: from gate.perex.cz ([85.132.177.35]:35286 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1750856AbWAPUiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:38:17 -0500
Date: Mon, 16 Jan 2006 21:38:15 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA PATCH] Sync with ALSA CVS
Message-ID: <Pine.LNX.4.61.0601162137000.9433@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-01-16.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt |   21 -
 arch/arm/mach-pxa/mainstone.c                   |    4 
 drivers/media/video/cx88/cx88-alsa.c            |   54 +-
 drivers/media/video/saa7134/saa7134-alsa.c      |   65 +--
 drivers/media/video/saa7134/saa7134.h           |    2 
 include/asm-arm/arch-pxa/audio.h                |    4 
 include/sound/ac97_codec.h                      |    4 
 include/sound/ad1848.h                          |    2 
 include/sound/ak4531_codec.h                    |    2 
 include/sound/core.h                            |    8 
 include/sound/cs4231.h                          |    4 
 include/sound/cs46xx.h                          |    2 
 include/sound/emu10k1.h                         |    4 
 include/sound/emux_synth.h                      |    2 
 include/sound/gus.h                             |    6 
 include/sound/hwdep.h                           |    2 
 include/sound/i2c.h                             |   10 
 include/sound/info.h                            |    2 
 include/sound/mixer_oss.h                       |    2 
 include/sound/opl3.h                            |    3 
 include/sound/pcm.h                             |    2 
 include/sound/pcm_oss.h                         |    4 
 include/sound/rawmidi.h                         |    4 
 include/sound/sb16_csp.h                        |    2 
 include/sound/seq_instr.h                       |    2 
 include/sound/soundfont.h                       |    2 
 include/sound/util_mem.h                        |    4 
 include/sound/vx_core.h                         |    2 
 sound/arm/aaci.c                                |   10 
 sound/arm/aaci.h                                |    2 
 sound/arm/pxa2xx-ac97.c                         |   12 
 sound/core/Kconfig                              |   18 
 sound/core/hwdep.c                              |   43 +-
 sound/core/info.c                               |   60 +-
 sound/core/info_oss.c                           |   13 
 sound/core/init.c                               |    2 
 sound/core/memalloc.c                           |   22 -
 sound/core/oss/copy.c                           |    5 
 sound/core/oss/io.c                             |    5 
 sound/core/oss/linear.c                         |    7 
 sound/core/oss/mixer_oss.c                      |   14 
 sound/core/oss/mulaw.c                          |   24 +
 sound/core/oss/pcm_oss.c                        |   50 +-
 sound/core/oss/pcm_plugin.c                     |  269 ++-----------
 sound/core/oss/pcm_plugin.h                     |   30 -
 sound/core/oss/plugin_ops.h                     |  166 --------
 sound/core/oss/rate.c                           |   85 +---
 sound/core/oss/route.c                          |  491 ++----------------------
 sound/core/pcm.c                                |   44 +-
 sound/core/pcm_native.c                         |   12 
 sound/core/rawmidi.c                            |   57 +-
 sound/core/seq/oss/seq_oss.c                    |   27 -
 sound/core/seq/seq_clientmgr.c                  |   40 -
 sound/core/seq/seq_clientmgr.h                  |    2 
 sound/core/seq/seq_device.c                     |   53 +-
 sound/core/seq/seq_instr.c                      |    6 
 sound/core/seq/seq_midi.c                       |   20 
 sound/core/seq/seq_ports.c                      |   12 
 sound/core/seq/seq_queue.c                      |    6 
 sound/core/seq/seq_queue.h                      |    2 
 sound/core/sound.c                              |   23 -
 sound/core/sound_oss.c                          |   23 -
 sound/core/timer.c                              |   77 +--
 sound/drivers/opl3/opl3_lib.c                   |    2 
 sound/drivers/opl3/opl3_seq.c                   |   10 
 sound/drivers/opl3/opl3_synth.c                 |   10 
 sound/drivers/opl4/opl4_lib.c                   |    2 
 sound/drivers/opl4/opl4_local.h                 |    2 
 sound/drivers/opl4/opl4_proc.c                  |   10 
 sound/drivers/opl4/opl4_seq.c                   |   12 
 sound/drivers/vx/vx_core.c                      |    2 
 sound/drivers/vx/vx_mixer.c                     |   72 +--
 sound/i2c/i2c.c                                 |    2 
 sound/isa/ad1848/ad1848_lib.c                   |   14 
 sound/isa/cmi8330.c                             |    6 
 sound/isa/cs423x/cs4231_lib.c                   |   30 -
 sound/isa/cs423x/cs4236.c                       |    7 
 sound/isa/cs423x/cs4236_lib.c                   |    4 
 sound/isa/es18xx.c                              |  224 +++++++++-
 sound/isa/gus/gus_dma.c                         |   10 
 sound/isa/gus/gus_main.c                        |    2 
 sound/isa/gus/gus_mem.c                         |   14 
 sound/isa/gus/gus_synth.c                       |   14 
 sound/isa/opl3sa2.c                             |    6 
 sound/isa/sb/sb16_csp.c                         |   12 
 sound/isa/sscape.c                              |    6 
 sound/isa/wavefront/wavefront.c                 |    7 
 sound/pci/ac97/ac97_codec.c                     |   45 +-
 sound/pci/ac97/ac97_patch.c                     |   63 ++-
 sound/pci/ac97/ac97_pcm.c                       |    6 
 sound/pci/ac97/ac97_proc.c                      |   14 
 sound/pci/ac97/ak4531_codec.c                   |   28 -
 sound/pci/ali5451/ali5451.c                     |    2 
 sound/pci/atiixp.c                              |   21 -
 sound/pci/atiixp_modem.c                        |   13 
 sound/pci/au88x0/au88x0.c                       |   10 
 sound/pci/au88x0/au88x0.h                       |   12 
 sound/pci/au88x0/au88x0_core.c                  |   12 
 sound/pci/au88x0/au88x0_eq.c                    |   33 -
 sound/pci/au88x0/au88x0_eq.h                    |   31 -
 sound/pci/au88x0/au88x0_eqdata.c                |    6 
 sound/pci/au88x0/au88x0_mpu401.c                |    4 
 sound/pci/au88x0/au88x0_synth.c                 |   10 
 sound/pci/au88x0/au88x0_wt.h                    |   10 
 sound/pci/au88x0/au88x0_xtalk.c                 |   16 
 sound/pci/au88x0/au88x0_xtalk.h                 |   12 
 sound/pci/bt87x.c                               |    4 
 sound/pci/ca0106/ca0106_main.c                  |   12 
 sound/pci/cmipci.c                              |   25 -
 sound/pci/cs46xx/cs46xx_lib.c                   |   52 +-
 sound/pci/cs46xx/dsp_spos.c                     |   58 +-
 sound/pci/cs46xx/dsp_spos_scb_lib.c             |    6 
 sound/pci/cs5535audio/cs5535audio.c             |    6 
 sound/pci/emu10k1/emu10k1_main.c                |    5 
 sound/pci/emu10k1/emufx.c                       |   22 -
 sound/pci/emu10k1/emumixer.c                    |   10 
 sound/pci/emu10k1/memory.c                      |   26 -
 sound/pci/ens1370.c                             |   39 +
 sound/pci/es1968.c                              |   22 -
 sound/pci/hda/hda_codec.c                       |   51 +-
 sound/pci/hda/hda_codec.h                       |    4 
 sound/pci/hda/hda_intel.c                       |   76 +--
 sound/pci/hda/patch_analog.c                    |   28 -
 sound/pci/hda/patch_realtek.c                   |    2 
 sound/pci/hda/patch_sigmatel.c                  |    1 
 sound/pci/ice1712/aureon.c                      |  116 +++--
 sound/pci/ice1712/aureon.h                      |    8 
 sound/pci/ice1712/delta.c                       |   26 -
 sound/pci/ice1712/hoontech.c                    |   26 -
 sound/pci/ice1712/ice1712.c                     |    7 
 sound/pci/ice1712/ice1712.h                     |   10 
 sound/pci/ice1712/ice1724.c                     |   37 -
 sound/pci/ice1712/phase.c                       |   10 
 sound/pci/ice1712/pontis.c                      |   86 ++--
 sound/pci/intel8x0.c                            |  154 ++++---
 sound/pci/korg1212/korg1212.c                   |   17 
 sound/pci/mixart/mixart.c                       |   21 -
 sound/pci/mixart/mixart.h                       |    7 
 sound/pci/mixart/mixart_core.c                  |   18 
 sound/pci/mixart/mixart_mixer.c                 |   52 +-
 sound/pci/nm256/nm256.c                         |   16 
 sound/pci/pcxhr/pcxhr.c                         |   43 +-
 sound/pci/pcxhr/pcxhr.h                         |    5 
 sound/pci/pcxhr/pcxhr_core.c                    |    2 
 sound/pci/pcxhr/pcxhr_mixer.c                   |   75 +--
 sound/pci/trident/trident.c                     |    8 
 sound/pci/trident/trident_memory.c              |   36 -
 sound/pci/via82xx.c                             |    3 
 sound/pci/vx222/vx222_ops.c                     |   18 
 sound/pci/ymfpci/ymfpci_main.c                  |   14 
 sound/pcmcia/vx/vxp_mixer.c                     |   12 
 sound/sparc/cs4231.c                            |   34 -
 sound/synth/emux/emux.c                         |    2 
 sound/synth/emux/emux_oss.c                     |   12 
 sound/synth/emux/emux_proc.c                    |    8 
 sound/synth/emux/emux_seq.c                     |   12 
 sound/synth/emux/soundfont.c                    |    6 
 sound/synth/util_mem.c                          |   15 
 sound/usb/usbaudio.c                            |   73 ++-
 sound/usb/usbmidi.c                             |    2 
 sound/usb/usbquirks.h                           |   43 +-
 sound/usb/usx2y/usbusx2y.c                      |    2 
 sound/usb/usx2y/usbusx2y.h                      |    2 
 sound/usb/usx2y/usbusx2yaudio.c                 |    8 
 sound/usb/usx2y/usx2yhwdeppcm.c                 |   12 
 165 files changed, 2019 insertions(+), 2273 deletions(-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
