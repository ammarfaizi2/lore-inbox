Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932861AbWF2Jjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbWF2Jjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932864AbWF2Jjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:39:39 -0400
Received: from gate.perex.cz ([85.132.177.35]:23736 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932861AbWF2Jjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:39:37 -0400
Date: Thu, 29 Jun 2006 11:39:35 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103-a.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] HG repo sync
Message-ID: <Pine.LNX.4.61.0606291138030.10575@tm8103-a.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-06-29.patch.gz

The following files will be updated:

 Documentation/sound/alsa/ALSA-Configuration.txt |  106 +
 include/sound/ac97_codec.h                      |    1 
 include/sound/ak4xxx-adda.h                     |   35 
 include/sound/initval.h                         |    3 
 sound/Makefile                                  |    3 
 sound/aoa/Kconfig                               |    3 
 sound/aoa/core/snd-aoa-gpio-feature.c           |   15 
 sound/aoa/fabrics/snd-aoa-fabric-layout.c       |   14 
 sound/aoa/soundbus/Kconfig                      |    3 
 sound/core/Kconfig                              |    4 
 sound/core/seq/seq_ports.c                      |    6 
 sound/i2c/other/ak4xxx-adda.c                   |  284 ++-
 sound/pci/Kconfig                               |  141 +
 sound/pci/Makefile                              |    1 
 sound/pci/ac97/ac97_patch.c                     |    2 
 sound/pci/echoaudio/Makefile                    |   30 
 sound/pci/echoaudio/darla20.c                   |   99 +
 sound/pci/echoaudio/darla20_dsp.c               |  125 +
 sound/pci/echoaudio/darla24.c                   |  106 +
 sound/pci/echoaudio/darla24_dsp.c               |  156 +
 sound/pci/echoaudio/echo3g.c                    |  118 +
 sound/pci/echoaudio/echo3g_dsp.c                |  131 +
 sound/pci/echoaudio/echoaudio.c                 | 2196 ++++++++++++++++++++++++
 sound/pci/echoaudio/echoaudio.h                 |  590 ++++++
 sound/pci/echoaudio/echoaudio_3g.c              |  431 ++++
 sound/pci/echoaudio/echoaudio_dsp.c             | 1125 ++++++++++++
 sound/pci/echoaudio/echoaudio_dsp.h             |  694 +++++++
 sound/pci/echoaudio/echoaudio_gml.c             |  198 ++
 sound/pci/echoaudio/gina20.c                    |  103 +
 sound/pci/echoaudio/gina20_dsp.c                |  215 ++
 sound/pci/echoaudio/gina24.c                    |  123 +
 sound/pci/echoaudio/gina24_dsp.c                |  346 +++
 sound/pci/echoaudio/indigo.c                    |  104 +
 sound/pci/echoaudio/indigo_dsp.c                |  170 +
 sound/pci/echoaudio/indigodj.c                  |  104 +
 sound/pci/echoaudio/indigodj_dsp.c              |  170 +
 sound/pci/echoaudio/indigoio.c                  |  105 +
 sound/pci/echoaudio/indigoio_dsp.c              |  141 +
 sound/pci/echoaudio/layla20.c                   |  112 +
 sound/pci/echoaudio/layla20_dsp.c               |  290 +++
 sound/pci/echoaudio/layla24.c                   |  121 +
 sound/pci/echoaudio/layla24_dsp.c               |  394 ++++
 sound/pci/echoaudio/mia.c                       |  117 +
 sound/pci/echoaudio/mia_dsp.c                   |  229 ++
 sound/pci/echoaudio/midi.c                      |  327 +++
 sound/pci/echoaudio/mona.c                      |  129 +
 sound/pci/echoaudio/mona_dsp.c                  |  428 ++++
 sound/pci/hda/hda_codec.c                       |    4 
 sound/pci/hda/patch_analog.c                    |    2 
 sound/pci/hda/patch_realtek.c                   | 1084 ++++++++++-
 sound/pci/hda/patch_sigmatel.c                  |  110 +
 sound/pci/ice1712/revo.c                        |   23 
 sound/usb/usbaudio.c                            |   32 
 53 files changed, 11393 insertions(+), 210 deletions(-)


The following things were done:

Clemens Ladisch:
      [ALSA] make CONFIG_SND_DYNAMIC_MINORS non-experimental

Giuliano Pochini:
      [ALSA] Add echoaudio sound drivers

Jani Alinikula:
      [ALSA] Stereo controls for M-Audio Revolution cards

Jaya Kumar:
      [ALSA] AD1888 mixer controls for DC mode

Johannes Berg:
      [ALSA] snd-aoa: not experimental
      [ALSA] snd-aoa: support iMac G5 iSight
      [ALSA] snd-aoa: enable dual-edge in GPIOs

Sam Revitch:
      [ALSA] usb-audio support for Turtle Beach Roadie

Takashi Iwai:
      [ALSA] Suppress irq handler mismatch messages in ALSA ISA drivers
      [ALSA] fix build failure due to snd-aoa
      [ALSA] Fix wrong dependencies of snd-aoa driver
      [ALSA] hda-codec - Add model entry for Samsung X60 Chane
      [ALSA] Fix misuse of __list_add() in seq_ports.c
      [ALSA] Remove CONFIG_EXPERIMENTAL from intel8x0m driver
      [ALSA] ak4xxx-adda - Code clean-up
      [ALSA] Fix a typo in echoaudio/midi.c
      [ALSA] Fix/add support of Realtek ALC883 / ALC888 and ALC861 codecs
      [ALSA] Add Intel D965 board support
      [ALSA] echoaudio - Fix Makefile
      [ALSA] echoaudio - Remove kfree_nocheck()


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
