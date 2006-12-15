Return-Path: <linux-kernel-owner+w=401wt.eu-S1751286AbWLOIQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWLOIQc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLOIQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:16:31 -0500
Received: from gate.perex.cz ([212.20.107.50]:59123 "EHLO gate.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbWLOIQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:16:30 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 03:16:29 EST
Date: Fri, 15 Dec 2006 08:52:48 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] alsa-git merge request
Message-ID: <Pine.LNX.4.61.0612150849410.13335@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
  (linus branch)

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-12-15.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt    |   35 
 .../sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   18 
 Documentation/sound/alsa/hda_codec.txt             |   10 
 Documentation/sound/alsa/soc/DAI.txt               |  546 ++++
 Documentation/sound/alsa/soc/clocking.txt          |  314 ++
 Documentation/sound/alsa/soc/codec.txt             |  232 ++
 Documentation/sound/alsa/soc/dapm.txt              |  297 ++
 Documentation/sound/alsa/soc/machine.txt           |  114 +
 Documentation/sound/alsa/soc/overview.txt          |   83 +
 Documentation/sound/alsa/soc/platform.txt          |   58 
 Documentation/sound/alsa/soc/pops_clicks.txt       |   52 
 MAINTAINERS                                        |    6 
 include/linux/i2c-id.h                             |    2 
 include/sound/ac97_codec.h                         |    3 
 include/sound/ak4xxx-adda.h                        |    2 
 include/sound/control.h                            |    1 
 include/sound/core.h                               |   62 
 include/sound/emu10k1.h                            |  397 +++
 include/sound/pcm.h                                |    4 
 include/sound/pcm_oss.h                            |    1 
 include/sound/pt2258.h                             |   37 
 include/sound/sb16_csp.h                           |   14 
 include/sound/snd_wavefront.h                      |    2 
 include/sound/soc-dapm.h                           |  286 ++
 include/sound/soc.h                                |  485 ++++
 include/sound/typedefs.h                           |  173 -
 include/sound/version.h                            |    4 
 include/sound/ymfpci.h                             |   11 
 sound/Kconfig                                      |    2 
 sound/Makefile                                     |    2 
 sound/aoa/aoa.h                                    |    2 
 sound/aoa/codecs/snd-aoa-codec-onyx.h              |    1 
 sound/aoa/codecs/snd-aoa-codec-tas.c               |    1 
 sound/aoa/core/snd-aoa-alsa.c                      |    5 
 sound/aoa/core/snd-aoa-alsa.h                      |    2 
 sound/aoa/core/snd-aoa-core.c                      |    4 
 sound/aoa/fabrics/snd-aoa-fabric-layout.c          |    5 
 sound/aoa/soundbus/i2sbus/i2sbus-pcm.c             |   79 -
 sound/arm/aaci.h                                   |    2 
 sound/core/control.c                               |   44 
 sound/core/control_compat.c                        |    5 
 sound/core/device.c                                |   24 
 sound/core/hwdep.c                                 |   10 
 sound/core/memalloc.c                              |   10 
 sound/core/misc.c                                  |   28 
 sound/core/oss/pcm_oss.c                           |   52 
 sound/core/pcm.c                                   |   54 
 sound/core/pcm_lib.c                               |    8 
 sound/core/pcm_memory.c                            |   23 
 sound/core/rawmidi.c                               |   33 
 sound/core/seq/seq_clientmgr.c                     |   14 
 sound/core/seq/seq_device.c                        |   25 
 sound/core/seq/seq_memory.c                        |    2 
 sound/core/seq/seq_ports.c                         |   49 
 sound/core/seq/seq_virmidi.c                       |    4 
 sound/core/sgbuf.c                                 |    2 
 sound/core/sound.c                                 |   17 
 sound/core/timer.c                                 |   77 -
 sound/drivers/serial-u16550.c                      |  221 +-
 sound/i2c/Makefile                                 |    1 
 sound/i2c/other/Makefile                           |    4 
 sound/i2c/other/ak4xxx-adda.c                      |   85 +
 sound/i2c/other/pt2258.c                           |  233 ++
 sound/isa/Kconfig                                  |    2 
 sound/isa/gus/gus_mem.c                            |    7 
 sound/isa/sb/sb16_csp.c                            |   61 
 sound/isa/sb/sb_common.c                           |    2 
 sound/isa/wavefront/wavefront.c                    |    1 
 sound/isa/wavefront/wavefront_fx.c                 |  812 ------
 sound/isa/wavefront/wavefront_synth.c              |    2 
 sound/isa/wavefront/yss225.c                       | 2739 ++++++++++++++++++++
 sound/pci/Kconfig                                  |   30 
 sound/pci/ac97/ac97_codec.c                        |   51 
 sound/pci/ac97/ac97_patch.c                        |    8 
 sound/pci/ad1889.c                                 |    4 
 sound/pci/ali5451/ali5451.c                        |    5 
 sound/pci/als300.c                                 |   12 
 sound/pci/atiixp.c                                 |   33 
 sound/pci/atiixp_modem.c                           |    4 
 sound/pci/au88x0/au88x0.c                          |    2 
 sound/pci/azt3328.c                                |    5 
 sound/pci/bt87x.c                                  |    4 
 sound/pci/ca0106/ca0106.h                          |    2 
 sound/pci/ca0106/ca0106_main.c                     |   56 
 sound/pci/ca0106/ca0106_mixer.c                    |   46 
 sound/pci/cmipci.c                                 |    2 
 sound/pci/cs4281.c                                 |    2 
 sound/pci/cs46xx/cs46xx_lib.c                      |    2 
 sound/pci/cs5535audio/cs5535audio.c                |    2 
 sound/pci/echoaudio/darla20.c                      |    1 
 sound/pci/echoaudio/darla24.c                      |    1 
 sound/pci/echoaudio/echo3g.c                       |    1 
 sound/pci/echoaudio/echoaudio.c                    |   24 
 sound/pci/echoaudio/gina20.c                       |    1 
 sound/pci/echoaudio/gina24.c                       |    1 
 sound/pci/echoaudio/indigo.c                       |    1 
 sound/pci/echoaudio/indigodj.c                     |    1 
 sound/pci/echoaudio/indigoio.c                     |    1 
 sound/pci/echoaudio/layla20.c                      |    1 
 sound/pci/echoaudio/layla24.c                      |    1 
 sound/pci/echoaudio/mia.c                          |    1 
 sound/pci/echoaudio/midi.c                         |    6 
 sound/pci/echoaudio/mona.c                         |    1 
 sound/pci/emu10k1/emu10k1_main.c                   |  621 ++++-
 sound/pci/emu10k1/emu10k1x.c                       |   15 
 sound/pci/emu10k1/emufx.c                          |  102 +
 sound/pci/emu10k1/emumixer.c                       |  744 +++++
 sound/pci/emu10k1/emupcm.c                         |  147 +
 sound/pci/emu10k1/emuproc.c                        |   34 
 sound/pci/emu10k1/io.c                             |  104 +
 sound/pci/emu10k1/p16v.c                           |   12 
 sound/pci/emu10k1/p17v.h                           |   47 
 sound/pci/emu10k1/voice.c                          |    2 
 sound/pci/ens1370.c                                |  156 +
 sound/pci/es1938.c                                 |    4 
 sound/pci/es1968.c                                 |    8 
 sound/pci/fm801.c                                  |    2 
 sound/pci/hda/Makefile                             |   11 
 sound/pci/hda/hda_codec.c                          |   61 
 sound/pci/hda/hda_intel.c                          |   20 
 sound/pci/hda/hda_local.h                          |   11 
 sound/pci/hda/hda_patch.h                          |    6 
 sound/pci/hda/hda_proc.c                           |   53 
 sound/pci/hda/patch_analog.c                       |  137 +
 sound/pci/hda/patch_cmedia.c                       |   24 
 sound/pci/hda/patch_conexant.c                     | 1311 ++++++++++
 sound/pci/hda/patch_realtek.c                      | 1339 ++++++++--
 sound/pci/hda/patch_si3054.c                       |    3 
 sound/pci/hda/patch_sigmatel.c                     |  538 ++--
 sound/pci/hda/patch_via.c                          | 1396 ++++++++++
 sound/pci/ice1712/ice1712.c                        |    2 
 sound/pci/ice1712/ice1712.h                        |   14 
 sound/pci/ice1712/ice1724.c                        |    2 
 sound/pci/ice1712/revo.c                           |  346 ++-
 sound/pci/ice1712/revo.h                           |   11 
 sound/pci/intel8x0.c                               |  212 +-
 sound/pci/intel8x0m.c                              |  124 -
 sound/pci/korg1212/korg1212.c                      |   47 
 sound/pci/maestro3.c                               |  377 +--
 sound/pci/mixart/mixart.c                          |    5 
 sound/pci/nm256/nm256.c                            |   58 
 sound/pci/pcxhr/pcxhr.c                            |    2 
 sound/pci/riptide/riptide.c                        |    5 
 sound/pci/rme32.c                                  |    3 
 sound/pci/rme96.c                                  |    3 
 sound/pci/rme9652/hdsp.c                           |   47 
 sound/pci/rme9652/hdspm.c                          | 1245 ++++++++-
 sound/pci/rme9652/rme9652.c                        |    7 
 sound/pci/sonicvibes.c                             |    5 
 sound/pci/trident/trident_main.c                   |    6 
 sound/pci/via82xx.c                                |  134 -
 sound/pci/via82xx_modem.c                          |    4 
 sound/pci/vx222/vx222.c                            |    4 
 sound/pci/ymfpci/ymfpci.c                          |    5 
 sound/pci/ymfpci/ymfpci_image.h                    |    6 
 sound/pci/ymfpci/ymfpci_main.c                     |  208 +-
 sound/soc/Kconfig                                  |   32 
 sound/soc/Makefile                                 |    4 
 sound/soc/at91/Kconfig                             |   24 
 sound/soc/at91/Makefile                            |   11 
 sound/soc/at91/at91-i2s.c                          |  673 +++++
 sound/soc/at91/at91-pcm.c                          |  427 +++
 sound/soc/at91/at91-pcm.h                          |   71 +
 sound/soc/at91/eti_b1_wm8731.c                     |  268 ++
 sound/soc/codecs/Kconfig                           |   15 
 sound/soc/codecs/Makefile                          |    9 
 sound/soc/codecs/ac97.c                            |  167 +
 sound/soc/codecs/ac97.h                            |   18 
 sound/soc/codecs/wm8731.c                          |  886 ++++++
 sound/soc/codecs/wm8731.h                          |   41 
 sound/soc/codecs/wm8750.c                          | 1282 +++++++++
 sound/soc/codecs/wm8750.h                          |   66 
 sound/soc/codecs/wm9712.c                          |  781 ++++++
 sound/soc/codecs/wm9712.h                          |   14 
 sound/soc/pxa/Kconfig                              |   60 
 sound/soc/pxa/Makefile                             |   20 
 sound/soc/pxa/corgi.c                              |  361 +++
 sound/soc/pxa/poodle.c                             |  329 ++
 sound/soc/pxa/pxa2xx-ac97.c                        |  437 +++
 sound/soc/pxa/pxa2xx-i2s.c                         |  354 +++
 sound/soc/pxa/pxa2xx-pcm.c                         |  363 +++
 sound/soc/pxa/pxa2xx-pcm.h                         |   48 
 sound/soc/pxa/spitz.c                              |  374 +++
 sound/soc/pxa/tosa.c                               |  287 ++
 sound/soc/soc-core.c                               | 2057 +++++++++++++++
 sound/soc/soc-dapm.c                               | 1327 ++++++++++
 sound/usb/usbaudio.c                               |   76 -
 187 files changed, 25779 insertions(+), 3210 deletions(-)


