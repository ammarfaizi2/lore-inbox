Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUHPNFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUHPNFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267609AbUHPNFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:05:35 -0400
Received: from gate.perex.cz ([82.113.61.162]:13723 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S267622AbUHPNA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:00:59 -0400
Date: Mon, 16 Aug 2004 14:54:58 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA 1.0.6
Message-ID: <Pine.LNX.4.58.0408161451280.1780@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-08-15.patch.gz

					Jaroslav

The pull command will update the following files:

 include/sound/sndmagic.h                                     |  218 -
 Documentation/sound/alsa/ALSA-Configuration.txt              |   31 
 Documentation/sound/alsa/DocBook/alsa-driver-api.tmpl        |    1 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |  462 +--
 include/linux/pci_ids.h                                      |    1 
 include/linux/slab.h                                         |    1 
 include/sound/ac97_codec.h                                   |   42 
 include/sound/asound.h                                       |    2 
 include/sound/control.h                                      |    3 
 include/sound/core.h                                         |   19 
 include/sound/cs46xx.h                                       |   21 
 include/sound/driver.h                                       |    2 
 include/sound/emu10k1.h                                      |   27 
 include/sound/es1688.h                                       |    2 
 include/sound/info.h                                         |    5 
 include/sound/initval.h                                      |   33 
 include/sound/memalloc.h                                     |   21 
 include/sound/pcm-indirect.h                                 |  199 +
 include/sound/pcm.h                                          |   33 
 include/sound/seq_kernel.h                                   |    3 
 include/sound/soundfont.h                                    |    1 
 include/sound/timer.h                                        |    3 
 include/sound/trident.h                                      |    1 
 include/sound/version.h                                      |    8 
 include/sound/vx_core.h                                      |    8 
 include/sound/ymfpci.h                                       |    1 
 mm/slab.c                                                    |   21 
 sound/arm/sa11xx-uda1341.c                                   |   23 
 sound/core/control.c                                         |   49 
 sound/core/device.c                                          |    4 
 sound/core/hwdep.c                                           |   40 
 sound/core/info.c                                            |   63 
 sound/core/info_oss.c                                        |   12 
 sound/core/init.c                                            |    4 
 sound/core/ioctl32/ioctl32.c                                 |    2 
 sound/core/ioctl32/pcm32.c                                   |   55 
 sound/core/memalloc.c                                        |  442 +--
 sound/core/memory.c                                          |   76 
 sound/core/oss/mixer_oss.c                                   |   53 
 sound/core/oss/pcm_oss.c                                     |   52 
 sound/core/oss/pcm_plugin.c                                  |  133 -
 sound/core/oss/pcm_plugin.h                                  |    2 
 sound/core/oss/route.c                                       |    2 
 sound/core/pcm.c                                             |   20 
 sound/core/pcm_lib.c                                         |   80 
 sound/core/pcm_memory.c                                      |  128 
 sound/core/pcm_misc.c                                        |  708 +----
 sound/core/pcm_native.c                                      |  307 +-
 sound/core/pcm_timer.c                                       |   13 
 sound/core/rawmidi.c                                         |   56 
 sound/core/seq/Makefile                                      |   58 
 sound/core/seq/instr/Makefile                                |   36 
 sound/core/seq/instr/ainstr_fm.c                             |    2 
 sound/core/seq/instr/ainstr_gf1.c                            |    4 
 sound/core/seq/instr/ainstr_iw.c                             |    8 
 sound/core/seq/instr/ainstr_simple.c                         |    2 
 sound/core/seq/oss/seq_oss.c                                 |    9 
 sound/core/seq/oss/seq_oss_init.c                            |    4 
 sound/core/seq/oss/seq_oss_ioctl.c                           |   74 
 sound/core/seq/oss/seq_oss_midi.c                            |    2 
 sound/core/seq/oss/seq_oss_readq.c                           |    4 
 sound/core/seq/oss/seq_oss_synth.c                           |    8 
 sound/core/seq/oss/seq_oss_timer.c                           |    4 
 sound/core/seq/oss/seq_oss_writeq.c                          |    2 
 sound/core/seq/seq.c                                         |    3 
 sound/core/seq/seq_clientmgr.c                               |   28 
 sound/core/seq/seq_device.c                                  |   14 
 sound/core/seq/seq_dummy.c                                   |   14 
 sound/core/seq/seq_fifo.c                                    |    2 
 sound/core/seq/seq_instr.c                                   |   11 
 sound/core/seq/seq_memory.c                                  |    6 
 sound/core/seq/seq_midi.c                                    |    6 
 sound/core/seq/seq_midi_emul.c                               |    2 
 sound/core/seq/seq_midi_event.c                              |    2 
 sound/core/seq/seq_ports.c                                   |    4 
 sound/core/seq/seq_prioq.c                                   |    2 
 sound/core/seq/seq_queue.c                                   |    2 
 sound/core/seq/seq_timer.c                                   |    2 
 sound/core/seq/seq_virmidi.c                                 |   46 
 sound/core/sgbuf.c                                           |   11 
 sound/core/sound.c                                           |   42 
 sound/core/timer.c                                           |   67 
 sound/drivers/dummy.c                                        |  102 
 sound/drivers/mpu401/mpu401.c                                |    7 
 sound/drivers/mpu401/mpu401_uart.c                           |   22 
 sound/drivers/mtpav.c                                        |   16 
 sound/drivers/opl3/opl3_lib.c                                |   10 
 sound/drivers/opl3/opl3_midi.c                               |   14 
 sound/drivers/opl3/opl3_oss.c                                |   16 
 sound/drivers/opl3/opl3_seq.c                                |    9 
 sound/drivers/opl3/opl3_synth.c                              |    6 
 sound/drivers/opl4/Makefile                                  |    2 
 sound/drivers/opl4/opl4_lib.c                                |   59 
 sound/drivers/opl4/opl4_local.h                              |    1 
 sound/drivers/opl4/opl4_mixer.c                              |   12 
 sound/drivers/opl4/opl4_proc.c                               |    8 
 sound/drivers/opl4/opl4_seq.c                                |   10 
 sound/drivers/opl4/opl4_synth.c                              |   35 
 sound/drivers/serial-u16550.c                                |   34 
 sound/drivers/virmidi.c                                      |    9 
 sound/drivers/vx/vx_core.c                                   |   11 
 sound/drivers/vx/vx_hwdep.c                                  |    4 
 sound/drivers/vx/vx_mixer.c                                  |   53 
 sound/drivers/vx/vx_pcm.c                                    |   37 
 sound/drivers/vx/vx_uer.c                                    |   15 
 sound/i2c/cs8427.c                                           |   26 
 sound/i2c/i2c.c                                              |   10 
 sound/i2c/l3/uda1341.c                                       |   28 
 sound/i2c/other/ak4117.c                                     |   10 
 sound/i2c/other/ak4xxx-adda.c                                |   12 
 sound/i2c/tea6330t.c                                         |   14 
 sound/isa/Kconfig                                            |    8 
 sound/isa/ad1816a/ad1816a.c                                  |   15 
 sound/isa/ad1816a/ad1816a_lib.c                              |   18 
 sound/isa/ad1848/ad1848.c                                    |   12 
 sound/isa/ad1848/ad1848_lib.c                                |   16 
 sound/isa/als100.c                                           |   15 
 sound/isa/azt2320.c                                          |   16 
 sound/isa/cmi8330.c                                          |   18 
 sound/isa/cs423x/cs4231.c                                    |   14 
 sound/isa/cs423x/cs4231_lib.c                                |   22 
 sound/isa/cs423x/cs4236.c                                    |   20 
 sound/isa/cs423x/cs4236_lib.c                                |   26 
 sound/isa/dt019x.c                                           |   14 
 sound/isa/es1688/es1688.c                                    |   11 
 sound/isa/es1688/es1688_lib.c                                |   15 
 sound/isa/es18xx.c                                           |   31 
 sound/isa/gus/Makefile                                       |    6 
 sound/isa/gus/gus_dram.c                                     |   10 
 sound/isa/gus/gus_instr.c                                    |   18 
 sound/isa/gus/gus_irq.c                                      |    4 
 sound/isa/gus/gus_main.c                                     |   10 
 sound/isa/gus/gus_mem.c                                      |    2 
 sound/isa/gus/gus_mem_proc.c                                 |   12 
 sound/isa/gus/gus_mixer.c                                    |   10 
 sound/isa/gus/gus_pcm.c                                      |   38 
 sound/isa/gus/gus_synth.c                                    |    2 
 sound/isa/gus/gus_timer.c                                    |    6 
 sound/isa/gus/gus_uart.c                                     |   12 
 sound/isa/gus/gusclassic.c                                   |   13 
 sound/isa/gus/gusextreme.c                                   |   17 
 sound/isa/gus/gusmax.c                                       |   13 
 sound/isa/gus/interwave.c                                    |   58 
 sound/isa/opl3sa2.c                                          |   39 
 sound/isa/opti9xx/opti92x-ad1848.c                           |   57 
 sound/isa/sb/emu8000.c                                       |   18 
 sound/isa/sb/emu8000_callback.c                              |   20 
 sound/isa/sb/emu8000_local.h                                 |    2 
 sound/isa/sb/emu8000_patch.c                                 |    2 
 sound/isa/sb/emu8000_pcm.c                                   |    4 
 sound/isa/sb/emu8000_synth.c                                 |    1 
 sound/isa/sb/es968.c                                         |   13 
 sound/isa/sb/sb16.c                                          |   21 
 sound/isa/sb/sb16_csp.c                                      |   17 
 sound/isa/sb/sb16_main.c                                     |   18 
 sound/isa/sb/sb8.c                                           |   13 
 sound/isa/sb/sb8_main.c                                      |    2 
 sound/isa/sb/sb8_midi.c                                      |   16 
 sound/isa/sb/sb_common.c                                     |    9 
 sound/isa/sb/sb_mixer.c                                      |    2 
 sound/isa/sgalaxy.c                                          |    9 
 sound/isa/sscape.c                                           |   24 
 sound/isa/wavefront/wavefront.c                              |   19 
 sound/isa/wavefront/wavefront_fx.c                           |   20 
 sound/isa/wavefront/wavefront_synth.c                        |    6 
 sound/parisc/harmony.c                                       |   73 
 sound/pci/Kconfig                                            |   20 
 sound/pci/Makefile                                           |    2 
 sound/pci/ac97/ac97_codec.c                                  |  437 ++-
 sound/pci/ac97/ac97_id.h                                     |    7 
 sound/pci/ac97/ac97_local.h                                  |   14 
 sound/pci/ac97/ac97_patch.c                                  |  295 +-
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/ac97/ac97_pcm.c                                    |    9 
 sound/pci/ac97/ac97_proc.c                                   |   18 
 sound/pci/ac97/ak4531_codec.c                                |   26 
 sound/pci/ali5451/ali5451.c                                  |   78 
 sound/pci/als4000.c                                          |   64 
 sound/pci/atiixp.c                                           |  122 
 sound/pci/atiixp_modem.c                                     | 1415 ++++++++++-
 sound/pci/au88x0/au88x0.c                                    |   16 
 sound/pci/au88x0/au88x0.h                                    |    2 
 sound/pci/au88x0/au88x0_a3d.c                                |   24 
 sound/pci/au88x0/au88x0_core.c                               |    2 
 sound/pci/au88x0/au88x0_eq.c                                 |  160 -
 sound/pci/au88x0/au88x0_game.c                               |    2 
 sound/pci/au88x0/au88x0_mixer.c                              |   13 
 sound/pci/au88x0/au88x0_mpu401.c                             |    2 
 sound/pci/au88x0/au88x0_pcm.c                                |    7 
 sound/pci/au88x0/au88x0_xtalk.c                              |   10 
 sound/pci/au88x0/au88x0_xtalk.h                              |    5 
 sound/pci/azt3328.c                                          |  115 
 sound/pci/bt87x.c                                            |   96 
 sound/pci/cmipci.c                                           |  225 -
 sound/pci/cs4281.c                                           |  151 -
 sound/pci/cs46xx/cs46xx.c                                    |    9 
 sound/pci/cs46xx/cs46xx_lib.c                                |  346 --
 sound/pci/cs46xx/cs46xx_lib.h                                |    2 
 sound/pci/cs46xx/dsp_spos.c                                  |   41 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                          |    2 
 sound/pci/emu10k1/emu10k1.c                                  |   19 
 sound/pci/emu10k1/emu10k1_callback.c                         |   16 
 sound/pci/emu10k1/emu10k1_main.c                             |   61 
 sound/pci/emu10k1/emu10k1_patch.c                            |    4 
 sound/pci/emu10k1/emu10k1_synth.c                            |    4 
 sound/pci/emu10k1/emufx.c                                    |  374 --
 sound/pci/emu10k1/emumixer.c                                 |   17 
 sound/pci/emu10k1/emupcm.c                                   |  483 ++-
 sound/pci/emu10k1/emuproc.c                                  |  126 
 sound/pci/emu10k1/io.c                                       |    4 
 sound/pci/emu10k1/irq.c                                      |    2 
 sound/pci/emu10k1/memory.c                                   |   14 
 sound/pci/ens1370.c                                          |  140 -
 sound/pci/es1938.c                                           |   89 
 sound/pci/es1968.c                                           |  216 -
 sound/pci/fm801.c                                            |   79 
 sound/pci/ice1712/Makefile                                   |    4 
 sound/pci/ice1712/ak4xxx.c                                   |    1 
 sound/pci/ice1712/aureon.c                                   |  298 +-
 sound/pci/ice1712/delta.c                                    |    4 
 sound/pci/ice1712/ews.c                                      |   26 
 sound/pci/ice1712/ews.h                                      |    4 
 sound/pci/ice1712/ice1712.c                                  |  125 
 sound/pci/ice1712/ice1712.h                                  |    6 
 sound/pci/ice1712/ice1724.c                                  |  391 +--
 sound/pci/ice1712/pontis.c                                   |  839 ++++++
 sound/pci/ice1712/pontis.h                                   |   33 
 sound/pci/ice1712/revo.c                                     |    4 
 sound/pci/ice1712/vt1720_mobo.c                              |  106 
 sound/pci/ice1712/vt1720_mobo.h                              |   39 
 sound/pci/intel8x0.c                                         |  311 +-
 sound/pci/intel8x0m.c                                        |  187 -
 sound/pci/korg1212/korg1212.c                                |  210 -
 sound/pci/maestro3.c                                         |   95 
 sound/pci/mixart/mixart.c                                    |  118 
 sound/pci/mixart/mixart.h                                    |    1 
 sound/pci/mixart/mixart_core.c                               |    2 
 sound/pci/mixart/mixart_hwdep.c                              |    4 
 sound/pci/mixart/mixart_mixer.c                              |    2 
 sound/pci/nm256/nm256.c                                      |   97 
 sound/pci/rme32.c                                            |  896 +++---
 sound/pci/rme96.c                                            |  367 --
 sound/pci/rme9652/hdsp.c                                     |  479 +--
 sound/pci/rme9652/rme9652.c                                  |  311 --
 sound/pci/sonicvibes.c                                       |  130 -
 sound/pci/trident/trident.c                                  |    8 
 sound/pci/trident/trident_main.c                             |  165 -
 sound/pci/trident/trident_memory.c                           |   14 
 sound/pci/trident/trident_synth.c                            |   33 
 sound/pci/via82xx.c                                          |  214 -
 sound/pci/vx222/vx222.c                                      |   42 
 sound/pci/vx222/vx222.h                                      |    2 
 sound/pci/vx222/vx222_ops.c                                  |    2 
 sound/pci/ymfpci/ymfpci.c                                    |   10 
 sound/pci/ymfpci/ymfpci_main.c                               |  186 -
 sound/pcmcia/pdaudiocf/pdaudiocf.c                           |   16 
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c                      |   12 
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c                       |    4 
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c                       |    4 
 sound/pcmcia/vx/vx_entry.c                                   |   10 
 sound/pcmcia/vx/vxp_mixer.c                                  |    2 
 sound/pcmcia/vx/vxp_ops.c                                    |    2 
 sound/pcmcia/vx/vxpocket.c                                   |    7 
 sound/ppc/Kconfig                                            |    5 
 sound/ppc/Makefile                                           |    2 
 sound/ppc/awacs.c                                            |   35 
 sound/ppc/beep.c                                             |  262 ++
 sound/ppc/burgundy.c                                         |    6 
 sound/ppc/daca.c                                             |    6 
 sound/ppc/pmac.c                                             |   93 
 sound/ppc/pmac.h                                             |   13 
 sound/ppc/powermac.c                                         |   24 
 sound/ppc/tumbler.c                                          |    4 
 sound/sparc/amd7930.c                                        |   22 
 sound/sparc/cs4231.c                                         |   33 
 sound/synth/emux/emux.c                                      |    6 
 sound/synth/emux/emux_effect.c                               |    2 
 sound/synth/emux/emux_hwdep.c                                |    2 
 sound/synth/emux/emux_nrpn.c                                 |   18 
 sound/synth/emux/emux_oss.c                                  |   14 
 sound/synth/emux/emux_proc.c                                 |    2 
 sound/synth/emux/emux_seq.c                                  |   20 
 sound/synth/emux/emux_synth.c                                |   12 
 sound/synth/emux/soundfont.c                                 |   60 
 sound/synth/util_mem.c                                       |    2 
 sound/usb/Kconfig                                            |   10 
 sound/usb/Makefile                                           |    8 
 sound/usb/usbaudio.c                                         |  108 
 sound/usb/usbaudio.h                                         |    7 
 sound/usb/usbmidi.c                                          |   94 
 sound/usb/usbmixer.c                                         |   62 
 sound/usb/usbmixer_maps.c                                    |    2 
 sound/usb/usbquirks.h                                        |   89 
 sound/usb/usx2y/Makefile                                     |    3 
 sound/usb/usx2y/usX2Yhwdep.c                                 |  275 ++
 sound/usb/usx2y/usX2Yhwdep.h                                 |    6 
 sound/usb/usx2y/usbus428ctldefs.h                            |  108 
 sound/usb/usx2y/usbusx2y.c                                   |  434 +++
 sound/usb/usx2y/usbusx2y.h                                   |   61 
 sound/usb/usx2y/usbusx2yaudio.c                              | 1033 ++++++++
 sound/usb/usx2y/usx2y.h                                      |   49 
 301 files changed, 11436 insertions(+), 8238 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/08/15 1.1807.1.65)
   version.h:
     ALSA 1.0.6

