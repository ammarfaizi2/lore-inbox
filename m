Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWHERh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWHERh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 13:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWHERh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 13:37:57 -0400
Received: from gate.perex.cz ([85.132.177.35]:53686 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1422653AbWHERh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 13:37:56 -0400
Date: Sat, 5 Aug 2006 19:37:54 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       Johannes Berg <johannes@sipsolutions.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA PATCH] bugfixes
Message-ID: <Pine.LNX.4.61.0608051919380.9377@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-08-03.patch.gz

Additional notes:

  Just simple bugfixes and k[z|c]alloc code cleanup.

The following files will be updated:

 MAINTAINERS                             |    7 +++++++
 sound/aoa/codecs/snd-aoa-codec-toonie.c |   17 +++++++++++++----
 sound/aoa/core/snd-aoa-gpio-feature.c   |    7 +++++--
 sound/aoa/core/snd-aoa-gpio-pmf.c       |    2 +-
 sound/core/oss/mixer_oss.c              |    3 +--
 sound/core/oss/pcm_oss.c                |    2 ++
 sound/core/seq/seq_device.c             |    3 +--
 sound/core/sgbuf.c                      |    9 +++------
 sound/drivers/vx/vx_pcm.c               |    7 ++-----
 sound/pci/echoaudio/echoaudio.c         |    4 ++--
 sound/pci/emu10k1/emu10k1_main.c        |   11 +++++++++++
 sound/pci/emu10k1/irq.c                 |    6 +++++-
 sound/ppc/awacs.c                       |    3 +--
 sound/ppc/daca.c                        |    3 +--
 sound/ppc/keywest.c                     |    3 +--
 sound/ppc/powermac.c                    |   13 +++----------
 sound/ppc/tumbler.c                     |    3 +--
 sound/usb/usbaudio.c                    |    6 ++----
 18 files changed, 62 insertions(+), 47 deletions(-)


The following things were done:

James Courtier-Dutton:
      [ALSA] snd-emu10k1: Fixes ALSA bug#2190
      [ALSA] snd-emu10k1: Implement support for Audigy 2 ZS [SB0353]

Johannes Berg:
      [ALSA] aoa: feature gpio layer: fix IRQ access
      [ALSA] aoa: fix toonie codec
      [ALSA] make snd-powermac load even when it can't bind the device
      [ALSA] aoa: platform function gpio: ignore errors from functions that don't exist
      [ALSA] add MAINTAINERS entry for snd-aoa

Panagiotis Issaris:
      [ALSA] Conversions from kmalloc+memset to k(z|c)alloc

Takashi Iwai:
      [ALSA] Don't reject O_RDWR at opening PCM OSS with read/write-only device


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
