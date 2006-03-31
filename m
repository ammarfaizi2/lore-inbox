Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWCaQNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWCaQNb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWCaQNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:13:31 -0500
Received: from gate.perex.cz ([85.132.177.35]:36802 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751264AbWCaQNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:13:31 -0500
Date: Fri, 31 Mar 2006 18:13:28 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] CVS sync
Message-ID: <Pine.LNX.4.61.0603311812010.9303@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-03-31.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt |   69 
 include/sound/core.h                            |    2 
 include/sound/pcm.h                             |   15 
 include/sound/pcm_oss.h                         |    3 
 sound/core/Kconfig                              |    5 
 sound/core/control.c                            |    6 
 sound/core/control_compat.c                     |    6 
 sound/core/init.c                               |    9 
 sound/core/oss/pcm_oss.c                        |  290 +--
 sound/core/pcm.c                                |   14 
 sound/core/pcm_lib.c                            |   49 
 sound/core/pcm_native.c                         |  157 -
 sound/isa/Kconfig                               |   23 
 sound/isa/Makefile                              |    2 
 sound/isa/adlib.c                               |  161 +
 sound/isa/cmi8330.c                             |    4 
 sound/isa/opti9xx/Makefile                      |    2 
 sound/isa/opti9xx/miro.c                        | 1455 +++++++++++++++
 sound/isa/opti9xx/miro.h                        |   73 
 sound/pci/Kconfig                               |   30 
 sound/pci/Makefile                              |    3 
 sound/pci/als300.c                              |  866 +++++++++
 sound/pci/cs4281.c                              |   28 
 sound/pci/hda/hda_codec.c                       |    2 
 sound/pci/hda/hda_intel.c                       |    2 
 sound/pci/hda/patch_analog.c                    |    9 
 sound/pci/hda/patch_realtek.c                   |  300 ++-
 sound/pci/hda/patch_sigmatel.c                  |   53 
 sound/pci/ice1712/aureon.c                      |  163 +
 sound/pci/ice1712/ice1712.c                     |    2 
 sound/pci/ice1712/ice1712.h                     |    1 
 sound/pci/maestro3.c                            |   57 
 sound/pci/pcxhr/pcxhr_core.c                    |    9 
 sound/pci/riptide/Makefile                      |    3 
 sound/pci/riptide/riptide.c                     | 2223 ++++++++++++++++++++++++
 sound/pci/via82xx.c                             |    1 
 sound/usb/usbmixer.c                            |   37 
 37 files changed, 5660 insertions(+), 474 deletions(-)


The following things were done:

Alan Horstmann:
      [ALSA] ice1712 - Fix wrong register value for DMX 6FIRE

Andreas Mohr:
      [ALSA] maestro3.c: fix BUG, optimization

Ash Willis:
      [ALSA] Add snd-als300 driver for Avance Logic ALS300/ALS300+ soundcards

Felix Kuehling:
      [ALSA] hda-intel - Add support of ATI SB600

Frederik Deweerdt:
      [ALSA] Kconfig SND_SEQUENCER_OSS help text fix

Jonathan Woithe:
      [ALSA] HDA/Realtek: multiple input mux definitions and pin mode additions

Markus Bollinger:
      [ALSA] pcxhr - Fix the crash with REV01 board

Martin Langer:
      [ALSA] Add snd-miro driver

Maximilian Rehkopf:
      [ALSA] Add Aux input switch control for Aureon Universe

OGAWA Hirofumi:
      [ALSA] sound/pci/hda: use create_singlethread_workqueue()

Peter Gruber:
      [ALSA] Add snd-riptide driver for Conexant Riptide chip

Rene Herman:
      [ALSA] ISA drivers bailing on first !enable[i]
      [ALSA] AdLib FM card driver

Takashi Iwai:
      [ALSA] Add support of LG LW20 laptop
      [ALSA] hda-codec - Fix VREF level of Mic inputs on STAC92xx codecs
      [ALSA] via82xx - Add dxs entry for EPoX EP-8KRAI
      [ALSA] Cleanup unused argument for snd_power_wait()
      [ALSA] Make CONFIG_SND_CS46XX_NEW_DSP yes as default
      [ALSA] hda-codec - Fix unsol event initialization at resume of stac92xx
      [ALSA] hda-codec - Fix noisy output wtih AD1986A 3stack model
      [ALSA] Remove obsolete kfree_nocheck call
      [ALSA] Remove obsolete kfree_nocheck call
      [ALSA] Tiny clean up of PCM codes
      [ALSA] Clean up PCM codes (take 2)
      [ALSA] Fix / clean up PCM-OSS setup hooks
      [ALSA] Test volume resolution of usb audio at initialization
      [ALSA] cs4281 - Fix the check of right channel
      [ALSA] cs4281 - Fix the check of timeout in probe

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
