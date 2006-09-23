Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWIWJXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWIWJXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 05:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIWJXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 05:23:54 -0400
Received: from gate.perex.cz ([85.132.177.35]:12683 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751379AbWIWJXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 05:23:53 -0400
Date: Sat, 23 Sep 2006 11:23:50 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103-a.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] alsa-git merge request
Message-ID: <Pine.LNX.4.61.0609231118020.9393@tm8103-a.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
  (linus branch)

The GNU path is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-09-23.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   44 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    5 
 include/sound/ac97_codec.h                                   |   32 
 include/sound/ad1848.h                                       |   22 
 include/sound/ak4xxx-adda.h                                  |   37 
 include/sound/asound.h                                       |   19 
 include/sound/control.h                                      |   13 
 include/sound/core.h                                         |   10 
 include/sound/emu10k1.h                                      |    4 
 include/sound/info.h                                         |    7 
 include/sound/pcm.h                                          |    4 
 include/sound/timer.h                                        |    1 
 include/sound/tlv.h                                          |   60 
 include/sound/vx_core.h                                      |    1 
 sound/aoa/codecs/Kconfig                                     |    4 
 sound/aoa/codecs/snd-aoa-codec-tas.c                         |   96 
 sound/core/control.c                                         |  160 +
 sound/core/control_compat.c                                  |    4 
 sound/core/device.c                                          |   20 
 sound/core/hwdep.c                                           |   12 
 sound/core/info.c                                            |  108 -
 sound/core/info_oss.c                                        |    6 
 sound/core/init.c                                            |  116 -
 sound/core/oss/mixer_oss.c                                   |   22 
 sound/core/oss/pcm_oss.c                                     |   24 
 sound/core/pcm.c                                             |  128 -
 sound/core/pcm_compat.c                                      |    2 
 sound/core/pcm_memory.c                                      |    2 
 sound/core/pcm_native.c                                      |   49 
 sound/core/rawmidi.c                                         |   38 
 sound/core/rtctimer.c                                        |    2 
 sound/core/seq/oss/seq_oss.c                                 |    3 
 sound/core/seq/seq_device.c                                  |   13 
 sound/core/seq/seq_info.c                                    |    6 
 sound/core/sound.c                                           |   59 
 sound/core/sound_oss.c                                       |    3 
 sound/core/timer.c                                           |   62 
 sound/drivers/Kconfig                                        |   13 
 sound/drivers/Makefile                                       |    2 
 sound/drivers/dummy.c                                        |   20 
 sound/drivers/mpu401/mpu401.c                                |    2 
 sound/drivers/mts64.c                                        | 1091 +++++++++++
 sound/drivers/opl4/opl4_proc.c                               |    9 
 sound/drivers/vx/vx_mixer.c                                  |   17 
 sound/i2c/other/ak4xxx-adda.c                                |  501 ++---
 sound/isa/ad1816a/ad1816a_lib.c                              |   55 
 sound/isa/ad1848/ad1848_lib.c                                |   49 
 sound/isa/es18xx.c                                           |  219 +-
 sound/isa/gus/gus_mem_proc.c                                 |    6 
 sound/isa/opl3sa2.c                                          |   26 
 sound/pci/Kconfig                                            |   14 
 sound/pci/ac97/ac97_codec.c                                  |  334 ++-
 sound/pci/ac97/ac97_patch.c                                  |   98 
 sound/pci/ac97/ac97_patch.h                                  |    1 
 sound/pci/ac97/ac97_pcm.c                                    |   18 
 sound/pci/ac97/ac97_proc.c                                   |   18 
 sound/pci/ac97/ak4531_codec.c                                |   49 
 sound/pci/ca0106/ca0106_mixer.c                              |   10 
 sound/pci/cs4281.c                                           |    5 
 sound/pci/cs46xx/dsp_spos.c                                  |   52 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                          |    2 
 sound/pci/cs5535audio/Makefile                               |    2 
 sound/pci/emu10k1/emu10k1.c                                  |    2 
 sound/pci/emu10k1/emu10k1_main.c                             |    1 
 sound/pci/emu10k1/emu10k1x.c                                 |    7 
 sound/pci/emu10k1/emufx.c                                    |   12 
 sound/pci/emu10k1/p16v.c                                     |    5 
 sound/pci/es1938.c                                           |  104 -
 sound/pci/es1968.c                                           |   40 
 sound/pci/fm801.c                                            |   63 
 sound/pci/hda/hda_codec.c                                    |   76 
 sound/pci/hda/hda_codec.h                                    |    2 
 sound/pci/hda/hda_generic.c                                  |  199 +-
 sound/pci/hda/hda_intel.c                                    |  132 -
 sound/pci/hda/hda_local.h                                    |    8 
 sound/pci/hda/hda_proc.c                                     |   12 
 sound/pci/hda/patch_analog.c                                 |   21 
 sound/pci/hda/patch_realtek.c                                |  330 ++-
 sound/pci/hda/patch_si3054.c                                 |    1 
 sound/pci/hda/patch_sigmatel.c                               |  904 +++++++--
 sound/pci/ice1712/aureon.c                                   |  104 -
 sound/pci/ice1712/ice1712.c                                  |   14 
 sound/pci/ice1712/phase.c                                    |   39 
 sound/pci/ice1712/pontis.c                                   |    9 
 sound/pci/ice1712/prodigy192.c                               |   14 
 sound/pci/ice1712/revo.c                                     |   68 
 sound/pci/ice1712/revo.h                                     |    2 
 sound/pci/intel8x0.c                                         |   14 
 sound/pci/intel8x0m.c                                        |    5 
 sound/pci/mixart/mixart.c                                    |   12 
 sound/pci/mixart/mixart_mixer.c                              |   14 
 sound/pci/pcxhr/pcxhr_mixer.c                                |   16 
 sound/pci/riptide/riptide.c                                  |   10 
 sound/pci/rme9652/hdsp.c                                     |   48 
 sound/pci/trident/trident_main.c                             |   10 
 sound/pci/via82xx.c                                          |   23 
 sound/pci/vx222/vx222.c                                      |    7 
 sound/pci/vx222/vx222_ops.c                                  |    9 
 sound/pci/ymfpci/ymfpci_main.c                               |    7 
 sound/pcmcia/pdaudiocf/pdaudiocf.c                           |    2 
 sound/pcmcia/vx/vxp_mixer.c                                  |    6 
 sound/pcmcia/vx/vxpocket.c                                   |    9 
 sound/ppc/beep.c                                             |   32 
 sound/ppc/keywest.c                                          |    3 
 sound/ppc/tumbler.c                                          |    5 
 sound/sparc/dbri.c                                           |  817 +++-----
 sound/synth/emux/emux_proc.c                                 |    6 
 sound/usb/usbaudio.c                                         |   54 
 sound/usb/usbmixer.c                                         |   27 
 sound/usb/usbmixer_maps.c                                    |   24 
 sound/usb/usbquirks.h                                        |    5 
 111 files changed, 5332 insertions(+), 1813 deletions(-)


