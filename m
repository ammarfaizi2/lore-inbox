Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWFVTm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWFVTm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWFVTm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:42:28 -0400
Received: from gate.perex.cz ([85.132.177.35]:36578 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932164AbWFVTm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:42:26 -0400
Date: Thu, 22 Jun 2006 21:42:23 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA PATCH] HG repo - 1.0.12rc1
Message-ID: <Pine.LNX.4.61.0606221704040.9048@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-06-22.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   19 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   50 
 include/sound/ac97_codec.h                                   |    1 
 include/sound/asequencer.h                                   |    4 
 include/sound/asound.h                                       |    2 
 include/sound/core.h                                         |    3 
 include/sound/emu10k1.h                                      |    2 
 include/sound/info.h                                         |   11 
 include/sound/mpu401.h                                       |   14 
 include/sound/pcm.h                                          |   19 
 include/sound/pcm_params.h                                   |  125 -
 include/sound/rawmidi.h                                      |    3 
 include/sound/version.h                                      |    4 
 sound/Kconfig                                                |    2 
 sound/Makefile                                               |    2 
 sound/aoa/Kconfig                                            |   17 
 sound/aoa/Makefile                                           |    4 
 sound/aoa/aoa-gpio.h                                         |   81 
 sound/aoa/aoa.h                                              |  131 +
 sound/aoa/codecs/Kconfig                                     |   32 
 sound/aoa/codecs/Makefile                                    |    3 
 sound/aoa/codecs/snd-aoa-codec-onyx.c                        | 1113 +++++++++++
 sound/aoa/codecs/snd-aoa-codec-onyx.h                        |   76 
 sound/aoa/codecs/snd-aoa-codec-tas-gain-table.h              |  209 ++
 sound/aoa/codecs/snd-aoa-codec-tas.c                         |  654 ++++++
 sound/aoa/codecs/snd-aoa-codec-tas.h                         |   47 
 sound/aoa/codecs/snd-aoa-codec-toonie.c                      |  141 +
 sound/aoa/core/Makefile                                      |    5 
 sound/aoa/core/snd-aoa-alsa.c                                |   98 
 sound/aoa/core/snd-aoa-alsa.h                                |   16 
 sound/aoa/core/snd-aoa-core.c                                |  162 +
 sound/aoa/core/snd-aoa-gpio-feature.c                        |  399 +++
 sound/aoa/core/snd-aoa-gpio-pmf.c                            |  246 ++
 sound/aoa/fabrics/Kconfig                                    |   12 
 sound/aoa/fabrics/Makefile                                   |    1 
 sound/aoa/fabrics/snd-aoa-fabric-layout.c                    | 1109 ++++++++++
 sound/aoa/soundbus/Kconfig                                   |   14 
 sound/aoa/soundbus/Makefile                                  |    3 
 sound/aoa/soundbus/core.c                                    |  250 ++
 sound/aoa/soundbus/i2sbus/Makefile                           |    2 
 sound/aoa/soundbus/i2sbus/i2sbus-control.c                   |  192 +
 sound/aoa/soundbus/i2sbus/i2sbus-control.h                   |   37 
 sound/aoa/soundbus/i2sbus/i2sbus-core.c                      |  387 +++
 sound/aoa/soundbus/i2sbus/i2sbus-interface.h                 |  187 +
 sound/aoa/soundbus/i2sbus/i2sbus-pcm.c                       | 1021 ++++++++++
 sound/aoa/soundbus/i2sbus/i2sbus.h                           |  112 +
 sound/aoa/soundbus/soundbus.h                                |  202 +
 sound/aoa/soundbus/sysfs.c                                   |   43 
 sound/arm/sa11xx-uda1341.c                                   |   16 
 sound/core/control.c                                         |   31 
 sound/core/device.c                                          |    6 
 sound/core/hwdep.c                                           |    1 
 sound/core/info.c                                            |  178 +
 sound/core/info_oss.c                                        |    3 
 sound/core/init.c                                            |   78 
 sound/core/isadma.c                                          |    6 
 sound/core/memory.c                                          |    5 
 sound/core/misc.c                                            |    6 
 sound/core/oss/mixer_oss.c                                   |    2 
 sound/core/oss/pcm_oss.c                                     |  529 +++++
 sound/core/pcm.c                                             |   90 
 sound/core/pcm_compat.c                                      |    4 
 sound/core/pcm_lib.c                                         |  725 -------
 sound/core/pcm_memory.c                                      |   14 
 sound/core/pcm_misc.c                                        |   24 
 sound/core/pcm_native.c                                      |  113 -
 sound/core/rawmidi.c                                         |    3 
 sound/core/seq/oss/seq_oss.c                                 |    1 
 sound/core/seq/seq.c                                         |   22 
 sound/core/seq/seq_clientmgr.c                               |   12 
 sound/core/seq/seq_device.c                                  |    3 
 sound/core/seq/seq_dummy.c                                   |    6 
 sound/core/seq/seq_info.c                                    |   11 
 sound/core/seq/seq_lock.c                                    |    2 
 sound/core/seq/seq_memory.c                                  |    3 
 sound/core/seq/seq_midi.c                                    |   11 
 sound/core/seq/seq_ports.c                                   |    5 
 sound/core/seq/seq_virmidi.c                                 |    4 
 sound/core/sound.c                                           |  109 -
 sound/core/sound_oss.c                                       |    9 
 sound/core/timer.c                                           |    6 
 sound/drivers/dummy.c                                        |    4 
 sound/drivers/mpu401/mpu401.c                                |    4 
 sound/drivers/mpu401/mpu401_uart.c                           |  186 +
 sound/drivers/mtpav.c                                        |   14 
 sound/drivers/opl3/opl3_lib.c                                |   19 
 sound/drivers/opl3/opl3_oss.c                                |    3 
 sound/drivers/opl3/opl3_seq.c                                |    4 
 sound/drivers/opl3/opl3_synth.c                              |    4 
 sound/drivers/opl4/opl4_lib.c                                |   12 
 sound/drivers/opl4/opl4_seq.c                                |    4 
 sound/drivers/serial-u16550.c                                |    4 
 sound/drivers/virmidi.c                                      |    4 
 sound/drivers/vx/vx_core.c                                   |   32 
 sound/drivers/vx/vx_hwdep.c                                  |    3 
 sound/i2c/i2c.c                                              |   17 
 sound/i2c/l3/uda1341.c                                       |    4 
 sound/isa/gus/gus_irq.c                                      |    2 
 sound/isa/gus/gus_mem.c                                      |    6 
 sound/isa/gus/gus_synth.c                                    |    4 
 sound/isa/gus/interwave.c                                    |    4 
 sound/isa/opl3sa2.c                                          |   12 
 sound/isa/opti9xx/miro.c                                     |    2 
 sound/isa/sb/emu8000.c                                       |   22 
 sound/isa/sb/emu8000_patch.c                                 |    2 
 sound/isa/sb/sb16.c                                          |    2 
 sound/isa/sb/sb16_csp.c                                      |    2 
 sound/isa/sb/sb8_midi.c                                      |   20 
 sound/isa/sscape.c                                           |    3 
 sound/isa/wavefront/wavefront.c                              |    2 
 sound/pci/Kconfig                                            |    9 
 sound/pci/ac97/ac97_codec.c                                  |   61 
 sound/pci/ac97/ac97_patch.c                                  |   19 
 sound/pci/ac97/ac97_pcm.c                                    |   10 
 sound/pci/ac97/ac97_proc.c                                   |    5 
 sound/pci/ac97/ak4531_codec.c                                |    2 
 sound/pci/ad1889.c                                           |    2 
 sound/pci/ali5451/ali5451.c                                  |    4 
 sound/pci/als4000.c                                          |    4 
 sound/pci/atiixp.c                                           |    2 
 sound/pci/atiixp_modem.c                                     |    2 
 sound/pci/au88x0/au88x0.c                                    |   12 
 sound/pci/au88x0/au88x0_mpu401.c                             |   11 
 sound/pci/au88x0/au88x0_xtalk.c                              |   29 
 sound/pci/azt3328.c                                          |  234 +-
 sound/pci/azt3328.h                                          |   36 
 sound/pci/bt87x.c                                            |    8 
 sound/pci/ca0106/ca0106.h                                    |    4 
 sound/pci/ca0106/ca0106_main.c                               |   57 
 sound/pci/ca0106/ca0106_mixer.c                              |  181 +
 sound/pci/ca0106/ca0106_proc.c                               |   17 
 sound/pci/cmipci.c                                           |   10 
 sound/pci/cs4281.c                                           |   16 
 sound/pci/cs46xx/cs46xx.c                                    |    4 
 sound/pci/cs46xx/cs46xx_lib.c                                |    5 
 sound/pci/cs46xx/dsp_spos.c                                  |    7 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                          |    1 
 sound/pci/cs5535audio/Makefile                               |    4 
 sound/pci/cs5535audio/cs5535audio.c                          |   41 
 sound/pci/cs5535audio/cs5535audio.h                          |    8 
 sound/pci/cs5535audio/cs5535audio_pcm.c                      |   24 
 sound/pci/cs5535audio/cs5535audio_pm.c                       |  123 +
 sound/pci/emu10k1/emu10k1.c                                  |    8 
 sound/pci/emu10k1/emu10k1_main.c                             |   69 
 sound/pci/emu10k1/emu10k1x.c                                 |    3 
 sound/pci/emu10k1/emumixer.c                                 |   54 
 sound/pci/emu10k1/emuproc.c                                  |   27 
 sound/pci/emu10k1/io.c                                       |    4 
 sound/pci/emu10k1/memory.c                                   |    8 
 sound/pci/emu10k1/p17v.h                                     |  111 +
 sound/pci/emu10k1/tina2.h                                    |    8 
 sound/pci/emu10k1/voice.c                                    |    4 
 sound/pci/ens1370.c                                          |    2 
 sound/pci/es1938.c                                           |    3 
 sound/pci/es1968.c                                           |    5 
 sound/pci/fm801.c                                            |    5 
 sound/pci/hda/Makefile                                       |    2 
 sound/pci/hda/hda_codec.c                                    |   41 
 sound/pci/hda/hda_intel.c                                    |   20 
 sound/pci/hda/hda_patch.h                                    |    3 
 sound/pci/hda/hda_proc.c                                     |    6 
 sound/pci/hda/patch_analog.c                                 |   61 
 sound/pci/hda/patch_atihdmi.c                                |  165 +
 sound/pci/hda/patch_realtek.c                                |   30 
 sound/pci/hda/patch_sigmatel.c                               |   82 
 sound/pci/ice1712/aureon.c                                   |   26 
 sound/pci/ice1712/aureon.h                                   |    1 
 sound/pci/ice1712/ews.c                                      |    3 
 sound/pci/ice1712/ice1712.c                                  |   43 
 sound/pci/ice1712/ice1712.h                                  |    5 
 sound/pci/ice1712/ice1724.c                                  |    5 
 sound/pci/ice1712/pontis.c                                   |    8 
 sound/pci/intel8x0.c                                         |   10 
 sound/pci/intel8x0m.c                                        |    4 
 sound/pci/korg1212/korg1212.c                                |    2 
 sound/pci/maestro3.c                                         |    3 
 sound/pci/mixart/mixart.c                                    |    1 
 sound/pci/pcxhr/pcxhr.c                                      |    4 
 sound/pci/riptide/riptide.c                                  |    6 
 sound/pci/rme32.c                                            |   14 
 sound/pci/rme96.c                                            |   44 
 sound/pci/rme9652/hdsp.c                                     |    7 
 sound/pci/rme9652/hdspm.c                                    |    2 
 sound/pci/rme9652/rme9652.c                                  |    4 
 sound/pci/sonicvibes.c                                       |    8 
 sound/pci/trident/trident.c                                  |    3 
 sound/pci/trident/trident_main.c                             |   22 
 sound/pci/trident/trident_memory.c                           |    3 
 sound/pci/trident/trident_synth.c                            |    4 
 sound/pci/via82xx.c                                          |   12 
 sound/pci/via82xx_modem.c                                    |    2 
 sound/pci/ymfpci/ymfpci.c                                    |    3 
 sound/pci/ymfpci/ymfpci_main.c                               |    2 
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c                      |    2 
 sound/pcmcia/vx/vxp_ops.c                                    |    2 
 sound/pcmcia/vx/vxpocket.c                                   |    2 
 sound/ppc/Makefile                                           |    2 
 sound/ppc/pmac.c                                             |   44 
 sound/ppc/pmac.h                                             |    3 
 sound/ppc/powermac.c                                         |   21 
 sound/ppc/toonie.c                                           |  378 ---
 sound/sparc/dbri.c                                           |    8 
 sound/synth/emux/emux.c                                      |   12 
 sound/synth/emux/emux_proc.c                                 |    1 
 sound/synth/emux/emux_seq.c                                  |    3 
 sound/synth/emux/emux_synth.c                                |    5 
 sound/synth/emux/soundfont.c                                 |    6 
 sound/usb/usbaudio.c                                         |   15 
 sound/usb/usbaudio.h                                         |    7 
 sound/usb/usbmidi.c                                          |  202 +
 sound/usb/usbmixer.c                                         |   70 
 sound/usb/usx2y/usx2yhwdeppcm.c                              |    2 
 212 files changed, 10139 insertions(+), 2276 deletions(-)