The following things were done:

Adrian Bunk:
      [ALSA] sound/core/control.c: remove dead code
      [ALSA] make sound/pci/hda/patch_sigmatel.c:stac92xx_dmic_labels[] static
      [ALSA] make sound/core/control.c:snd_ctl_new() static
      [ALSA] sound/soc/soc-dapm.c: make 4 functions static

Akinobu Mita:
      [ALSA] sound: initialize rawmidi substream list
      [ALSA] sound: fix PCM substream list

Andreas Mohr:
      [ALSA] via82xx: add __devinitdata

Andrew L. Neporada:
      [ALSA] hda-codec - Clevo M540JE, M550JE laptops (Nvidia MCP51 chipset, ALC883 codec)

Andrew Morton:
      [ALSA] arm header fix

Christian Hesse:
      [ALSA] hda-codec - fix typo in PCI IDs

Clemens Ladisch:
      [ALSA] usb-audio: merge playback/capture hardware information structs
      [ALSA] usb-audio: allow pausing
      [ALSA] use the ALIGN macro
      [ALSA] use the roundup macro
      [ALSA] soc-core: fix multi-line string literal
      [ALSA] pci: select FW_LOADER instead of depending on it
      [ALSA] emu10k1: select FW_LOADER
      [ALSA] ymfpci: add request_firmware()
      [ALSA] pcm core: fix silence_start calculations
      [ALSA] sb16: add request_firmware()
      [ALSA] wavefront: simplify YSS225 register initialization
      [ALSA] wavefront: add request_firmware()
      [ALSA] korg1212: add request_firmware()
      [ALSA] maestro3: add request_firmware()
      [ALSA] usb-audio: work around wrong frequency in CM6501 descriptors

