Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUEXHki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUEXHki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUEXHkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:40:37 -0400
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:63166 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S264088AbUEXHiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:38:24 -0400
Date: Mon, 24 May 2004 09:45:53 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA CVS update
Message-ID: <Pine.LNX.4.58.0405240943320.1779@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-05-23.patch.gz

Additional notes:

  - lots of maintenance work and cleanups for 2.6
  - use the new module_param*() functions
  - power-management cleanups
  - ICE1712/24 driver has now "card type" option
  - ICE1724 driver cleanups

The pull command will update the following files:

 sound/pci/ice1712/prodigy.c                                  |  664 -----------
 sound/pci/ice1712/prodigy.h                                  |   67 -
 Documentation/sound/alsa/ALSA-Configuration.txt              |   37 
 Documentation/sound/alsa/Audigy-mixer.txt                    |  345 +++++
 Documentation/sound/alsa/CMIPCI.txt                          |    4 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |  239 ---
 Documentation/sound/alsa/Procfile.txt                        |    6 
 include/linux/pci_ids.h                                      |    1 
 include/sound/ac97_codec.h                                   |   20 
 include/sound/ad1848.h                                       |    3 
 include/sound/asound.h                                       |   23 
 include/sound/core.h                                         |   28 
 include/sound/cs4231.h                                       |    1 
 include/sound/cs46xx.h                                       |    8 
 include/sound/emu10k1.h                                      |   12 
 include/sound/initval.h                                      |   40 
 include/sound/timer.h                                        |    1 
 include/sound/trident.h                                      |   13 
 include/sound/uda1341.h                                      |    2 
 include/sound/version.h                                      |    4 
 include/sound/ymfpci.h                                       |    5 
 sound/arm/sa11xx-uda1341.c                                   |   70 -
 sound/core/Kconfig                                           |   15 
 sound/core/control.c                                         |   33 
 sound/core/init.c                                            |  115 +
 sound/core/memalloc.c                                        |   59 
 sound/core/oss/pcm_oss.c                                     |   37 
 sound/core/pcm_memory.c                                      |   11 
 sound/core/pcm_misc.c                                        |    2 
 sound/core/pcm_native.c                                      |   57 
 sound/core/rawmidi.c                                         |   26 
 sound/core/rtctimer.c                                        |   15 
 sound/core/seq/oss/seq_oss.c                                 |    5 
 sound/core/seq/oss/seq_oss_init.c                            |    5 
 sound/core/seq/seq.c                                         |   32 
 sound/core/seq/seq_dummy.c                                   |   11 
 sound/core/seq/seq_midi.c                                    |    9 
 sound/core/sound.c                                           |   19 
 sound/core/timer.c                                           |   58 
 sound/drivers/dummy.c                                        |   39 
 sound/drivers/mpu401/mpu401.c                                |   49 
 sound/drivers/mtpav.c                                        |   34 
 sound/drivers/opl3/opl3_seq.c                                |    3 
 sound/drivers/opl4/opl4_seq.c                                |    5 
 sound/drivers/serial-u16550.c                                |   56 
 sound/drivers/virmidi.c                                      |   33 
 sound/isa/ad1816a/ad1816a.c                                  |   53 
 sound/isa/ad1848/ad1848.c                                    |   43 
 sound/isa/ad1848/ad1848_lib.c                                |   65 -
 sound/isa/als100.c                                           |   53 
 sound/isa/azt2320.c                                          |   55 
 sound/isa/cmi8330.c                                          |   63 -
 sound/isa/cs423x/cs4231.c                                    |   52 
 sound/isa/cs423x/cs4231_lib.c                                |   64 -
 sound/isa/cs423x/cs4236.c                                    |   76 -
 sound/isa/cs423x/pc98.c                                      |   58 
 sound/isa/dt019x.c                                           |   50 
 sound/isa/es1688/es1688.c                                    |   48 
 sound/isa/es18xx.c                                           |  124 --
 sound/isa/gus/gusclassic.c                                   |   55 
 sound/isa/gus/gusextreme.c                                   |   65 -
 sound/isa/gus/gusmax.c                                       |   55 
 sound/isa/gus/interwave.c                                    |   75 -
 sound/isa/opl3sa2.c                                          |  147 --
 sound/isa/opti9xx/opti92x-ad1848.c                           |   72 -
 sound/isa/sb/emu8000_patch.c                                 |    6 
 sound/isa/sb/es968.c                                         |   40 
 sound/isa/sb/sb16.c                                          |   88 -
 sound/isa/sb/sb8.c                                           |   40 
 sound/isa/sgalaxy.c                                          |   42 
 sound/isa/sscape.c                                           |   42 
 sound/isa/wavefront/wavefront.c                              |   69 -
 sound/isa/wavefront/wavefront_synth.c                        |   21 
 sound/parisc/harmony.c                                       |  226 +--
 sound/pci/Kconfig                                            |   18 
 sound/pci/ac97/ac97_codec.c                                  |  111 +
 sound/pci/ac97/ac97_local.h                                  |    3 
 sound/pci/ac97/ac97_patch.c                                  |  247 +++-
 sound/pci/ac97/ac97_pcm.c                                    |    2 
 sound/pci/ac97/ac97_proc.c                                   |   79 +
 sound/pci/ali5451/ali5451.c                                  |   94 -
 sound/pci/als4000.c                                          |   46 
 sound/pci/atiixp.c                                           |  349 +++--
 sound/pci/au88x0/au8810.h                                    |  106 +
 sound/pci/au88x0/au8820.c                                    |    2 
 sound/pci/au88x0/au8820.h                                    |    4 
 sound/pci/au88x0/au8830.c                                    |    2 
 sound/pci/au88x0/au8830.h                                    |    8 
 sound/pci/au88x0/au88x0.c                                    |  152 +-
 sound/pci/au88x0/au88x0.h                                    |   20 
 sound/pci/au88x0/au88x0_a3d.c                                |    6 
 sound/pci/au88x0/au88x0_core.c                               |   61 -
 sound/pci/au88x0/au88x0_eq.c                                 |    4 
 sound/pci/au88x0/au88x0_game.c                               |   12 
 sound/pci/au88x0/au88x0_pcm.c                                |   23 
 sound/pci/au88x0/au88x0_synth.c                              |   24 
 sound/pci/azt3328.c                                          |   67 -
 sound/pci/bt87x.c                                            |   49 
 sound/pci/cmipci.c                                           |  567 +--------
 sound/pci/cs4281.c                                           |  117 -
 sound/pci/cs46xx/cs46xx.c                                    |   75 -
 sound/pci/cs46xx/cs46xx_lib.c                                |   46 
 sound/pci/emu10k1/emu10k1.c                                  |   55 
 sound/pci/emu10k1/emu10k1_main.c                             |    2 
 sound/pci/emu10k1/emufx.c                                    |   20 
 sound/pci/emu10k1/emumixer.c                                 |   11 
 sound/pci/ens1370.c                                          |   56 
 sound/pci/es1938.c                                           |   40 
 sound/pci/es1968.c                                           |  160 --
 sound/pci/fm801.c                                            |   43 
 sound/pci/ice1712/Makefile                                   |    2 
 sound/pci/ice1712/amp.c                                      |    9 
 sound/pci/ice1712/aureon.c                                   |  412 ++++++
 sound/pci/ice1712/aureon.h                                   |   12 
 sound/pci/ice1712/delta.c                                    |  108 -
 sound/pci/ice1712/envy24ht.h                                 |    3 
 sound/pci/ice1712/ews.c                                      |   45 
 sound/pci/ice1712/hoontech.c                                 |  153 ++
 sound/pci/ice1712/hoontech.h                                 |   15 
 sound/pci/ice1712/ice1712.c                                  |  185 ++-
 sound/pci/ice1712/ice1712.h                                  |    8 
 sound/pci/ice1712/ice1724.c                                  |  297 +++-
 sound/pci/ice1712/prodigy.c                                  |    1 
 sound/pci/ice1712/revo.c                                     |    9 
 sound/pci/intel8x0.c                                         |  203 +--
 sound/pci/intel8x0m.c                                        |  121 --
 sound/pci/korg1212/korg1212.c                                |   46 
 sound/pci/maestro3.c                                         |  117 -
 sound/pci/mixart/mixart.c                                    |   40 
 sound/pci/nm256/nm256.c                                      |  152 --
 sound/pci/rme32.c                                            |   38 
 sound/pci/rme96.c                                            |   40 
 sound/pci/rme9652/hdsp.c                                     |   50 
 sound/pci/rme9652/rme9652.c                                  |   45 
 sound/pci/sonicvibes.c                                       |   50 
 sound/pci/trident/trident.c                                  |   73 -
 sound/pci/trident/trident_main.c                             |   53 
 sound/pci/via82xx.c                                          |  171 +-
 sound/pci/vx222/vx222.c                                      |   44 
 sound/pci/ymfpci/ymfpci.c                                    |   77 -
 sound/pci/ymfpci/ymfpci_main.c                               |   37 
 sound/pcmcia/Kconfig                                         |    1 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                           |   21 
 sound/pcmcia/pdaudiocf/pdaudiocf.h                           |    7 
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c                      |   33 
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c                       |    7 
 sound/pcmcia/vx/vxpocket.c                                   |   14 
 sound/ppc/keywest.c                                          |   18 
 sound/ppc/pmac.c                                             |   67 -
 sound/ppc/pmac.h                                             |    2 
 sound/ppc/powermac.c                                         |   35 
 sound/ppc/tumbler.c                                          |    4 
 sound/sparc/amd7930.c                                        |   30 
 sound/sparc/cs4231.c                                         |   30 
 sound/usb/usbaudio.c                                         |  172 ++
 sound/usb/usbaudio.h                                         |    5 
 sound/usb/usbmixer.c                                         |    4 
 sound/usb/usbquirks.h                                        |   96 +
 158 files changed, 4137 insertions(+), 5874 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/05/23 1.1742)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCM Midlevel,ALSA Core
   Added SNDRV_PCM_SYNC_PTR_APPL and SNDRV_PCM_SYNC_PTR_AVAIL_MIN extensions
   to SYNC_PTR ioctl for PCM API.

