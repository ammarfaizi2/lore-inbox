Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVCKKn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVCKKn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbVCKKms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:42:48 -0500
Received: from gate.perex.cz ([82.113.61.162]:25538 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261352AbVCKKiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:38:50 -0500
Date: Fri, 11 Mar 2005 11:26:21 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA PATCH] ALSA sync 2005-03-11
Message-ID: <Pine.LNX.4.58.0503111123560.2396@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2005-03-11.patch.gz

The pull command will update the following files:

 include/sound/yss225.h                                       |   23 
 sound/core/ioctl32/Makefile                                  |   11 
 sound/core/ioctl32/hwdep32.c                                 |   73 
 sound/core/ioctl32/ioctl32.c                                 |  433 --
 sound/core/ioctl32/ioctl32.h                                 |  102 
 sound/core/ioctl32/pcm32.c                                   |  464 --
 sound/core/ioctl32/rawmidi32.c                               |   91 
 sound/core/ioctl32/seq32.c                                   |  116 
 sound/core/ioctl32/timer32.c                                 |  105 
 sound/isa/gus/gus_lfo.c                                      |  429 --
 Documentation/sound/alsa/ALSA-Configuration.txt              |  294 -
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |  401 ++
 Documentation/sound/alsa/VIA82xx-mixer.txt                   |    8 
 Documentation/sound/alsa/hda_codec.txt                       |  303 +
 Documentation/sound/alsa/serial-u16550.txt                   |   10 
 include/sound/ac97_codec.h                                   |   14 
 include/sound/ak4114.h                                       |  205 +
 include/sound/ak4117.h                                       |    6 
 include/sound/ak4xxx-adda.h                                  |    3 
 include/sound/control.h                                      |    7 
 include/sound/core.h                                         |   45 
 include/sound/emu10k1.h                                      |  123 
 include/sound/gus.h                                          |    4 
 include/sound/hwdep.h                                        |    1 
 include/sound/mixer_oss.h                                    |    2 
 include/sound/mpu401.h                                       |    3 
 include/sound/rawmidi.h                                      |    5 
 include/sound/seq_virmidi.h                                  |    2 
 include/sound/trident.h                                      |    6 
 include/sound/version.h~                                     |    3 
 include/sound/ymfpci.h                                       |    8 
 sound/arm/sa11xx-uda1341.c                                   |   10 
 sound/core/Kconfig                                           |   24 
 sound/core/Makefile                                          |    1 
 sound/core/control.c                                         |  186 -
 sound/core/control_compat.c                                  |  412 ++
 sound/core/hwdep.c                                           |   25 
 sound/core/hwdep_compat.c                                    |   77 
 sound/core/init.c                                            |  171 
 sound/core/ioctl32/ioctl32.c                                 |    5 
 sound/core/ioctl32/pcm32.c                                   |    3 
 sound/core/memory.c                                          |    4 
 sound/core/oss/mixer_oss.c                                   |   25 
 sound/core/oss/pcm_oss.c                                     |   49 
 sound/core/pcm.c                                             |    2 
 sound/core/pcm_compat.c                                      |  513 ++
 sound/core/pcm_lib.c                                         |   19 
 sound/core/pcm_memory.c                                      |    2 
 sound/core/pcm_native.c                                      |   67 
 sound/core/rawmidi.c                                         |  216 -
 sound/core/rawmidi_compat.c                                  |  120 
 sound/core/rtctimer.c                                        |    2 
 sound/core/seq/oss/seq_oss.c                                 |   21 
 sound/core/seq/oss/seq_oss_midi.c                            |    2 
 sound/core/seq/oss/seq_oss_readq.c                           |    5 
 sound/core/seq/oss/seq_oss_synth.c                           |    2 
 sound/core/seq/oss/seq_oss_writeq.c                          |   24 
 sound/core/seq/seq_clientmgr.c                               |   30 
 sound/core/seq/seq_compat.c                                  |  137 
 sound/core/seq/seq_dummy.c                                   |    1 
 sound/core/seq/seq_instr.c                                   |    6 
 sound/core/seq/seq_memory.c                                  |    8 
 sound/core/seq/seq_midi_event.c                              |   12 
 sound/core/seq/seq_queue.c                                   |   34 
 sound/core/seq/seq_queue.h                                   |    2 
 sound/core/sound.c                                           |    9 
 sound/core/timer.c                                           |   25 
 sound/core/timer_compat.c                                    |  119 
 sound/drivers/mpu401/mpu401.c                                |  336 -
 sound/drivers/mpu401/mpu401_uart.c                           |   52 
 sound/drivers/mtpav.c                                        |   12 
 sound/drivers/serial-u16550.c                                |   30 
 sound/drivers/vx/vx_core.c                                   |   17 
 sound/drivers/vx/vx_hwdep.c                                  |    1 
 sound/i2c/other/Makefile                                     |    2 
 sound/i2c/other/ak4114.c                                     |  598 +++
 sound/i2c/other/ak4xxx-adda.c                                |   36 
 sound/i2c/other/tea575x-tuner.c                              |    5 
 sound/isa/Kconfig                                            |    6 
 sound/isa/ad1848/ad1848_lib.c                                |    4 
 sound/isa/als100.c                                           |    2 
 sound/isa/cs423x/cs4231_lib.c                                |    4 
 sound/isa/es18xx.c                                           |    4 
 sound/isa/gus/gus_pcm.c                                      |   13 
 sound/isa/gus/gus_reset.c                                    |    7 
 sound/isa/gus/interwave.c                                    |    2 
 sound/isa/opl3sa2.c                                          |    6 
 sound/isa/sb/emu8000.c                                       |    4 
 sound/isa/sb/sb8_midi.c                                      |    8 
 sound/isa/wavefront/wavefront_midi.c                         |    8 
 sound/isa/wavefront/wavefront_synth.c                        |    7 
 sound/pci/Kconfig                                            |   12 
 sound/pci/Makefile                                           |    1 
 sound/pci/ac97/ac97_codec.c                                  |  410 +-
 sound/pci/ac97/ac97_local.h                                  |   22 
 sound/pci/ac97/ac97_patch.c                                  |  253 +
 sound/pci/ac97/ac97_patch.h                                  |    3 
 sound/pci/ac97/ac97_pcm.c                                    |    6 
 sound/pci/ali5451/ali5451.c                                  |    8 
 sound/pci/atiixp.c                                           |   10 
 sound/pci/atiixp_modem.c                                     |   29 
 sound/pci/au88x0/au88x0_core.c                               |    5 
 sound/pci/au88x0/au88x0_pcm.c                                |  108 
 sound/pci/bt87x.c                                            |    4 
 sound/pci/ca0106/ca0106_main.c                               |   13 
 sound/pci/cmipci.c                                           |   86 
 sound/pci/cs4281.c                                           |   30 
 sound/pci/cs46xx/cs46xx_lib.c                                |   27 
 sound/pci/emu10k1/emu10k1.c                                  |    5 
 sound/pci/emu10k1/emu10k1_callback.c                         |    2 
 sound/pci/emu10k1/emu10k1_main.c                             |    9 
 sound/pci/emu10k1/emu10k1x.c                                 |    7 
 sound/pci/emu10k1/emufx.c                                    |  112 
 sound/pci/emu10k1/emumixer.c                                 |  314 +
 sound/pci/emu10k1/emumpu401.c                                |    7 
 sound/pci/emu10k1/emupcm.c                                   |  440 ++
 sound/pci/emu10k1/emuproc.c                                  |   99 
 sound/pci/emu10k1/io.c                                       |   57 
 sound/pci/emu10k1/irq.c                                      |   15 
 sound/pci/emu10k1/voice.c                                    |   95 
 sound/pci/ens1370.c                                          |   41 
 sound/pci/es1938.c                                           |    4 
 sound/pci/es1968.c                                           |    4 
 sound/pci/fm801.c                                            |    2 
 sound/pci/hda/Makefile                                       |    7 
 sound/pci/hda/hda_codec.c                                    | 1970 ++++++++++-
 sound/pci/hda/hda_codec.h                                    |  614 +++
 sound/pci/hda/hda_generic.c                                  |  909 +++++
 sound/pci/hda/hda_intel.c                                    | 1461 ++++++++
 sound/pci/hda/hda_local.h                                    |  165 
 sound/pci/hda/hda_patch.h                                    |   14 
 sound/pci/hda/hda_proc.c                                     |  298 +
 sound/pci/hda/patch_cmedia.c                                 |  626 +++
 sound/pci/hda/patch_realtek.c                                | 1534 ++++++++
 sound/pci/ice1712/Makefile                                   |    4 
 sound/pci/ice1712/ak4xxx.c                                   |   12 
 sound/pci/ice1712/envy24ht.h                                 |    2 
 sound/pci/ice1712/ice1712.c                                  |   32 
 sound/pci/ice1712/ice1712.h                                  |   12 
 sound/pci/ice1712/ice1724.c                                  |   78 
 sound/pci/ice1712/juli.c                                     |  230 +
 sound/pci/ice1712/juli.h                                     |   10 
 sound/pci/ice1712/phase.c                                    |  138 
 sound/pci/ice1712/phase.h                                    |   34 
 sound/pci/ice1712/prodigy192.c                               |    4 
 sound/pci/ice1712/revo.c                                     |   24 
 sound/pci/ice1712/vt1720_mobo.c                              |    9 
 sound/pci/ice1712/vt1720_mobo.h                              |    4 
 sound/pci/intel8x0.c                                         |   59 
 sound/pci/intel8x0m.c                                        |   86 
 sound/pci/korg1212/korg1212.c                                |   87 
 sound/pci/maestro3.c                                         |   13 
 sound/pci/nm256/nm256.c                                      |    4 
 sound/pci/rme9652/hdsp.c                                     |  532 +-
 sound/pci/trident/trident_main.c                             |    8 
 sound/pci/via82xx.c                                          |   63 
 sound/pci/via82xx_modem.c                                    |    6 
 sound/pci/vx222/vx222_ops.c                                  |    1 
 sound/pci/ymfpci/ymfpci_main.c                               |    4 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                           |    4 
 sound/pcmcia/pdaudiocf/pdaudiocf.h                           |    4 
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c                      |    4 
 sound/pcmcia/vx/vx_entry.c                                   |    4 
 sound/pcmcia/vx/vxp_ops.c                                    |    1 
 sound/ppc/pmac.c                                             |   12 
 sound/usb/usbaudio.c                                         |    5 
 sound/usb/usbaudio.h                                         |   18 
 sound/usb/usbmidi.c                                          |  666 ++-
 sound/usb/usbmixer.c                                         |    2 
 sound/usb/usbquirks.h                                        |  250 +
 sound/usb/usx2y/usbusx2yaudio.c                              |    1 
 172 files changed, 14932 insertions(+), 4170 deletions(-)

