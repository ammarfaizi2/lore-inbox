Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264070AbTDJP37 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 11:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTDJP37 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 11:29:59 -0400
Received: from gate.perex.cz ([194.212.165.105]:11795 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S264070AbTDJP3z (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 11:29:55 -0400
Date: Thu, 10 Apr 2003 17:40:43 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] ALSA update
Message-ID: <Pine.LNX.4.44.0304101731270.1192-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-04-10.patch.gz

Additional notes:

  I changed the PnP header to add extra macros to identify the used
protocol. I need this check for a workaround for the ES18xx driver (IRQ
share settings via ISA PnP registers). Perhaps, Adam will have a better
idea for final implementation, but in meantime, we can use this code.

  Now, the whole ALSA tree can be finally compiled with new PnP layer.

				    Thank you for inclusion,
							Jaroslav

The pull command will update the following files:

 sound/core/memory_wrapper.c                                  |   69 
 sound/pci/rme9652/digiface_firmware.dat                      | 4072 -----------
 sound/pci/rme9652/multiface_firmware.dat                     | 4072 -----------
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |  733 +
 drivers/pnp/isapnp/core.c                                    |    2 
 drivers/pnp/pnpbios/core.c                                   |    2 
 include/linux/pnp.h                                          |   19 
 include/sound/ac97_codec.h                                   |   13 
 include/sound/asound.h                                       |   11 
 include/sound/control.h                                      |   43 
 include/sound/cs46xx.h                                       |    3 
 include/sound/cs46xx_dsp_scb_types.h                         |  846 +-
 include/sound/cs46xx_dsp_spos.h                              |   26 
 include/sound/cs46xx_dsp_task_types.h                        |  124 
 include/sound/driver.h                                       |    1 
 include/sound/emu10k1.h                                      |   10 
 include/sound/hdsp.h                                         |   92 
 include/sound/initval.h                                      |    2 
 include/sound/memalloc.h                                     |   15 
 include/sound/opl3.h                                         |    3 
 include/sound/snd_wavefront.h                                |   12 
 include/sound/trident.h                                      |    8 
 include/sound/ymfpci.h                                       |   24 
 sound/core/Makefile                                          |    2 
 sound/core/control.c                                         |  156 
 sound/core/info.c                                            |    5 
 sound/core/ioctl32/pcm32.c                                   |   14 
 sound/core/ioctl32/rawmidi32.c                               |   10 
 sound/core/ioctl32/timer32.c                                 |   13 
 sound/core/memalloc.c                                        |  181 
 sound/core/oss/mixer_oss.c                                   |   19 
 sound/core/oss/pcm_oss.c                                     |    5 
 sound/core/pcm_lib.c                                         |    6 
 sound/core/pcm_native.c                                      |    1 
 sound/core/rtctimer.c                                        |    4 
 sound/core/seq/instr/ainstr_iw.c                             |    2 
 sound/core/seq/oss/seq_oss_midi.c                            |    1 
 sound/core/seq/seq_memory.c                                  |    4 
 sound/core/seq/seq_midi.c                                    |    2 
 sound/core/seq/seq_midi_emul.c                               |    2 
 sound/core/sgbuf.c                                           |    1 
 sound/core/sound.c                                           |    3 
 sound/drivers/dummy.c                                        |    1 
 sound/drivers/opl3/opl3_lib.c                                |    2 
 sound/drivers/opl3/opl3_seq.c                                |    4 
 sound/drivers/opl3/opl3_synth.c                              |   12 
 sound/i2c/cs8427.c                                           |    2 
 sound/i2c/l3/uda1341.c                                       |    2 
 sound/isa/Kconfig                                            |    5 
 sound/isa/ad1816a/ad1816a.c                                  |  216 
 sound/isa/als100.c                                           |   41 
 sound/isa/azt2320.c                                          |   48 
 sound/isa/cmi8330.c                                          |  230 
 sound/isa/cs423x/cs4236.c                                    |  320 
 sound/isa/dt019x.c                                           |   43 
 sound/isa/es18xx.c                                           |  281 
 sound/isa/gus/interwave.c                                    |  255 
 sound/isa/opl3sa2.c                                          |  158 
 sound/isa/opti9xx/opti92x-ad1848.c                           |  322 
 sound/isa/sb/es968.c                                         |   15 
 sound/isa/sb/sb16.c                                          |   46 
 sound/isa/sb/sb8.c                                           |    6 
 sound/isa/sgalaxy.c                                          |    2 
 sound/isa/wavefront/wavefront.c                              |  257 
 sound/pci/ac97/ac97_codec.c                                  |  199 
 sound/pci/ac97/ac97_id.h                                     |    2 
 sound/pci/ac97/ac97_patch.c                                  |   34 
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/ali5451/ali5451.c                                  |   15 
 sound/pci/cmipci.c                                           |    4 
 sound/pci/cs4281.c                                           |    4 
 sound/pci/cs46xx/cs46xx.c                                    |    8 
 sound/pci/cs46xx/cs46xx_lib.c                                |  174 
 sound/pci/cs46xx/cs46xx_lib.h                                |    2 
 sound/pci/cs46xx/dsp_spos.c                                  |  126 
 sound/pci/cs46xx/dsp_spos.h                                  |   11 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                          |   93 
 sound/pci/emu10k1/emu10k1_main.c                             |    9 
 sound/pci/emu10k1/emufx.c                                    |   10 
 sound/pci/emu10k1/emumixer.c                                 |   77 
 sound/pci/emu10k1/emupcm.c                                   |   25 
 sound/pci/ens1370.c                                          |    4 
 sound/pci/es1938.c                                           |   13 
 sound/pci/fm801.c                                            |   11 
 sound/pci/ice1712/ak4524.c                                   |   18 
 sound/pci/ice1712/ice1712.c                                  |   16 
 sound/pci/intel8x0.c                                         |    4 
 sound/pci/korg1212/korg1212.c                                |  212 
 sound/pci/maestro3.c                                         |    7 
 sound/pci/rme32.c                                            |    4 
 sound/pci/rme96.c                                            |    4 
 sound/pci/rme9652/hdsp.c                                     | 2109 ++++-
 sound/pci/rme9652/rme9652.c                                  |    4 
 sound/pci/trident/trident_main.c                             |  100 
 sound/pci/via82xx.c                                          |  164 
 sound/pci/ymfpci/ymfpci.c                                    |   76 
 sound/pci/ymfpci/ymfpci_main.c                               |   12 
 sound/ppc/awacs.c                                            |   33 
 sound/ppc/pmac.c                                             |  257 
 sound/ppc/pmac.h                                             |   25 
 sound/ppc/powermac.c                                         |   12 
 sound/usb/usbquirks.h                                        |    2 
 102 files changed, 5576 insertions(+), 11206 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/04/10 1.1168)
   ALSA and PnP update
     - compilation fixes
     - enhanced linux/pnp.h:
         pnp_device_is_isapnp(dev)
         pnp_device_is_pnpbios(dev)
         isapnp_card_number(dev)
         isapnp_csn_number(dev)

<perex@suse.cz> (03/04/10 1.1167)
   ALSA update
     - documentation
     - control API - added multi-elements to reduce memory usage
     - improved preallocation of DMA buffers
     - CS46xx driver - added support for secondary codec
     - HDSP driver - big update
       - firmware is loaded with hdsptool now
     - pmac driver updates (fixed oops and beep stuff)
     - VIA82xx driver updated
     - ymfpci driver updated 
     - drivers updated to new PnP layer
       - wavefront, ad1816a, cs423x, es18xx, interwave, opl3sa2, cmi8330
       


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