<perex@suse.cz> (04/08/15 1.1807.1.64)
   ALSA CVS update
   USB generic driver
   add support for Yamaha CVP-301, CVP-303, CVP-305, CVP-307, CVP-309,
   CVP-309GP, PSR-1500, PSR-3000, ELS-01, ELS-01C, PSR-295, PSR-293,
   DGX-205, DGX-203, DGX-305, DGX-505, DGP-7, DGP-5, PM5D, DME64N,
   DME24N, DTX, UB99
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/08/15 1.1807.1.63)
   ALSA CVS update
   AC97 Codec Core
   Add more timeout to avoid not respond messages
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/15 1.1807.1.62)
   ALSA CVS update
   PCM Midlevel
   Fixed cut-n-paste typo
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/15 1.1807.1.61)
   ALSA CVS update
   AC97 Codec Core
   Don't use mute bit in REC_GAIN register during tests.
   We have at least one case when the mute bit is zero.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/15 1.1807.1.60)
   ALSA CVS update
   Intel8x0-modem driver
   Added SiS, NVidia modem descriptions
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/15 1.1807.1.59)
   ALSA CVS update
   PCM Midlevel
   Serialize runtime->status->state access
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/06 1.1807.1.57)
   ALSA CVS update
   au88x0 driver
   some other misc eq cleanups
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/06 1.1807.1.56)
   ALSA CVS update
   au88x0 driver
   Cleans up the equalizer code by converting some loops to proper for
   loops and fixes the conditions for looping.
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/06 1.1807.1.55)
   ALSA CVS update
   au88x0 driver
   Fixed asXtalkGainsAllChan problem for the solid kernel build.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/06 1.1807.1.54)
   ALSA CVS update
   USB USX2Y
   fix compilation on 2.2.x kernels
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/08/06 1.1807.1.53)
   ALSA CVS update
   EMU10K1/EMU10K2 driver,KORG1212 driver
   Fixed the compile warnings on 64bit architectures.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/06 1.1807.1.52)
   ALSA CVS update
   PCI drivers,Intel8x0-modem driver
   Added the support of SIS7013 modem.
   
   Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/06 1.1807.1.51)
   ALSA CVS update
   SoundFont,Common EMU synth
   Fixed messy locks in soundfont support code.
   
   Removed hacky down_trylock() in the interrupt context, and check
   the busy lock flag explicitly.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/06 1.1807.1.50)
   ALSA CVS update
   PPC PMAC driver
   Removed non-functional 48kHz support from pmac driver.
   
   Signed-off-by: Rene Rebe <rene.rebe@gmx.net>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/04 1.1807.1.49)
   ALSA misc
   - control.c - compilation fixes
   - es1968.c - hw volume fix

