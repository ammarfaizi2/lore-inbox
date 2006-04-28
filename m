Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWD1TZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWD1TZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWD1TZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:25:51 -0400
Received: from gate.perex.cz ([85.132.177.35]:23754 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751703AbWD1TZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:25:50 -0400
Date: Fri, 28 Apr 2006 21:25:47 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA sync
Message-ID: <Pine.LNX.4.61.0604282112590.11398@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-04-28.patch.gz

Additional notes:

  This patch contains only cleanups, fixes and very simple driver 
  enhancements.

The following files will be updated:

 Documentation/sound/alsa/Audiophile-Usb.txt                  |   81 +++++++----
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    4 
 drivers/media/video/cx88/cx88-alsa.c                         |    2 
 include/sound/pcm.h                                          |    6 
 include/sound/pcm_oss.h                                      |    2 
 sound/core/Kconfig                                           |   12 +
 sound/core/oss/pcm_oss.c                                     |    8 -
 sound/core/pcm.c                                             |   12 -
 sound/core/pcm_lib.c                                         |    6 
 sound/core/pcm_memory.c                                      |    8 -
 sound/drivers/dummy.c                                        |   14 -
 sound/drivers/mpu401/mpu401.c                                |   14 -
 sound/drivers/serial-u16550.c                                |   14 -
 sound/drivers/virmidi.c                                      |   14 -
 sound/isa/opti9xx/miro.c                                     |    3 
 sound/pci/ad1889.c                                           |    3 
 sound/pci/ali5451/ali5451.c                                  |    2 
 sound/pci/als300.c                                           |    2 
 sound/pci/als4000.c                                          |    2 
 sound/pci/atiixp.c                                           |    2 
 sound/pci/atiixp_modem.c                                     |    2 
 sound/pci/au88x0/au8810.c                                    |    2 
 sound/pci/au88x0/au8820.c                                    |    2 
 sound/pci/au88x0/au8830.c                                    |    2 
 sound/pci/azt3328.c                                          |    2 
 sound/pci/bt87x.c                                            |    4 
 sound/pci/ca0106/ca0106_main.c                               |    2 
 sound/pci/cmipci.c                                           |    2 
 sound/pci/cs4281.c                                           |    2 
 sound/pci/cs46xx/cs46xx.c                                    |    2 
 sound/pci/cs5535audio/cs5535audio.c                          |    2 
 sound/pci/emu10k1/emu10k1.c                                  |    2 
 sound/pci/emu10k1/emu10k1x.c                                 |    3 
 sound/pci/ens1370.c                                          |    2 
 sound/pci/es1938.c                                           |    2 
 sound/pci/es1968.c                                           |    3 
 sound/pci/fm801.c                                            |    2 
 sound/pci/hda/hda_intel.c                                    |    2 
 sound/pci/hda/patch_analog.c                                 |   13 -
 sound/pci/hda/patch_realtek.c                                |    1 
 sound/pci/hda/patch_sigmatel.c                               |    4 
 sound/pci/ice1712/ice1712.c                                  |    3 
 sound/pci/ice1712/ice1724.c                                  |    2 
 sound/pci/intel8x0.c                                         |    8 -
 sound/pci/intel8x0m.c                                        |    2 
 sound/pci/korg1212/korg1212.c                                |    2 
 sound/pci/maestro3.c                                         |    3 
 sound/pci/mixart/mixart.c                                    |    3 
 sound/pci/nm256/nm256.c                                      |    2 
 sound/pci/pcxhr/pcxhr.c                                      |    3 
 sound/pci/pcxhr/pcxhr_hwdep.c                                |    4 
 sound/pci/riptide/riptide.c                                  |    4 
 sound/pci/rme32.c                                            |    2 
 sound/pci/rme96.c                                            |    2 
 sound/pci/rme9652/hdsp.c                                     |    2 
 sound/pci/rme9652/hdspm.c                                    |    2 
 sound/pci/rme9652/rme9652.c                                  |    2 
 sound/pci/sonicvibes.c                                       |    2 
 sound/pci/trident/trident.c                                  |    2 
 sound/pci/via82xx.c                                          |   18 ++
 sound/pci/via82xx_modem.c                                    |    2 
 sound/pci/vx222/vx222.c                                      |    2 
 sound/pci/ymfpci/ymfpci.c                                    |    2 
 sound/pcmcia/Kconfig                                         |    4 
 sound/usb/usbquirks.h                                        |    9 +
 65 files changed, 196 insertions(+), 160 deletions(-)


The following things were done:

Adrian Bunk:
      [ALSA] sound/pci/: remove duplicate #include's

Bastiaan Jacques:
      [ALSA] via82xx: add support for VIA VT8251 (AC'97)
      [ALSA] via82xx: tweak VT8251 workaround

Charis Kouzinopoulos:
      [ALSA] Fix typos and add information about Jack support to Audiophile-Usb.txt

Clemens Ladisch:
      [ALSA] add another Phase 26 quirk

Erik Mouw:
      [ALSA] PCMCIA sound devices shouldn't depend on ISA

Henrik Kretzschmar:
      [ALSA] pcxhr - Fix a compiler warning on 64bit architectures
      [ALSA] add __devinitdata to all pci_device_id

Jaroslav Kysela:
      [ALSA] PCM core - introduce CONFIG_SND_PCM_XRUN_DEBUG

Kenrik Kretzschmar:
      [ALSA] adding __devinitdata to pci_device_id

Rene Herman:
      [ALSA] continue on IS_ERR from platform device registration

Steven Finney:
      [ALSA] Handle the error correctly in SNDCTL_DSP_SETFMT ioctl

Takashi Iwai:
      [ALSA] hda-codec - Use model 'hp' for all HP laptops with AD1981HD
      [ALSA] hda-codec - Add entry for Epox EP-5LDA+ GLi
      [ALSA] Fix double free in error path of miro driver
      [ALSA] intel8x0 - Disable ALI5455 SPDIF-input
      [ALSA] hda-codec - Add model entry for ASUS M9 laptop
      [ALSA] hda-codec - Add codec id for AD1988B codec chip
      [ALSA] Fix Oops at rmmod with CONFIG_SND_VERBOSE_PROCFS=n
      [ALSA] hda-codec - Fix capture from line-in on VAIO SZ/FE laptops
      [ALSA] hda-codec - Add model entry for ASUS Z62F
      [ALSA] via82xx - Use DXS_SRC as default for VIA8235/8237/8251 chips

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