Dan Carpenter:
      [ALSA] atiixp - Add a parameter ac97_quirk

Frank Mandarino:
      [ALSA] ASoC: core code
      [ALSA] ASoC AT91RM92000 audio DMA
      [ALSA] ASoC AT91RM92000 I2S support
      [ALSA] ASoC AT91RM92000 eti_b1 machine support
      [ALSA] ASoC AT91RM92000 build
      [ALSA] ASoC AT91 DAI modes update
      [ALSA] Update AT91 ASoC driver for 2.6.19 kernel.

Giuliano Pochini:
      [ALSA] Fix potential NULL pointer dereference in echoaudio midi
      [ALSA] echoaudio, add TLV support

Glen Masgai:
      [ALSA] ymfpci: fix swap_rear for S/PDIF passthrough

Hubert Kahlert:
      [ALSA] Fix mask to stop AT91 SSC clock on shutdown

James C Georgas:
      [ALSA] ac97_codec - trivial fix for bit update functions

James Courtier-Dutton:
      [ALSA] snd-emu10k1: Added support for emu1010, including E-Mu 1212m and E-Mu 1820m
      [ALSA] snd_emu10k1: Added support for 14dB Attenuation PADS on DACs and ADCs.
      [ALSA] snd-emu10k1: Add emu1010 internal clock rate control for 44100 or 48000.
      [ALSA] snd-emu10k1: emu1010: replace long udelay with msleep.
      [ALSA] snd-emu10k1: Update Enum naming.
      [ALSA] snd-ca0106: Updated Enum control names.
      [ALSA] snd-ca0106: Add new card variant.
      [ALSA] snd-ca0106: Fix typos.
      [ALSA] emu10k1: Add Audio capture support for Audigy 2 ZS Notebook.
      [ALSA] emu10k1: Rename the digital optical capture control for the Audigy 2 ZS
      [ALSA] ca0106: Fix sound capture on Audigy LS via AC97.
      [ALSA] ac97: Identify CMI9761 chips.
      [ALSA] emu10k1: Update registers defines for the Audigy 2/emu10k2.5