<perex@suse.cz> (04/08/03 1.1807.1.48)
   ALSA CVS update
   au88x0 driver
   Cleanup the private_data initialization
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/08/03 1.1807.1.47)
   ALSA CVS update
   USB generic driver
   fix email address and license
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/08/03 1.1807.1.46)
   ALSA CVS update
   Documentation,Intel8x0 driver
   Added buggy_irq module parameter to intel8x0 driver.
   
   On some (broken :) motherboards, unknown irq is triggered when the audio
   is started.  This this option, the irq handler returns IRQ_HANDLED for
   such an irq, so that the irq line won't be disabled.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/03 1.1807.1.45)
   ALSA CVS update
   Documentation,USB,USB generic driver,USB USX2Y
   Added snd-usb-usx2y driver for Tascam US-122/224/428 support.
   Driver written by Karsten Wiese <annabellesgarden@yahoo.de>
   
   The shared code is split from usbaudio as snd-usb-lib module.
   Currently, only MIDI part is included there.  In future, more
   audio part will be shared, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/03 1.1807.1.44)
   ALSA CVS update
   VIA82xx driver
   Added the DXS whitelist entry for Acer Inspire 1353LM.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/03 1.1807.1.43)
   From: Jaroslav Kysela <perex@suse.cz>
   ALSA patch
   Removed duplicate CK804_AUDIO from intel8x0.c

