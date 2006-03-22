Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWCVOmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWCVOmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWCVOmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:42:14 -0500
Received: from gate.perex.cz ([85.132.177.35]:26767 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1750706AbWCVOmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:42:13 -0500
Date: Wed, 22 Mar 2006 15:42:09 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ALSA 1.0.11rc4
Message-ID: <Pine.LNX.4.61.0603221540150.27433@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-03-22.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   71 
 Documentation/sound/alsa/Audiophile-Usb.txt                  |  333 +++
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    6 
 arch/arm/mach-pxa/mainstone.c                                |    4 
 drivers/media/video/cx88/cx88-alsa.c                         |   54 
 drivers/media/video/saa7134/saa7134-alsa.c                   |   65 
 drivers/media/video/saa7134/saa7134.h                        |    2 
 include/asm-arm/arch-pxa/audio.h                             |    4 
 include/linux/dma-mapping.h                                  |    1 
 include/sound/ac97_codec.h                                   |   15 
 include/sound/ad1848.h                                       |    2 
 include/sound/ak4531_codec.h                                 |    2 
 include/sound/core.h                                         |    8 
 include/sound/cs4231.h                                       |    4 
 include/sound/cs46xx.h                                       |    2 
 include/sound/emu10k1.h                                      |    4 
 include/sound/emux_synth.h                                   |    2 
 include/sound/gus.h                                          |    6 
 include/sound/hwdep.h                                        |    2 
 include/sound/i2c.h                                          |   10 
 include/sound/info.h                                         |    2 
 include/sound/mixer_oss.h                                    |    2 
 include/sound/opl3.h                                         |    3 
 include/sound/pcm.h                                          |    2 
 include/sound/pcm_oss.h                                      |    4 
 include/sound/rawmidi.h                                      |    4 
 include/sound/sb16_csp.h                                     |    2 
 include/sound/seq_instr.h                                    |    2 
 include/sound/soundfont.h                                    |    2 
 include/sound/util_mem.h                                     |    4 
 include/sound/version.h                                      |    4 
 include/sound/vx_core.h                                      |    2 
 include/sound/ymfpci.h                                       |   10 
 sound/arm/aaci.c                                             |   10 
 sound/arm/aaci.h                                             |    2 
 sound/arm/pxa2xx-ac97.c                                      |   12 
 sound/core/Kconfig                                           |   18 
 sound/core/control.c                                         |   39 
 sound/core/control_compat.c                                  |   33 
 sound/core/hwdep.c                                           |   43 
 sound/core/info.c                                            |   27 
 sound/core/info_oss.c                                        |   13 
 sound/core/init.c                                            |   44 
 sound/core/memalloc.c                                        |   56 
 sound/core/oss/copy.c                                        |    5 
 sound/core/oss/io.c                                          |    5 
 sound/core/oss/linear.c                                      |    7 
 sound/core/oss/mixer_oss.c                                   |   14 
 sound/core/oss/mulaw.c                                       |   24 
 sound/core/oss/pcm_oss.c                                     |   50 
 sound/core/oss/pcm_plugin.c                                  |  272 --
 sound/core/oss/pcm_plugin.h                                  |   30 
 sound/core/oss/plugin_ops.h                                  |  166 -
 sound/core/oss/rate.c                                        |   85 
 sound/core/oss/route.c                                       |  491 ----
 sound/core/pcm.c                                             |   45 
 sound/core/pcm_native.c                                      |   28 
 sound/core/rawmidi.c                                         |   57 
 sound/core/seq/oss/seq_oss.c                                 |   27 
 sound/core/seq/seq_clientmgr.c                               |   43 
 sound/core/seq/seq_clientmgr.h                               |    2 
 sound/core/seq/seq_device.c                                  |   53 
 sound/core/seq/seq_instr.c                                   |    6 
 sound/core/seq/seq_midi.c                                    |   20 
 sound/core/seq/seq_ports.c                                   |   12 
 sound/core/seq/seq_queue.c                                   |    6 
 sound/core/seq/seq_queue.h                                   |    2 
 sound/core/seq/seq_virmidi.c                                 |    4 
 sound/core/sound.c                                           |   27 
 sound/core/sound_oss.c                                       |   25 
 sound/core/timer.c                                           |   77 
 sound/drivers/dummy.c                                        |    4 
 sound/drivers/mpu401/mpu401.c                                |    4 
 sound/drivers/opl3/opl3_lib.c                                |    2 
 sound/drivers/opl3/opl3_oss.c                                |   12 
 sound/drivers/opl3/opl3_seq.c                                |   22 
 sound/drivers/opl3/opl3_synth.c                              |   10 
 sound/drivers/opl4/opl4_lib.c                                |    2 
 sound/drivers/opl4/opl4_local.h                              |    2 
 sound/drivers/opl4/opl4_proc.c                               |   10 
 sound/drivers/opl4/opl4_seq.c                                |   12 
 sound/drivers/serial-u16550.c                                |    5 
 sound/drivers/virmidi.c                                      |    4 
 sound/drivers/vx/vx_core.c                                   |    2 
 sound/drivers/vx/vx_mixer.c                                  |   72 
 sound/drivers/vx/vx_pcm.c                                    |   13 
 sound/i2c/cs8427.c                                           |    7 
 sound/i2c/i2c.c                                              |    2 
 sound/isa/ad1816a/ad1816a_lib.c                              |   15 
 sound/isa/ad1848/ad1848.c                                    |    4 
 sound/isa/ad1848/ad1848_lib.c                                |   18 
 sound/isa/cs423x/cs4231.c                                    |    4 
 sound/isa/cs423x/cs4231_lib.c                                |   30 
 sound/isa/cs423x/cs4236.c                                    |    4 
 sound/isa/cs423x/cs4236_lib.c                                |    6 
 sound/isa/es1688/es1688.c                                    |    4 
 sound/isa/es18xx.c                                           |  223 +-
 sound/isa/gus/gus_dma.c                                      |   10 
 sound/isa/gus/gus_main.c                                     |    2 
 sound/isa/gus/gus_mem.c                                      |   14 
 sound/isa/gus/gus_pcm.c                                      |    2 
 sound/isa/gus/gus_synth.c                                    |   14 
 sound/isa/gus/gusclassic.c                                   |    4 
 sound/isa/gus/gusextreme.c                                   |    4 
 sound/isa/gus/gusmax.c                                       |    4 
 sound/isa/gus/interwave.c                                    |    4 
 sound/isa/opl3sa2.c                                          |    4 
 sound/isa/opti9xx/opti92x-ad1848.c                           |    6 
 sound/isa/sb/sb16.c                                          |    4 
 sound/isa/sb/sb16_csp.c                                      |   12 
 sound/isa/sb/sb8.c                                           |    4 
 sound/isa/sb/sb_mixer.c                                      |    4 
 sound/isa/sgalaxy.c                                          |    4 
 sound/isa/wavefront/wavefront.c                              |    4 
 sound/mips/au1x00.c                                          |   42 
 sound/pci/ac97/ac97_codec.c                                  |   68 
 sound/pci/ac97/ac97_patch.c                                  |   40 
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/ac97/ac97_pcm.c                                    |    6 
 sound/pci/ac97/ac97_proc.c                                   |   14 
 sound/pci/ac97/ak4531_codec.c                                |   28 
 sound/pci/ad1889.c                                           |    7 
 sound/pci/atiixp.c                                           |   21 
 sound/pci/atiixp_modem.c                                     |   13 
 sound/pci/au88x0/au88x0.c                                    |   10 
 sound/pci/au88x0/au88x0.h                                    |   12 
 sound/pci/au88x0/au88x0_core.c                               |   12 
 sound/pci/au88x0/au88x0_eq.c                                 |   31 
 sound/pci/au88x0/au88x0_eq.h                                 |   31 
 sound/pci/au88x0/au88x0_eqdata.c                             |    6 
 sound/pci/au88x0/au88x0_mpu401.c                             |    4 
 sound/pci/au88x0/au88x0_synth.c                              |   10 
 sound/pci/au88x0/au88x0_wt.h                                 |   10 
 sound/pci/au88x0/au88x0_xtalk.c                              |   16 
 sound/pci/au88x0/au88x0_xtalk.h                              |   12 
 sound/pci/bt87x.c                                            |   13 
 sound/pci/cmipci.c                                           |   25 
 sound/pci/cs46xx/cs46xx_lib.c                                |   52 
 sound/pci/cs46xx/dsp_spos.c                                  |   68 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                          |    6 
 sound/pci/cs5535audio/cs5535audio.c                          |    6 
 sound/pci/emu10k1/emu10k1_main.c                             |   13 
 sound/pci/emu10k1/emu10k1_synth.c                            |    1 
 sound/pci/emu10k1/emu10k1x.c                                 |   13 
 sound/pci/emu10k1/emufx.c                                    |   22 
 sound/pci/emu10k1/memory.c                                   |   26 
 sound/pci/ens1370.c                                          |   39 
 sound/pci/es1968.c                                           |   27 
 sound/pci/hda/hda_codec.c                                    |  140 +
 sound/pci/hda/hda_codec.h                                    |    4 
 sound/pci/hda/hda_generic.c                                  |  128 -
 sound/pci/hda/hda_intel.c                                    |  122 -
 sound/pci/hda/hda_local.h                                    |    9 
 sound/pci/hda/patch_analog.c                                 |  599 +++++
 sound/pci/hda/patch_realtek.c                                | 1120 +++++++++--
 sound/pci/hda/patch_sigmatel.c                               |  251 ++
 sound/pci/ice1712/aureon.c                                   |  130 -
 sound/pci/ice1712/aureon.h                                   |    8 
 sound/pci/ice1712/delta.c                                    |   62 
 sound/pci/ice1712/hoontech.c                                 |   26 
 sound/pci/ice1712/ice1712.c                                  |   68 
 sound/pci/ice1712/ice1712.h                                  |   11 
 sound/pci/ice1712/ice1724.c                                  |   37 
 sound/pci/ice1712/phase.c                                    |   10 
 sound/pci/ice1712/pontis.c                                   |   86 
 sound/pci/intel8x0.c                                         |  151 -
 sound/pci/korg1212/korg1212.c                                |   17 
 sound/pci/maestro3.c                                         |    5 
 sound/pci/mixart/mixart.c                                    |   24 
 sound/pci/mixart/mixart.h                                    |    7 
 sound/pci/mixart/mixart_core.c                               |   18 
 sound/pci/mixart/mixart_mixer.c                              |   52 
 sound/pci/nm256/nm256.c                                      |  136 +
 sound/pci/pcxhr/pcxhr.c                                      |   39 
 sound/pci/pcxhr/pcxhr.h                                      |    5 
 sound/pci/pcxhr/pcxhr_core.c                                 |    2 
 sound/pci/pcxhr/pcxhr_mixer.c                                |   75 
 sound/pci/rme9652/hdspm.c                                    |    4 
 sound/pci/trident/trident_memory.c                           |   36 
 sound/pci/via82xx.c                                          |    2 
 sound/pci/vx222/vx222_ops.c                                  |   18 
 sound/pci/ymfpci/ymfpci.c                                    |    5 
 sound/pci/ymfpci/ymfpci_main.c                               |   38 
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c                       |    7 
 sound/pcmcia/vx/vxp_mixer.c                                  |   12 
 sound/sparc/cs4231.c                                         |   34 
 sound/synth/emux/emux.c                                      |    2 
 sound/synth/emux/emux_oss.c                                  |   12 
 sound/synth/emux/emux_proc.c                                 |    8 
 sound/synth/emux/emux_seq.c                                  |   12 
 sound/synth/emux/soundfont.c                                 |    6 
 sound/synth/util_mem.c                                       |   15 
 sound/usb/usbaudio.c                                         |  168 +
 sound/usb/usbaudio.h                                         |    4 
 sound/usb/usbmidi.c                                          |   10 
 sound/usb/usbmixer.c                                         |    2 
 sound/usb/usbmixer_maps.c                                    |   20 
 sound/usb/usbquirks.h                                        |  103 -
 sound/usb/usx2y/usbusx2y.c                                   |    2 
 sound/usb/usx2y/usbusx2y.h                                   |    2 
 sound/usb/usx2y/usbusx2yaudio.c                              |    8 
 sound/usb/usx2y/usx2yhwdeppcm.c                              |   12 
 202 files changed, 4943 insertions(+), 2759 deletions(-)


The following things were done:

Adrian Bunk:
      [ALSA] sound/core/: fix 3 off-by-one errors
      [ALSA] sound/pci/rme9652/hdspm.c: fix off-by-one errors
      [ALSA] fix some memory leaks
      [ALSA] sound/pci/ice1712/delta.c: make 2 functions static

Alan Horstmann:
      [ALSA] ice1712 - disable unused ADCs & DACs on DMX6fire
      [ALSA] ice1712 - typo fixes for dxr_enable module option

Alexey Dobriyan:
      [ALSA] vx - Fix memory leak on error path

Brent Cook:
      [ALSA] Add support for EDIROL UM-3ex

Charl Coetzee:
      [ALSA] ac97 - Added a codec patch for LM4550

Clemens Ladisch:
      [ALSA] usb-audio: cosmetic changes
      [ALSA] usb-audio: factor out packet size calculation code
      [ALSA] ymfpci: fix swapped channels in SPDIF output
      [ALSA] usb-audio: add Edirol PC-50 support
      [ALSA] usb-audio: add Roland G-70 support
      [ALSA] usb-audio: fix number of G-70 ports
      [ALSA] usb-audio: add UM-1EX/UM-2EX information
      [ALSA] usb-audio: rename QUIRK_MIDI_MIDITECH to QUIRK_MIDI_CME
      [ALSA] usb-audio: add Miditech Play'n Roll support
      [ALSA] usb-audio: optimize snd_usbmidi_count_bits()
      [ALSA] return ENODEV for disconnected devices
      [ALSA] usb-audio: add Casio AP-80R support
      [ALSA] usb-audio: show USB error descriptions
      [ALSA] usb-audio: change Casio quirk product name
      [ALSA] bt87x: add more DVB card IDs
      [ALSA] usb-audio: add error message about missing split iso support
      [ALSA] usb-audio: add MDP-5/EZ-J24 support
      [ALSA] usb-audio: add Casio PL-40R support
      [ALSA] usb-audio: add Maya44 mixer control names

Dave Jones:
      [ALSA] fix usbmixer double kfree
      [ALSA] emu10k1_synth use after free
      [ALSA] sound/isa/sb/sb_mixer.c double kfree
      [ALSA] ad1848 double free
      [ALSA] Fix use after free in opl3_seq and opl3_oss

David Vrabel:
      [ALSA] CS5535: shorter delays when accessing AC'97 codec registers

Doug McLain:
      [ALSA] ice1712 - Fix wordclock status on Delta1010LT

Eugene Teo:
      [ALSA] Fix seq_clientmgr dereferences before NULL check
      [ALSA] Fix gus_pcm dereference before NULL

Florian Schlichting:
      [ALSA] Fix NM256 hard lock up

Giuliano Pochini:
      [ALSA] make control.c suspend aware

Ingo Molnar:
      [ALSA] semaphore -> mutex (core part)
      [ALSA] semaphore -> mutex (driver part)
      [ALSA] semaphore -> mutex (ISA part)
      [ALSA] semaphore -> mutex (PCI part)
      [ALSA] semaphore -> mutex (Archs, misc buses)

Jaroslav Kysela:
      [ALSA] PCM midlevel & PCM OSS - make procfs & OSS plugin code optional
      [ALSA] ymfpci - make rear channel swap optional
      [ALSA] snd_pcm_format_name() is no longer exported
      [ALSA] ice1712 & cs8427 - fix problem for S/PDIF input setup
      [ALSA] bt848 - added Leadtek Winfast tv 2000xp delux to whitelist
      [ALSA] ice1712 - Delta 1010LT S/PDIF fixes
      [ALSA] intel8x0 - wait for ICH_RESETREGS
      [ALSA] version 1.0.11rc4

Jesper Juhl:
      [ALSA] no need to check pointers passed to vfree() for NULL
      [ALSA] Don't NULL check vfree argument in pdaudiocf_pcm.c
      [ALSA] fix resource leak in usbmixer

Jonathan Woithe:
      [ALSA] hda: add PCM for 2nd ADC on ALC260
      [ALSA] hda: ALC260 test model implementation
      [ALSA] HDA/ALC260: 1/7 - Fix test model input mux label
      [ALSA] HDA/ALC260: 2/7 - switch pin buffer enables
      [ALSA] HDA/ALC260: 3/7 - generalise some structures
      [ALSA] HDA/ALC260: 4/7 - add GPIO switches to test model
      [ALSA] HDA/ALC260: 5/7 - add 'acer' model
      [ALSA] HDA/ALC260: 6/7 - Fujitsu/test model tweaks
      [ALSA] HDA/ALC260: 7/7 - add SPDIF enable to test model

Ken Arromdee:
      [ALSA] ad1816a - Fix PCM trigger direction

Mark Salazar:
      [ALSA] #1/4 for Zoom Video - resolve common vs chipset specific mixer controls
      [ALSA] #2/4 for Zoom Video - resolve number of record sources
      [ALSA] #3/4 for Zoom Video - change Hardware Volume interrupt handling
      [ALSA] #4/4 for Zoom Video - add Zoom Video support

Sergei Shtylylov:
      [ALSA] AMD Au1x00: make driver build after cleanup

Sergei Shtylyov:
      [ALSA] AMD Au1x00: fix DMA init/cleanup
      [ALSA] AMD Au1x00: AC'97 controller is memory mapped

Takashi Iwai:
      [ALSA] pcxhr - Suppress debug messages
      [ALSA] ens1370 - Fix resume
      [ALSA] intel8x0 - Fix/cleanup detection of codecs on SIS7012
      [ALSA] hda-intel - Add single_cmd option for debugging
      [ALSA] Fix a typo
      [ALSA] Clean up pcm-oss plugins
      [ALSA] ice1724 - Add support of Prodigy-7.1LT
      [ALSA] Update description of ice1724 driver
      [ALSA] au88x0 - 64bit arch fixes
      [ALSA] Fix snd_xxx_t typedefs
      [ALSA] au88x0 - Fix structs for equalizer
      [ALSA] Add the notes on PM to ens1370/ens1371 sections
      [ALSA] Fix mulaw -> linear conversion in OSS PCM emulation
      [ALSA] Use dma_alloc_coherent() hack on i386 only
      [ALSA] Removed unneeded page-reserve
      [ALSA] ac97 - Add support of static resolution tables
      [ALSA] hda: minor correction to fujitsu ALC260 initverbs
      [ALSA] via82xx - Add dxs entry for FSC Amilo L7300
      [ALSA] ac97 - Remove duplicated entry in lm4550_restbl
      [ALSA] hda-codec - Add missing model entries for Intel 945 boards
      [ALSA] hda-intel - Automatic correction to single_cmd mode
      [ALSA] hda-intel - Auto-correction of the DMA position mode
      [ALSA] Fix check of enable module option
      [ALSA] pcm - Move PAUSE ioctl to common ioctl handler
      [ALSA] Fix sleep in atomic in virmidi driver
      [ALSA] cs4236 - Fix a typo
      [ALSA] opti9x - Fix compile without CONFIG_PNP
      [ALSA] hda-codec - Fix ALC262 for Fujitsu laptop
      [ALSA] Update description of hda-intel models
      [ALSA] via82xx - Add dxs entry for ASRock mobo
      [ALSA] hda-codec - Fix AD198x recording and add HP model
      [ALSA] Fix missing AD1986a capsrc
      [ALSA] Fix typos in document
      [ALSA] hda-codec - Add lg model for LG laptop
      [ALSA] emu10k1 - Add the entry for Audigy4 SB0400
      [ALSA] Add default entry for CTL Travel Master U553W
      [ALSA] hda-codec - Fix support of laptops with AD1986A codec
      [ALSA] hda-codec - Fix Aopen i915GMm-HFS mobo
      [ALSA] ac97 - Allow drivers to set static volume resolution table
      [ALSA] ac97 - Clean up obsolete workarounds
      [ALSA] hda-codec - Add model entry for FIC P4M-915GD1
      [ALSA] hda-codec - Add support for VAIO FE550G and SZ110
      [ALSA] hda-codec - Fix for Samsung R65 and ASUS A6J
      [ALSA] ice1712 - Fix wrong value types for enum items
      [ALSA] hda-codec - Fix BIOS auto-configuration
      [ALSA] hda-codec - Fix generic auto-configurator
      [ALSA] Fix memory leaks in error path of control.c
      [ALSA] hda-codec - Add support for HP nx9420 laptop
      [ALSA] hda-codec - Add support for ASUS P4GPL-X

Thibault LE MEUR:
      [ALSA] Fixes audiophile usb analog capture with the new device_setup parameter
      [ALSA] Fixes typos in Audiophile-USB.txt

Tobias Klauser:
      Intruduce DMA_28BIT_MASK


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