The following things were done:

Alan Horstmann:
      [ALSA] Change seq_midi.c so client name is card, rather than port, specific
      [ALSA] ice1712 - Provides specified midi port names instead of defaults
      [ALSA] au88x0 - Init before create components
      [ALSA] Remove ENTER_UART from au88x0 init
      [ALSA] ice1712 - Disable AC97 for DMX6fire
      [ALSA] ice1712 - Set mpu401 info flags from _card_info

Andreas Mohr:
      [ALSA] azt3328.c: add suspend/resume support
      [ALSA] azt3328.c: add 3D sound mixer switch/rename controls
      [ALSA] azt3328.c: use kernel coding style

Ben Williamson:
      [ALSA] USB midi: Remove duplicate CS_AUDIO_* #defines

Clemens Ladisch:
      [ALSA] fix a wrong lock
      [ALSA] fix port type bits
      [ALSA] add more sequencer port type information bits
      [ALSA] rawmidi: add get_port_info callback for sequencer information flags
      [ALSA] usb-audio: add workaround for CSR Bluetooth Headphones (Saitek A-250)
      [ALSA] bt87x: add Voodoo TV 200 whitelist entry
      [ALSA] virmidi: revert erroneous removal of zero initialization

Daniel T Chen:
      [ALSA] sound/pci/: Add hp_only quirk for Dell D800 laptops
      [ALSA] Add hp_only quirk for pci id [161f:2032] to via82xx
      [ALSA] HDA - Lenovo 3000 N100-07684JU - enable laptop-eapd by default