through these ChangeSets:

<perex@suse.cz> (05/03/11 1.2009.1.28)
   [ALSA] AC97 wm9713 support
   
   AC97 Codec
   This patch series adds support for the WM9713/WM9714 family of AC97
   codecs. This family is different from 'standard' AC97 codecs in that the
   default codec power state is 'off'. i.e. performing a register reset
   will power the device down.
   
   This patch also adds better support for larger single/double channel
   enumerated mixer types.
   
   Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.27)
   [ALSA] Fix ALC260 input
   
   HDA Codec driver
   Fixed the ALC260 input on HP machines.  Added the front mic support.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.26)
   [ALSA] Fix pops and clicks at beginning/end of playback
   
   EMU10K1/EMU10K2 driver
   The patch fixes pops and clicks at the beginning and the end of playback
   on emu10k1 due to the cache size mismatch.
   
   Signed-off-by: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.25)
   [ALSA] fix forgotten release of semaphore in error path
   
   ALSA<-OSS emulation
   In snd_mixer_oss_get_volume1_vol and snd_mixer_oss_put_volume1_vol,
   card->controls_rwsem wouldn't be released if the boolean type
   check fails.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.24)
   [ALSA] remove duplicate field initialization
   
   au88x0 driver
   Remove duplicate (and inconsistent) initialization of the iface field.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.23)
   [ALSA] replace wrong spin_trylock_irqsave with spin_lock_irqsave
   
   MPU401 UART
   The last patch accidentally left a 'try' in where none was intended.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.22)
   [ALSA] Add PCI ids for ICH6/7
   
   Intel8x0-modem driver
   Added the PCI IDs for ICH6 and ICH7.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.21)
   [ALSA] Add AD1986 support
   
   AC97 Codec
   Added the support of AD1986.  Using the same patch as AD1985.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.20)
   [ALSA] Disable DRA for ALI5455
   
   Intel8x0 driver
   Disable DRA for ALI5455.  Apparently the device doesn't support it.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.19)
   [ALSA] Restore the default value after rate detection
   
   AC97 Codec
   Restore the default value of rate registers after detection of available
   rates.  This might fix the problem of playback noises on some mobo drivers.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.18)
   [ALSA] replace spdif frequency control with iec958 control
   
   au88x0 driver
   The appended patch replaces the manual spdif frequency control in the
   mixer with code that use the standard iec958 interface. The patch is
   nearly the same as the one Raymond submitted, except it gets rid of the
   identical *_default_* versions of the functions, and has a tiny bit of
   cleanup.
   I have only tested it a little bit because I don't currently
   have the hardware to actually test it properly. However, it looks
   harmless to me.
   
   Patch-by: Raymond
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.17)
   [ALSA] Fix sample rates of Revo 7.1
   
   ICE1712 driver,ICE1724 driver
   Fixed the available sample rates of Revo 7.1 board.
   AK codecs don't support the rate below 32k Hz.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.16)
   [ALSA] Fix auto-probing of widget tree
   
   HDA generic driver
   Fixed auto-probing of the widget tree, ignoring the widgets with
   the digital attributes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.15)
   [ALSA] Fix stereo mutes on Surround volume control
   
   AC97 Codec
   Fix stereo mutes on Surround volume control.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.14)
   [ALSA] Fix ALC260 support
   
   HDA Codec driver
   Fix ALC260 support on HP machines.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.13)
   [ALSA] Use DXS volumes as PCM
   
   VIA82xx driver
   Use DXS volumes as PCM control in cases with no volume control on codec
   (e.g. C-Media).  'DXS Playback Volume' controls are removed.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/10 1.2009.1.12)
   [ALSA] GUS - Remove unused gus_lfo.c file
   
   GUS Library
   
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/10 1.2009.1.11)
   [ALSA] fix locking for rawmidi trigger callbacks
   
   Generic drivers,MPU401 UART,SB8 driver,Wavefront drivers,CS4281 driver
   ENS1370/1+ driver,CS46xx driver,EMU10K1/EMU10K2 driver,RME HDSP driver
   Use spin_lock_irqsave() instead of spin_lock() in places where we
   could be interrupted by another hardware interrupt that could call
   the rawmidi trigger callback that could try to take the same lock.
   
   Additionally, remove locking code that is no longer needed now that
   the trigger callback is no longer called recursively from the rawmidi
   'event' handler.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.10)
   [ALSA] remove duplicate module alias
   
   ALSA Core
   Remove duplicate MODULE_ALIAS for the snd module.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.9)
   [ALSA] add module aliases for rtctimer and seq-dummy
   
   RTC timer driver,ALSA sequencer
   Add snd-timer-1 and snd-seq-client-63 module aliases for the
   snd-rtctimer and snd-seq-dummy modules.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.8)
   [ALSA] document rawmidi interface
   
   Documentation
   Add information about the rawmidi interface to the driver-writing
   documentation.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.7)
   [ALSA] use simple_strtoul instead of simple_strtol
   
   AC97 Codec
   Replace simple_strtol with simple_strtoul for compatibility with
   2.2.x kernels.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.6)
   [ALSA] move rawmidi event callback into tasklet
   
   RawMidi Midlevel
   Move the event callback into a tasklet instead of calling it directly
   from snd_rawmidi_transmit_ack/_receive to prevent recursive calls to
   the trigger callback.  This means that drivers no longer have to
   check that they're called inside their own spinlock.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.5)
   [ALSA] move common code into snd_rawmidi_runtime_create/_free functions
   
   RawMidi Midlevel
   Move the duplicated memory handling code for the rawmidi runtime struct
   into the snd_rawmidi_init/_done_buffer functions and rename them to
   snd_rawmidi_runtime_create/_free.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/10 1.2009.1.4)
   [ALSA]  Fix bugs with incorrectly wrapped appl_ptr
   
   PCM Midlevel
       This patch is against alsa-driver-1.0.8.
       It covers:
           alsa-kernel/core/pcm_lib.c
       The main changes are in the first listed file.
   
       It corresponds to bug description:
           <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=951>
   
       The patch does cosmetic change:
   
        -- Better, more universal and smaller wrapping to within
           0..runtime->boundary-1 in functions snd_pcm_lib_write1() and
           snd_pcm_lib_read1() in pcm_lib.c
   
   Signed-off-by:  Charles Levert <charles_levert@gna.org>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/10 1.2009.1.3)
   [ALSA]  Fix rounded-up integer division bug
   
   PCM Midlevel
       This patch is against alsa-driver-1.0.8.
       It covers:
           alsa-kernel/core/pcm_lib.c
   
       It corresponds to bug description:
           <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=951>
   
       The patch fixes the following problem:
   
        -- Properly perform rounded-up integer division in
           snd_pcm_system_tick_set() in pcm_lib.c.
   
           This only had a minor impact.
   
   Signed-off-by:  Charles Levert <charles_levert@gna.org>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/10 1.2009.1.2)
   [ALSA] fix snd-serial-u16550 docs for setserial
   
   Documentation
   Change the documentation about disabling the standard serial driver
   to use 'uart none' instead of 'none' as setserial option.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.50)
   [ALSA] emu10k1 - fix the initial value for Captured FX8010 Outputs
   
   EMU10K1/EMU10K2 driver
   - rename 'EFX voices mask' to 'Captured FX8010 Outputs'
   - fix the initial value
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/02 1.1982.125.49)
   [ALSA] Control API - fix the wrong allocation for userspace controls
   
   Control Midlevel
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/02 1.1982.125.48)
   [ALSA] Fix the Audigy SPDIF sample rate register definitions
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/02 1.1982.125.47)
   [ALSA] remove _snd_rawmidi_runtime.trigger
   
   RawMidi Midlevel
   Remove the trigger field from _snd_rawmidi_runtime because
   it is never ever read.  (This may be why nobody noticed that
   snd_rawmidi_transmit_empty sets it to the wrong value.)
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.46)
   [ALSA] remove unsafe usage of urb->status
   
   USB generic driver
   Remove unprotected accesses to urb->status and
   substream->runtimer->trigger.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.45)
   [ALSA] add port names for serial MIDI ports
   
   Generic drivers
   Give each of the MIDI ports created by snd-serial-u16550
   a unique name.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.44)
   [ALSA] fix counting of MIDI input overruns
   
   RawMidi Midlevel
   Do not throw away the old value of the overrun counter when
   more than one byte is received.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.43)
   [ALSA] fix buffer wrap in snd_rawmidi_transmit_peek
   
   RawMidi Midlevel
   Fix the behaviour and return value of snd_rawmidi_transmit_peek
   when the buffer wraps around.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.42)
   [ALSA] add more USB MIDI quirks
   
   USB generic driver
   Add support for Roland RS-70, SP-606, BOSS DR-880
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.41)
   [ALSA] AC97 quirk for Dell Precision 650
   
   Intel8x0 driver
   Added the ac97 quirk entry for Dell Precision 650.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.40)
   [ALSA] Add mixer controls to intel8x0m
   
   Intel8x0-modem driver
   This patch adds a mixer switch to the intel8x0m driver, so that the
   hook state can be controlled from userspace, instead of bringing the
   line off hook on capture start. Please someone test, and merge into
   cvs. Comments are welcome.
   
   Signed-off-by: Jaime A. Lopez Sollano <jsollano@gmail.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.39)
   [ALSA] Fix CM9761 again
   
   AC97 Codec
   Fixed the silent output playback problem on CM9761.
   The SPDIF_CTRL register (0x6c) bit 17 was the culprit.
   
   The master volume is back again since it seems to have some
   influence on the looped input sounds.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.38)
   [ALSA] do codec init more like windows does
   
   au88x0 driver
   The following patch makes the codec init code act more like the windows
   code.
   
   Signed-off-by: Jeff Muizelaar <jeff@infidigm.net>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.37)
   [ALSA] add Roland FANTOM-X support
   
   USB generic driver
   This adds a USB MIDI quirk for the Roland FANTOM-X.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.36)
   [ALSA] Add module_init and module_exit entries
   
   ALSA sequencer
   From Mikael Magnusson <mikaelmagnusson@glocalnet.net>:
   Added the missing module_init and module_exit entries.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.35)
   [ALSA] Don't query chip models on CMI8338
   
   CMIPCI driver
   Don't call query_chip() for CMI8338.  It's for CMI8738/8768 only.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.34)
   [ALSA] Fix digital input
   
   HDA Codec driver
   Fixed SPDIF digital input.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.33)
   [ALSA] ALC882 support, fix ALC880 5-stack mode
   
   HDA Codec driver
   - Added the ALC882 support.
     Currently no model selections; full-mode with digital I/O only.
   - Fixed the widget assignment in ALC880 5-stack mode.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.32)
   [ALSA] CMI8768 patch
   
   CMIPCI driver
   Hi,
   
   I made a patch for CM8768, which has the same PCI ID but there are
   several HW diffecece, aas listed:
   
   1. 8768 has no PCM volume control.
   2. The ADC of 8768 can only record in 44.1kHz or 48kHz.
   3. 8768 can support up to 8 channels.
   
   I made change for item 2 and 3, I want to use the softvol plugin but
   don't know how to. The driver just don't generate the PCM volume slider
    for now.
   
   Signed-off-by: ChenLi Tien <cltien@cmedia.com.tw>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.31)
   [ALSA] Fix Digital Input
   
   HDA Codec driver,HDA generic driver
   Fixed the SPDIF digital input support for HDA codecs.
   New controls 'IEC958 Capture Switch' and 'IEC958 Capture Default'
   are added.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.30)
   [ALSA] fix Emagic broadcast port names
   
   USB generic driver
   Name the broadcast port 'Broadcast' instead of 'Broadcast/Control'
   because control messages are returned through the first MIDI port.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.29)
   [ALSA] ignore Emagic padding bytes
   
   USB generic driver
   Ignore the 0xff padding bytes added by Emagic devices at the end
   of input packets.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.28)
   [ALSA] add logging to send_bulk_static_data
   
   USB generic driver
   Add the optional dump_urb call to send_bulk_static_data, too.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.27)
   [ALSA] add support for Emagic USB MIDI interfaces
   
   USB generic driver
   Add support for the Emagic USB MIDI protocol (raw MIDI with 'F5 xx'
   port switching) and for Unitor8/AMT8/MT4 devices.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.26)
   [ALSA] fix indentation
   
   Generic drivers
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.25)
   [ALSA] remove superfluous from_timer_port parameter
   
   ALSA sequencer
   Removed superfluous from_timer_port parameter from
   snd_seq_queue_process_event and queue_broadcast_event
   functions.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.24)
   [ALSA] Fix SPDIF output
   
   HDA Codec driver
   Fixed SPDIF output (over multi-out).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.23)
   [ALSA] Fix mono volume/mute controls
   
   HDA generic driver
   Fixed mono volume/mute controls.  They were handled as stereo mistakenly.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.22)
   [ALSA] Don't set up the front stream twice
   
   HDA Codec driver
   Don't set up the front stream twice in the loop.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.21)
   [ALSA] Fix compilation with compat support
   
   ALSA sequencer
   Fix the compilation with 32bit compat support.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.20)
   [ALSA] remove an unnecessary printk
   
   EMU10K1/EMU10K2 driver
   This patch removes an unnecessary printk accidentally left in the
   multichannel patch.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.19)
   [ALSA] Fix invalid use of readl/writel
   
   KORG1212 driver
   Fixed the invalid use of readl/writel to normal pointers.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.18)
   [ALSA] [SPARSE] Use NULL instead of 0
   
   HDA Codec driver
   Use NULL for pointers instead of 0.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.17)
   [ALSA] [SPARSE] Add __user pointer casts
   
   Wavefront drivers
   Added __user pointer casts to sys_*() arguments
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.16)
   [ALSA] [SPARSE] Fix __user pointers
   
   EMU10K1/EMU10K2 driver
   Fix the access to __user pointers in some places.
   Added proper casts.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.15)
   [ALSA] Fix comiple with old gcc
   
   EMU10K1/EMU10K2 driver
   Fix compile with old gcc.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.14)
   [ALSA] [SPARSE] Use unsigned int :1 bitfields
   
   EMU10K1/EMU10K2 driver,GUS Library,ALSA<-OSS emulation,Trident driver
   YMFPCI driver,CMIPCI driver,Intel8x0-modem driver,Maestro3 driver
   ALI5451 driver,ICE1712 driver
   Use unsigned int :1 bitfields.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.13)
   [ALSA] [SPARSE] Fix __user pointers
   
   PCM Midlevel,RawMidi Midlevel,ALSA<-OSS emulation,ALSA sequencer
   Fixed __user pointers including other misc fixes:
    - replaced the obsolete CONFIG_SND_IOCTL32_EMUL.
    - added the proper segment change before passing the kernel pointer
      as the user pointer in PCM code.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.12)
   [ALSA] Fix the wrong function call from ioctl
   
   Control Midlevel
   Fixed the call of a wrong function from ioctl.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.11)
   [ALSA] use unsigned 1-bit fields
   
   Virtual Midi
   Can't have a boolean and a sign bit in 1 bit.
   
   Fix (14) boolean/bitfield sparse warning:
   include/sound/seq_virmidi.h:41:16: warning: dubious one-bit signed bitfield
   
   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.10)
   [ALSA] Fix CM9761 again
   
   AC97 Codec
   Revert the last addition for CM9761A support.  The codec doesn't
   support the real control of Master/PCM volumes, too.
   Instead, fixed the default multi-channel register setting now.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.9)
   [ALSA] Fix CM9761A codec support
   
   AC97 Codec
   Fixed the codec patch for (probably) CM9761A.  It looks incompatible
   with other CM9761 models.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.8)
   [ALSA] add code to dump packets
   
   USB generic driver
   add a compile-time option to log the contents of USB packets
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/02 1.1982.125.7)
   [ALSA] Fix detection of AFG node
   
   HDA Codec driver
   Fix the detection of AFG node with unsolicited events.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/02 1.1982.125.6)
   [ALSA] emu10k1 - add 'voices' /proc entry for debugging the voice allocator
   
   EMU10K1/EMU10K2 driver
   This patch adds a 'voices' /proc entry for debugging the voice
   allocator.  It also increases the size of the ptr_regs files to display
   the values for all channels.  Finally it updates the names of the EFX
   recording inputs from '???' to 'FXBUS2_*'.
   
   Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/02 1.1982.125.5)
   [ALSA] emu10k1 driver - add multichannel device hw:x,3 [2-8/8]
   
   EMU10K1/EMU10K2 driver
   This series of patches adds a 16 channel non interleaved PCM playback
   device, hw:x,3, to the emu10k1 driver.  It also adds support for the
   newly discovered per channel half loop interrupt.
   
   Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/02 1.1982.125.4)
   [ALSA] emu10k1 driver - add multichannel device hw:x,3 [1/8]
   
   EMU10K1/EMU10K2 driver
   Update header file for multichannel support.
   Add some new register info.
   
   Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/02 1.1982.125.3)
   [ALSA] FM801 - radio: Fixed thinko for tea575x_tuner module parameter (int type not bool)
   
   FM801 driver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/02 1.1982.125.2)
   [ALSA] TEA575x - add video release callback to avoid warning
   
   TEA575x tuner
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/02/14 1.1966.112.53)
   [ALSA] Add ac97_quirk for Dell machine
   
   Intel8x0 driver
   Added ac97_quirk option for Dell machine.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.52)
   [ALSA] Enables SPDIF output on the Audigy2 Value
   
   EMU10K1/EMU10K2 driver
   Enables SPDIF output on the Audigy2 Value.
   It seems to work for PCM, but not AC3 yet.
   
   Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.51)
   [ALSA] Add support for Audigy2LS on MSI motherboard
   
   CA0106 driver
   Add support for Audigy2LS on MSI motherboard.
   Fixes Bug #0901
   
   Signed-off-by: James Courtier-Dutton <James@superbug.demon.co.uk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.50)
   [ALSA] fix typo in midi code
   
   RME HDSP driver
   fix typo in midi code
   
   Signed-off-by: Thomas Charbonnel <thomas@undata.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.49)
   [ALSA] Fix rate setting on multiple codecs
   
   AC97 Codec
   From Ron Cococcia <ron.cococcia@request.com>:
   
   Fixed the PCM rate setting on multiple AC97 codecs.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.48)
   [ALSA] split snd_emu10k1_trigger_voice into trigger and prepare functions
   
   EMU10K1/EMU10K2 driver
   This patch provides better sync between multiple voices by separating
   the trigger_voice function into prepare_voice which sets up the volume
   and filter parameters and trigger_voice which sets pitch target, current
   and initial pitch and enables the voice interrupt.  For standard PCM
   this should not make much of a difference but will be important for
   minimizing phase error between voices for multichannel PCM.
   
   This behavior was derived from the opensource.creative.com driver.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.47)
   [ALSA] Remove unused yss225.h
   
   Wavefront drivers
   yss225.h is just obsolete, not used/read by any codes.
   Let's remove it.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.46)
   [ALSA] Added support for Terratec PHASE 22
   
   ICE1712 driver,ICE1724 driver
   I've struggled for a couple of days with Terratec Phase 22 card.
   Chips used on it are well known but the combination is somehow unique.
   Phase 88 should have been similar...  but it actually uses 1712
   instead of 1721 (Envy24HT-S). So here is the patch against release
   1.0.8 that adds Phase 22 to ice1724. I've tested only analog part
   (balances 1/4 TRS in and outs).
   
   Signed-off-by: Misha Zhilin <misha@epiphan.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.45)
   [ALSA] AK4114 - fixed workqueue initialization & removed debug code
   
   AK4114 receiver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/02/14 1.1966.112.44)
   [ALSA] fix typo in assignment of snd_ak4114_spdif_playback_put
   
   AK4114 receiver
   snd_ak4114_spdif_playback_put was assigned to the .get callback
   which resulted in a duplicate initialization of that member
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.43)
   [ALSA] Added ICE1724 - ESI Juli@ code (not complete) + AK4114 code + AK4358
   
   Serial BUS drivers,AK4114 receiver,AK4XXX AD/DA converters
   ICE1712 driver,ICE1724 driver
   Initial incomplete driver for ESI Juli@ cardcards based on ICE1724, AK4114,
   AK4358 and AK5385. The ICE1724 and ICE1712 main files plus some drivers are
   also updated (cleanups and new callbacks).
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/02/14 1.1966.112.42)
   [ALSA] add STAC9708 output bias mixer control
   
   AC97 Codec
   This adds a mixer control for an undocumented bit of the STAC9708
   that somehow affects the analog output.  This should help reducing
   the distortion at high output levels on ymfpci and SBLive cards.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.41)
   [ALSA] MPU-401 driver cleanup
   
   MPU401 UART
   Correctly check for error codes returned by pnp_register_driver,
   use a common function for registering the sound card, and remove
   many #ifdef's.
   
   Signed-off-by: Matthieu Castet <castet.matthieu@free.fr>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.40)
   [ALSA] add 96Khz support and setting sample rate for	direct SPDIF output
   
   EMU10K1/EMU10K2 driver
   This patch should add support for 96Khz 'direct SPDIF' aka 'SPDIF
   Bypass' (not P16V) playback mode available on the Audigy1 and 2 and
   newer SBLives (?).  It lets you bypass the 48khz DSP resampling when
   using the card in digital mode.  It also adds 96khz analog playback
   support, good for testing but less interesting because it's downsampled
   to 48khz.  A new mixer control 'Audigy SPDIF Output Sample Rate' is
   created, you can choose 44100, 48000, or 96000.  Standard SPDIF
   playback, AC3 passthrough (real 96khz playback), and analog playback
   (96khz is resampled to 48khz in the DSP) all work with a 16 bit,96khz
   wav file.  Only the last was tested due to lack of any SPDIF hardware.
   
   This was derived mostly from the opensource.creative.com driver.  All
   that was needed for 96khz playback to work in analog mode was changing
   the format to 8000_96000 (looks like the creative driver supports 192khz
   too).  And, of course this sample rate has always been supported (albeit
   downsampled) because if you have 48khz samples in a soundfont the
   envelope engine has to be able to pitch shift them in both directions.
   
   I still have not been able to figure out how to get 24 bit playback to
   work.  This is possible, independent of the P16V, for spdif and analog
   24/48 playback via the DSP.  I do know how to access the full 24 bits
   from the ADC from within the DSP, just not how to get it in there.  For
   one thing I have no idea which 24 bit format it supports.  Some of them
   seemed to work with JACK but produced noise.
   
   This was generated with my multichannel patch but it applies against
   ALSA CVS as well.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.39)
   [ALSA] fix sound/isa/gus/interwave.c compile with PNP=n
   
   AMD InterWave driver
   Emmanuel Colbus sent this patch one month ago with the following
   description:
   
   There is a trivial bug in the file sound/isa/gus/interwave.c .
   The variable isapnp is defined only if CONFIG_PNP is enabled, but it is
   always used few lines after.
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.38)
   [ALSA] Bind master and HP controls with hp_only quirk
   
   AC97 Codec
   Bind master and HP controls when hp_only quirk is given, instead
   of removing master control.  This fixes the problem of some laptops
   which require sync'ed volume for PC-speaker and headphone output.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.37)
   [ALSA] fixes als100 not detecting opl3
   
   ALS100 driver
   This patch fixes issue when opl3 device couldn't be found
   due to numbering of devices in pnp card, because search of
   opl3 device started from mpu device, which could have number
   greater than opl3 could.
   
   Example:
   MPU is 00:01.03
   and
   OPL is 00:01.01
   
   Signed-off-by: Anton Romanov <theli@ukr.net>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.36)
   [ALSA] enable disabling of isapnp
   
   OPL3SA2 driver
   Fixed a logic error that prevented the 'isapnp=0' module
   parameter from taking effect.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.35)
   [ALSA] MPU-401 PnP support
   
   Documentation,MPU401 UART
   Replace the ACPI PnP code with generic PnP calls.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.34)
   [ALSA] Add quirk for Fujitsu S6210
   
   Intel8x0 driver
   Added ac97_quirk for Fujitsu S6210.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.33)
   [ALSA] Add __iomem prefix
   
   BT87x driver
   Added __iomem prefix to the mmio pointer.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.32)
   [ALSA] Remove interruptible_sleep_on_timeout().
   
   ALSA<-OSS sequencer
   Use wait_event_interruptible_timeout() instead of deprecated
   interruptible_sleep_on_timeout().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.31)
   [ALSA] remove interruptible_sleep_on_timeout() usage
   
   GUS Library
   Replace deprecated interruptible_sleep_on_timeout() with
   wait_event_timeout(). Code is not identical, as the current sleeping
   system is 1 jiffy at a time checking atomic_read()'s return every
   iteration. Patch is compile-tested.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.30)
   [ALSA] Korg1212 updates
   
   KORG1212 driver
   This patches covers the following issues:
   
       - solves double 'spin_lock_irqsave' problems;
       - eliminate the use of deprecated function 'sleep_on_timeout';
       - clarify some 'printk' messages; and
       - logs korg DMA Errors due to PCI congestion.
   
   Signed-off-by: Haroldo Gamal <gamal@alternex.com.br>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.29)
   [ALSA] Novation and MOTU USB MIDI support
   
   USB generic driver
   Rewrote USB MIDI protocol handling code to use callbacks
   for each protocol;
   added support for Novation and MOTU protocols;
   changed detection code to allow interrupt endpoints.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.28)
   [ALSA] simplify snd_usbmidi_count_bits()
   
   USB generic driver
   This makes the bit counting code smaller and simpler.
   
   Signed-off-by: Charles C. Bennett <ccb@acm.org>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.27)
   [ALSA] capture EXTINs with multichannel device
   
   EMU10K1/EMU10K2 driver
   This patch changes the emu10k1 multichannel capture device (hw:x,2) to
   capture the 16 external inputs by default.  This involves adding DSP
   code to route the EXTINs to the FXBUS2 (EFX capture) channels and
   setting the corresponding FXWC bits by default.
   
   This allows capturing multiple inputs simultaneously.  It completely
   bypasses the capture controls of the mixer.  With my Audigy2 ZS I can
   capture LineIn, Line2, and Aux2 at the same time (6 channels).
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.26)
   [ALSA] Add quirk for LEGEND ZhaoYang 3100CF
   
   Maestro3 driver
   Added a quirk entry for LEGEND ZhaoYang 3100CF.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.25)
   [ALSA] replace interruptible_sleep_on_timeout() with wait_event_interruptible_timeout()
   
   RawMidi Midlevel
   Use wai_event_interruptible_timeout() instead of deprecated
   interruptible_sleep_on_timeout(). Patch is compile-tested.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.24)
   [ALSA] Kconfig: cleanup sound menu
   
   ALSA Core
   This properly indents the sound menu.
   
   Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.23)
   [ALSA] hdsp ghost midi device fix
   
   RME HDSP driver
   * Prevents the creation of a second midi device for cards with only
     one midi I/O
   
   Signed-off-by: Thomas Charbonnel <thomas@undata.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.22)
   [ALSA] Fix 32bit calls to snd_pcm_channel_info()
   
   PCM Midlevel
   Fix 32-bit calls to snd_pcm_channel_info().
   
   Signed-off-by: Brian Gerst <bgerst@didntduck.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.21)
   [ALSA] Fix compile error (due to last suspend/resume fix)
   
   PPC PMAC driver
   Fixed the forgotten caller of suspend/resume callbacks to follow
   the recent PM fixes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.20)
   [ALSA] intel8x0 - fix for broken PCI ID define for ICH6
   
   Intel8x0 driver
   Patch-level: High
   
   Signed-off-by: Jean Delvare <khali@linux-fr.org>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/02/14 1.1966.112.19)
   [ALSA] intel8x0 - fixed timeout in the 'get current DMA pointer' routine
   
   Intel8x0 driver
   Patch-level: High
   
   Signed-off-by: Wei Ni <Wei.Ni@uli.com.tw>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/02/14 1.1966.112.18)
   [ALSA] Fix suspend/resume functions
   
   ALSA Core
   Fix the suspend/resume callback functions to follow the last change.
   (This fix was missing in the last patch.)
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.17)
   [ALSA] Fix inclusion of pm.h
   
   ALSA Core
   Added the missing inclusion of linux/pm.h.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.16)
   [ALSA] Fix resume callback
   
   HDA Codec driver
   Fixed resume callback to follow the recent change of PM callbacks.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.15)
   [ALSA] Remove unused variable
   
   USB USX2Y
   Removed an unused variable to fix a compile warning.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.14)
   [ALSA] Fix descriptions about suspend/resume callbacks
   
   Documentation
   Fixed the descriptions about suspend/resume callbacks.
   The suspend callback takes pm_message_t argument, and resume takes no
   extra argument now.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.13)
   [ALSA] driver model type fixes for ALSA
   
   SA11xx UDA1341 driver,Control Midlevel,ALSA Core,Digigram VX core
   ES18xx driver,OPL3SA2 driver,AD1848 driver,CS4231 driver,ATIIXP driver
   ATIIXP-modem driver,CS4281 driver,ES1938 driver,ES1968 driver
   Intel8x0 driver,Intel8x0-modem driver,Maestro3 driver,VIA82xx driver
   VIA82xx-modem driver,ALI5451 driver,CS46xx driver,HDA Codec driver
   HDA Intel driver,NM256 driver,Trident driver,YMFPCI driver
   PDAudioCF driver,Digigram VX Pocket driver,PPC PMAC driver
   Fixes by Pavel Machek <pavel@suse.cz>:
   suspend() routines no longer get u32 as their parameter (they get
   pm_message_t, which is u32 for now, but will change in 2.6.12 or
   so). This fixes ALSA to notice this, and uses constants with right
   types where appropriate. It results in no code changes. [Best results
   will be when patching against latest -mm, you may get some warnings if
   you patch it into older kernel, but it should still do the right
   thing.] Please apply,
   							Pavel
   
   [In addition, suspend callback type is changed to follow to the standard
    style taking no state argument -- Takashi]
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.12)
   [ALSA] use cached idVendor/idProduct values
   
   USB generic driver
   use the vendor/product IDs in the state structure instead of
   reading them again from the device
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/02/14 1.1966.112.11)
   [ALSA] Set default index of modem and bt87x drivers to -2
   
   Documentation,ATIIXP-modem driver,BT87x driver,Intel8x0-modem driver
   VIA82xx-modem driver
   Set the default index value of modem and bt87x drivers to -2 so that
   the first slot is excluded when no index option is given.
   This gives other uadio drivers a chance to put them as the primary
   driver.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.10)
   [ALSA] Interpret negative index as bitmask of permissible indexes
   
   Documentation,ALSA Core
   Currently arguments of the 'index' option from 0 through SNDRV_CARDS-1
   force a module to take the specified index. Index -1 makes the module
   take the first available index. This patch extends this convention so
   that a negative index value is interpreted as a bitmask of the
   permitted indexes. Special cases:
   
       -1 0xffffffff 0 and up
       -2 0xfffffffe 1 and up
       -4 0xfffffffc 2 and up
       ...
   
   The patch includes also corrections of ALSA-Configuration.txt document.
   
   Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.9)
   [ALSA] Changes 'Music' to 'Synth' in mixer control names
   
   EMU10K1/EMU10K2 driver
   Changes 'Music' to 'Synth' in mixer control names
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.8)
   [ALSA] HDSP fixes
   
   Documentation,RME HDSP driver
   * init sequence cleanup and firmware upload related bugfixes
   * more robust revision detection scheme
     (should transparently handle new revisions)
   * allow hdsploader and the kernel fw loader to coexist
     this is useful for cardbus user who compiled the driver in-kernel
     (userspace may not be ready to upload the firmware when the card
      is probed)
   * removed confusing and obsolete passthru option (was interfering
     with the mixer when opening the device for capture or playback)
     this change requires a recompile of the userspace tools against
     the patched hdsp.h
   * removed confusing and obsolete line_outs_monitor module param
   * made precise_ptr the default behaviour, and runtime tweakable
     (removed corresponding module param)
   * add an alsa ctl to disable the use of the midi tasklet, and
     process midi data in the interrupt handler
     (using the tasklet is still the default)
     this is mainly intended for users of Ingo Molnar's RT patch
   * metering fix for Multiface/Digiface users (closes ALSA BUG #0000801)
   * small endianness fix
   * ALSA-Configuration.txt HDSP entry update
   * error messages cleanup
   
   Signed-off-by: Thomas Charbonnel <thomas@undata.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.7)
   [ALSA] Remove pm_register/pm_unregister
   
   SA11xx UDA1341 driver,ALSA Core,ISA
   Removed pm_register() and pm_unregister().
   Use platform_device for suspend/resume, instead.
   
   The current implemention is still a hack.  The whole ISA drivers should
   be rewritten with a proper bus definition.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.6)
   [ALSA] Remove descriptions of obsolete options
   
   Documentation
   Removed descriptions of obsolete irq_mask and irq_list options for
   vxpocket, vxp440 and pdaudiocf drivers.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/02/14 1.1966.112.5)
   [ALSA] Ascii chars only
   
   RME HDSP driver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/02/14 1.1966.112.4)
   [ALSA] Add newline to printk
       
   ALSA Core
   Added the newline to printk error output.
       
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/27 1.1966.112.3)
   [ALSA] Removed file added by mistake
   
   Removed include/sound/version.h~

