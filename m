Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422821AbWJFS1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbWJFS1l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422822AbWJFS1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:27:41 -0400
Received: from gate.perex.cz ([85.132.177.35]:7906 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1422821AbWJFS1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:27:40 -0400
Date: Fri, 6 Oct 2006 20:27:38 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] alsa-git merge request
Message-ID: <Pine.LNX.4.61.0610062025300.8573@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
  (linus branch)

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-10-06.patch.gz

Additional notes:

  This patch group contains only serious bugfixes and new device IDs.


The following files will be updated:

 include/sound/core.h             |    4 +-
 include/sound/version.h          |    6 +-
 sound/core/hwdep.c               |    3 +
 sound/core/init.c                |   92 +++++++++++++++++++++-----------------
 sound/isa/es18xx.c               |    1 
 sound/pci/ac97/ac97_patch.c      |    7 ++-
 sound/pci/au88x0/au88x0.c        |    1 
 sound/pci/emu10k1/emu10k1_main.c |    4 +-
 sound/pci/hda/hda_intel.c        |    1 
 sound/pci/hda/patch_realtek.c    |    4 ++
 sound/pci/hda/patch_si3054.c     |    5 ++
 sound/usb/usx2y/usbusx2yaudio.c  |   18 ++-----
 sound/usb/usx2y/usx2yhwdeppcm.c  |   17 ++-----
 13 files changed, 89 insertions(+), 74 deletions(-)


The following things were done:

Amol Lad:
      [ALSA] sound/pci/au88x0/au88x0.c: ioremap balanced with iounmap

Arnaud Patard:
      [ALSA] emu10k1: Fix outl() in snd_emu10k1_resume_regs()

Dan Cyr:
      [ALSA] hda-intel - New pci id for Nvidia MCP61

Eric Sesterhenn:
      [ALSA] Fix memory leak in sound/isa/es18xx.c

Florin Malita:
      [ALSA] Dereference after free in snd_hwdep_release()

Jaroslav Kysela:
      [ALSA] version 1.0.13

Karsten Wiese:
      [ALSA] Fix bug in snd-usb-usx2y's usX2Y_pcms_lock_check()
      [ALSA] Repair snd-usb-usx2y for usb 2.6.18
      [ALSA] Handle file operations during snd_card disconnects using static file->f_op

Luke Zhang:
      [ALSA] WM9712 fixes for ac97_patch.c

Sasha Khapyorsky:
      [ALSA] hda/patch_si3054: new codec vendor IDs

Tobin Davis:
      [ALSA] Add new subdevice ids for hda-intel

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