The following things were done:

Adrian Bunk:
      [ALSA] make sound/pci/emu10k1/emu10k1.c:snd_emu10k1_resume() static

Alexey Dobriyan:
      [ALSA] emu10k1x: simplify around pci_register_driver()

Andreas Schwab:
      [ALSA] [PPC,SOUND] Fix audio gpio state detection

Andrey Liakhovets:
      [ALSA] ac97 - Fix VIA EPIA sound problem

Andy Shevchenko:
      [ALSA] fm801: Support FM only card

Clemens Ladisch:
      [ALSA] system timer: fix lost ticks correction adjustment
      [ALSA] system timer: accumulate correction for multiple lost ticks
      [ALSA] system timer: clear correction value when timer stops
      [ALSA] timer: fix timer rescheduling
      [ALSA] system timer: remove unused snd_timer_system_private.timer field
      [ALSA] usb-audio: add more Yamaha devices
      [ALSA] riptide: fix compile errors with older gcc
      [ALSA] usb-audio: increase number of packets per URB
      [ALSA] ES1938: remove duplicate field initialization
      [ALSA] usb-audio: add mixer control names for the Aureon 5.1 MkII

Danny Tholen:
      [ALSA] [snd-hda-intel] fix sound on some Asus W6A chips

Dmitry Torokhov:
      [ALSA] ppc-beep - handle errors from input_register_device()

Guillaume Munch:
      [ALSA] Add support for Sony Vaio AR 11B
      [ALSA] hda-codec - Support for SigmaTel 9872

James Courtier-Dutton:
      [ALSA] snd-emu10k1: Implement 24bit capture via Philips 1361T ADC for SB0240 card.
      [ALSA] snd-ca0106: Fix dB gain TLVs.
      [ALSA] snd-emu10k1: Implement dB gain infomation.
      [ALSA] snd-emu10k1: Add a comment explaining the conversion function for dB gain.

