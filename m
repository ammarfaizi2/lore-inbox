Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbTA1UQ1>; Tue, 28 Jan 2003 15:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTA1UQ1>; Tue, 28 Jan 2003 15:16:27 -0500
Received: from gate.perex.cz ([194.212.165.105]:45842 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267678AbTA1UQY>;
	Tue, 28 Jan 2003 15:16:24 -0500
Date: Tue, 28 Jan 2003 21:25:40 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update
Message-ID: <Pine.LNX.4.44.0301282122390.4537-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-01-28.patch.gz

					Thanks,
						Jaroslav

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |    3 
 Documentation/sound/alsa/CMIPCI.txt                          |   15 
 Documentation/sound/alsa/DocBook/alsa-driver-api.tmpl        |  102 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl | 5360 ++++++++++-
 Documentation/sound/alsa/OSS-Emulation.txt                   |  302 
 include/sound/ac97_codec.h                                   |    4 
 include/sound/ad1848.h                                       |   49 
 include/sound/ak4531_codec.h                                 |    1 
 include/sound/core.h                                         |   50 
 include/sound/cs46xx.h                                       |    2 
 include/sound/emu10k1.h                                      |   23 
 include/sound/gus.h                                          |    8 
 include/sound/info.h                                         |   19 
 include/sound/pcm.h                                          |   17 
 include/sound/pcm_sgbuf.h                                    |   21 
 include/sound/sb.h                                           |   46 
 include/sound/sb16_csp.h                                     |    1 
 include/sound/sndmagic.h                                     |   56 
 include/sound/trident.h                                      |    6 
 include/sound/version.h                                      |   10 
 sound/core/control.c                                         |  134 
 sound/core/device.c                                          |   66 
 sound/core/hwdep.c                                           |   13 
 sound/core/info.c                                            |  202 
 sound/core/init.c                                            |   75 
 sound/core/ioctl32/ioctl32.c                                 |   10 
 sound/core/isadma.c                                          |   21 
 sound/core/memory.c                                          |  237 
 sound/core/oss/mixer_oss.c                                   |    9 
 sound/core/oss/pcm_oss.c                                     |   50 
 sound/core/pcm.c                                             |   33 
 sound/core/pcm_lib.c                                         |  328 
 sound/core/pcm_memory.c                                      |  357 
 sound/core/pcm_misc.c                                        |   87 
 sound/core/pcm_native.c                                      |   34 
 sound/core/pcm_sgbuf.c                                       |  511 -
 sound/core/rawmidi.c                                         |   82 
 sound/core/rtctimer.c                                        |    2 
 sound/core/seq/Makefile                                      |  106 
 sound/core/seq/instr/Makefile                                |   68 
 sound/core/seq/oss/Makefile                                  |    4 
 sound/core/seq/oss/seq_oss_init.c                            |    6 
 sound/core/seq/oss/seq_oss_midi.c                            |    1 
 sound/core/seq/seq_clientmgr.c                               |    7 
 sound/core/sound.c                                           |   35 
 sound/core/timer.c                                           |    6 
 sound/drivers/mpu401/mpu401.c                                |    9 
 sound/drivers/mpu401/mpu401_uart.c                           |  133 
 sound/drivers/serial-u16550.c                                |   29 
 sound/i2c/l3/uda1341.c                                       |   50 
 sound/isa/ad1848/ad1848_lib.c                                |   80 
 sound/isa/cmi8330.c                                          |  314 
 sound/isa/cs423x/cs4231_lib.c                                |   21 
 sound/isa/es18xx.c                                           |   17 
 sound/isa/gus/Makefile                                       |   20 
 sound/isa/gus/gus_irq.c                                      |   22 
 sound/isa/gus/gus_main.c                                     |    6 
 sound/isa/gus/gus_mem.c                                      |   17 
 sound/isa/gus/gus_mem_proc.c                                 |   41 
 sound/isa/gus/gus_reset.c                                    |    4 
 sound/isa/sb/Makefile                                        |   12 
 sound/isa/sb/sb16.c                                          |    3 
 sound/isa/sb/sb16_csp.c                                      |   23 
 sound/isa/sb/sb16_main.c                                     |    7 
 sound/isa/sb/sb_common.c                                     |    1 
 sound/isa/sb/sb_mixer.c                                      |  288 
 sound/isa/sgalaxy.c                                          |    9 
 sound/isa/wavefront/wavefront_fx.c                           |    6 
 sound/isa/wavefront/wavefront_synth.c                        |    6 
 sound/pci/Kconfig                                            |    8 
 sound/pci/ac97/ac97_codec.c                                  |  276 
 sound/pci/ac97/ac97_patch.c                                  |    9 
 sound/pci/ac97/ak4531_codec.c                                |   24 
 sound/pci/ali5451/ali5451.c                                  |    2 
 sound/pci/cmipci.c                                           |   96 
 sound/pci/cs4281.c                                           |   73 
 sound/pci/cs46xx/cs46xx_lib.c                                |  173 
 sound/pci/emu10k1/Makefile                                   |   12 
 sound/pci/emu10k1/emu10k1.c                                  |    3 
 sound/pci/emu10k1/emu10k1_main.c                             |   45 
 sound/pci/emu10k1/emupcm.c                                   |   18 
 sound/pci/emu10k1/emuproc.c                                  |   94 
 sound/pci/emu10k1/memory.c                                   |   14 
 sound/pci/ens1370.c                                          |  119 
 sound/pci/es1938.c                                           |   50 
 sound/pci/es1968.c                                           |   10 
 sound/pci/fm801.c                                            |   74 
 sound/pci/ice1712/amp.c                                      |    7 
 sound/pci/ice1712/ice1712.c                                  |   28 
 sound/pci/intel8x0.c                                         |   89 
 sound/pci/korg1212/korg1212.c                                |   25 
 sound/pci/maestro3.c                                         |   10 
 sound/pci/nm256/nm256.c                                      |   10 
 sound/pci/rme32.c                                            |  174 
 sound/pci/rme96.c                                            |  172 
 sound/pci/rme9652/hammerfall_mem.c                           |   11 
 sound/pci/rme9652/hdsp.c                                     |   38 
 sound/pci/rme9652/rme9652.c                                  |   25 
 sound/pci/sonicvibes.c                                       |   34 
 sound/pci/trident/Makefile                                   |   12 
 sound/pci/trident/trident_main.c                             |  700 -
 sound/pci/trident/trident_memory.c                           |   42 
 sound/pci/via82xx.c                                          | 1241 +-
 sound/pci/ymfpci/ymfpci_main.c                               |   52 
 sound/ppc/keywest.c                                          |    1 
 sound/ppc/pmac.c                                             |   10 
 sound/sound_firmware.c                                       |   21 
 sound/synth/emux/Makefile                                    |   19 
 sound/synth/emux/emux_seq.c                                  |    7 
 sound/usb/usbaudio.c                                         |  553 -
 sound/usb/usbaudio.h                                         |   16 
 sound/usb/usbmidi.c                                          |  148 
 sound/usb/usbquirks.h                                        |  132 
 113 files changed, 11105 insertions(+), 3269 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/01/28 1.961)
   ALSA update
     - fixed makefiles for sequencer modules:
       when CONFIG_SND_SEQUENCER is m, then synth modules should be m, too

<perex@suse.cz> (03/01/27 1.960)
   ALSA update
     - updated programmer's documentation
     - recoded PCM scatter-gather memory management
     - MPU401 - cleanups
     - CMI8330 - cleanups
     - EMU10K1 - Audigy2 update
     - ENS1371 - added surround support
     - USB - added more quirks and improved PCM constraint definitions

<perex@suse.cz> (03/01/27 1.959)
   ALSA update
     - added documentation for OSS emulation
     - CMI8330 - duplex/mixer cleanups
     - via82xx - rewritten for 8233+ (multiple playback, S/PDIF, secondary capture)
     - USB - quirk code update

<perex@suse.cz> (03/01/27 1.958)
   ALSA update
     - added DocBook documentation
     - added many source comments
     - simplified proc style interface (per card)
     - updated PCM scatter-gather routines
     - moved PM locking outside callbacks

<perex@suse.cz> (03/01/27 1.957)
   ALSA update
     - removed some 2.2 code
     - PCM - fixed memory leak for 24-bit samples
     - gameport cleanups (CS4231, ENS1370/1371, SonicVibes, Trident)
     - VIA82xx - fixed current pointer calculation
     - sound_firmware - fixed errno problem
     - USB - moved out compatibility code
   

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