<perex@suse.cz> (04/08/03 1.1807.1.42)
   From: "Andrew Chew" <achew@nvidia.com>
   
   This patch updates include/linux/pci_ids.h with the CK804 audio controller
   ID, and adds the CK804 audio controller to the sound/pci/intel8x0.c audio
   driver.
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>

<perex@suse.cz> (04/08/02 1.1807.1.41)
   ALSA CVS update
   PPC PMAC driver
   Bailed a long delay out of the spin_lock_irq.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1807.1.40)
   ALSA CVS update
   PPC PMAC driver
   pmac also apply the DMA stop work around to fix capture on iBook2
   
   the attached patch for the pmac driver fixes capture for at least all
   iBook2s I have access to. Without the fix arround 33% percent of all
   recordings are just white noise.
   
   Signed-off-by: Rene Rebe <rene.rebe@gmx.net>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1807.1.39)
   ALSA CVS update
   PPC,PPC AWACS driver,PPC Beep,PPC PMAC driver,PPC PowerMac driver
   Added the PCM beep support.
   
   enable_beep module option is back again (default = 1).
   Beep is emulated via PCM playback when enabled.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.15)
   ALSA CVS update
   IOCTL32 emulation
   Added the wrapper for sync_ptr and hwsync ioctls.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.14)
   ALSA CVS update
   ICE1712 driver
   Added the support of ZNF3-250 (supposed to be ZNF3-150 compatible).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.13)
   ALSA CVS update
   Intel8x0 driver
   Added an ac97 quirk for ICH/AD1885 mobo.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.12)
   ALSA CVS update
   Intel8x0 driver
   Fixed the handling of unknown irqs on ICH5.
   
   This patch fixes (hopefully) the handling of unkown irqs triggered
   on some ICH5 mobo.  Also, free_irq() is moved before releasing
   i/o ports to avoid hang-up at removal.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.11)
   ALSA CVS update
   PCI drivers,Intel8x0-modem driver
   Added the support of Nvidia modem.
   
   Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.10)
   ALSA CVS update
   PARISC Harmony driver
   Clean up DMA buffer allocation routines.
   
   - snd_dma_alloc_pages*() take the device type and device pointer
     directly as arguments.  snd_dma_free_pages() takes only dma_buffer
     instance.
   
   - snd_dma_device struct is removed in each driver's instance (no longer
     needed due to the change above).
   
   - snd_malloc_pages_fallback() is removed since it's no longer used.
   
   - The buffer reservation / preallocation in snd-page-alloc module is
     performed only when the buffer id is given.  Normal PCM buffers won't
     be reserved any more (unless the driver specifies).  The module keeps
     the linked list of free-reserved buffers, instead of the whole buffers
     Reservation is done via snd_dma_reserve_buf(), and retrieved via
     snd_dma_get_reserved_buf()).
   
   - Other misc clean-ups/fixes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.9)
   ALSA CVS update
   Memalloc module,PCM Midlevel,CS46xx driver,EMU10K1/EMU10K2 driver
   ALSA Core,YMFPCI driver,Sound Scape driver,ATIIXP driver
   ATIIXP-modem driver,BT87x driver,ENS1370/1+ driver,ES1968 driver
   Intel8x0 driver,Intel8x0-modem driver,VIA82xx driver,KORG1212 driver
   MIXART driver,RME HDSP driver,RME9652 driver,Trident driver
   Clean up DMA buffer allocation routines.
   
   - snd_dma_alloc_pages*() take the device type and device pointer
     directly as arguments.  snd_dma_free_pages() takes only dma_buffer
     instance.
   
   - snd_dma_device struct is removed in each driver's instance (no longer
     needed due to the change above).
   
   - snd_malloc_pages_fallback() is removed since it's no longer used.
   
   - The buffer reservation / preallocation in snd-page-alloc module is
     performed only when the buffer id is given.  Normal PCM buffers won't
     be reserved any more (unless the driver specifies).  The module keeps
     the linked list of free-reserved buffers, instead of the whole buffers
     Reservation is done via snd_dma_reserve_buf(), and retrieved via
     snd_dma_get_reserved_buf()).
   
   - Other misc clean-ups/fixes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.8)
   ALSA CVS update
   AC97 Codec Core,ATIIXP driver,ATIIXP-modem driver,Intel8x0 driver
   Intel8x0-modem driver
   Fixed the reset problem of shared audio/modem drivers.
   
   This patch fixes the problem that the shared audio/modem drivers reset
   the codecs with each other at loading time.
   Currently, intel8x0 and atiixp drivers are supported.
   The other drivers (if any) should add the new shared type in ac97_codec.h.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.7)
   ALSA CVS update
   Intel8x0 driver
   Added the support of MCP04.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.6)
   ALSA CVS update
   Intel8x0 driver
   Added the support of nVidia CK804.
   
   Signed-off-by: Andrew Chew <achew@nvidia.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/08/02 1.1784.34.5)
   ALSA CVS update
   VIA82xx driver
   Added the quirk entry for ECS L7VMM2 uATX.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/29 1.1784.34.4)
   ALSA CVS update
   ICE1712 driver,ICE1724 driver
   Added the support of Pontis MS300 to snd-ice1724 driver.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/29 1.1784.34.3)
   ALSA CVS update
   ALSA<-OSS emulation
   Fixed a typo in the last change, resulting in the infinite loop.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.82)
   ALSA CVS update
   VIA82xx driver
   Fixed the check of invalid DMA position.
   
   The workaround for buggy mobo to correct the DMA position is fixed
   so that it works properly on normal chips.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.81)
   ALSA CVS update
   ICE1712 driver
   Added the (experimental) support of Terratec Phase 88.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.80)
   ALSA CVS update
   RME32 driver
   Fixed the address mask to get the correct DMA pointer value.
   
   Signed-off-by: Pilo Chambert <pilo.c@wanadoo.fr>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.79)
   ALSA CVS update
   RME32 driver
   Fixed the fullduplex mode.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.78)
   ALSA CVS update
   PCM Midlevel
   Notify PCM buffer overrun of the intermidate buffer on capture.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.77)
   ALSA CVS update
   PCM Midlevel
   Fixed/improved XRUN detection
   
   - don't print XRUN message in the case of draining.
   - pointer callback can return SNDRV_PCM_POS_XRUN to notify the middle layer.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.76)
   ALSA CVS update
   Control Midlevel,HWDEP Midlevel,ALSA Core,PCM Midlevel,RawMidi Midlevel
   Timer Midlevel,ALSA<-OSS emulation,ALSA sequencer,ALSA<-OSS sequencer
   Unlock BKL in ioctl callback to avoid the long preempt-disabling.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.75)
   ALSA CVS update
   ALSA Core
   Clean up: removed ifdefs and obsolete codes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.74)
   ALSA CVS update
   ALSA Core
   Added unlikely() to the debug check macros.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.73)
   ALSA CVS update
   ICE1712 driver
   Added master volume control.
   
   The master volume control is added again, this time with
   the digital attenuation so that it works independently from
   the DAC volumes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.72)
   ALSA CVS update
   ALSA Core,MIXART driver
   Removed the obsolete NONATOMIC_OPS flag.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.71)
   ALSA CVS update
   PPC PowerMac driver
   Fixed typo.
   
   Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/07/28 1.1757.61.70)
   ALSA CVS update
   PPC PMAC driver
   Fixed typo.
   
   Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/07/28 1.1757.61.69)
   ALSA CVS update
   ALSA Core
   use list_for_each() in core/memory.c
   
   Signed-off-by: Domen Puncer <domen@coderock.org>
   Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/07/28 1.1757.61.68)
   ALSA CVS update
   PPC
   The alsa driver for powermacs requires i2c support.
   
   Signed-off-by: Olaf Hering <olh@suse.de>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/07/28 1.1757.61.67)
   ALSA CVS update
   BT87x driver
   use exact values of analog clock rate
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.66)
   ALSA CVS update
   Documentation,SA11xx UDA1341 driver,PCM Midlevel,IOCTL32 emulation
   ALSA<-OSS emulation,Generic drivers,I2C cs8427,I2C tea6330t,L3 drivers
   OPL3SA2 driver,AD1816A driver,CS4231 driver,CS4236+ driver
   ES1688 driver,GUS Library,AMD InterWave driver,Opti9xx drivers
   EMU8000 driver,PARISC Harmony driver,AZT3328 driver,CMIPCI driver
   CS4281 driver,FM801 driver,Intel8x0 driver,Maestro3 driver,RME32 driver
   RME96 driver,SonicVibes driver,AK4531 codec,CS46xx driver
   ICE1712 driver,KORG1212 driver,NM256 driver,RME HDSP driver
   RME9652 driver,YMFPCI driver,PPC AWACS driver,PPC Burgundy driver
   PPC DACA driver,SPARC AMD7930 driver,SPARC cs4231 driver
   Common EMU synth
   use ARRAY_SIZE() instead of sizeof() computations
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.65)
   ALSA CVS update
   ALI5451 driver
   Added the missing snd_power_change_state() in the resume callback.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.64)
   ALSA CVS update
   ALSA Core,ATIIXP driver,ATIIXP-modem driver,Intel8x0 driver
   VIA82xx driver
   Clean up the suspend/resume: save/restore of pci state
   
   PCI status is restored in the common resume callback.
   (Stored in the saved_config array of pci_dev struct.)
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.63)
   ALSA CVS update
   Documentation
   Changed the description of PCI resource allocation to use pci_request_regions().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.62)
   ALSA CVS update
   EMU10K1/EMU10K2 driver,Trident driver,ALS4000 driver,ATIIXP driver
   ATIIXP-modem driver,AZT3328 driver,BT87x driver,CMIPCI driver
   CS4281 driver,ENS1370/1+ driver,ES1938 driver,ES1968 driver
   FM801 driver,Intel8x0 driver,Intel8x0-modem driver,Maestro3 driver
   RME32 driver,RME96 driver,SonicVibes driver,VIA82xx driver
   ALI5451 driver,ICE1712 driver,ICE1724 driver,KORG1212 driver
   MIXART driver,RME HDSP driver,RME9652 driver,Digigram VX222 driver
   Clean up the PCI resource allocation.
   
   Replaced the manual resource allocations with request_[mem_]region()
   with pci_request_regions().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.61)
   ALSA CVS update
   ALI5451 driver
   Fixed the suspend/resume.
   
   The suspend callback wasn't set the power state correctly, so
   the resume process was skipped.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.60)
   ALSA CVS update
   EMU10K1/EMU10K2 driver
   Fixed the detection of Audigy 2 ZS.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.59)
   ALSA CVS update
   ALSA sequencer
   Fixed the bad check on copy_from_user() return value
   
   Signed-off-by: Mika Kukkonen <mika@osdl.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.58)
   ALSA CVS update
   VIA82xx driver
   Added the ac97_quirk entry for ECS K7VTA3 v8.0 mobo.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.57)
   ALSA CVS update
   EMU10K1/EMU10K2 driver
   Enable low latency EFX capture on emu10k1
   
   The following patch fixes EFX capture on the emu10k1.  The
   capture_period_sizes table is in bytes, but the hardware constraint was
   being set in frames.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.56)
   ALSA CVS update
   AC97 Codec Core,Intel8x0 driver,Intel8x0-modem driver
   Fixed the detection of sample rates with no VRA support.
   
   - Changed ac97bus->vra to ac97bus->no_vra to indicate the VRA is NOT
     supported.
   - In the case of no_vra=1, only 48k is set as the possible rates in
     snd_ac97_pcm_assign().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.55)
   ALSA CVS update
   ALS4000 driver,ATIIXP driver,ATIIXP-modem driver,AZT3328 driver
   BT87x driver,CMIPCI driver,CS4281 driver,ENS1370/1+ driver
   ES1968 driver,FM801 driver,Intel8x0 driver,Maestro3 driver,RME32 driver
   RME96 driver,SonicVibes driver,VIA82xx driver,ALI5451 driver
   CS46xx driver,EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver
   KORG1212 driver,MIXART driver,NM256 driver,RME HDSP driver
   RME9652 driver,Trident driver,YMFPCI driver,PPC PMAC driver
   USB generic driver
   Clean up spinlocks.
   
   - Removed superfluous spinlocks.
   - Replaced spin_lock_irqsave() with spin_lock_irq() in the obvious places.
   - Make sure that prepare callback be non-atomic.
   - Removed SNDRV_PCM_INFO_NONATOMIC_OPS flag (which is default now).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.54)
   ALSA CVS update
   Documentation,PCM Midlevel
   Changed the atomicity of PCM prepare callback.
   
   The PCM prepare callback is now non-atomic, so that the driver can
   use the functions calling schedule (e.g. kmalloc with GFP_KERNEL).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.53)
   ALSA CVS update
   CS46xx driver
   Fixed a compile warning in the debug code.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.52)
   ALSA CVS update
   Intel8x0-modem driver
   Added -MODEM suffix to the driver name string to distinguish from the
   intel8x0 audio driver.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.51)
   ALSA CVS update
   Control Midlevel
   Fixed the unbalanced spinlock in the error path.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.50)
   ALSA CVS update
   Memalloc module
   Mark the allocated DMA pages as reserved for certain architectures.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.49)
   ALSA CVS update
   Documentation,PCI drivers,ATIIXP-modem driver
   Added snd-atiixp driver for ATI IXP AC97 modem controllers.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.48)
   ALSA CVS update
   ATIIXP driver
   Fixed a typo in the check of buffer/period size configuration.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.47)
   ALSA CVS update
   RME HDSP driver
   ALSA rme9652/hdsp: remove inlines
   
   The patch below removes all inlines from hdsp.c. As a side effect, it
   showed that snd_hdsp_9652_disable_mixer() is completely unused, and it's
   therefore also removed in the patch.
   
   Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.46)
   ALSA CVS update
   Documentation
   fix typo
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.45)
   ALSA CVS update
   ALSA<-OSS emulation
   fix missing semaphore release in snd_mixer_oss_build_input()
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.44)
   ALSA CVS update
   Documentation,AC97 Codec Core,ATIIXP driver,CS4281 driver
   ENS1370/1+ driver,ES1968 driver,FM801 driver,Intel8x0 driver
   Intel8x0-modem driver,Maestro3 driver,VIA82xx driver,ALI5451 driver
   au88x0 driver,EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver
   NM256 driver,Trident driver,YMFPCI driver
   replace ac97_t template with ac97_template_t
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.43)
   ALSA CVS update
   CS46xx driver
   change codec index computation in snd_cs46xx_read/write;
   replace ac97_t template with ac97_template_t
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.42)
   ALSA CVS update
   Memalloc module
   - Don't mark pages from dma_alloc_coherent as reserved.
     The pages from __get_free_pages() are still marked as reserved, but this could
     be also unnecessary.
   - Fixed a typo in comment.
   - Fixed the pre-allocated buffer size for rme9652 & hdsp.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.41)
   ALSA CVS update
   Documentation
   Fixed missing </section>.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.40)
   ALSA CVS update
   ALSA Core
   Fixed compile warnings withoug CONFIG_PM.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.39)
   ALSA CVS update
   Documentation
   Removed obsolete sndmagic.h.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/28 1.1757.61.38)
   ALSA CVS update
   Documentation,AC97 Codec Core,ATIIXP driver,CS4281 driver
   ENS1370/1+ driver,ES1968 driver,FM801 driver,Intel8x0 driver
   Intel8x0-modem driver,Maestro3 driver,VIA82xx driver,ALI5451 driver
   au88x0 driver,CS46xx driver,EMU10K1/EMU10K2 driver,ICE1712 driver
   ICE1724 driver,NM256 driver,Trident driver,YMFPCI driver
   move AC'97 bus callbacks into seperate ops record;
   remove ac97_bus_t template requirement from snd_ac97_bus()
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.37)
   ALSA CVS update
   USB generic driver
   allow USB MIDI devices without audio control interface
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.36)
   ALSA CVS update
   AC97 Codec Core
   fix odd comment :)
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.35)
   ALSA CVS update
   AMD InterWave driver
   reduce stack usage;
   fix ROM checksum check
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.34)
   ALSA CVS update
   GUS Library,Wavefront drivers
   reduce stack usage;
   fix buffer overflow
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.33)
   ALSA CVS update
   PCM Midlevel
   fix memory leak
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.32)
   ALSA CVS update
   USB generic driver
   remove whitespace at end of lines
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.31)
   ALSA CVS update
   Generic drivers,AK4531 codec
   One space at the end of a line is evil.
   So how do we call it if a line has 300 of them? :)
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.30)
   ALSA CVS update
   OPL4
   reorganize locking;
   optimize memory accesses
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/28 1.1757.61.29)
   ALSA CVS update
   Intel8x0 driver
   set msbits for 20-bit sample format
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/07/04 1.1757.61.28)
   ALSA CVS update
   au88x0 driver
   - asXtalkGainsAllChan -> vortex_asXtalkGainsAllChan
   - fixed extern/static problem
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/07/04 1.1757.61.27)
   ALSA CVS update
   ES1938 driver
   
   Playing Quake1 (quakeforge-flavor with ALSA-driver) I hear cracks and blibs.
   Other apps (xine, mpg321) are fine. The OSS driver in 2.6.7 produces no
   cracks (but reverses stereo BTW).
   
   I fixed it, i.e. it works for me:
   
   *No swapping of stereo channels
   *no cracks
   
   Signed-off-by: <maps4711@gmx.de>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/07/04 1.1757.61.26)
   ALSA CVS update
   PCM Midlevel,RME32 driver
   - Fixed the int types in indirect_pcm helpers.
   - Added the missing initialization of fullduplex mode on rme32.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/04 1.1757.61.25)
   ALSA CVS update
   EMU10K1/EMU10K2 driver
   Clean up the invalid (commented out) lines for emu10k1x.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.24)
   ALSA CVS update
   Instrument layer
     LD      .tmp_vmlinux1
   sound/built-in.o(.text+0xfb4ae): In function nd_gus_synth_new_device':
   : undefined reference to nd_seq_iwffff_init'
   make: *** [.tmp_vmlinux1] Error 1
   
   Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/07/01 1.1757.61.23)
   ALSA CVS update
   PCM Midlevel
   
   snd_pcm_timer_resolution_change():
   
   Right, that function doesn't work well for 44100/1024 in 32 bits -- it
   ends up trying to calculate 1e7 * 1024 / 441 and having to divide
   both numerator and denominator by 4 (thus losing the rather crucial 1
   at the end of 441) before it can do the calculation without overflow.
   
   Attached is a patch against 1.0.5a that gets better results in this
   instance, by leaving the denominator alone and instead doubling the
   result back up by the same number of times as the multiplier had to
   be halved by.
   
   Signed-off-by: Chris Cannam <cannam@all-day-breakfast.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/07/01 1.1757.61.22)
   ALSA CVS update
   RME32 driver
   Added the experimental fullduplex support.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.21)
   ALSA CVS update
   CS46xx driver,EMU10K1/EMU10K2 driver,PCM Midlevel
   Clean up of indirect PCM data transfer with helper functions.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.20)
   ALSA CVS update
   AC97 Codec Core
   Check the validity of registers before creating controls.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.19)
   ALSA CVS update
   ALSA<-OSS sequencer
   Suppress the error message when no device is found.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.18)
   ALSA CVS update
   NM256 driver
   Added AC97 CD register to the list of allowed registeres.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.17)
   ALSA CVS update
   SA11xx UDA1341 driver,Generic drivers,MPU401 UART,OPL3,OPL4,L3 drivers
   PARISC Harmony driver,Sound Core PDAudioCF driver
   Digigram VX Pocket driver,PPC PowerMac driver,SPARC AMD7930 driver
   SPARC cs4231 driver,USB generic driver
   Clean up of obsolete MODULE_* stuff (other part)
   
   Removed MODULE_CLASSES() and MODULE_SYNTAX().
   Replaced MODULE_DEVICES() with MODULE_SUPPORTED_DEVICE()
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.16)
   ALSA CVS update
   ALS4000 driver,ATIIXP driver,AZT3328 driver,BT87x driver,CMIPCI driver
   CS4281 driver,ENS1370/1+ driver,ES1938 driver,ES1968 driver
   FM801 driver,Intel8x0 driver,Intel8x0-modem driver,Maestro3 driver
   RME32 driver,RME96 driver,SonicVibes driver,VIA82xx driver
   AC97 Codec Core,ALI5451 driver,au88x0 driver,CS46xx driver
   EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver,KORG1212 driver
   MIXART driver,NM256 driver,RME HDSP driver,RME9652 driver
   Trident driver,Digigram VX222 driver,YMFPCI driver
   Clean up of obsolete MODULE_* stuff (pci part)
   
   Removed MODULE_CLASSES() and MODULE_SYNTAX().
   Replaced MODULE_DEVICES() with MODULE_SUPPORTED_DEVICE()
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.15)
   ALSA CVS update
   ALS100 driver,AZT2320 driver,CMI8330 driver,DT019x driver,ES18xx driver
   OPL3SA2 driver,Sound Galaxy driver,Sound Scape driver,AD1816A driver
   AD1848 driver,CS4231 driver,CS4236+ driver,ES1688 driver
   GUS Classic driver,GUS Extreme driver,GUS MAX driver
   AMD InterWave driver,Opti9xx drivers,EMU8000 driver,ES968 driver
   SB16/AWE driver,SB8 driver,SB drivers,Wavefront drivers
   Clean up of obsolete MODULE_* stuff (isa part)
   
   Removed MODULE_CLASSES() and MODULE_SYNTAX().
   Replaced MODULE_DEVICES() with MODULE_SUPPORTED_DEVICE()
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.14)
   ALSA CVS update
   Documentation,PCM Midlevel,RawMidi Midlevel,ALSA Core,Timer Midlevel
   ALSA<-OSS emulation,ALSA sequencer,Instrument layer,ALSA<-OSS sequencer
   Clean up of obsolete MODULE_* stuff (core part)
   
   Removed MODULE_CLASSES() and MODULE_SYNTAX().
   Replaced MODULE_DEVICES() with MODULE_SUPPORTED_DEVICE()
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.13)
   ALSA CVS update
   CMIPCI driver
   Fix the i/o port range of gameport on cmipci
   
   Gameport use only 1 I/O port not 8.
   Attached patch fix gameport on CMIPCI soundcards.
   
   Signed-off-by: Artur Frysiak <wiget@pld-linux.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.12)
   ALSA CVS update
   AC97 Codec Core
   Fixed STAC9758 output jack selection control
   
   - fixed unbalnaced mutex.
   - use ac97_update_bits_page() instead of snd_ac97_update_bits().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.11)
   ALSA CVS update
   Documentation,SA11xx UDA1341 driver,Generic drivers,MPU401 UART,OPL3
   OPL4,Digigram VX core,I2C cs8427,I2C lib core,I2C tea6330t,L3 drivers
   AK4117 receiver,Serial BUS drivers,PARISC Harmony driver
   Sound Core PDAudioCF driver,Digigram VX Pocket driver,PPC AWACS driver
   PPC Burgundy driver,PPC DACA driver,PPC PMAC driver,PPC Tumbler driver
   SPARC AMD7930 driver,SPARC cs4231 driver,Common EMU synth
   USB generic driver
   Removal and replacement of magic memory allocators and casts (other parts)
   
   This patch replaces snd_magic_kmalloc(), snd_magic_kcallc() and snd_magic_kfree()
   with kmalloc(), kcalloc() and kfree(), respectively.
   The cast via snd_magic_cast() is replaced with the standard cast, too.
   
   Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.10)
   ALSA CVS update
   ES1688 driver,ALS100 driver,AZT2320 driver,CMI8330 driver,DT019x driver
   ES18xx driver,OPL3SA2 driver,Sound Scape driver,AD1816A driver
   AD1848 driver,CS4231 driver,CS4236+ driver,GUS Library,Opti9xx drivers
   EMU8000 driver,ES968 driver,SB16/AWE driver,SB8 driver,SB drivers
   Wavefront drivers
   Removal and replacement of magic memory allocators and casts (isa part)
   
   This patch replaces snd_magic_kmalloc(), snd_magic_kcallc() and snd_magic_kfree()
   with kmalloc(), kcalloc() and kfree(), respectively.
   The cast via snd_magic_cast() is replaced with the standard cast, too.
   
   Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.9)
   ALSA CVS update
   ALS4000 driver,ATIIXP driver,AZT3328 driver,BT87x driver,CMIPCI driver
   CS4281 driver,ENS1370/1+ driver,ES1938 driver,ES1968 driver
   FM801 driver,Intel8x0 driver,Intel8x0-modem driver,Maestro3 driver
   RME32 driver,RME96 driver,SonicVibes driver,VIA82xx driver
   AC97 Codec Core,AK4531 codec,ALI5451 driver,au88x0 driver,CS46xx driver
   EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver,KORG1212 driver
   MIXART driver,NM256 driver,RME HDSP driver,RME9652 driver
   Trident driver,Digigram VX222 driver,YMFPCI driver
   Removal and replacement of magic memory allocators and casts (pci part)
   
   This patch replaces snd_magic_kmalloc(), snd_magic_kcallc() and snd_magic_kfree()
   with kmalloc(), kcalloc() and kfree(), respectively.
   The cast via snd_magic_cast() is replaced with the standard cast, too.
   
   Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.8)
   ALSA CVS update
   Control Midlevel,ALSA Core,HWDEP Midlevel,PCM Midlevel,RawMidi Midlevel
   Timer Midlevel,IOCTL32 emulation,ALSA<-OSS emulation,ALSA sequencer
   Removal and replacement of magic memory allocators and casts (core part)
   
   This patch replaces snd_magic_kmalloc(), snd_magic_kcallc() and snd_magic_kfree()
   with kmalloc(), kcalloc() and kfree(), respectively.
   The cast via snd_magic_cast() is replaced with the standard cast, too.
   
   Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.7)
   ALSA CVS update
   Control Midlevel,ALSA Core,PCM Midlevel,RawMidi Midlevel,Timer Midlevel
   IOCTL32 emulation,ALSA<-OSS emulation,ALSA sequencer,Instrument layer
   ALSA<-OSS sequencer,OPL3,EMU8000 driver,AC97 Codec Core,au88x0 driver
   EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver,Trident driver
   Synth,Common EMU synth
   Removal of snd_kcalloc()
   
   This patch removes snd_kcalloc() from the kernel and updates callers to use
   the new generic kcalloc().
   
   Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.6)
   ALSA CVS update
   ICE1712 driver,ICE1724 driver
   Fixes for VT1720/VT1724
   
   - Fixed the volume update on aureon.
   - Removed the bogus master volume from aureon.
   - Fixed the wrong number of ADCS (not used, though).
   - Don't access GPIO high bits on VT1720.
   - Fixed the buffer byte alignment for SPDIF and independen PCMs.
   - Proper rate constraints according to the I2S/AC-link connection.
   - Clean up the private data for PCM callbacks.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.5)
   ALSA CVS update
   EMU10K1/EMU10K2 driver
   Audigy 2 ZS - side support
   
   Added the support of side speakers on Audigy 2 ZS.
   
   TODO - detection of audigy 2 zs. Now it will add side controls to
   mixer for audigy 2 to. Maybe left or right slider can control volume
   of back center on audigy 2 too.
   
   Signed-off-by: Peter Zubaj <pzad@pobox.sk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.4)
   ALSA CVS update
   EMU10K1/EMU10K2 driver
   Fix Audigy + FX8010 capture (hw:x,2)
   
   
   This patch fixes capture problems from hw:x,2 on Audigy. It is same as
    previous, because it can be applied cleanly against CVS (I tested
   version from 23.06.2004) and hope it is still true for current CVS.
   
   I tested 4 channel recrding and it was OK.
   
   hw:x,2 records outputs from FX8010 (not FX buses)
   
   Using 'EFX voices mask' you can set channels what you want record.
   
   use alsactl store to store config
   edit this config (set true for needed channel for 'EFX voices mask'
   control) - I recorded channels 8,9,14,15 (front and rear output).
   use alsactl restore to restore config
   
   Looks like channel count must be power of 2 (1, 2, 4, 8, ...).
   
   Signed-off-by: Peter Zubaj <pzad@pobox.sk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.3)
   ALSA CVS update
   AC97 Codec Core
   Fixed the detection of STAC9708/11 surround control.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/07/01 1.1757.61.2)
   This patch introduces a kcalloc() in the kernel that is used to
   replace the ALSA subsystem-specific snd_kcalloc() and snd_magic_kcalloc().
   
   Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

