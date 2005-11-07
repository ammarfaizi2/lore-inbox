Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVKGN7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVKGN7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 08:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVKGN7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 08:59:31 -0500
Received: from gate.perex.cz ([85.132.177.35]:19090 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932487AbVKGN7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 08:59:30 -0500
Date: Mon, 7 Nov 2005 14:59:28 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA UPDATE] 1.0.10rc3
Message-ID: <Pine.LNX.4.61.0511071457480.8818@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2005-11-07.patch.gz

The following files will be updated:

 sound/core/wrappers.c                                        |   50 
 Documentation/sound/alsa/ALSA-Configuration.txt              |   29 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   58 
 drivers/char/rtc.c                                           |   65 
 include/sound/ac97_codec.h                                   |   10 
 include/sound/core.h                                         |   94 -
 include/sound/driver.h                                       |   17 
 include/sound/emu10k1.h                                      |    3 
 include/sound/minors.h                                       |    8 
 include/sound/pcm.h                                          |    3 
 include/sound/timer.h                                        |    1 
 include/sound/version.h                                      |    4 
 sound/Kconfig                                                |    8 
 sound/core/Kconfig                                           |    6 
 sound/core/Makefile                                          |    3 
 sound/core/control.c                                         |   18 
 sound/core/hwdep.c                                           |   10 
 sound/core/info.c                                            |    2 
 sound/core/init.c                                            |    7 
 sound/core/memory.c                                          |  216 --
 sound/core/misc.c                                            |   14 
 sound/core/oss/mixer_oss.c                                   |   62 
 sound/core/oss/pcm_oss.c                                     |   20 
 sound/core/pcm.c                                             |    3 
 sound/core/pcm_lib.c                                         |    5 
 sound/core/pcm_native.c                                      |   18 
 sound/core/rawmidi.c                                         |   12 
 sound/core/rtctimer.c                                        |   24 
 sound/core/seq/seq_instr.c                                   |   12 
 sound/core/seq/seq_lock.c                                    |    3 
 sound/core/seq/seq_memory.c                                  |    3 
 sound/core/seq/seq_midi.c                                    |    2 
 sound/core/seq/seq_timer.c                                   |   29 
 sound/core/sound.c                                           |   24 
 sound/core/timer.c                                           |  380 ++--
 sound/drivers/mpu401/mpu401_uart.c                           |    5 
 sound/drivers/mtpav.c                                        |    5 
 sound/drivers/opl3/opl3_lib.c                                |   10 
 sound/drivers/opl4/opl4_lib.c                                |   10 
 sound/drivers/serial-u16550.c                                |    5 
 sound/drivers/vx/vx_pcm.c                                    |    4 
 sound/i2c/cs8427.c                                           |   17 
 sound/i2c/other/ak4114.c                                     |    6 
 sound/i2c/other/ak4117.c                                     |    8 
 sound/i2c/tea6330t.c                                         |    2 
 sound/isa/ad1816a/ad1816a_lib.c                              |    5 
 sound/isa/ad1848/ad1848_lib.c                                |   27 
 sound/isa/cs423x/cs4231_lib.c                                |   10 
 sound/isa/cs423x/cs4236.c                                    |    8 
 sound/isa/cs423x/cs4236_lib.c                                |    5 
 sound/isa/es1688/es1688_lib.c                                |    3 
 sound/isa/es18xx.c                                           |   49 
 sound/isa/gus/gus_dma.c                                      |    2 
 sound/isa/gus/gus_io.c                                       |   94 -
 sound/isa/gus/gus_main.c                                     |   25 
 sound/isa/gus/gus_mem.c                                      |    2 
 sound/isa/gus/gus_pcm.c                                      |    5 
 sound/isa/gus/gus_reset.c                                    |    4 
 sound/isa/gus/gus_simple.c                                   |    2 
 sound/isa/gus/gus_uart.c                                     |    4 
 sound/isa/gus/gus_volume.c                                   |    6 
 sound/isa/gus/interwave.c                                    |    9 
 sound/isa/opl3sa2.c                                          |    5 
 sound/isa/opti9xx/opti92x-ad1848.c                           |   25 
 sound/isa/sb/emu8000.c                                       |   24 
 sound/isa/sb/emu8000_patch.c                                 |    3 
 sound/isa/sb/emu8000_pcm.c                                   |    3 
 sound/isa/sb/emu8000_synth.c                                 |    2 
 sound/isa/sb/sb16.c                                          |    5 
 sound/isa/sb/sb16_main.c                                     |    8 
 sound/isa/sb/sb8.c                                           |    5 
 sound/isa/sb/sb8_main.c                                      |    3 
 sound/isa/sb/sb_common.c                                     |   12 
 sound/isa/sb/sb_mixer.c                                      |    4 
 sound/isa/sscape.c                                           |   23 
 sound/isa/wavefront/wavefront.c                              |    5 
 sound/isa/wavefront/wavefront_synth.c                        |    6 
 sound/mips/au1x00.c                                          |   13 
 sound/pci/Kconfig                                            |    9 
 sound/pci/ac97/ac97_codec.c                                  |   56 
 sound/pci/ac97/ac97_patch.c                                  |   80 
 sound/pci/ac97/ac97_pcm.c                                    |    9 
 sound/pci/ad1889.c                                           |    5 
 sound/pci/ali5451/ali5451.c                                  |   92 -
 sound/pci/als4000.c                                          |    8 
 sound/pci/atiixp.c                                           |   48 
 sound/pci/atiixp_modem.c                                     |   37 
 sound/pci/au88x0/au8810.h                                    |    5 
 sound/pci/au88x0/au8820.h                                    |    5 
 sound/pci/au88x0/au8830.h                                    |    5 
 sound/pci/au88x0/au88x0.c                                    |    2 
 sound/pci/au88x0/au88x0.h                                    |    8 
 sound/pci/au88x0/au88x0_a3d.c                                |    2 
 sound/pci/au88x0/au88x0_core.c                               |   10 
 sound/pci/au88x0/au88x0_eq.c                                 |    2 
 sound/pci/au88x0/au88x0_synth.c                              |    8 
 sound/pci/azt3328.c                                          | 1005 +++++++----
 sound/pci/azt3328.h                                          |  135 -
 sound/pci/ca0106/Makefile                                    |    2 
 sound/pci/ca0106/ca0106.h                                    |   27 
 sound/pci/ca0106/ca0106_main.c                               |  123 +
 sound/pci/ca0106/ca_midi.c                                   |  306 +++
 sound/pci/ca0106/ca_midi.h                                   |   69 
 sound/pci/cmipci.c                                           |  126 -
 sound/pci/cs4281.c                                           |    6 
 sound/pci/cs46xx/cs46xx_lib.c                                |   43 
 sound/pci/emu10k1/emu10k1.c                                  |    2 
 sound/pci/emu10k1/emu10k1_callback.c                         |    4 
 sound/pci/emu10k1/emu10k1x.c                                 |    6 
 sound/pci/emu10k1/emufx.c                                    |   59 
 sound/pci/emu10k1/emupcm.c                                   |    3 
 sound/pci/emu10k1/irq.c                                      |    2 
 sound/pci/emu10k1/memory.c                                   |    6 
 sound/pci/emu10k1/p16v.c                                     |    2 
 sound/pci/ens1370.c                                          |   17 
 sound/pci/es1938.c                                           |   38 
 sound/pci/es1968.c                                           |   22 
 sound/pci/fm801.c                                            |   25 
 sound/pci/hda/hda_codec.c                                    |   52 
 sound/pci/hda/hda_codec.h                                    |    2 
 sound/pci/hda/hda_intel.c                                    |   72 
 sound/pci/hda/hda_local.h                                    |   22 
 sound/pci/hda/hda_proc.c                                     |    5 
 sound/pci/hda/patch_analog.c                                 |  133 +
 sound/pci/hda/patch_realtek.c                                |  272 +-
 sound/pci/hda/patch_si3054.c                                 |    2 
 sound/pci/ice1712/aureon.c                                   |    6 
 sound/pci/ice1712/delta.c                                    |    2 
 sound/pci/ice1712/ews.c                                      |    6 
 sound/pci/ice1712/ice1712.c                                  |   10 
 sound/pci/ice1712/ice1724.c                                  |   43 
 sound/pci/ice1712/pontis.c                                   |    3 
 sound/pci/ice1712/revo.c                                     |   13 
 sound/pci/ice1712/vt1720_mobo.c                              |   20 
 sound/pci/intel8x0.c                                         |  158 -
 sound/pci/intel8x0m.c                                        |   55 
 sound/pci/maestro3.c                                         |   21 
 sound/pci/mixart/mixart.c                                    |    3 
 sound/pci/nm256/nm256.c                                      |  141 -
 sound/pci/rme32.c                                            |    4 
 sound/pci/rme96.c                                            |    4 
 sound/pci/rme9652/hdsp.c                                     |  588 ++----
 sound/pci/rme9652/hdspm.c                                    |    3 
 sound/pci/rme9652/rme9652.c                                  |    6 
 sound/pci/sonicvibes.c                                       |   24 
 sound/pci/trident/trident_main.c                             |   18 
 sound/pci/trident/trident_memory.c                           |    4 
 sound/pci/via82xx.c                                          |  375 ++--
 sound/pci/via82xx_modem.c                                    |   49 
 sound/pci/ymfpci/ymfpci.c                                    |   18 
 sound/pci/ymfpci/ymfpci_main.c                               |   75 
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c                       |    6 
 sound/ppc/beep.c                                             |    2 
 sound/ppc/pmac.c                                             |   16 
 sound/sparc/dbri.c                                           |    5 
 sound/synth/emux/emux_synth.c                                |    1 
 sound/usb/usbaudio.c                                         |  144 -
 sound/usb/usbaudio.h                                         |    8 
 sound/usb/usbmidi.c                                          |   98 -
 sound/usb/usbmixer.c                                         |    2 
 sound/usb/usbquirks.h                                        |   40 
 sound/usb/usx2y/usX2Yhwdep.c                                 |   10 
 sound/usb/usx2y/usbusx2y.c                                   |    5 
 sound/usb/usx2y/usbusx2yaudio.c                              |   23 
 sound/usb/usx2y/usx2yhwdeppcm.c                              |    4 
 165 files changed, 3678 insertions(+), 3015 deletions(-)

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