<perex@suse.cz> (04/05/23 1.1741)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added the DXS entry for ECS K7VTA3 v8.0
   - fixed the DXS entry for ASUS A7V8X to NO_VRA.

<perex@suse.cz> (04/05/23 1.1740)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA Core
   added reverse selections of components to CONFIG_SND_BIT32_EMUL.

<perex@suse.cz> (04/05/23 1.1739)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCI drivers,ICE1712 driver,ICE1724 driver
   - improved the description of ice1724 driver on Kconfig.
   - better support of VT1720 with snd-ice1724 driver.
   - check PCI subsystem IDs when no EEPROM is available (ice1724 only)
   - change the driver name string if given in the board list.
   - merged prodigy 7.1 support into aureon.c.  they are almost identical.
   - allow to use PDMA4 and RMDA1 for non-SPDIF purpose if specified (ice1724 only).

<perex@suse.cz> (04/05/18 1.1717.1.52)
   ALSA CVS sync

<perex@suse.cz> (04/05/17 1.1717.1.51)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCM Midlevel
   Call hwsync at the start of SYNC_PTR ioctl

<perex@suse.cz> (04/05/17 1.1717.1.50)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCM Midlevel,ALSA Core
   Added SYNC_PTR ioctl for the PCM interface.

<perex@suse.cz> (04/05/17 1.1717.1.49)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ICE1712 driver
   <Dirk.Kalis@t-online.de>
   ice1712 patch for dsp24 value cards
   Without this patch in envy24control no controls for DAC and ADC
   available because no number of dacs and adcs is given.