Jaroslav Kysela:
      [ALSA] ac97_codec (ALC655): add EAPD hack for MSI L725 laptop
      [ALSA] hda_intel: increase maximum DMA buffer size to 1024MB
      [ALSA] pcm core: add prealloc_max file to substream directory to show maximum DMA size
      [ALSA] version 1.0.14rc1

Jason Gaston:
      [ALSA] hda_intel: ALSA HD Audio patch for Intel ICH9

Jean Delvare:
      [ALSA] sound: Don't include i2c-dev.h

Jerome Demange:
      [ALSA] ac97 - enables sound output through speakers on MSI S250 laptop

Jochen Voss:
      [ALSA] Enable capture from line-in and CD on Revolution 5.1
      [ALSA] Enable the analog loopback of the Revolution 5.1

Johannes Berg:
      [ALSA] allow registering an alsa device with struct device pointer
      [ALSA] alsa core: add struct device pointer to struct snd_pcm
      [ALSA] aoa: set device pointer in pcms
      [ALSA] aoa: fix up i2sbus_attach_codec
      [ALSA] alsa core: convert to list_for_each_entry*

Jonathan Woithe:
      [ALSA] hda-codec - Make internal speaker work on Acer C20x tablets

Joseph Chan:
      [ALSA] hda-codec - Add support for VIA VT1708(A) HD audio codec

Kailang Yang:
      [ALSA] hda-codec - Add new modesl for Realtek codecs

Liam Girdwood:
      [ALSA] ASoC: Build files
      [ALSA] ASoC: documentation & maintainer
      [ALSA] ASoC pxa2xx DMA support
      [ALSA] ASoC pxa2xx I2S support
      [ALSA] ASoC pxa2xx AC97 support
      [ALSA] ASoC pxa2xx Corgi machine support
      [ALSA] ASoC pxa2xx Spitz machine support
      [ALSA] ASoC pxa2xx Tosa machine support
      [ALSA] ASoC pxa2xx Poodle machine support
      [ALSA] ASoC pxa2xx build support
      [ALSA] ASoC DAI capabilities labelling
      [ALSA] ASoC debug output build breakage
      [ALSA] ASoC - Fix build warnings in soc-core.c
      [ALSA] ASoC: Add support for BCLK based on (Rate * Chn * Word Size)
      [ALSA] ASoC - mixer name changes for older OSS app support

Mariusz Domanski:
      [ALSA] hda-codec - Add asus model to ALC861 codec

Matt Porter:
      [ALSA] hda: add dig mic support for sigmatel codecs

Nickolay V. Shmyrev:
      [ALSA] snd_hda_intel 3stack mode for ASUS P5P-L2

