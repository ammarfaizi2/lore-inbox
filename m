Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWBAMUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWBAMUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWBAMUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:20:07 -0500
Received: from gate.perex.cz ([85.132.177.35]:60604 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932430AbWBAMUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:20:06 -0500
Date: Wed, 1 Feb 2006 13:20:03 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] Sync with ALSA CVS
Message-ID: <Pine.LNX.4.61.0602011318460.9342@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-02-01.patch.gz

Additional notes:

  Only small patches and fixes were selected.

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   10 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    4 
 drivers/pnp/card.c                                           |    9 
 sound/core/info.c                                            |   33 --
 sound/drivers/serial-u16550.c                                |    2 
 sound/isa/cmi8330.c                                          |    6 
 sound/isa/cs423x/cs4236.c                                    |   13 
 sound/isa/es18xx.c                                           |    6 
 sound/isa/gus/gusclassic.c                                   |    2 
 sound/isa/opl3sa2.c                                          |   12 
 sound/isa/opti9xx/opti92x-ad1848.c                           |    2 
 sound/isa/sb/sb16.c                                          |    4 
 sound/isa/sscape.c                                           |    6 
 sound/isa/wavefront/wavefront.c                              |    7 
 sound/isa/wavefront/wavefront_synth.c                        |    2 
 sound/pci/ac97/ac97_patch.c                                  |   53 ++-
 sound/pci/ali5451/ali5451.c                                  |    2 
 sound/pci/au88x0/au88x0_eq.c                                 |    2 
 sound/pci/bt87x.c                                            |    4 
 sound/pci/ca0106/ca0106_main.c                               |   12 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                          |    2 
 sound/pci/cs5535audio/cs5535audio.c                          |    6 
 sound/pci/emu10k1/emumixer.c                                 |   10 
 sound/pci/hda/hda_intel.c                                    |    2 
 sound/pci/hda/patch_realtek.c                                |   11 
 sound/pci/hda/patch_si3054.c                                 |    1 
 sound/pci/hda/patch_sigmatel.c                               |  176 ++++++++++-
 sound/pci/intel8x0.c                                         |   15 
 sound/pci/pcxhr/pcxhr.c                                      |    9 
 sound/pci/rme9652/hdspm.c                                    |    6 
 sound/pci/trident/trident.c                                  |    8 
 sound/pci/via82xx.c                                          |    5 
 sound/pci/ymfpci/ymfpci_main.c                               |    2 
 sound/ppc/pmac.c                                             |    2 
 sound/usb/usbaudio.c                                         |   31 +
 35 files changed, 365 insertions(+), 112 deletions(-)


The following things were done:

Adam Belay:
      [ALSA] check return code in pnp_register_card_driver()

Alexey Dobriyan:
      [ALSA] Fix adding second dma channel

Andrew Morton:
      [ALSA] Fix a typo in snd_assert()
      [ALSA] hdsp - Fix printk warnings
      [ALSA] pcxhr - Fix printk warning

Arnaud Patard:
      [ALSA] patch_realtek.c: Add new model

Chris Ball:
      [ALSA] intel8x0: Add quirk for Optiplex GX270

Clemens Ladisch:
      [ALSA] usb-audio: don't use empty packets at start of playback
      [ALSA] ymfpci: fix SPDIF sample rate information
      [ALSA] usb-audio: fix non-48k sample rates with SB Audigy 2 ZS

Giuliano Pochini:
      [ALSA] fix typos in writing-an-alsa-driver

Ingo Molnar:
      [ALSA] Remove BKL from sound/core/info.c

James Courtier-Dutton:
      [ALSA] snd-ca0106: Fixed ALSA bug#1600

Jaroslav Kysela:
      [ALSA] bt87x - fix detection of unknown card
      [ALSA] cs4232/cs4236 - moved CS423X_DRIVER define outside CONFIG_PNP

Jason Gaston:
      [ALSA] hda-intel - patch for Intel ICH8

Jon Mason:
      [ALSA] Prevent ALSA trident driver from grabbing pcnet32 hardware
      [ALSA] ali5451: Add PCI_DEVICE and #defines in snd_ali_ids

Jonathan Woithe:
      [ALSA] hda-codec - Fix init verb of ALC260

Lukasz Stemach:
      [ALSA] cs4236 - Add PnP ids for Netfinity 3000

Martin Drab:
      [ALSA] bt87x - Fix the unability of snd-bt87x to recognize AVerMedia Studio

Matt Porter:
      [ALSA] hda-codec - add D975XBK support to sigmatel patch
      [ALSA] hda-codec - add sigmatel 927x codec support
      [ALSA] hda: sigmatel fixes

Rene Rebe:
      [ALSA] AMD cs5536 ID for cs5535audio

Sasha Khapyorsky:
      [ALSA] hda-codec - support for Agere's HDA soft modem

Stelian Pop:
      [ALSA] sound/ppc/pmac.c typo

Takashi Iwai:
      [ALSA] via82xx - Add dxs_support for ASUS mobo
      [ALSA] Fix compilation without CONFIG_PNP
      [ALSA] emu10k1 - Fix silence problems after suspend
      [ALSA] emu10k1 - Fix the confliction of 'Front' control
      [ALSA] via82xx - Add dxs_support entry
      [ALSA] pcxhr - Fix the sample rate changes
      [ALSA] hda-codec - Add model entry for Sony VAIO
      [ALSA] ac97 - Suppress jack sense controls for Thinkpads
      [ALSA] ac97 - Fix CLFE channel setting of ALC850
      [ALSA] hda-codec - Fix capture on Sigmatel STAC92xx codecs
      [ALSA] via82xx - Add dxs_support entry for EpoX 9HEAI
      [ALSA] au88x0 - Fix a compile warning
      [ALSA] opl3sa2 - Fix conflict of driver name on sysfs
      [ALSA] sb16 - Fix duplicated PnP entry
      [ALSA] via82xx - Add dxs entry for a FSC board
      [ALSA] wavefront - Fix a compile warning
      [ALSA] opti93x - Fix a compile warning
      [ALSA] serial-uart16550 - Fix a compile warning
      [ALSA] via82xx - Add dxs entry for P4M800/VIA8237R
      [ALSA] hda-codec - Fix max_channels computation for STAC92xx codecs
      [ALSA] intel8x0 - Add MCP51 PCI ID
      [ALSA] hda-codec - Fix typos in alc882 model table

Ulrich Mueller:
      [ALSA] intel8x0 - Fix duplicate ac97_quirks entry

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