<perex@suse.cz> (04/05/17 1.1717.1.48)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1712 driver
   fixes by Christoph Haderer <chris_web@gmx.at>:
   - added the support of DAC/ADC mute switches
   - fixed the capture route enum.

<perex@suse.cz> (04/05/17 1.1717.1.47)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1712 driver
   Added the support of Aureon 7.1-Universe.

<perex@suse.cz> (04/05/17 1.1717.1.46)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1712 driver
   added headphone amplifier switch.
   initial patch by Radoslaw 'AstralStorm' Szkodzinski.

<perex@suse.cz> (04/05/17 1.1717.1.45)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   RME HDSP driver,RME9652 driver
   fixed invalid spin_lock/unlock_irq() in the prepare callback.

<perex@suse.cz> (04/05/17 1.1717.1.44)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   CS4236+ driver
   Added the new pnp id for an Intel mobo.

<perex@suse.cz> (04/05/17 1.1717.1.43)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ATIIXP driver
   - probe only audio codecs.
   - use enums instead of embedded numbers.
   - added KERN_ERR prefix to the error messages.

<perex@suse.cz> (04/05/17 1.1717.1.42)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC PMAC driver,PPC Tumbler driver
   Giuliano Pochini <pochini@shiny.it>:
   fixed the return value of interrupt handlers.

