Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVC0Ipy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVC0Ipy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVC0Ipy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:45:54 -0500
Received: from gate.perex.cz ([82.113.61.162]:21983 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261463AbVC0Ioq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:44:46 -0500
Date: Sun, 27 Mar 2005 10:44:44 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA 1.0.9rc2
Message-ID: <Pine.LNX.4.58.0503271041410.1798@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2005-03-24.patch.gz

The pull command will update the following files:

 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   34 
 include/sound/ac97_codec.h                                   |    1 
 include/sound/asound.h                                       |    1 
 include/sound/asoundef.h                                     |    2 
 include/sound/core.h                                         |    9 
 include/sound/emu10k1.h                                      |   89 +
 include/sound/rawmidi.h                                      |    5 
 include/sound/seq_midi_emul.h                                |    4 
 include/sound/version.h                                      |    4 
 sound/core/control.c                                         |   25 
 sound/core/info.c                                            |    9 
 sound/core/misc.c                                            |    8 
 sound/core/oss/mixer_oss.c                                   |   38 
 sound/core/oss/pcm_oss.c                                     |    2 
 sound/core/pcm.c                                             |   36 
 sound/core/pcm_native.c                                      |   31 
 sound/core/rawmidi.c                                         |   64 
 sound/core/seq/oss/seq_oss_init.c                            |   46 
 sound/core/seq/oss/seq_oss_midi.c                            |   35 
 sound/core/seq/seq_midi.c                                    |   96 -
 sound/core/seq/seq_midi_emul.c                               |   12 
 sound/core/seq/seq_system.c                                  |   64 
 sound/core/seq/seq_virmidi.c                                 |   54 
 sound/core/timer.c                                           |   72 -
 sound/drivers/mpu401/mpu401_uart.c                           |   15 
 sound/drivers/mtpav.c                                        |    5 
 sound/drivers/serial-u16550.c                                |    7 
 sound/i2c/other/ak4114.c                                     |    4 
 sound/i2c/other/ak4xxx-adda.c                                |  134 +
 sound/isa/Kconfig                                            |   45 
 sound/isa/gus/gus_synth.c                                    |   21 
 sound/isa/wavefront/wavefront_synth.c                        |  131 +
 sound/pci/ac97/ac97_codec.c                                  |   38 
 sound/pci/ac97/ac97_patch.c                                  |    2 
 sound/pci/als4000.c                                          |    6 
 sound/pci/atiixp.c                                           |   20 
 sound/pci/au88x0/au88x0_game.c                               |   12 
 sound/pci/au88x0/au88x0_mixer.c                              |    1 
 sound/pci/azt3328.c                                          |    6 
 sound/pci/ca0106/ca0106_main.c                               |   10 
 sound/pci/cmipci.c                                           |    6 
 sound/pci/cs4281.c                                           |   34 
 sound/pci/cs46xx/cs46xx_lib.c                                |   31 
 sound/pci/emu10k1/Makefile                                   |    2 
 sound/pci/emu10k1/emu10k1.c                                  |   47 
 sound/pci/emu10k1/emu10k1_main.c                             |  209 ++-
 sound/pci/emu10k1/emu10k1x.c                                 |    6 
 sound/pci/emu10k1/emufx.c                                    |  160 +-
 sound/pci/emu10k1/emumixer.c                                 |   39 
 sound/pci/emu10k1/emumpu401.c                                |    5 
 sound/pci/emu10k1/emupcm.c                                   |   94 -
 sound/pci/emu10k1/emuproc.c                                  |   14 
 sound/pci/emu10k1/io.c                                       |   32 
 sound/pci/emu10k1/irq.c                                      |   41 
 sound/pci/emu10k1/p16v.c                                     |  744 ++++++++++-
 sound/pci/emu10k1/p16v.h                                     |  299 ++++
 sound/pci/emu10k1/timer.c                                    |    4 
 sound/pci/emu10k1/voice.c                                    |   14 
 sound/pci/ens1370.c                                          |   41 
 sound/pci/es1938.c                                           |    2 
 sound/pci/es1968.c                                           |   26 
 sound/pci/hda/Makefile                                       |    2 
 sound/pci/hda/hda_codec.c                                    |    6 
 sound/pci/hda/hda_generic.c                                  |   13 
 sound/pci/hda/hda_patch.h                                    |    3 
 sound/pci/hda/patch_analog.c                                 |  445 ++++++
 sound/pci/hda/patch_cmedia.c                                 |   11 
 sound/pci/hda/patch_realtek.c                                |   11 
 sound/pci/mixart/mixart.c                                    |    6 
 sound/pci/mixart/mixart.h                                    |    2 
 sound/pci/mixart/mixart_hwdep.c                              |   93 -
 sound/pci/rme32.c                                            |    5 
 sound/pci/rme9652/hdsp.c                                     |    7 
 sound/pci/sonicvibes.c                                       |    2 
 sound/pci/trident/trident_main.c                             |   12 
 sound/pci/via82xx.c                                          |   16 
 sound/pci/via82xx_modem.c                                    |   11 
 sound/pci/ymfpci/ymfpci.c                                    |    7 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                           |   12 
 sound/usb/usbaudio.c                                         |   46 
 sound/usb/usbmidi.c                                          |    2 
 81 files changed, 2870 insertions(+), 890 deletions(-)

through these ChangeSets:

<perex@suse.cz> (05/03/24 1.2342)
   ALSA 1.0.9rc2

<perex@suse.cz> (05/03/24 1.2341)
   ALSA CVS update
   ALSA Version
   release: 1.0.9rc2
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/24 1.2340)
   [ALSA] seq - fix local variable initialization
   
   ALSA sequencer
   This patch re-adds the initialization of callbacks and pcallbacks
   that was accidentally removed in the last revision.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/24 1.2339)
   [ALSA] usb - change timeout of USB control/bulk msg functions to msecs
   
   USB generic driver
   This changes the timeout in the remaining (indirect) calls to
   usb_control/bulk_msg from jiffies to msecs.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/24 1.2338)
   [ALSA] cs4281 - fix typos in the case gameport is disabled
   
   CS4281 driver
   This patch fixes the wrong names of the dummy gameport functions
   used when CONFIG_GAMEPORT isn't set.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/24 1.2337)
   [ALSA] Add AC97_SCAP_NO_SPDIF flag
   
   AC97 Codec,ATIIXP driver,au88x0 driver,EMU10K1/EMU10K2 driver
   Added a new flag, AC97_SCAP_NO_SPDIF, to prevent to build the SPDIF-related
   controls on ac97 codec.  This flag is used when the sound chip has its
   native SPDIF support and it conflicts with the one of AC97 codec.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2336)
   [ALSA] Fix EFX voice allocation/preparation
   
   EMU10K1/EMU10K2 driver
   Fixed a bug (possibly Oops) in allocation/preparation of EFX voices
   The invalid voice pointer was accessed when voices are allocated over
   the voice table boundary.
   
   The patch includes a small clean-up & optimization.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2335)
   [ALSA] Fix Oops in snd_emu10k1_add_controls
   
   EMU10K1/EMU10K2 driver
   Fixed Oops in snd_emu101k_add_controls (introduced in the last patch
   for stack usage reduction).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2334)
   [ALSA] Clean up the chip detection
   
   EMU10K1/EMU10K2 driver
   Minor clean-ups of the chip detectoin code.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2333)
   [ALSA] Add Mono volume controls for ALC260
   
   HDA Codec driver
   Added Mono volume controls for ALC260 codec.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2332)
   [ALSA] Add AD1986A support
   
   HDA generic driver,HDA Codec driver
   Added the patch for Analog Device AD1986A codec.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2331)
   [ALSA] correct comment for setting widget output
   
   HDA Codec driver
   This patch has no real logical change, it simply correct the comment.
   
   Signed-off-by: ChenLi Tien<cltien@cmedia.com.tw>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2330)
   [ALSA] Fixes AC3 output on Audigy2 sound cards
   
   EMU10K1/EMU10K2 driver
   This patch adds a DSP patch to fix an spdif_bug on some Audigy2 cards.
   
   Signed-off-by: James Courtier-Dutton
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2329)
   [ALSA] Add framework for better audigy sound card capabilities selection
   
   EMU10K1/EMU10K2 driver
   This patch adds more options to help identify all the many different
   creative sound cards. It will eventually be used to control features
   more finely.
   
   Signed-off-by: James Courtier-Dutton
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2328)
   [ALSA] Replace with macros for gameport initialization
   
   ALSA Core,ALS4000 driver,AZT3328 driver,CMIPCI driver,CS4281 driver
   ENS1370/1+ driver,ES1938 driver,ES1968 driver,SonicVibes driver
   VIA82xx driver,au88x0 driver,CS46xx driver,Trident driver,YMFPCI driver
   Use some macros for gameport initialization.  This makes much easier
   to write the compatible layer for the old gameport API in alsa-driver
   tree.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2327)
   [ALSA] Fix Oops with joystick support
   
   YMFPCI driver
   Fix Oops when joystick is enabled.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2326)
   [ALSA] Fix Oops with joystick support
   
   ES1968 driver
   Fix Oops when joystick is enabled.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2325)
   [ALSA] Use vprintk()
   
   ALSA Core
   Use vprintk() instead of printk with a temporary line buffer.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2324)
   [ALSA] Reduce stack usage
   
   Control Midlevel,ALSA Core,PCM Midlevel,Timer Midlevel
   ALSA<-OSS emulation,ALSA sequencer,ALSA<-OSS sequencer
   AK4XXX AD/DA converters,GUS Library,Wavefront drivers
   EMU10K1/EMU10K2 driver,HDA generic driver,MIXART driver
   PDAudioCF driver,USB generic driver
   Reduce the stack usage, mostly by replacing large structs with kmalloc'ed
   instances.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/24 1.2323)
   [ALSA] Remove unnecessary ac97 init code
   
   VIA82xx driver,VIA82xx-modem driver
   Removed unnecessary ac97 init code in snd_via82xx_chip_init().
   This reduces eventually the big stack usage, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2322)
   [ALSA] Increase buffer sizes for the CA0106 driver
   
   CA0106 driver
   This patch increases the buffer size for the ca0106 driver, so this
   might help prevent over/underruns.
   
   Signed-off-by: James Courtier-Dutton
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2321)
   [ALSA] Fix 96000 SPDIF out from Audigy 2 P16V
   
   EMU10K1/EMU10K2 driver
   This allows one to output at 96000 to the SPDIF using the P16V chip.
   Note: The sample phase is wrong when using the P16V chip, but at least
   no resampling is done.
   
   Signed-off-by: James Courtier-Dutton
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2320)
   [ALSA] emu10k1 external tram size
   
   EMU10K1/EMU10K2 driver
   This patch fixes wrong size reported by driver for external tram. It
   reports size in bytes and should report it in samples as for internal tram.
   
   Signed-off-by: Peter Zubaj <pzad@pobox.sk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2319)
   [ALSA] use amp capabilities from afg if amp override not set
   
   HDA Codec driver
   Fix by Matt <matt@embeddedalley.com>:
   
   Some HDA codec nodes contain an amp, but do not provide local amp
   capabilities.  In these cases, AC_WCAP_AMP_OVRD is not set so we
   should query the AFG nid in order to get the general amp capabilities.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2318)
   [ALSA] fix bug with pci hotplug mode
   
   MIXART driver
   Fix the Oops with hotplug fw loader.
   (Theis fix is missing in the last commit to mixart.c accidentally.)
   
   Signed-off-by: Markus Bollinger <bollinger@digigram.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2317)
   [ALSA] add HPET support
   
   Timer Midlevel,ALSA Core
   add a wrapper for the HPET driver
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/22 1.2316)
   [ALSA] remove unneeded interrupt locks in rawmidi drivers
   
   Generic drivers,MPU401 UART,CS4281 driver,ENS1370/1+ driver
   CS46xx driver,EMU10K1/EMU10K2 driver
   Now that the output trigger callback is called from a softirq instead
   of an hardirq, we don't need anymore to disable interrupts in our
   interrupt handlers.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/22 1.2315)
   [ALSA] rawmidi - move output trigger into a tasklet
   
   Documentation,RawMidi Midlevel
   Calling the output trigger callback from another interrupt handler
   can lead to unintuitive locking requirements (i.e., spin_lock_irqsave)
   in the sound card interrupt handler.  Moving the call to the callback
   into a tasklet cures this, and has the added benefit that the callback
   is called only once if more that one sequencer event has been
   delivered in one timer interrupt tick.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/22 1.2314)
   [ALSA] rawmidi - fix locking in drop_output and drain_input
   
   RawMidi Midlevel
   The comments in snd_rawmidi_drop_output and snd_rawmidi_drain_input
   are wrong -- interrupts _are_ enabled, and spinlocks _are_ required.
   So remove the comments and add spinlocks.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/22 1.2313)
   [ALSA] Replace '/' with commas in ac97 codec names
   
   AC97 Codec
   Replaced '/' letters with commas in ac97 codec names, so that
   they can be used for sysfs entries in ac97_bus.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2312)
   [ALSA] Fix SPDIF output on CMI9880
   
   HDA Codec driver
   There is mute control on 9880's spdif (IEC958) out, so it needs to be
   turned on/off in mixer.
   The patch is for CVS version and I think it can be patched to azx too.
   Hope this also fix the 9880 SPDIF-out bug.
   
   Signed-off-by: ChenLi Tien <cltien@cmedia.com.tw>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2311)
   [ALSA] fix bug with pci hotplug mode
   
   MIXART driver
   There is a bug with mixart driver, when using hotplug:
   accessing NULL pointer -> segmentation fault
   
   Signed-off-by: Markus Bollinger <bollinger@digigram.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2310)
   [ALSA] rme32 - remove superfluous spin_lock_irqsave call
   
   RME32 driver
   In the PCM trigger callback, replace spin_lock_irqsave() with
   spin_lock() because interrupts are already guaranteed to be disabled.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/22 1.2309)
   [ALSA] Fix typos
   
   ALSA sequencer,ALSA Core
   Fix typos in alsa-kernel code for MIDI sostenuto.
   
   Signed-off-by: William <walsac3c AT orthoset.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2308)
   [ALSA] fix misc oopses
   
   EMU10K1/EMU10K2 driver
   Fix Oops with Multi-channel (EFX) mixer controls.
   
   Signed-off-by: Arnaud Patard <apatard@mandrakesoft.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2307)
   [ALSA] fix P16V breakage for non Audigy2 cards
   
   EMU10K1/EMU10K2 driver
   The P16V patch unconditionally checks the IPR2 register in the interrupt
   handler resulting in infinite loop and system lockup on any non Audigy2
   cards.  I really hate checking emu->is_audigy and emu->revision in a
   fast path like the IRQ handler but I don't see another way.
   
   Also, don't bother allocating/freeing the DMA buffer for P16V unless
   it's really present.
   
   This is a critical fix and should trigger an immediate rc2 release IMO.
   Currently any emu10k1 users other than Audigy 2 will lock up hard as
   soon as they play any sound.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2306)
   [ALSA] remove superfluous spin_lock_irqsave calls
   
   MPU401 UART,CS4281 driver,ENS1370/1+ driver,CS46xx driver
   RME HDSP driver
   In PCM trigger and pointer callbacks, replace spin_lock_irqsave() with
   spin_lock() because interrupts are already guaranteed to be disabled.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/22 1.2305)
   [ALSA] documentation - clarify information about atomic callbacks
   
   Documentation
   Document that the ack callback is atomic, too, and that the atomic
   callbacks are called with disabled interrupts.  Additionally, clarify
   the description of the rawmidi trigger callback.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/03/22 1.2304)
   [ALSA] Add new C-Media 9880 codec ID
   
   HDA Codec driver
   Following change need to be added for newer C-Media 9880 codec ID.
   
   Signed-off-by: ChenLi Tien <cltien@cmedia.com.tw>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2303)
   [ALSA] Use full-digital model as default for CMI9880
   
   HDA Codec driver
   Use full-digital model as default for CMI9880 rather than the
   minimal model.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2302)
   [ALSA] ak4114 (Juli@) - increased delay between statistics update & rate check
   
   AK4114 receiver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/22 1.2301)
   [ALSA] Wake up polls and signals at timer notification
   
   Timer Midlevel
   Wake up polls and signals at timer notification (TREAD mode only).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2300)
   [ALSA] Fix resume of es1968
   
   ES1968 driver
   Fixed the resume of es1968.
    - restore the running PCM set up properly in resume
    - ignore spurious hw-vol irqs during resume
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2299)
   [ALSA] Fix Oops with timer notifying
   
   Timer Midlevel
   Fixed Oops with timer notifying after TIMER_TREAD ioctl.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2298)
   [ALSA] Fix suspend/resume with ATIIXP
   
   ATIIXP driver
   Fixed the suspend/resume with ATIIXP driver.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2297)
   [ALSA] Add proper spin/irq locks to suspend
   
   PCM Midlevel
   Add the proper spin/irq locks to PCM suspend functions so that PCM
   trigger and pointer callbacks can be called safely without irqsave.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2296)
   [ALSA] isa/Kconfig - added SND_AD1848_LIB and SND_CS4231_LIB tristates
   
   ISA
   This patch fixes problem with missing SND_GENERIC_PM for isa cards using
   ad1848 and cs4231 library modules.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/22 1.2295)
   [ALSA] emu10k1 - add support for p16v chip (24-bit playback)
   
   EMU10K1/EMU10K2 driver
   Add 24bit, 96khz support for multichannel playback on the Audigy 2 sound cards.
   
   Signed-off-by: James Courtier-Dutton <James@superbug.demon.co.uk>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/22 1.2294)
   [ALSA] emu10k1 - copyright additions/fixes
   
   EMU10K1/EMU10K2 driver
   The next two patches add my copyright for adding the multichannel PCM
   support to emupcm.c and emumixer.c.
   
   The final patch adds Clemens Ladisch to the copyright on timer.c, rather
   than just saying 'Copied from similar code by CL'.  This has been
   bugging me for a while, since I just copied and pasted from the ymfpci
   driver & changed the registers.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/22 1.2293)
   [ALSA] emu10k1 - Silence the 'BUG (or not enough voices)' message
   
   EMU10K1/EMU10K2 driver
   Silence the 'BUG (or not enough voices)' message. This does not in fact
   represent a bug; it's a normal ocurrence when the wavetable synth is in use.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/22 1.2292)
   [ALSA] emu10k1 - give the subdevices descriptive names
   
   EMU10K1/EMU10K2 driver
   Give the subdevices descriptive names, like 'ADC Capture/Standard PCM Playback' instead of 'EMU10K1' for
   hw:x,0 and 'Multichannel Capture/PT Playback' instead of 'EMU10K1 EFX'
   for hw:x,2.  Now that qjackctl enumerates the devices automatically,
   this is a significant usability improvement.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/03/22 1.2291)
   [ALSA] Fix voice allocation corruption
   
   EMU10K1/EMU10K2 driver
   Fixed the corrupted voice allocation in snd_emu10k1_pcm_channel_alloc().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2290)
   [ALSA] Add DXS support for MSI K8T Neo2-FI
   
   VIA82xx driver
   Added the DXS entry for MSI K8T Neo2-FI.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/03/22 1.2289)
   [ALSA] Fix ALC655/658/850 SPDIF playback route
   
   AC97 Codec
   Fix ALC655/658/850 IEC958 (SPDIF) playback route control.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
