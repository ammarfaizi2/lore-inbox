Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbTBHUzZ>; Sat, 8 Feb 2003 15:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTBHUzZ>; Sat, 8 Feb 2003 15:55:25 -0500
Received: from gate.perex.cz ([194.212.165.105]:43021 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267098AbTBHUzX>;
	Sat, 8 Feb 2003 15:55:23 -0500
Date: Sat, 8 Feb 2003 22:04:34 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update
Message-ID: <Pine.LNX.4.44.0302082201090.1141-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-02-08.patch.gz

						Jaroslav

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt |    2 
 Documentation/sound/alsa/CMIPCI.txt             |   25 -
 include/sound/core.h                            |    2 
 include/sound/cs46xx_dsp_scb_types.h            |    8 
 include/sound/cs46xx_dsp_spos.h                 |    4 
 include/sound/mixer_oss.h                       |    4 
 include/sound/pcm_params.h                      |    4 
 include/sound/seq_kernel.h                      |    2 
 include/sound/sndmagic.h                        |    2 
 include/sound/timer.h                           |   32 -
 include/sound/version.h                         |    6 
 sound/core/device.c                             |    3 
 sound/core/hwdep.c                              |    2 
 sound/core/info.c                               |    6 
 sound/core/init.c                               |    6 
 sound/core/ioctl32/ioctl32.c                    |   35 -
 sound/core/ioctl32/ioctl32.h                    |    5 
 sound/core/ioctl32/pcm32.c                      |   28 -
 sound/core/ioctl32/rawmidi32.c                  |   14 
 sound/core/ioctl32/seq32.c                      |   52 +-
 sound/core/ioctl32/timer32.c                    |   14 
 sound/core/isadma.c                             |   13 
 sound/core/oss/mixer_oss.c                      |   11 
 sound/core/oss/pcm_oss.c                        |   26 -
 sound/core/oss/pcm_plugin.c                     |    2 
 sound/core/pcm.c                                |    2 
 sound/core/pcm_lib.c                            |   24 -
 sound/core/pcm_memory.c                         |    2 
 sound/core/pcm_native.c                         |    6 
 sound/core/pcm_sgbuf.c                          |    2 
 sound/core/rawmidi.c                            |   28 -
 sound/core/rtctimer.c                           |   37 -
 sound/core/seq/Makefile                         |    2 
 sound/core/seq/instr/Makefile                   |    2 
 sound/core/seq/instr/ainstr_fm.c                |    4 
 sound/core/seq/instr/ainstr_gf1.c               |   14 
 sound/core/seq/instr/ainstr_iw.c                |   24 -
 sound/core/seq/instr/ainstr_simple.c            |    8 
 sound/core/seq/seq_clientmgr.c                  |    2 
 sound/core/seq/seq_device.c                     |    2 
 sound/core/seq/seq_instr.c                      |    4 
 sound/core/seq/seq_midi.c                       |    3 
 sound/core/seq/seq_midi_emul.c                  |    8 
 sound/core/seq/seq_midi_event.c                 |    8 
 sound/core/seq/seq_ports.c                      |    4 
 sound/core/seq/seq_queue.c                      |   60 --
 sound/core/seq/seq_queue.h                      |    2 
 sound/core/seq/seq_timer.c                      |   21 
 sound/core/seq/seq_timer.h                      |    6 
 sound/core/sound.c                              |    2 
 sound/core/timer.c                              |  296 +++++++-----
 sound/drivers/dummy.c                           |    3 
 sound/drivers/mtpav.c                           |    2 
 sound/drivers/opl3/opl3_oss.c                   |    3 
 sound/drivers/opl3/opl3_seq.c                   |    1 
 sound/i2c/cs8427.c                              |    3 
 sound/i2c/tea6330t.c                            |    3 
 sound/isa/ad1816a/ad1816a_lib.c                 |    7 
 sound/isa/ad1848/ad1848_lib.c                   |    7 
 sound/isa/cmi8330.c                             |    3 
 sound/isa/cs423x/cs4231_lib.c                   |    7 
 sound/isa/cs423x/cs4236.c                       |    2 
 sound/isa/cs423x/cs4236_lib.c                   |    8 
 sound/isa/es1688/es1688_lib.c                   |    9 
 sound/isa/es18xx.c                              |   27 -
 sound/isa/gus/Makefile                          |    2 
 sound/isa/gus/gus_mem.c                         |    4 
 sound/isa/gus/gus_mixer.c                       |    3 
 sound/isa/gus/gus_pcm.c                         |    9 
 sound/isa/gus/gus_synth.c                       |    5 
 sound/isa/gus/interwave.c                       |    3 
 sound/isa/opti9xx/opti92x-ad1848.c              |    9 
 sound/isa/sb/Makefile                           |    2 
 sound/isa/sb/emu8000.c                          |    4 
 sound/isa/sb/emu8000_pcm.c                      |    2 
 sound/isa/sb/sb16_main.c                        |    8 
 sound/isa/sb/sb8_main.c                         |    4 
 sound/isa/sgalaxy.c                             |    3 
 sound/isa/wavefront/wavefront_fx.c              |    2 
 sound/isa/wavefront/wavefront_synth.c           |    4 
 sound/pci/ac97/ac97_codec.c                     |  124 ++++-
 sound/pci/ac97/ac97_patch.c                     |   16 
 sound/pci/ac97/ak4531_codec.c                   |    3 
 sound/pci/ali5451/ali5451.c                     |   16 
 sound/pci/cmipci.c                              |   77 ++-
 sound/pci/cs4281.c                              |    4 
 sound/pci/cs46xx/cs46xx_lib.c                   |  154 ++++--
 sound/pci/cs46xx/dsp_spos.c                     |    6 
 sound/pci/cs46xx/dsp_spos_scb_lib.c             |    2 
 sound/pci/emu10k1/Makefile                      |    2 
 sound/pci/emu10k1/emufx.c                       |   23 
 sound/pci/ens1370.c                             |    5 
 sound/pci/es1938.c                              |   16 
 sound/pci/es1968.c                              |    7 
 sound/pci/fm801.c                               |    7 
 sound/pci/ice1712/ak4524.c                      |    5 
 sound/pci/ice1712/amp.c                         |    1 
 sound/pci/ice1712/ews.c                         |    9 
 sound/pci/ice1712/ice1712.c                     |   29 -
 sound/pci/ice1712/ice1712.h                     |    6 
 sound/pci/intel8x0.c                            |   10 
 sound/pci/korg1212/korg1212.c                   |    6 
 sound/pci/maestro3.c                            |   10 
 sound/pci/nm256/nm256.c                         |    8 
 sound/pci/rme32.c                               |   10 
 sound/pci/rme96.c                               |   53 +-
 sound/pci/rme9652/hdsp.c                        |   46 -
 sound/pci/rme9652/rme9652.c                     |   27 -
 sound/pci/sonicvibes.c                          |    6 
 sound/pci/trident/Makefile                      |    2 
 sound/pci/trident/trident_main.c                |   13 
 sound/pci/trident/trident_synth.c               |    5 
 sound/pci/via82xx.c                             |  556 +++++++++++++++---------
 sound/pci/ymfpci/ymfpci_main.c                  |   17 
 sound/ppc/powermac.c                            |    2 
 sound/synth/emux/Makefile                       |    2 
 sound/synth/emux/emux_oss.c                     |    2 
 sound/synth/emux/emux_seq.c                     |    2 
 sound/synth/emux/soundfont.c                    |   10 
 sound/usb/usbaudio.c                            |   75 +--
 sound/usb/usbmidi.c                             |    2 
 sound/usb/usbmixer.c                            |   16 
 sound/usb/usbquirks.h                           |   13 
 123 files changed, 1442 insertions(+), 993 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/02/08 1.1009)
   ALSA update
     - emu10k1 - fixed makefile to not build synth module when emu10k1 is not selected

<perex@suse.cz> (03/02/08 1.1008)
   ALSA update
     - cmipci driver cleanups (ac3 & surround)
     - replaced snd_dma_residue() with snd_dma_pointer()
     - GCC 3.3 warnings removal
     - timer interface
       - recoded using tasklet
       - improved slave timer locking (should be much faster)
       - added async support
     - improved ioctl32 wrapper functions
     - fixed Makefile problems (synth modules were build for not selected driver)
     - AC97 codec
       - improved SPSA control
       - moved reset function outside the main init code
       - improved ALC650 initialization
     - USB driver
       - added quirk for Roland XV-2020
   

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