<perex@suse.cz> (05/01/25 1.1966.95.13)
   [ALSA] replace schedule_timeout() with msleep()
   
   EMU8000 driver
   Use msleep() instead of schedule_timeout() to guarantee the task
   delays as expected.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1966.95.12)
   [ALSA] insert set_current_state() before schedule_timeout()
   
   Wavefront drivers
   Insert set_current_state() before schedule_timeout(). Without the
   insertion, schedule_timeout() returns immediately, resulting in an
   effective busy-wait.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1966.95.11)
   [ALSA] replace schedule_timeout() with msleep_interruptible()
   
   GUS Library
   Use msleep_interruptible() instead of custom wait code involving
   schedule_timeout() to guarantee the task delays as expected. This also
   removes a dependence on the value of HZ.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1966.95.10)
   [ALSA] insert set_current_state() before schedule_timeout()
   
   GUS Library
   Insert set_current_state() before schedule_timeout(). Without the
   insertion, schedule_timeout() returns immediately.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1966.95.9)
   [ALSA] replace schedule_timeout() with msleep()
   
   Digigram VX core
   Use msleep() instead of schedule_timeout() to guarantee the task
   delays as expected.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1966.95.8)
   [ALSA] replace schedule_timeout() with msleep()
   
   RawMidi Midlevel
   Use msleep instead of schedule_timeout() to guarantee the task delays
   as expected. This also removes a dependence on the value of HZ.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1966.95.7)
   [ALSA] Special AC97 patch for ASUS W1000/CMI9739 laptop
   
   AC97 Codec
   This patch fixes sound output on the ASUS W1000 laptop with the CMI9739
   chip. It wrongly reports that it has a SPDIF in, when in fact we wish to
   use the EAPD pin.
   
   Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1966.95.6)
   [ALSA] Warning doc about VIA82xx recording
   
   Documentation
   Add warning about the consequences of adjusting the 'Input Source Select'
   of VIA82xx.
   
   Signed-off-by: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/25 1.1966.95.5)
   [ALSA] fix usage of preprocessor directive inside macro
   
   HDA Intel driver
   gcc-2 complains about preprocessor directives inside a macro argument list
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/25 1.1966.95.4)
   [ALSA] add more Yamaha USB MIDI quirks
   
   USB generic driver
   add support for Yamaha UC-MX, UC-KX, CLP-175, SPX2000
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/20 1.1966.95.3)
   [ALSA] remove obsolete sound/core/ioctl32 directory
   
   The compatibility layer is integrated to ALSA midlevel code now.