<perex@suse.cz> (04/05/17 1.1717.1.41)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel
   fixed the buffer id confliction in the case of CONTINUOUS or ISA buffers.

<perex@suse.cz> (04/05/17 1.1717.1.40)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   fix typo

<perex@suse.cz> (04/05/17 1.1717.1.39)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   Roland UA-1000 support

<perex@suse.cz> (04/05/17 1.1717.1.38)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   AC97 Codec Core
   STAC9758: stereo mutes, jack configuration

<perex@suse.cz> (04/05/17 1.1717.1.37)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PARISC Harmony driver
   - fixed the buffer allocation with the new API.
   - optimized the rate and format setting.
   - removed redundant call of buffer release.
   - removed invalid __devinit prefix.

<perex@suse.cz> (04/05/17 1.1717.1.36)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,ICE1724 driver,ICE1712 driver
   - added model module option to specify board model to snd-ice1712 and snd-ice1724
     drivers.
   - removed ez8 option from ice1724.  this can be specified as 'model=ez8' option.
   - rewritten some struct init in C99 style.
   - function for accessing i2c of ice1724 (for future use).

<perex@suse.cz> (04/05/17 1.1717.1.35)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Sound Core PDAudioCF driver
   - fixed the changed function decleration.
   - fixed the return value from cast check.

<perex@suse.cz> (04/05/17 1.1717.1.34)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   renamed the elements of 'input source select' control to avoid confusion.
   
   formerly used words 'Line' and 'Mic', which have nothing to do with
   the actual connections.

<perex@suse.cz> (04/05/17 1.1717.1.33)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,CMIPCI driver
   make soft_ac3 option conditional again.
   
   this will make it possible for old chips to feed the IEC958 data
   without conversion (sometimes useful, e.g. for apps using mmap).

<perex@suse.cz> (04/05/17 1.1717.1.32)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Sound Core PDAudioCF driver
   Updated interrupt function to 2.6 irq API

<perex@suse.cz> (04/05/17 1.1717.1.31)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   EMU10K1/EMU10K2 driver
   Credits for SB Live (c) 2003

<perex@suse.cz> (04/05/17 1.1717.1.30)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   (Alan Stern) use altsetting number instead of index in messages

<perex@suse.cz> (04/05/17 1.1717.1.29)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   added the document about Audigy mixer implementation by Peter Zubaj.
   it is not target to users, rather to developers.

<perex@suse.cz> (04/05/17 1.1717.1.28)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ATIIXP driver
   - fixed the direct SPDIF playback mode.  (still experimental)
   - use the different driver id name for the direct spdif mode, so that
     alsa-lib can read another corresponding configuration.

<perex@suse.cz> (04/05/17 1.1717.1.27)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,CMIPCI driver
   dropped the software encoding of AC3 stream in the driver.
   this is done now in alsa-lib.
   soft_ac3 module option is kept for backward compatibility but not
   referred at all.

<perex@suse.cz> (04/05/17 1.1717.1.26)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,NM256 driver
   - added a blacklist to avoid the possible hang-up at module loading.
   - added notes about the hang-up problem to ALSA-Configuration.txt.

<perex@suse.cz> (04/05/17 1.1717.1.25)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel
   fixed the bit width of IEC958_SUBFRAME_* formats from 24 to 32.

<perex@suse.cz> (04/05/17 1.1717.1.24)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   fixed again the DXS entry for m680x to 48k-fixed rate.

<perex@suse.cz> (04/05/17 1.1717.1.23)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   ALSA<-OSS emulation
   don't return negative byte count from GET[IO]PTR ioctl

<perex@suse.cz> (04/05/17 1.1717.1.22)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   ICE1712 driver
   fix Hoontech DSP* box configuration

<perex@suse.cz> (04/05/17 1.1717.1.21)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   - fixed some obsolete descriptions and typos.
   - a bit more detailed description about addition of the new driver.

<perex@suse.cz> (04/05/17 1.1717.1.20)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   SA11xx UDA1341 driver,UDA1341
   - clean up PM codes using the new PM callback functions.

<perex@suse.cz> (04/05/17 1.1717.1.19)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALSA Core
   - added the generic PM callback registration.
   - rewritten ISA callbacks to use the new one.

<perex@suse.cz> (04/05/17 1.1717.1.18)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ES1968 driver
   - set ACPI D3 at suspend.
   - fixed the interrupt disabling at shutdown.
   - enabled PM for compaq Armada.