<perex@suse.cz> (04/06/23 1.1757.29.36)
   ALSA CVS update
   ALSA sequencer,Instrument layer,ISA,GUS drivers
   Clean up Makefiles for the sequencer stuff using reverse selections.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.35)
   ALSA CVS update
   USB generic driver
   new functions snd_usbmidi_input_stop() and snd_usbmidi_input_start()
   needed by snd-usb-usx2y to be able to use usb_set_interface()
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/06/23 1.1757.29.34)
   ALSA CVS update
   PCM Midlevel
   Each of snd_pcm_hw_refine_old_user() and snd_pcm_hw_params_old_user()
   consume 856 bytes of stack and can invoke deep calls via the page allocator.
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/06/23 1.1757.29.33)
   ALSA CVS update
   CMIPCI driver
   don't sleep in prepare callback
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/06/23 1.1757.29.32)
   ALSA CVS update
   PCM Midlevel,ALSA<-OSS emulation,CMIPCI driver
   reduce stack usage
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/06/23 1.1757.29.31)
   ALSA CVS update
   au88x0 driver
   - Fixed the wrong pointer cast on 64bit architectures.
   
   Signed-off-by: Andi Kleen <ak@suse.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.30)
   ALSA CVS update
   EMU10K1/EMU10K2 driver
   Merge EFX playback and capture streams to the single device (hw:0,2).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.29)
   ALSA CVS update
   PCM Midlevel,ALSA Core,RME32 driver,RME96 driver,NM256 driver
   - Fix the mmap via io_remap_page_range() on nm256, rme32 and rme96.
     Added SNDRV_PCM_INFO_MMAP_IOMEM to handle this case.
   - Clean up the indirect accessing on RME32/RME96 drivers.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.28)
   ALSA CVS update
   USB generic driver
   handle devices that allow setting but not reading sample rate
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/06/23 1.1757.29.27)
   ALSA CVS update
   VIA82xx driver
   Fixed the calculation of the current DMA position at the period boundary.
   
   In some cases, DMA residue returns the value 0 during the transition
   at the DMA boundary.  The patch handles it as the position 0.
   This may prevent the flood of 'invalid last pointer' debug messages
   on some devices.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.26)
   ALSA CVS update
   Intel8x0 driver
   Fixed the calculation of the current DMA position on some sloppy devices.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.25)
   ALSA CVS update
   PCM Midlevel,ES1968 driver,EMU10K1/EMU10K2 driver,KORG1212 driver
   Trident driver
   Clean up the buffer management in the PCM runtime record.
   
   The buffer-allocation record is hold in runtime instance, so that
   it can be checked more cleanly.
   
   dma_private is removed from runtime (it's used for SG-buffers).
   The macro snd_pcm_substream_sgbuf() should be used instead of direct
   access to the pointer, to retrieve the sgbuf struct from the PCM
   substream instance.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.24)
   ALSA CVS update
   Generic drivers
   Do the buffer allocation in hw_params callback instead of open callback.
   
   This will prevent to use the allocation of excessive size.
   Pre-allocation is called with the default size 0, ie. no buffer will be
   pre-allocated as default.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.23)
   ALSA CVS update
   ES1968 driver
   Fix the crash at unloading the module due to the shared interrupt
   with other devices.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.22)
   ALSA CVS update
   PCM Midlevel
   Removed the obsoleted init for boot parameters.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.21)
   ALSA CVS update
   CS46xx driver,MIXART driver
   reduce stack usage
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/06/23 1.1757.29.20)
   ALSA CVS update
   OSS sequencer emulation
   
   Use separate functions for some ioctls to reduce stack usage.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/06/23 1.1757.29.19)
   ALSA CVS update
   OPL4
   add newline at end of file
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/06/23 1.1757.29.18)
   ALSA CVS update
   Opti9xx drivers
   Fixed spin deadlocks.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.17)
   ALSA CVS update
   USB generic driver
   Quattro USB: handle the different endianness of playback and recording sample data
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/06/23 1.1757.29.16)
   ALSA CVS update
   PCM Midlevel,ALSA<-OSS emulation
   Clean up and optimization of PCM format-specific functions.
   
   - Use array indexing instead of huge swith/case.
   - Removed superfluous handling of floats.
   - Use memcpy for silencing to simplify the codes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.15)
   ALSA CVS update
   Intel8x0 driver
   Added the PCI ID for nVidia CK8.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.14)
   ALSA CVS update
   ATIIXP driver,VIA82xx driver
   Added the missing RESUME info bits to pcm.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.13)
   ALSA CVS update
   ICE1724 driver
   SPDIF output fixes
   
   - Fixed the encoding of SPDIF status bits in the consumer mode.
   - Change the SPDIF status bits according to the current sample rate.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/06/23 1.1757.29.12)
   ALSA CVS update
   Documentation
   Added snd-fm801 tuner parameter description
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/05/31 1.1722.2.40)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   Fixed mutex deadlocks.