<perex@suse.cz> (05/01/20 1.1966.58.31)
   [ALSA] Use DEFINE_SPINLOCK(), DEFINE_RWLOCK() macros
   
   ALSA Core,PCM Midlevel,Timer Midlevel,ALSA sequencer
   ALSA<-OSS sequencer
   Replace spin/rwlock definitions with DEFINE_SPINLOCK() and DEFINE_RWLOCK()
   macros.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.30)
   [ALSA] Remove snd-ioctl32 entry
   
   ALSA Core
   Remove the entry for snd-ioctl32.  The 32bit wrapper is built in the core
   module.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.29)
   [ALSA] Export new register/unregister functions
   
   ALSA Core
   Export new register/unregister functions for compat control-ioctls.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.28)
   [ALSA] unlocked/compat_ioctl rewrite for OSS compatible drivers
   
   ALSA<-OSS emulation,ALSA<-OSS sequencer
   The ioctl handlers for OSS compatible drivers are rewritten using
   unlocked/compat_ioctl.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.27)
   [ALSA] unlocked/compat_ioctl rewrite for hwdep, rawmidi, timer and sequencer API
   
   HWDEP Midlevel,RawMidi Midlevel,Timer Midlevel,ALSA sequencer
   The ioctl handler for hwdep, rawmidi, timer and sequencer API are rewritten
   using unlocked/compat_ioctl.
   The 32bit wrapper is merged to the core module.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.26)
   [ALSA] unlocked/compat_ioctl rewrite for PCM API
   
   PCM Midlevel
   The ioctl handler for PCM API is rewritten using unlocked/compat_ioctl.
   The 32bit wrapper is merged to the core module.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.25)
   [ALSA] unlocked/compat_ioctl rewrite for control API
   
   Control Midlevel
   ioctl handler for control API is rewritten using unlocked/compat_ioctl.
   The 32bit wrapper is merged to the core module.
   
   Added a new register/unregister function for compat control ioctls.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.24)
   [ALSA] Add Intel HDA driver
   
   Documentation,PCI drivers,HDA generic driver,HDA Codec driver
   HDA Intel driver
   Added a new Intel High-Definition audio driver.
   The driver consists of two separate modules: the generic support
   module for HD codecs (snd-hda-codec), and the driver for Intel ICH6/7
   chipset (snd-hda-intel).  The snd-hda-intel was called formerly
   snd-azx in the ALSA 1.0.8 rlease.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.23)
   [ALSA] Enable HP jack sense for FSC Scenic-W
   
   AC97 Codec
   Enable 'Headphone Jack Sense' control on FSC Scenic-W as default, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.22)
   [ALSA] Add quirk for HP nc8000
   
   Intel8x0 driver
   Added ac97 quirk for HP nc8000.
   The list is sorted again.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.21)
   [ALSA] Add quirk for HP pavilion ZV5030US
   
   ATIIXP driver
   Added ac97 quirk for HP Pavilion ZV5030US to bind the control with
   mute-LED.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.20)
   [ALSA] Simplify the general ac97 volume/switch callback
   
   AC97 Codec
   Simplified the control callbacks of general AC97 volumes/switches.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.19)
   [ALSA] Add missing inclusion of linux/device.h
   
   Digigram VX core,Digigram VX222 driver,Digigram VX Pocket driver
   Added the missing inclusion of <linux/device.h>
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.18)
   [ALSA] Add workaround for buggy ATI IXP hardwares
   
   ATIIXP-modem driver
   Added a workaround for buggy ATI IXP hardwares which returns
   bogus DMA pointer register value.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.17)
   [ALSA] Add support for Chaintech 9CJS
   
   ICE1712 driver
   Added the support for Chaintech 9CJS by Delmaire Maxime.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.16)
   [ALSA] AK4117 code - fixed cosmetic typos
   
   AK4117 receiver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/01/20 1.1966.58.15)
   [ALSA] don't use broken legacy interfaces on M-Audio Quattro/Omnistudio
   
   USB generic driver
   Interfaces 0-2 of M-Audio Quattro/Omnistudio devices duplicate functionality
   of interfaces 3-5 and cause errors when used with those.  Add a quirk to
   tell the driver not to use them.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/20 1.1966.58.14)
   [ALSA] Fix silent output on some machines with AD1981x codecs
   
   AC97 Codec
   Fixed the default state of 'Headphone Jack Sense' switch on AD1981x
   codecs.  Setting this on affects the output of some machines (e.g.
   Thindpads).
   
   The default value is set on only hardwares which are known to work.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.13)
   [ALSA] AC'97 Audio support for Intel ICH7
   
   Intel8x0 driver
   This patch adds the ICH7 AC'97 DID the the intel8x0.c AC'97 audio
   driver. This patch was build against 2.6.11-rc1.
   
   Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.12)
   [ALSA] Fix compilation on big-endian arch
   
   RME HDSP driver
   Fixed typo in the code for big-endian architectures.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.11)
   [ALSA] Show firmware loading state in proc file
   
   Digigram VX core
   Show the firmware loading state in proc file.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.10)
   [ALSA] Fix struct size mismatch
   
   IOCTL32 emulation
   Fixed the struct size mismatch - should work on SPARC64 now, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.9)
   [ALSA] Add missing FORWARD ioctl
   
   IOCTL32 emulation
   Added the missing FORWARD ioctl.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.8)
   [ALSA] Fix struct alignment on PPC64
   
   IOCTL32 emulation
   Fixed the struct size mismatch (due to alignment) of
   snd_ctl_elem_value_t for PPC64.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.7)
   [ALSA] fix typo
   
   Documentation
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/20 1.1966.58.6)
   [ALSA] Fix typos in doc
   
   Documentation
   Fixed typos in the document by Kirill Smelkov <kirr@mns.spb.ru>
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/20 1.1966.58.5)
   ALSA CVS update
   PCM Midlevel
   Sumary: Fix comment of snd_pcm_lib_malloc_pages()
   
   Fixed comment of snd_pcm_lib_malloc_pages() by
   Kirill Smelkov <kirr@mns.spb.ru>.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
