Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWF2T0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWF2T0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWF2T0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:26:36 -0400
Received: from [141.84.69.5] ([141.84.69.5]:29968 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932276AbWF2TV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:21:27 -0400
Date: Thu, 29 Jun 2006 21:20:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] the scheduled removal of some OSS drivers
Message-ID: <20060629192029.GS19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled removal of OSS drivers that:
- have ALSA drivers for the same hardware without known regressions and
- whose Kconfig options have been removed in 2.6.17.

This patch should go into 2.6.19.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Due to its size, the patch is available at
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/misc/patch-remove-oss-drivers.gz

 Documentation/feature-removal-schedule.txt |    8 
 Documentation/kernel-parameters.txt        |   25 
 Documentation/sound/oss/AWE32              |   76 
 Documentation/sound/oss/CMI8338            |   85 
 Documentation/sound/oss/INSTALL.awe        |  134 
 Documentation/sound/oss/MAD16              |   56 
 Documentation/sound/oss/Maestro            |  123 
 Documentation/sound/oss/Maestro3           |   92 
 Documentation/sound/oss/NEWS               |   42 
 Documentation/sound/oss/OPL3-SA            |   52 
 Documentation/sound/oss/README.awe         |  218 
 Documentation/sound/oss/Wavefront          |  339 -
 Documentation/sound/oss/es1370             |   70 
 Documentation/sound/oss/rme96xx            |  767 --
 Documentation/sound/oss/solo1              |   70 
 Documentation/sound/oss/sonicvibes         |   81 
 MAINTAINERS                                |   11 
 include/linux/ac97_codec.h                 |    5 
 include/linux/sound.h                      |    2 
 include/linux/wavefront.h                  |  675 --
 sound/oss/Makefile                         |   49 
 sound/oss/ac97.c                           |   20 
 sound/oss/ac97.h                           |    3 
 sound/oss/ac97_codec.c                     |   89 
 sound/oss/ac97_plugin_ad1980.c             |  126 
 sound/oss/ad1848.c                         |    4 
 sound/oss/ad1848.h                         |    1 
 sound/oss/ali5455.c                        | 3735 ------------
 sound/oss/au1000.c                         | 2216 -------
 sound/oss/audio_syms.c                     |    2 
 sound/oss/awe_hw.h                         |   99 
 sound/oss/awe_wave.c                       | 6149 ---------------------
 sound/oss/awe_wave.h                       |   77 
 sound/oss/cmpci.c                          | 3381 -----------
 sound/oss/cs4281/Makefile                  |    6 
 sound/oss/cs4281/cs4281_hwdefs.h           | 1234 ----
 sound/oss/cs4281/cs4281_wrapper-24.c       |   41 
 sound/oss/cs4281/cs4281m.c                 | 4487 ---------------
 sound/oss/cs4281/cs4281pm-24.c             |   45 
 sound/oss/cs4281/cs4281pm.h                |   74 
 sound/oss/dm.h                             |   79 
 sound/oss/dmabuf.c                         |   30 
 sound/oss/es1370.c                         | 2819 ---------
 sound/oss/esssolo1.c                       | 2516 --------
 sound/oss/forte.c                          | 2139 -------
 sound/oss/gus.h                            |   24 
 sound/oss/gus_card.c                       |  293 -
 sound/oss/gus_hw.h                         |   50 
 sound/oss/gus_linearvol.h                  |   18 
 sound/oss/gus_midi.c                       |  256 
 sound/oss/gus_vol.c                        |  153 
 sound/oss/gus_wave.c                       | 3464 -----------
 sound/oss/harmony.c                        | 1330 ----
 sound/oss/ics2101.c                        |  247 
 sound/oss/iwmem.h                          |   36 
 sound/oss/mad16.c                          | 1113 ---
 sound/oss/maestro.c                        | 3686 ------------
 sound/oss/maestro.h                        |   60 
 sound/oss/maestro3.c                       | 2969 ----------
 sound/oss/maestro3.h                       |  821 --
 sound/oss/maui.c                           |  478 -
 sound/oss/mpu401.c                         |   12 
 sound/oss/mpu401.h                         |    2 
 sound/oss/opl3sa.c                         |  329 -
 sound/oss/rme96xx.c                        | 1857 ------
 sound/oss/rme96xx.h                        |   78 
 sound/oss/sequencer.c                      |    1 
 sound/oss/sequencer_syms.c                 |    7 
 sound/oss/sgalaxy.c                        |  207 
 sound/oss/sonicvibes.c                     | 2792 ---------
 sound/oss/sound_calls.h                    |    2 
 sound/oss/tuning.h                         |   10 
 sound/oss/wavfront.c                       | 3554 ------------
 sound/oss/wf_midi.c                        |  880 ---
 sound/oss/ymfpci.c                         | 2692 ---------
 sound/oss/ymfpci.h                         |  361 -
 sound/oss/ymfpci_image.h                   | 1565 -----
 sound/oss/yss225.c                         |  319 -
 sound/oss/yss225.h                         |   24 
 sound/sound_core.c                         |   34 
 80 files changed, 6 insertions(+), 62070 deletions(-)