Jaroslav Kysela:
      [ALSA] Control API - TLV implementation for additional information like dB scale
      [ALSA] fm801: fixed broken previous patch for the FM tuner only code
      [ALSA] Control API - more robust TLV implementation
      [ALSA] HDA codec - little code & comment cleanup
      [ALSA] HDA codec & CA0106 - add/fix TLV support
      [ALSA] HDA driver - do not set mute flag for dB scale (follow HDA specification)
      [ALSA] ice1712 - fix 1600->16000Hz value typo

Jochen Voss:
      [ALSA] Revolution 5.1 - add AK5365 ADC support
      [ALSA] Revolution 5.1 - register the AK5365 ADC with ALSA
      [ALSA] Revolution 5.1 - complete the AK5365 support
      [ALSA] Fix volume control for the AK4358 DAC

Johannes Berg:
      [ALSA] aoa: add locking to tas codec

Josef 'Jeff' Sipek:
      [ALSA] sound core: Use SEEK_{SET,CUR,END} instead of hardcoded values
      [ALSA] opl4: Use SEEK_{SET,CUR,END} instead of hardcoded values
      [ALSA] gus: Use SEEK_{SET,CUR,END} instead of hardcoded values
      [ALSA] mixart: Use SEEK_{SET,CUR,END} instead of hardcoded values

Krzysztof Helt:
      [ALSA] dbri driver cleanup
      [ALSA] sparc dbri removal of DBRI_NO_INTS
      [ALSA] sparc dbri: removal of unused struct members
      [ALSA] sparc dbri: removal of redudant volatile keywords
      [ALSA] sparc dbri: removal of dri_desc struct
      [ALSA] sparc dbri: more driver cleanup
      [ALSA] sparc dbri: fixed setting of burst size after reset
      [ALSA] sparc dbri: simplifed linking time slot function
      [ALSA] sparc dbri: ring buffered version
      [ALSA] sparc dbri: hardware constrains added
      [ALSA] sparc dbri: recording is back
      [ALSA] dbri sparc: fixes TS leak
      [ALSA] sparc dbri: OSS layer fix
      [ALSA] sparc dbri: SMP fixes

Liam Girdwood:
      [ALSA] Fix WM9705 AC97 patch build error

Luke Ross:
      [ALSA] Support for non-standard rates in USB audio driver

Magnus Sandin:
      [ALSA] Fix for LG K1 Express Laptop
      [ALSA] ac97 - Enable S/PDIF on ASUS P5P800-VM mobo

Matt Porter:
      [ALSA] hda: fix sigmatel 9227/8/9 codec support
      [ALSA] hda: sigmatel 9205 family support

Matthias Koenig:
      [ALSA] Add snd-mts64 driver for ESI Miditerminal 4140

Mike Rapoport:
      [ALSA] add codec-specific controls for UCB1400

Nicolas Graziano:
      [ALSA] hda_intel prefer 24bit instead of 20bit

Ondrej Zary:
      [ALSA] es18xx - Add PnP BIOS support

Pavel Machek:
      [ALSA] sound/pci/hda/intel_hda: small cleanups

Richard Fish:
      [ALSA] hda-codec - restore HDA sigmatel pin configs on resume
      [ALSA] [snd-intel-hda] enable center/LFE speaker on some laptops

Stephen Hemminger:
      [ALSA] intel_hda: MSI support