<perex@suse.cz> (04/05/30 1.1722.2.38)
   ALSA 1.0.5

<perex@suse.cz> (04/05/30 1.1722.2.37)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core
   Fixed warnings for pci PM callbacks when not CONFIG_PCI

<perex@suse.cz> (04/05/28 1.1722.2.36)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - Added the single mixer control with AC97 2.3 paging.
   - Handle the paging for some ALC655/658 registers.
   - Added the experimental support for ALC850.

<perex@suse.cz> (04/05/28 1.1722.2.35)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   Avoid warning message during codec probing in case SKIP_AUDIO flag is not set.

<perex@suse.cz> (04/05/28 1.1722.2.34)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PARISC Harmony driver
   fixed typos.

<perex@suse.cz> (04/05/28 1.1722.2.33)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Signed-off-by: Kevin Mack <kevmack@accesscomm.ca>
   For Gateway M675 notebook - this will direct mixer
   output to speaker, headphone and line-out instead
   of just the front(DAC-A) signal.

<perex@suse.cz> (04/05/28 1.1722.2.32)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - use snd_pcm_limit_hw_rates() and removed redundant codes.
   - fixed the rate constraints when 'IEC958 Output Switch' is on.
   - check the SPDIF support on AC97 and don't build IEC958 stuffs if not available.