Olaf Hering:
      [ALSA] create device symlink in snd-aoa
      [ALSA] create driver symlink in snd-aoa /sys/bus/aoa-soundbus/devices/*/

Peer Chen:
      [ALSA] Audio: Add nvidia HD Audio controllers of MCP67 support to hda_intel.c

Philipp Zabel:
      [ALSA] ASoC - Bit clock matching error

Randy Dunlap:
      [ALSA] korg1212: fix printk format warning
      [ALSA] add struct snd_pcm_substream forward declaration

Remy Bruno:
      [ALSA] hdsp: support for mixer matrix of RME9632 rev 152
      [ALSA] hdsp: precise_ptr control switched off by default
      [ALSA] hdspm: Add support for AES32
      [ALSA] hdsp - Add DDS register support for RME9632 rev >= 152

Richard Purdie:
      [ALSA] ASoC: core and dapm headers
      [ALSA] ASoC: dynamic audio power management (DAPM)
      [ALSA] ASoC codecs: WM8731 support
      [ALSA] ASoC codecs: WM8750 support
      [ALSA] ASoC codecs: WM9712 support
      [ALSA] ASoC codecs: generic AC97 support
      [ALSA] ASoC codecs: build files

Takashi Iwai:
      [ALSA] emu10k1 - Fix compile warning
      [ALSA] intel8x0 - Use pci_iomap
      [ALSA] Fix irq handler in soc/at91/at91rm9200-i2s.c
      [ALSA] hda-codec - Fix wrong error checks in patch_{realtek,analog}.c
      [ALSA] hda-codec - Don't return error at initialization of modem codec
      [ALSA] hda-codec - Add missing comma
      [ALSA] Remove trailing whitespaces from soc/* files
      [ALSA] hda-codec - Fix a typo
      [ALSA] hda-codec - Add model for HP q965
      [ALSA] ac97 - Suppress power-saving mode on non-supporting drivers
      [ALSA] hda-codec - Fix model for Lenovo A60 desktop
      [ALSA] hda-codec - Fix model for ASUS M2N-MX
      [ALSA] hdspm - Fix printk warnings
      [ALSA] hda-codec - Fix model for ASUS V1j laptop
      [ALSA] hda-codec - Fix detection of supported sample rates
      [ALSA] hda-codec - Verbose proc output for PCM parameters
      [ALSA] ac97 - Fix potential negative array index
      [ALSA] ice1724 - Add support of M-Audio Audiophile 192
      [ALSA] hda-codec - Add support for Sony UX-90s
      [ALSA] Fix races in PCM OSS emulation
      [ALSA] Fix invalid assignment of PCI revision
      [ALSA] hda-codec - Fix ALC861 connection of front-output
      [ALSA] hda-codec - Add model for ASUS W3j laptop
      [ALSA] hda-intel - Disable INTX when MSI is used
      [ALSA] Remove IRQF_DISABLED for shared PCI irqs
      [ALSA] hda-codec - Add asus-laptop model for ALC861 (ALC660)
      [ALSA] Remove obsolete typedefs.h
      [ALSA] Fix obsolete *_t typedefs
      [ALSA] Add PCI quirk list helper function
      [ALSA] atiixp - Use quirk list helper function
      [ALSA] nm256 - Use quirk list helper function
      [ALSA] maestro3 - Use quirk list helper function
      [ALSA] via82xx - Use quirk list helper function
      [ALSA] ens1371 - Clean up quirks
      [ALSA] intel8x0 - Add spdif_aclink option
      [ALSA] Fix documentation of ASoC
      [ALSA] Clean up serial-u16500.c
      [ALSA] hda-codec - Use snd_pci_quirk_lookup() for board config lookup
      [ALSA] hda-codec - Fix compile warnings without CONFIG_SND_DEBUG
      [ALSA] Add description about spdif_aclink option for snd-intel8x0

Teru KAMOGASHIRA:
      [ALSA] Current driver does not utilize 44.1kHz high quality sampling rate converter.

Tobias Klauser:
      [ALSA] sound/usb/usbaudio: Handle return value of usb_register()

Tobin Davis:
      [ALSA] hda-codec - Add support for Medion laptops
      [ALSA] hda-codec - Add toshiba model to ALC861 codec
      [ALSA] Add Conexant audio support to the HD Audio driver
      [ALSA] hda-codec - Change Gigabyte K8N51 from 6stack to 6stack-digout
      [ALSA] hda-codec - Add support for Evesham Voyager C530RD laptops
      [ALSA] hda-codec - Add missing array to conexant driver

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