Eric Sesterhenn:
      [ALSA] NULL pointer dereference in sound/synth/emux/soundfont.c

Felix Kuehling:
      [ALSA] hda - Add support for the ATI RS600 HDMI audio device

James Courtier-Dutton:
      [ALSA] ca0106: Add analog capture controls.
      [ALSA] emu10k1: Add support for Audigy4 (not Pro)
      [ALSA] Add p17v.h file.
      [ALSA] ca0106: Fixes MSI K8N's SB Live 24 bit, no sound from line-in.
      [ALSA] AC97: Correct Mic Boost label.
      [ALSA] snd-ca0106: Update playback to 24bit. Fix typo is comment.

Jaroslav Kysela:
      [ALSA] aoa driver - Kconfig - remove spaces for SND!=n
      [ALSA] version 1.0.12rc1

Jaya Kumar:
      [ALSA] PM support for cs5535audio
      [ALSA] Single variables for cs5535audio
      [ALSA] ac97_codec - fix duplicate control creation in AC97
      [ALSA] cs5535audio - trivial debug printk
      [ALSA] AD1888 suspend/resume fix

Jesper Juhl:
      [ALSA] fix potential NULL pointer deref in snd_sb8dsp_midi_interrupt()

Johannes Berg:
      [ALSA] snd-aoa: add snd-aoa
      [ALSA] snd-powermac: no longer handle anything with a layout-id property