<perex@suse.cz> (04/05/28 1.1722.2.31)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   added ac97_can_spdif() for checking the SPDIF support.

<perex@suse.cz> (04/05/28 1.1722.2.30)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   added the DXS entry for Mitac/Vobis/Yakumo laptop.

<perex@suse.cz> (04/05/28 1.1722.2.29)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   Wavefront drivers
   fix possible buffer overflow in wavefront_download_firmware()

<perex@suse.cz> (04/05/28 1.1722.2.28)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1724 driver
   avoid to change the AC97 rate registers.  this seems conflicting
   with the rate conversion on VT172x.

<perex@suse.cz> (04/05/28 1.1722.2.27)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   added 'Clock Mode' control to choose the clock source.

<perex@suse.cz> (04/05/28 1.1722.2.26)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   fixed the compile warnings due to the last change.

<perex@suse.cz> (04/05/28 1.1722.2.25)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PARISC Harmony driver
   - fixed the buffer handling without dma_alloc_coherent support.

<perex@suse.cz> (04/05/28 1.1722.2.24)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Digigram VX core
   fixed sleep while atomic in the trigger callback.

<perex@suse.cz> (04/05/28 1.1722.2.23)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - added the global mutex for ac97_t (ad18xx mutex is removed).
     used to protect paging and AD18xx multi-codecs.
   - set PAGE_INT register explicitly before accessing (for STAC9758).
   - moved ALC650 revision check to patch_alc650().
   - support stereo Mic playback.
   - moved STAC9708 quirk to patch_stac9708().
   - don't clear PC_BEEP high bits (ac97 2.3 sets frequency there).
   - avoid the unnecessary RESET-waiting for audio/modem codec.
   - fixed the evaluation of modem codec to call mpatch callback properly.
   - determine the SPDIF rate in the build path.
   - added suffix argument to snd_ac97_rename|remove|swap_ctl().
   - added snd_ac97_rename_vol_ctl().

<perex@suse.cz> (04/05/28 1.1722.2.22)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   - added ifdef CONFIG_PCI around the enable module option to avoid the compile
     warnings without PCI support.

<perex@suse.cz> (04/05/28 1.1722.2.21)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,ICE1712 driver,ICE1724 driver
   - fixed the description of model module parameters for ice1712 and ice1724
     drivers.
   - added the support of VT1720-based mobo.
     (still experimental and supporting AC97 only)

<perex@suse.cz> (04/05/28 1.1722.2.20)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ATIIXP driver
   - continue to probe other codecs even if a codec returns error
     (instead of breaking the probing).
     this will fix some cases with both AC97 and MC97 codecs.

<perex@suse.cz> (04/05/28 1.1722.2.19)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   ALSA sequencer,ALSA<-OSS sequencer
   export snd_seq_set_queue_tempo() for OSS to prevent calling
   snd_seq_kernel_client_ctl() (using copy_from_user()) in interrupt
   context

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