<perex@suse.cz> (04/05/17 1.1717.1.17)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   try to mute and power down in the destructor (to shut up noises).

<perex@suse.cz> (04/05/17 1.1717.1.16)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   CS4231 driver
   add missing closing brace

<perex@suse.cz> (04/05/17 1.1717.1.15)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   RME HDSP driver
   HDSP9632 has also firmware version 0x97

<perex@suse.cz> (04/05/17 1.1717.1.14)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Documentation,EMU10K1/EMU10K2 driver
   Initial attempt to add support for SB Live 5.1 (c) 2003

<perex@suse.cz> (04/05/17 1.1717.1.13)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   added DXS whitelist for (eMachines) m680x.

<perex@suse.cz> (04/05/17 1.1717.1.12)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   CS4231 driver
   checks the PCM substream pointers to fix oops/panic in the interrupt
   handler.

<perex@suse.cz> (04/05/17 1.1717.1.11)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   Intel8x0 driver
   check that period interrupt really has occured;
   clear only those interrupts that have been handled

<perex@suse.cz> (04/05/17 1.1717.1.10)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   ALSA<-OSS emulation,ALSA sequencer,ALSA<-OSS sequencer,OPL4
   make some module parameters sysfs-writable, where appropriate

<perex@suse.cz> (04/05/17 1.1717.1.9)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PARISC Harmony driver
   fixed compilation - using struct parisc_device for DMA allocation.

<perex@suse.cz> (04/04/24 1.1371.764.50)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   OPL3SA2 driver
   Added YMH0801 ISA PnP ID - OPL3-SA2

<perex@suse.cz> (04/04/24 1.1371.764.49)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   - added the experimental PM support.

<perex@suse.cz> (04/04/24 1.1371.764.48)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCI drivers,ATIIXP driver
   - added IXP 300 to descriptions and comments.
   - fixed the codec probing without the proper interrupts.
   - added the experimental PM support.

<perex@suse.cz> (04/04/24 1.1371.764.47)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   fixed the compilation without CONFIG_SND_DEBUG.

<perex@suse.cz> (04/04/24 1.1371.764.46)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC Keywest driver,PPC PMAC driver,PPC PowerMac driver
   PPC Tumbler driver
   fixed the oops on resume and the initialization of chip.

<perex@suse.cz> (04/04/24 1.1371.764.45)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   ac97->pci might be null

<perex@suse.cz> (04/04/24 1.1371.764.44)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   patch_sigmatel_stac9758
     - initialize with default values from datasheet
     - apply old initialization only for Gateway M675 notebook

<perex@suse.cz> (04/04/24 1.1371.764.43)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Intel8x0 driver
   From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
   
   It seems that pci config space is messed up after resume for Intel ICH4
   audio controller (on Dell Latitude D600, but I notice that others also
   complain about this problem).  Consequently resume from S3 causes oops with
   snd_intel8x0 module.  If the module is removed before suspend and loaded
   afterwards, I still get oops.  The following simple patch fixes the
   problem.  With this, I can leave alsa untouched during suspend/resume.

<perex@suse.cz> (04/04/24 1.1371.764.42)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Opti9xx drivers
   Fixed irq&dma initialization for <93x chips

<perex@suse.cz> (04/04/24 1.1371.764.41)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Fixed AD18xx PCM bit handling

<perex@suse.cz> (04/04/24 1.1371.764.40)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,AC97 Codec Core
   added the write support to ac97#x-x+regs proc file.
   
   this is for debugging purpose, and enabled only when CONFIG_SND_DEBUG is set.
   it allows the user to modify AC97 register bits without compiling the sources.

<perex@suse.cz> (04/04/24 1.1371.764.39)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   added the mic/center sharing switch of cm9739 codec again.

<perex@suse.cz> (04/04/24 1.1371.764.38)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Control Midlevel
   - fixed the compilation without CONFIG_PM.
   - fixed the return value of POWER ioctl.

<perex@suse.cz> (04/04/24 1.1371.764.37)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed the center/mic share switch on ALC65x.
   - created AC97_SINGLE_VALUME() macro.

<perex@suse.cz> (04/04/24 1.1371.764.36)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ATIIXP driver
   - added the PCI id entry for SB300.
   - added the missing terminator to the PCI id list.

<perex@suse.cz> (04/04/24 1.1371.764.35)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC PMAC driver
   fixed the missing function declarations.

