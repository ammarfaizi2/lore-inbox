Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUJXLKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUJXLKg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUJXLKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:10:36 -0400
Received: from gate.perex.cz ([82.113.61.162]:49286 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261439AbUJXLI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:08:57 -0400
Date: Sun, 24 Oct 2004 13:11:04 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [ALSA PATCH] 1.0.7rc2
Message-ID: <Pine.LNX.4.58.0410241308190.1751@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-10-24.patch.gz

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   14 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   47 
 Documentation/sound/alsa/Joystick.txt                        |   10 
 include/sound/ac97_codec.h                                   |   17 
 include/sound/core.h                                         |    8 
 include/sound/cs46xx.h                                       |    2 
 include/sound/emu10k1.h                                      |   67 
 include/sound/hdsp.h                                         |   14 
 include/sound/opl3.h                                         |    5 
 include/sound/pcm.h                                          |    4 
 include/sound/seq_kernel.h                                   |   10 
 include/sound/ymfpci.h                                       |    2 
 sound/arm/Kconfig                                            |    9 
 sound/core/Kconfig                                           |   75 -
 sound/core/init.c                                            |    2 
 sound/core/ioctl32/hwdep32.c                                 |    2 
 sound/core/ioctl32/ioctl32.c                                 |    8 
 sound/core/ioctl32/ioctl32.h                                 |    6 
 sound/core/ioctl32/pcm32.c                                   |   97 +
 sound/core/memalloc.c                                        |    8 
 sound/core/memory.c                                          |    8 
 sound/core/oss/pcm_oss.c                                     |   22 
 sound/core/pcm.c                                             |    3 
 sound/core/pcm_lib.c                                         |    2 
 sound/core/pcm_native.c                                      |  639 ++++-----
 sound/core/seq/oss/seq_oss.c                                 |   14 
 sound/core/seq/seq.c                                         |   26 
 sound/core/seq/seq_clientmgr.c                               |   25 
 sound/core/seq/seq_device.c                                  |   32 
 sound/core/seq/seq_dummy.c                                   |    6 
 sound/core/seq/seq_midi.c                                    |    4 
 sound/drivers/Kconfig                                        |   48 
 sound/drivers/dummy.c                                        |    2 
 sound/drivers/mpu401/mpu401_uart.c                           |    4 
 sound/drivers/opl3/opl3_lib.c                                |  146 +-
 sound/isa/Kconfig                                            |  189 +-
 sound/isa/es18xx.c                                           |    5 
 sound/parisc/Kconfig                                         |    5 
 sound/parisc/harmony.c                                       |   15 
 sound/pci/Kconfig                                            |  286 +++-
 sound/pci/ac97/Makefile                                      |    7 
 sound/pci/ac97/ac97_codec.c                                  |  127 +
 sound/pci/ac97/ac97_id.h                                     |    3 
 sound/pci/ac97/ac97_local.h                                  |    7 
 sound/pci/ac97/ac97_patch.c                                  |  134 +
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/ac97/ac97_pcm.c                                    |  158 +-
 sound/pci/ac97/ac97_proc.c                                   |    6 
 sound/pci/atiixp.c                                           |   16 
 sound/pci/atiixp_modem.c                                     |   10 
 sound/pci/au88x0/au88x0.c                                    |    4 
 sound/pci/au88x0/au88x0.h                                    |    2 
 sound/pci/au88x0/au88x0_eq.c                                 |   76 -
 sound/pci/bt87x.c                                            |   30 
 sound/pci/cs4281.c                                           |   49 
 sound/pci/cs46xx/cs46xx_lib.c                                |  150 --
 sound/pci/cs46xx/dsp_spos.c                                  |   10 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                          |    4 
 sound/pci/emu10k1/emufx.c                                    |   42 
 sound/pci/emu10k1/emupcm.c                                   |   11 
 sound/pci/emu10k1/emuproc.c                                  |   30 
 sound/pci/ens1370.c                                          |   31 
 sound/pci/es1968.c                                           |   48 
 sound/pci/ice1712/Makefile                                   |    2 
 sound/pci/ice1712/aureon.c                                   |  778 +++++++++--
 sound/pci/ice1712/aureon.h                                   |    5 
 sound/pci/ice1712/delta.c                                    |   13 
 sound/pci/ice1712/delta.h                                    |    4 
 sound/pci/ice1712/ews.c                                      |   59 
 sound/pci/ice1712/hoontech.c                                 |  164 +-
 sound/pci/ice1712/ice1712.c                                  |   58 
 sound/pci/ice1712/ice1712.h                                  |   26 
 sound/pci/ice1712/ice1724.c                                  |   12 
 sound/pci/ice1712/prodigy192.c                               |  524 +++++++
 sound/pci/ice1712/prodigy192.h                               |   11 
 sound/pci/ice1712/stac946x.h                                 |   25 
 sound/pci/intel8x0.c                                         |  285 +---
 sound/pci/intel8x0m.c                                        |   41 
 sound/pci/korg1212/korg1212.c                                |  135 +
 sound/pci/mixart/mixart.c                                    |    6 
 sound/pci/mixart/mixart.h                                    |    2 
 sound/pci/nm256/nm256.c                                      |   77 -
 sound/pci/rme32.c                                            |   34 
 sound/pci/rme96.c                                            |   21 
 sound/pci/rme9652/hdsp.c                                     |  407 +++--
 sound/pci/rme9652/rme9652.c                                  |   10 
 sound/pci/via82xx.c                                          |   26 
 sound/pci/ymfpci/ymfpci_main.c                               |    4 
 sound/pcmcia/Kconfig                                         |   18 
 sound/ppc/Kconfig                                            |    5 
 sound/ppc/tumbler.c                                          |    6 
 sound/usb/Kconfig                                            |   13 
 sound/usb/usbaudio.c                                         |  104 +
 sound/usb/usbaudio.h                                         |    7 
 sound/usb/usbmidi.c                                          |    6 
 sound/usb/usbmixer_maps.c                                    |    9 
 sound/usb/usbquirks.h                                        |   67 
 sound/usb/usx2y/usbusx2y.c                                   |   10 
 sound/usb/usx2y/usbusx2yaudio.c                              |   36 
 99 files changed, 4037 insertions(+), 1817 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/10/23 1.2028)
   [ALSA]  boot_devs removal - module_param_array() accepts NULL now
   
   Intel8x0 driver,RME96 driver,ICE1724 driver,NM256 driver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/20 1.1988.71.13)
   [ALSA]  Fix non-blocking write in ALSA OSS emulation
   
   ALSA<-OSS emulation
   write() calls in non-blocking mode eat the written data and never
   return -EAGAIN.  The attached patch fixes the problem.
   
   Signed-off-by: Benjamin Otte <otte@gnome.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.12)
   [ALSA]  PCM boundary fix in 32bit compat layer
   
   IOCTL32 emulation
   PCM boundary size is fixed within the 32bit value range when HW_PARAMS
   ioctl is called in 32bit mode.
   Also, with this patch, the conversion functions are inlined.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.11)
   [ALSA]  Add VIA8237 driver type
   
   VIA82xx driver
   VIA8237 and later chips are handled as a different type from VIA8233,
   since they don't support the AC97 slot mapping any more.
   The alsa-lib will resolve the 5.1 remapping for them.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.10)
   [ALSA]  Exclude uneeded code when ! CONFIG_PROC_FS
   
   PCM Midlevel,AC97 Codec Core
   From Michal Rokos <michal@rokos.info>
   
   I tried to compile without procfs support and I got few 'unused code'
   warnings.
   
   This patch fixes it.
   
   Tested by compilation only. (With CONFIG_PROC_FS on and off)
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.9)
   [ALSA]  Fix AC97_EXTENDED_STATUS initialial value
   
   AC97 Codec Core
   Fixed a bug to write an invalid initial value of AC97_EXTENDED_STATUS.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.8)
   [ALSA]  Fixed SPDIF on CS4298
   
   AC97 Codec Core
   Fixed SPDIF support on CS4298 AC97 chip.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.7)
   [ALSA]  fix build in !KMOD case (sequencer)
   
   ALSA sequencer
   seq_device.c needs to pull in the snd_seq_autoload_lock()/unlock()
   defines from seq_kernel.h in the !KMOD case.
   
   Signed-off-by: Ingo Molnar <mingo@elte.hu>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/20 1.1988.71.6)
   [ALSA]  RME9632 precise_ptr fix
   
   RME HDSP driver
   Correct hardware position mask to mask correctly when buffer is not
   maximum size.
   
   Signed-off-by:  Ed Wildgoose <lists@wildgooses.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.5)
   [ALSA]  Misc. volume fixes
   
   ICE1712 driver
    - Added mute function to Master/Front/Rear/Side/LFE/CEnter
    - Master volume is artificially made in software
    - Added PCM volume control (basically what was the master volume)
    - Front/Read/Side/LFE/Center is now logarithmic (and computed as <volume> * <master volume> / <maximum volume>)
   
   Signed-off-by: Peter Christensen <peter@developers.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.4)
   [ALSA]  Add routing/volume of ADAT I/O on EWS88D
   
   ICE1712 driver
   The routing/volume control of ADAT I/O on EWS88D is added.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/20 1.1988.71.3)
   [ALSA]  fixing a two-rme32-in-one-machine bug
       
   RME32 driver
       - fixing the dev counter in snd_rme32_probe(). The patch can enable a second
         rme32 card
   
   Signed-off-by: Martin Langer <martin-langer@gmx.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.38)
   [ALSA]  Fix the detection of secondary codec
   
   CS46xx driver
   Fixed the detection of secondary codec.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.37)
   [ALSA]  Fix Aureon CCS init sequence
   
   ICE1712 driver
   - Fix Aureon 5.1 Sky GPIO write mask bits
   - Fix 192kHz bit
   
   Signed-off-by: Peter Christensen <peter@developers.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.36)
   [ALSA]  Fix compilation (sync with parisc tree)
   
   PARISC Harmony driver
   Sync with parisc tree - fix compilations, module description fixes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.35)
   [ALSA]  Fix ac97 codec reset and clean up
   
   CS46xx driver
   - Fixed AC97 codec RESET for duel codecs (only for CONFIG_SND_CS46XX_NEW_DSP)
   - Clean up the codec detection routine
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.34)
   [ALSA]  Added dxs quirk for QDI Kudoz 7X/600-6AL
   
   VIA82xx driver
   Added the default dxs_support entry for QDI Kudoz 7X/600-6AL.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.33)
   [ALSA]  Fix typo
   
   ALSA sequencer
   Fixed a typo for snd_seq_autoload_lock() in the last change
   (only for the case without CONFIG_KMOD).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.32)
   [ALSA]  Add KERN_ERR to error messages
   
   ALSA Core
   Added KERN_ERR prefix to error messages in snd_assert() and
   snd_runtime_check() macros.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.31)
   [ALSA]  Fix pci_restore_state()
   
   ALSA Core
   Fixed pci_save_state() call with the new API.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.30)
   [ALSA]  Fix dead blocking during module_init()
   
   ALSA sequencer,ALSA<-OSS sequencer
   Fixed the auto-loading of modules during module_init().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.29)
   [ALSA]  Clean up bitmap
   
   EMU10K1/EMU10K2 driver
   Clean up the declaration of bitmap with DECLARE_BITMAP().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.28)
   [ALSA]  fix snd_opl3_init documentation
   
   Documentation
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/07 1.1939.10.27)
   [ALSA]  fix description of SPSA=3 in the proc file
   
   AC97 Codec Core
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/07 1.1939.10.26)
   [ALSA]  fix DAC slot assignment
   
   AC97 Codec Core
   write the DAC slot assignment bits to the extended ID register
   where they belong instead of overwriting the SPSA bits in the
   extended status register
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/07 1.1939.10.25)
   [ALSA]  Fix / clean up OPL3 for CS4281
   
   Documentation,OPL3,CS4281 driver
   Moved cs4281-specific code into cs4281 driver from opl3.
   The ugly type-casting is removed now.
   
   The opl3 instance can be created via snd_opl3_new() (followed by
   snd_opl3_init()) to allow the driver to set its own command and
   private_data/private_free.
   
   snd_opl3_create() is kept for compatibility as it was.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.24)
   ALSA CVS update
   USB generic driver
   add Edirol UA-25 support
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/07 1.1939.10.23)
   [ALSA]  Fix AC3 playback on SB Live
   
   EMU10K1/EMU10K2 driver
   Fix the AC3 playback on SB Live!
   (Audigy has been working fine.)
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.22)
   [ALSA]  Fix AC97 master mute
   
   ICE1712 driver
   Instead of muting the AC97 chip and thus eliminating the possibility of recording,
   muting is done by setting front playback to DAC only instead of DAC+AUX.
   
   Signed-off-by: Peter Christensen <ungod@developers.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.21)
   [ALSA]  Fix SPDIF support on ICH4/5/6
   
   Intel8x0 driver
   Fixed SPDIF support on ICH4/5/6.  The driver name of these chipsets
   is set as 'ICH4' to tell from the older ICHs.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.20)
   [ALSA]  Add (experimental) CM9761 support
   
   AC97 Codec Core
   CM9761 support patch is added.
   At least, SPDIF and 4.0 output seems working.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.19)
   [ALSA]  add overclocking option for the analog input
   
   PCI drivers,BT87x driver
   adds CONFIG_SND_BT87X_OVERCLOCK to enable sample rates
   up to 1792000 Hz when recording from the analog input
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/07 1.1939.10.18)
   [ALSA]  Add reset_workaround module option
   
   Documentation,NM256 driver
   - The workaround for some laptops like Dell Latitude LS can be
     specified via reset_workaround module option, too.
   - The check of reset_workaround is merged into the quirk table.
   - The spinlock in AC97 reset callback is removed.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.17)
   [ALSA]  Adds AC'97 support to Aureon cards.
   
   ICE1712 driver
   This patch adds support of the STAC9744 chip located on Aureon cards,
   enabling volume control for analogue input channels.
   It also adds the posibility of listening to both the analogue inputs
   and the digital audio.
   
   Signed-off-by: Peter Christensen <peter@developers.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.16)
   [ALSA]  Clean up ice1712 chip struct
   
   ICE1712 driver
   Clean up of ice1712 chip struct.  The board-specific data are moved
   to spec union.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.15)
   [ALSA]  Fix peakmeter ioctl on big-endian
   
   RME HDSP driver
   Fixed the data transfer of peakmeter ioctl on big-endian architectures.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.14)
   [ALSA]  Replace with usb_kill_urb()
   
   USB generic driver
   Use usb_kill_urb() instead of deprecated usb_unlink_urb() for sync'ed URBs.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.13)
   [ALSA]  snd-usb-usx2y 0.7.3
   
   USB generic driver,USB USX2Y
   Use usb_kill_urb() instead of deprecated usb_unlink_urb()
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.12)
   [ALSA]  Fix drain/drop of linked PCM streams
   
   PCM Midlevel
   This patch fixes the dead-locking of linked PCM streams when
   drain/drop is called.  The counter field is added to pcm group
   struct to handle link/unlink more easily.
   
   When the PCM streams are linked, start/drain/drop are operated
   to all linked streams.  The drain will wait until draining of all
   linked streams are finished.
   
   The XRUN triggers stopping of all linked streams and changes the
   state of all of them to XRUN even if only one of them is actually
   in XRUN.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.11)
   [ALSA]  Aureon S/PDIF input fixes
   
   ICE1712 driver
   GPIO directions changed
      * GPIO>22 not configured as they do not exist
      * GPIO22 set to output (CS8415A CS pin)
      * GPIO21 set to input. (SPI MISO pin)
   
   Init sequence of CS8415A changed:
     * SWCLK is set to 1 (OMCK output to RMCK pin)
     * MUX2:0 is set to 001 (S/PDIF input on RXP1)
     * SODEL is set to 1 (MSB of SDOUT data occurs if the second OSCLK period after the OLRCK edge)
     * SOLRPOL is set to 1 (SDOUT data is for the right channel with OLRCK is high)
   
   Signed-off-by: Peter Christensen <peter@christensen>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.10)
   [ALSA]  Aureon S/PDIF input fixes
   
   ICE1712 driver
   Fix GPIO pin directions and use RXP1 instead of RXP0 as S/PDIF source on CS8415A
   
   Signed-off-by: Peter Christensen <peter@developers.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.9)
   [ALSA]  Fix DXS entry for GA-7VAX
   
   VIA82xx driver
   From: 1 1 <anoy@mail.ru>
   
   I have tested my MB GA-7VAX and want to say you that you should use
   VIA_DXS_ENABLE instead VIA_DXS_NO_VRA.  On the maximum volume output level
   with VIA_DXS_NO_VRA there is abnormal loud noise, and with VIA_DXS_ENABLE
   there are much less noises.  And I have detected unused code section.
   
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.8)
   [ALSA]  Fix HDSP meter ioctl
   
   RME HDSP driver
   Fixes and clean up of GET_PEAK_RMS ioctl.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.7)
   [ALSA]  more au88x0 eq cleanups
   
   au88x0 driver
   cleanup au88x0 equalizer code by factoring out a sign_invert function
   that ensures all negative integers become positive.
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/10/07 1.1939.10.6)
   [ALSA]  Fix the variable types in struct
   
   RME HDSP driver
   The variable types are declared explicitly like u32 and u64
   to avoid ambiguity.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1939.10.5)
   [ALSA]  don't stop capture on errors
   
   BT87x driver
   don't stop capture on errors because there's too much broken hardware out there
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1939.10.4)
   [ALSA]  remove 'Rawmidi' part from sequencer port names
   
   ALSA sequencer
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1832.72.45)
   [ALSA]  use card-specific driver name
   
   au88x0 driver
   use CARD_NAME_SHORT as driver name to allow different configuration file aliases in alsa-lib
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1832.72.44)
   [ALSA]  Fix SPDIF rate setting for old ICHs
   
   Intel8x0 driver
   Force to set SPDIF rate when PCMOUT is used on ICH[1-3].
   ICH4, NFORCE and ALI uses a separate DMA for SPDIF.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.43)
   [ALSA]  [hdsp] Fix for 64bit architectures
   
   RME HDSP driver
   Fixed the loading of firmware data and the handling of meter mmap
   on 64bit architectures.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.42)
   [ALSA]  rme32 segfault fix
   
   RME32 driver
   - disables buffer prefill in halfduplex mode, which fixes segmentation fault
     of rme32 for playback in halfduplex mode
   
   Signed-Off-By: Martin Langer <martin-langer@gmx.de>
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.41)
   [ALSA]  Added support of Mediastation
   
   ICE1712 driver
   The support for Lionstracs Mediastation is added.
   The model name is 'mediastation'.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.40)
   [ALSA]  Fix iomem variable type
   
   Documentation,ALSA Core,MPU401 UART,OPL3,CS46xx driver,YMFPCI driver
   ATIIXP driver,ATIIXP-modem driver,CS4281 driver,Intel8x0 driver
   Intel8x0-modem driver,RME32 driver,RME96 driver,au88x0 driver
   KORG1212 driver,MIXART driver,NM256 driver,RME HDSP driver
   RME9652 driver,PPC Tumbler driver
   The type of iomem variables is changed to void __iomem *.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.39)
   [ALSA]  Fix auto-loading of sequencer modules
   
   ALSA sequencer
   Allow auto-loading of sequencer modules except for module init time
   (which may cause blocking).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.38)
   [ALSA]  Fixed the obsolete description in comments
   
   IOCTL32 emulation
   
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.37)
   [ALSA]  Improved clock measurement
   
   Intel8x0 driver
   Improved the clock measurement routine to allow the longer sleep time.
   Now it invokes schedule_timeout() instead of a long mdelay().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.36)
   [ALSA]  Remove delay() to improve latency
   
   ES1968 driver
   - Removed mdelay() in ac97 codec handling.
   - Improved the clock measurement routine to allow the longer sleep time.
     Now it invokes schedule_timeout() instead of a long mdelay().
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.35)
   [ALSA]  Support for capture of 16,32,64 channels on emu10k1 device 2
   
   EMU10K1/EMU10K2 driver
   This patch changes default constraint on 'EFX voices mask' control and
   allow capture of 1, 2, 4, 8, 16, 32, 64 channels instead of 1, 2, 4, 8.
   
   Signed-off-by: Peter Zubaj <pzad@pobox.sk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.34)
   [ALSA]  Fixes for PCM/control 32bit emulation
   
   PCM Midlevel,IOCTL32 emulation
   - Size mismatch of control element struct due to packed attribute
     is removed.
   - A typo in PCM syncptr definition is fixed.
   - Suppress the mmap of PCM status/control records on 32bit emulation
     mode since the record size doesn't match.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.33)
   [ALSA]  fix ALI M5451 description
   
   PCI drivers
   modify ali5451 and intel8x0 help texts to better distinguish
   between M5451 and M5455 AC97 controllers
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1832.72.32)
   [ALSA]  remove 'ALSA' from Kconfig USB menu name
   
   USB
   make ISA, PCI and USB device look the same in {q,x,menu}config
   
   Signed-off-by: Thierry Vignaud <tvignaud@mandrakesoft.com>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1832.72.31)
   [ALSA]  enhance Kconfig help texts
   
   ARM,ALSA Core,Generic drivers,ISA,PARISC,PCI drivers,PCMCIA Kconfig,PPC
   USB
   add module names and references to other documentation files
   add more help for generic options
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1832.72.30)
   [ALSA]  adjust intel8x0 joystick documentation
   
   Documentation
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1832.72.29)
   [ALSA]  show codec name in card description
   
   AC97 Codec Core,ATIIXP driver,Intel8x0 driver,VIA82xx driver
   Include the AC97 codec name in the card longname of
   motherboard controllers.
   (to enhance the chance of getting useful bug reports :)
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1832.72.28)
   [ALSA]  Fix driver name for nforce and clean-up
   
   Intel8x0-modem driver
   Driver name is always ICH-MODEM as defined in alsa-lib config.
   Cosmetic cleanups: unused include files, MODULE_DEVICE update.
   
   Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/22 1.1832.72.27)
   [ALSA]  Added missing header file for AudioTrak Prodigy 192 cards
   
   ICE1712 driver
   
   
   Signed-off-by: Kouichi ONO <co2b@ceres.dti.ne.jp>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/09/22 1.1832.72.26)
   [ALSA]  copy_to_user() return value checking in snd_seq_read()
   
   ALSA sequencer
   Here's a patch that ensures the copy_to_user() return value gets checked
   and acted upon if it is != 0 (that is, if we failed to copy all data) in
   snd_seq_read().
   
   Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/09/22 1.1832.72.25)
   [ALSA]  [ac97 core] added AC97_SCAP_DETECT_BY_VENDOR flag
   
   AC97 Codec Core,Intel8x0 driver
   This patch adds a AC97_SCAP_DETECT_BY_VENDOR flag for Xbox. If the flag
   is set, the AC97 codec is detected only by reading of a reasonable
   vendor ID. It seems that Xbox has accessible only vendor/device ID
   registers for reading. Also, a new xbox parameter for snd-intel8x0
   has been introduced to let user force this behaviour.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/09/22 1.1832.72.24)
   [ALSA]  mark snd_card_dummy_new_mixer() as static
   
   Generic drivers
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/09/22 1.1832.72.23)
   [ALSA]  add UA-1000 sample rate detection
   
   USB generic driver
   Instead of assuming 48 kHz, the driver now detects
   the current sample rate setting.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/22 1.1832.72.22)
   [ALSA]  Added support for AudioTrak Prodigy 192 cards
   
   ICE1712 driver,ICE1724 driver
   
   
   Signed-off-by: Kouichi ONO <co2b@ceres.dti.ne.jp>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/09/22 1.1832.72.21)
   [ALSA]  Fix the OSS PCM emulation - O_NONBLOCK write
   
   ALSA<-OSS emulation
   This patch fixes the OSS PCM write() in O_NONBLOCK mode.
   The previous code had not returned partial written bytes.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/09/06 1.1832.72.20)
   [ALSA]  [emu10k1] Audigy DSP support
   
   EMU10K1/EMU10K2 driver
   This patch will add better support for Audigy DSP.  More gpr,
   instruction and tram.  It will break binary compatibility for app
   which use emu10k1 hwdep.
   
   Signed-off-by: Peter Zubaj <pzad@pobox.sk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.19)
   [ALSA]  Added Compaq Evo W4000 quirk
   
   Intel8x0 driver
   Added an AC97 quirk entry for Compaq Evo W4000.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.18)
   [ALSA]  detect errors reported by the hardware
   
   BT87x driver
   stop the PCM if the hardware reports FIFO/PCI errors
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/06 1.1832.72.17)
   [ALSA]  inverted EAPD support
   
   Documentation,AC97 Codec Core,Intel8x0 driver,CS46xx driver
   Since there are more than one (broken) implementation of EAPD bit
   on ac97 chips, the new scaps bit is added for the inverted EAPD.
   Also, AC97_TUNE_INV_EAPD is used to tune this behavior later by
   snd_ac97_tune_hardware().
   
   The ac97 quirk entry for Sony S1XP is added to turn this on.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.16)
   [ALSA]  ac97 quirk entry for Soltek SL-75DRV5
   
   VIA82xx driver
   Added an ac97 quirk entry for Soltek SL-75DRV5.
   Since the PCI subsystem id is identical with ASRock K7VT2, codec_id is
   used additionally to tell between them.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.15)
   [ALSA]  [ac97] Check ac97 codec id in quirk table
   
   AC97 Codec Core
   Added codec_id field to ac97_quirk struct so that the devices with
   the same PCI subsystem IDs but with different AC97 chips can be
   distinguished properly.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.14)
   [ALSA]  [ac97] Added VIA shared type.
   
   AC97 Codec Core,VIA82xx driver
   Added a new shared type AC97_SHARED_TYPE_VIA for via82xx southbridge
   to share codecs between audio and modem drivers.
   
   Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.13)
   [ALSA]  add mixer quirk for LineX FM Transmitter
   
   USB generic driver
   The LineX FM Transmitter needs a mixer quirk entry
   to ignore control errors.
   
   Signed-off-by: Lonnie Mendez <dignome@gmail.com>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/06 1.1832.72.12)
   [ALSA]  remove gameport/MIDI support
   
   Documentation,PCI drivers,Intel8x0 driver
   snd-intel8x0's gameport/MIDI code has quite a few problems:  the port
   addresses cannot be detected reliably (or not at all with newer LPC
   bridge devices), joystick port address 0x208 isn't supported, the MIDI
   interrupt isn't detected, PnP isn't supported, changing the port
   addresses in the LPC bridge configuration doesn't affect the devices
   in the Super-I/O chip connected to the LPC bus, and registering this
   driver for the LPC bridge PCI device prevents other drivers using the
   LPC's PCI id from loading later.
   
   All these problems can be cured by removing the offending code and
   using the proper modules for these devices (ns558/snd-mpu401) instead.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/06 1.1832.72.11)
   [ALSA]  add AC97 quirk for Fujitsu-Siemens E4010
   
   Intel8x0 driver
   
   
   Signed-off-by: <castet.matthieu@free.fr>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/06 1.1832.72.10)
   [ALSA]  Fix latency in ens1371 driver
   
   ENS1370/1+ driver
   The high latency in prepare callback of ens1371 driver is fixed.
   The *_rate_set() functions are moved outside of spinlock, and
   cond_resched() is inserted in the busy probing loop.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.9)
   [ALSA]  suppress auto-loading of modules in module_init().
   
   ALSA sequencer
   The auto-loading of sequencer modules is suppressed in module_init().
   The recent module-init-tools may cause blocking.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.8)
   [ALSA]  add missing ifdef for disabling MIDI
   
   Intel8x0 driver
   
   
   Signed-off-by: <castet.matthieu@free.fr>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/06 1.1832.72.7)
   [ALSA]  AC97 96 kHz sample rate support
   
   Documentation,AC97 Codec Core,Intel8x0 driver
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/09/06 1.1832.72.6)
   [ALSA]  Korg1212 misc fixes
   
   KORG1212 driver
   The DSP firmware download timeout has been increased;
   Some concurrent device settings has been fixed (I have shameless copied
   some code from RME9652); and
   One debug message was fixed.
   
   Signed-off-by: Haroldo Gamal <gamal@alternex.com.br>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.5)
   [ALSA]  Enable __GFP_NOWARN as default for buffer allocation
   
   Memalloc module
   __GFP_NOWARN is enabled for DMA buffer allocation regardless of
   its size.  The DMA buffer allocation is not a critical task.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.4)
   [ALSA]  Added __GFP_NORETRY to avoid OOM-killer
   
   Memalloc module
   __GFP_NORETRY is added to the DMA buffer allocator to avoid triggering
   OOM-killer.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.3)
   ALSA CVS update
   ES18xx driver
   Fixed a bug in setting the filter register.
   
   A fix from the kernel OSS driver.  The original report/patch is from
   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=204147
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.2)
   ALSA CVS update
   ICE1712 driver
   Allow the private EEPROM image for evaluation boards
   
   The driver may have a private EEPROM image instead of reading
   from the board (as well as ice1724 does).  It'll be helpful for
   test boards.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/09/06 1.1832.72.1)
   ALSA CVS update
   ENS1370/1+ driver
   Fixed AC3-passthru on ens1371/1373 boards.
   
   SRC is bypassed when the sample rate is 48k, so that the non-audio
   signal won't be broken.  The other sample rates still need SRC.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