Karsten Wiese:
      [ALSA] via82xx - Default to variable samplerate enabled for MSI K8T Neo2-FI

Kenneth Crudup:
      [ALSA] hda-codec - Add support for Sony Vaio VGN-A790 laptop

Matt Porter:
      [ALSA] hda: add sigmatel 9227/9228/9229 ids

Raimonds Cicans:
      [ALSA] add support for SB Live! 24-Bit External remote control

Randy Dunlap:
      [ALSA] sound/vxpocket: fix printk warning

Remy Bruno:
      [ALSA] RME HDSP - fixed proc interface (missing {})

Rene Herman:
      [ALSA] unregister platform device again if probe was unsuccessful

Rodolfo Giometti:
      [ALSA] Disable AC97 AUX and VIDEO controls for WM9705 touchscreen

Sam Revitch:
      [ALSA] hda-codec - Add support for Apple Mac Mini (early 2006)

Takashi Iwai:
      [ALSA] vxpocket - Fix a typo
      [ALSA] hda-codec - Add Thinkpad X60/T60/Z60 support
      [ALSA] hda-codec - Fix a typo
      [ALSA] Clean up ugly hacks in pcm_params.h
      [ALSA] Clean up EXPORT_SYMBOL()s in snd module
      [ALSA] Clean up EXPORT_SYMBOL()s in snd-seq module
      [ALSA] ac97 - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] opl3 - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] opl4 - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] emu10k1 - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] trident - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] emux - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] vx - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] i2c - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] hda-codec - Move EXPORT_SYMBOL() to adjacent to each function
      [ALSA] Move OSS-specific hw_params helper to snd-pcm-oss module
      [ALSA] Clean up ugly hacks in pcm_lib.c
      [ALSA] Make buffer size of proc text interface variable
      [ALSA] Remove unneeded read/write_size fields in proc text ops
      [ALSA] Remove spinlocks around proc prints
      [ALSA] Insert might_sleep() in snd_iprintf()
      [ALSA] Add O_APPEND flag support to PCM
      [ALSA] Fix mmap_count with O_APPEND opened streams
      [ALSA] Fix compile warning in timer.c
      [ALSA] hda-codec - Add support for LG S1 laptop
      [ALSA] Add a workaround for ASUS A6KM
      [ALSA] cs5535audio - Add missing module_param*() and MODULE_PARM_DESC()
      [ALSA] hda-codec - Fix mute switch on VAIO laptops with STAC7661
      [ALSA] Fix a typo in writing-an-alsa-driver document
      [ALSA] cmipci - Disable integrated mpu401 as default
      [ALSA] rme96 - Fix OSS full-duplex
      [ALSA] hda-codec - Add support for Sony Vaio VGN-S3HP
      [ALSA] Remove obsolete description from ALSA-Configuration.txt
      [ALSA] hda-codec - Fix handling of capture controls on ALC882 3/6-stack models
      [ALSA] Fix rwlock around snd_iprintf() in sound core
      [ALSA] Fix description of snd-hda-intel driver in document
      [ALSA] Fix pcm-draining of capture stream in PCM middle layer
      [ALSA] Remove zero-initialization of static variables
      [ALSA] hda-codec - Fix init verbs for ALC260 hp model
      [ALSA] usbaudio - Fix a typo
      [ALSA] mpu401_uart - Fix coding style and code clean up
      [ALSA] Fix description of cs5535audio driver in ALSA-Configuration.txt
      [ALSA] hdsp - Fix compilation with hdsp driver built in kernel
      [ALSA] Change an arugment of snd_mpu401_uart_new() to bit flags
      [ALSA] au88x0 - Fix 64bit address of MPU401 MMIO port
      [ALSA] ice1724 - Add functionality for Audiotrak Prodigy 7.1 LT
      [ALSA] hda-codec - Fix model for HP dc7600
      [ALSA] cmipci - Fix a typo in 'PC Speaker Playback Switch' control
      [ALSA] hda-intel - Fix race in remove
      [ALSA] Fix possible races in PCI driver removal
      [ALSA] ac97 - Add Thinkpad T41p to AD1981 jack-sense blacklist
      [ALSA] hda-codec - Add model entry for HP nx6320
      [ALSA] Fix races in irq handler and ioremap
      [ALSA] Remove bogus check of mmap_count in snd_pcm_release()
      [ALSA] Fix invalid __init in ALSA ISA drivers
      [ALSA] hda-codec - Add SPDIF support to Thinkpad T/X/Z60
      [ALSA] hda-codec - Use 3stack model for ASUS P5RD2-VM / P5GPL-X SE
      [ALSA] Remove ppc/toonie.c
      [ALSA] Remove nested mutexes in seq_ports.c
      [ALSA] hda-codec - Show EAPD and pin-detection capabilities in proc

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