<perex@suse.cz> (04/04/24 1.1371.764.34)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ICE1712 driver
   <Dirk.Kalis@t-online.de>
   added a control for default rate in the ice1712 driver

<perex@suse.cz> (04/04/24 1.1371.764.33)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC PMAC driver
   another fix for the new suspend/resume.

<perex@suse.cz> (04/04/24 1.1371.764.32)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   removed the obsolete hack for dev_alloc_coherent() with dev = 0.

<perex@suse.cz> (04/04/24 1.1371.764.31)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PPC PMAC driver
   fixed the suspend/resume with the new ALSA common callbacks.

<perex@suse.cz> (04/04/24 1.1371.764.30)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel
   fixed the deadlock of power_lock in suspend (by Terry Loftin)

<perex@suse.cz> (04/04/24 1.1371.764.29)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   CS4281 driver,ES1968 driver,Maestro3 driver,ALI5451 driver
   CS46xx driver,NM256 driver,Trident driver,YMFPCI driver
   - call snd_ac97_suspend() in the suspend callback.
   - suspend/resume secondary codecs, too.

<perex@suse.cz> (04/04/24 1.1371.764.28)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - export snd_ac97_suspend().
   - mute MASTER and HEADPHONE volumes in suspend to avoid possible clicks.

<perex@suse.cz> (04/04/24 1.1371.764.27)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver,Intel8x0-modem driver
   - probe only audio (intel8x0) or modem (intel8x0m) codecs.
   - call snd_ac97_suspend() in the suspend callback.

<perex@suse.cz> (04/04/24 1.1371.764.26)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   Edirol UA-700 advanced modes support

<perex@suse.cz> (04/04/24 1.1371.764.25)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   fixed the allocation of coherent DMA pages under 32bit mask.

<perex@suse.cz> (04/04/24 1.1371.764.24)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   fixed MX440 workaround in suspend/resume.

<perex@suse.cz> (04/04/24 1.1371.764.23)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ICE1712 driver
   added Event Electronics EZ8 support by Doug McLain <nostar@comcast.net>

<perex@suse.cz> (04/04/24 1.1371.764.22)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCI drivers,au88x0 driver
   bugfixes and VIA/AMD chipset automatic workaround by Manuel Jander <manuel.jander@mat.utfsm.cl>

