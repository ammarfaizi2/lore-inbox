Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVG1OAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVG1OAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVG1N61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:58:27 -0400
Received: from gate.perex.cz ([82.113.61.162]:48816 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261469AbVG1N5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:57:41 -0400
Date: Thu, 28 Jul 2005 15:57:40 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] 1.0.9b+
Message-ID: <Pine.LNX.4.61.0507281546040.8458@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2005-07-28.patch.gz

Additional notes:

  Mostly cleanups and added the Sparc DBRI driver.

The following files will be updated:

 sound/pcmcia/vx/vx_entry.c                      |  375 ---
 sound/pcmcia/vx/vxp440.c                        |   14 
 Documentation/sound/alsa/ALSA-Configuration.txt |   44 
 include/sound/core.h                            |   37 
 include/sound/driver.h                          |    2 
 include/sound/emu10k1.h                         |    1 
 include/sound/version.h                         |    4 
 sound/arm/Kconfig                               |   14 
 sound/arm/Makefile                              |    8 
 sound/arm/pxa2xx-ac97.c                         |  410 +++
 sound/arm/pxa2xx-pcm.c                          |  367 +++
 sound/arm/pxa2xx-pcm.h                          |   29 
 sound/core/device.c                             |   15 
 sound/core/info.c                               |    5 
 sound/core/memalloc.c                           |    3 
 sound/core/memory.c                             |    8 
 sound/core/seq/Makefile                         |    2 
 sound/core/seq/instr/ainstr_gf1.c               |    3 
 sound/core/seq/instr/ainstr_iw.c                |    8 
 sound/core/seq/seq_midi.c                       |   16 
 sound/core/wrappers.c                           |    2 
 sound/drivers/vx/vx_uer.c                       |   46 
 sound/i2c/other/ak4114.c                        |    1 
 sound/isa/gus/gus_main.c                        |    2 
 sound/isa/wavefront/wavefront_fx.c              |   34 
 sound/pci/ac97/ac97_codec.c                     |   25 
 sound/pci/ac97/ac97_patch.c                     |    3 
 sound/pci/ali5451/ali5451.c                     |    4 
 sound/pci/atiixp_modem.c                        |    1 
 sound/pci/cmipci.c                              |    9 
 sound/pci/cs46xx/cs46xx_lib.c                   |   15 
 sound/pci/emu10k1/emu10k1.c                     |   10 
 sound/pci/emu10k1/emu10k1_main.c                |  133 -
 sound/pci/emu10k1/p16v.c                        |   20 
 sound/pci/ens1370.c                             |   22 
 sound/pci/es1968.c                              |   14 
 sound/pci/hda/hda_codec.h                       |    3 
 sound/pci/hda/hda_intel.c                       |    6 
 sound/pci/hda/patch_cmedia.c                    |    5 
 sound/pci/hda/patch_realtek.c                   |   28 
 sound/pci/hda/patch_sigmatel.c                  |  810 +++++--
 sound/pci/intel8x0.c                            |   16 
 sound/pci/maestro3.c                            |   26 
 sound/pci/mixart/mixart.c                       |    4 
 sound/pci/rme9652/hdsp.c                        |   68 
 sound/pci/trident/trident_main.c                |    4 
 sound/pci/via82xx.c                             |   16 
 sound/pci/via82xx_modem.c                       |   13 
 sound/pci/ymfpci/ymfpci_main.c                  |    6 
 sound/pcmcia/Kconfig                            |   15 
 sound/pcmcia/vx/Makefile                        |    7 
 sound/pcmcia/vx/vxpocket.c                      |  437 +++
 sound/pcmcia/vx/vxpocket.h                      |   27 
 sound/ppc/awacs.c                               |    6 
 sound/ppc/pmac.h                                |    5 
 sound/ppc/tumbler.c                             |   16 
 sound/sparc/Kconfig                             |   22 
 sound/sparc/Makefile                            |    4 
 sound/sparc/dbri.c                              | 2729 ++++++++++++++++++++++++
 sound/usb/usbaudio.c                            |  105 
 sound/usb/usbaudio.h                            |   38 
 sound/usb/usbmidi.c                             |   21 
 sound/usb/usbquirks.h                           |   29 
 sound/usb/usx2y/usX2Yhwdep.c                    |    3 
 sound/usb/usx2y/usx2yhwdeppcm.c                 |    6 
 65 files changed, 5059 insertions(+), 1122 deletions(-)

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