Takashi Iwai:
      [ALSA] Fix disconnection of proc interface
      [ALSA] Unregister device files at disconnection
      [ALSA] Deprecate snd_card_free_in_thread()
      [ALSA] Add experimental support of aggressive AC97 power-saving mode
      [ALSA] Remove unused tlv_rw field from struct snd_kcontrol
      [ALSA] Add TLV support to snd-usb-audio driver
      [ALSA] Add model entry for Samsung X10 laptop
      [ALSA] Add model entry for Clevo m665n laptop
      [ALSA] Add hp-bpc model type for HP laptops
      [ALSA] Add support of Benq laptop with ALC262
      [ALSA] Added model for ASUS M2NPV-VM mobo
      [ALSA] via82xx - Add dxs_support entry for a FSC machine
      [ALSA] Fix Makefile of cs5535audio
      [ALSA] Misc fixes for Realtek HD-audio codecs
      [ALSA] Don't set up the same PID twice in snd_hda_multi_out_analog_prepare
      [ALSA] Fix noisy output with shared channel mode with hd-audio
      [ALSA] Fix control/status mmap with shared PCM substream
      [ALSA] Fix substream selection in PCM and rawmidi
      [ALSA] usb-audio - Fix a typo of CONFIG_PROC_FS
      [ALSA] Fix the preselected model for HP machine
      [ALSA] Fix compile warnings in ak4xxx-adda.c
      [ALSA] Select I2C and I2C_POWERMAC in aoa/codecs/Kconfig
      [ALSA] Added model for Uniwill laptop with ALC861
      [ALSA] Fix compile errors with older gcc
      [ALSA] Fix some typos in snd-dummy driver
      [ALSA] Add missing TLV callbacks for HD-audio codecs
      [ALSA] Fix missing selection of CONFIG_VIDEO_DEV from SND_FM801_TEA575X
      [ALSA] hda-intel - Switch to polling mode for CORB/RIRB communication
      [ALSA] Add TLV support to AC97 codec driver
      [ALSA] Added TLV support to VIA82xx driver
      [ALSA] Add dB scale information to ak4531 codec
      [ALSA] Add dB scale information to cs4281 driver
      [ALSA] Add dB scale information to fm801 driver
      [ALSA] Add dB scale information to trident driver
      [ALSA] Add dB scale information to dummy driver
      [ALSA] Add dB scale information to ad1816a driver
      [ALSA] Add dB scale information to ad1848 driver
      [ALSA] Add dB scale information to opl3sa2 driver
      [ALSA] hda-codec - Fix mic capture with generic parser
      [ALSA] Add dB scale information to pcxhr driver
      [ALSA] Add dB scale information to vxpocket and vx222 drivers
      [ALSA] Fix errors with user TLV_WRITE
      [ALSA] Return error if no user TLV is defined
      [ALSA] hda-codec - Use model=ref for some Dell laptops
      [ALSA] Add the definition of linear volume TLV
      [ALSA] ymfpci - Add TLV entries for native volume controls
      [ALSA] Add missing dB scale information to vxpocket driver
      [ALSA] Clean up and add TLV support to AK4xxx i2c driver
      [ALSA] Add dB scale information to ice1712 driver
      [ALSA] Add dB scale information to ice1724 driver
      [ALSA] hda-intel - Remove volatile
      [ALSA] Add dB scale information to mixart driver
      [ALSA] hdsp - Fix auto-updating of firmware
      [ALSA] Add definition of TLV dB range compound
      [ALSA] Add dB information to es1938 driver
      [ALSA] hda-codec - Add independent headphone volume control
      [ALSA] Add pcm_class attribute to PCM sysfs entry
      [ALSA] hda-codec - Add support for LG LW25 laptop
      [ALSA] hda-intel - Fix pci_disable_msi() call
      [ALSA] hda-codec - Fix SPDIF device number of ALC codecs
      [ALSA] ak4xxx - Remove bogus IPGA controls
      [ALSA] hda-intel - Fix suspend/resume with MSI
      [ALSA] powermac - Fix Oops when conflicting with aoa driver
      [ALSA] Add missing compat ioctls for ALSA control API
      [ALSA] hda-codec - Add device id for Motorola si3054-compatible codec
      [ALSA] hda-codec - Add vendor ids for Motorola and Conexant
      [ALSA] hda-codec - Support multiple headphone pins
      [ALSA] hda-codec - Fix mic input with STAC92xx codecs
      [ALSA] hda-intel - A slight cleanup of timeout check in azx_get_response()
      [ALSA] hda-codec - Fix headphone auto-toggle on sigmatel codec
      [ALSA] Move CONFIG_SND_AC97_POWER_SAVE to pci/Kconfig
      [ALSA] intel8x0m - Free irq in suspend

Tobias Klauser:
      [ALSA] sound/pci/fm801: Use ARRAY_SIZE macro

Tobin Davis:
      [ALSA] hda-codec - add missing device ids
      [ALSA] hda-codec - Fix headphone output for some Intel 945 systems
      [ALSA] hda-codec - add missing device ids for Intel 945 boards
      [ALSA] hda-codec - Add support for new Intel boards with Stac9227 codec
      [ALSA] hda-codec - Add 5 stack audio support for Intel 965 systems

Ville Syrjala:
      [ALSA] ac97: Fix AD1819 volume range
      [ALSA] es1968: Fix hw volume

Vladimir Avdonin:
      [ALSA] hda-codec - Fix for Acer laptops with ALC883 codec