<perex@suse.cz> (04/04/24 1.1371.764.21)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,ALS4000 driver,ATIIXP driver,AZT3328 driver,BT87x driver
   CMIPCI driver,CS4281 driver,ENS1370/1+ driver,ES1938 driver
   ES1968 driver,FM801 driver,Intel8x0 driver,Intel8x0-modem driver
   Maestro3 driver,RME32 driver,RME96 driver,SonicVibes driver
   VIA82xx driver,ALI5451 driver,au88x0 driver,CS46xx driver
   EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver,KORG1212 driver
   MIXART driver,NM256 driver,RME HDSP driver,RME9652 driver
   Trident driver,Digigram VX222 driver,YMFPCI driver
   - removed superfluous warning messages after pci_module_init().
     (2.6 kernel doesn't return the error anyway...)
   - store card pointer in pci_drvdata instead of chip pointer.
     this would make easier to add PM support.

<perex@suse.cz> (04/04/24 1.1371.764.20)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   use wrapper function for usb_control_msg()
   to prevent DMA'ing from/to the stack

<perex@suse.cz> (04/04/24 1.1371.764.19)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   ALSA sequencer
   load snd-seq-dummy automatically, as documented in seq_dummy.c

<perex@suse.cz> (04/04/24 1.1371.764.18)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Trident driver,CS4231 driver,PARISC Harmony driver
   Remove all old SNDRV_DMA_TYPE_PCI references

<perex@suse.cz> (04/04/24 1.1371.764.17)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ALI5451 driver
   Clean up of power-management codes.
   
   - moved commonly used codes to the core layer.
   - using the unified suspend/resume callbacks for PCI and ISA
   - added snd_card_set_pm_callbacks() and snd_card_set_isa_pm_callbacks()
     as the registration functions.

<perex@suse.cz> (04/04/24 1.1371.764.16)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,Control Midlevel,ALSA Core,AD1848 driver,CS4231 driver
   CS46xx driver,Trident driver,YMFPCI driver,ES18xx driver,OPL3SA2 driver
   ATIIXP driver,CS4281 driver,ES1968 driver,Intel8x0 driver
   Intel8x0-modem driver,Maestro3 driver,ALI5451 driver,NM256 driver
   Sound Core PDAudioCF driver
   Clean up of power-management codes.
   
   - moved commonly used codes to the core layer.
   - using the unified suspend/resume callbacks for PCI and ISA
   - added snd_card_set_pm_callbacks() and snd_card_set_isa_pm_callbacks()
     as the registration functions.

<perex@suse.cz> (04/04/24 1.1371.764.15)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,SA11xx UDA1341 driver,Memalloc module,PCM Midlevel
   RawMidi Midlevel,RTC timer driver,ALSA Core,Timer Midlevel
   ALSA<-OSS emulation,ALSA sequencer,ALSA<-OSS sequencer,Generic drivers
   MPU401 UART,OPL3,OPL4,ALS100 driver,AZT2320 driver,CMI8330 driver
   DT019x driver,ES18xx driver,OPL3SA2 driver,Sound Galaxy driver
   Sound Scape driver,AD1816A driver,AD1848 driver,CS4231 driver
   CS4236+ driver,PC98(CS423x) driver,ES1688 driver,GUS Classic driver
   GUS Extreme driver,GUS MAX driver,AMD InterWave driver,Opti9xx drivers
   EMU8000 driver,ES968 driver,SB16/AWE driver,SB8 driver
   Wavefront drivers,PARISC Harmony driver,ALS4000 driver,ATIIXP driver
   AZT3328 driver,BT87x driver,CMIPCI driver,CS4281 driver
   ENS1370/1+ driver,ES1938 driver,ES1968 driver,FM801 driver
   Intel8x0 driver,Intel8x0-modem driver,Maestro3 driver,RME32 driver
   RME96 driver,SonicVibes driver,VIA82xx driver,AC97 Codec Core
   ALI5451 driver,au88x0 driver,CS46xx driver,EMU10K1/EMU10K2 driver
   ICE1712 driver,ICE1724 driver,KORG1212 driver,MIXART driver
   NM256 driver,RME HDSP driver,RME9652 driver,Trident driver
   Digigram VX222 driver,YMFPCI driver,Sound Core PDAudioCF driver
   Digigram VX Pocket driver,PPC PowerMac driver,SPARC AMD7930 driver
   SPARC cs4231 driver,USB generic driver
   use the new module_param*() functions.

<perex@suse.cz> (04/04/24 1.1371.764.14)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   AC97 Codec Core
   fix AC'97 revision bits on AD1985

<perex@suse.cz> (04/04/24 1.1371.764.13)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   AC97 Codec Core
   show AC'97 2.3 information in proc file

<perex@suse.cz> (04/04/24 1.1371.764.12)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Timer Midlevel,ALSA Core
   Added early event flag and code to the timer interface.

<perex@suse.cz> (04/04/24 1.1371.764.11)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   allow specification of rate_table in AUDIO_FIXED_ENDPOINT quirks

<perex@suse.cz> (04/04/24 1.1371.764.10)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   remove superfluous address operator from literal arrays

<perex@suse.cz> (04/04/24 1.1371.764.9)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   Intel8x0 driver
   20-bit sample format support

<perex@suse.cz> (04/04/24 1.1371.764.8)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   AC97 Codec Core
   fix access to wrong register when clearing powerdown bits

<perex@suse.cz> (04/04/24 1.1371.764.7)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   - fixed the possibl ac97 register cache mismatch.
   - added the detection of spdif sample rates.

<perex@suse.cz> (04/04/24 1.1371.764.6)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   ATIIXP driver
   - fixed SPDIF support.
     restricted only 48k sample rate.
   - fixed the address assignment for bigendian (not existing, though)

<perex@suse.cz> (04/04/24 1.1371.764.5)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   VIA82xx driver
   added dxs_support and ac97_quirk entries for Amira notebook.

<perex@suse.cz> (04/04/24 1.1371.764.4)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Version
   release: 1.0.4

<perex@suse.cz> (04/04/24 1.1371.764.3)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCMCIA Kconfig
   SND_PDAUDIOCF depends on SND_PCM

<perex@suse.cz> (04/04/24 1.1371.764.2)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   CS4281 driver
   Added retry_count

<perex@suse.cz> (04/04/01 1.1371.669.1)
   Fixed ALSA aureal driver compilation - wrong and missing PCI IDs


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
