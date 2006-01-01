Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWAANrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWAANrC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 08:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWAANq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 08:46:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18448 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932208AbWAANq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 08:46:58 -0500
Date: Sun, 1 Jan 2006 14:46:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] the scheduled removal of obsolete OSS drivers
Message-ID: <20060101134658.GU3811@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the scheduled removal of obsolete OSS drivers with 
ALSA replacements.

I've gotten exactly zero feedback regarding any of the hardware affected 
not working properly with ALSA.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Due to it's size, the patch is available at
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/misc/patch-oss-removal.gz

 Documentation/feature-removal-schedule.txt |    7 
 Documentation/sound/oss/AWE32              |   76 
 Documentation/sound/oss/CMI8338            |   85 
 Documentation/sound/oss/CS4232             |   23 
 Documentation/sound/oss/MAD16              |   56 
 Documentation/sound/oss/Maestro            |  123 
 Documentation/sound/oss/Maestro3           |   92 
 Documentation/sound/oss/NEWS               |   42 
 Documentation/sound/oss/NM256              |  280 
 Documentation/sound/oss/OPL3-SA            |   52 
 Documentation/sound/oss/Wavefront          |  339 -
 Documentation/sound/oss/btaudio            |   92 
 Documentation/sound/oss/es1370             |   70 
 Documentation/sound/oss/es1371             |   64 
 Documentation/sound/oss/rme96xx            |  767 --
 Documentation/sound/oss/solo1              |   70 
 Documentation/sound/oss/sonicvibes         |   81 
 MAINTAINERS                                |   36 
 arch/ppc/platforms/prep_setup.c            |   81 
 include/asm-powerpc/dma.h                  |   39 
 include/linux/ac97_codec.h                 |    5 
 include/linux/sound.h                      |    2 
 include/sound/wavefront.h                  |  695 --
 include/sound/wavefront_fx.h               |    9 
 sound/oss/Kconfig                          |  409 -
 sound/oss/Makefile                         |   67 
 sound/oss/ac97_codec.c                     |   89 
 sound/oss/ac97_plugin_ad1980.c             |  126 
 sound/oss/ad1848.c                         |    5 
 sound/oss/ad1848.h                         |    1 
 sound/oss/ali5455.c                        | 3733 ------------
 sound/oss/au1000.c                         | 2214 -------
 sound/oss/audio_syms.c                     |    3 
 sound/oss/awe_hw.h                         |   99 
 sound/oss/awe_wave.c                       | 6147 ---------------------
 sound/oss/awe_wave.h                       |   77 
 sound/oss/btaudio.c                        | 1136 ---
 sound/oss/cmpci.c                          | 3379 -----------
 sound/oss/cs4232.c                         |  522 -
 sound/oss/cs4281/Makefile                  |    6 
 sound/oss/cs4281/cs4281_hwdefs.h           | 1234 ----
 sound/oss/cs4281/cs4281_wrapper-24.c       |   41 
 sound/oss/cs4281/cs4281m.c                 | 4506 ---------------
 sound/oss/cs4281/cs4281pm-24.c             |   84 
 sound/oss/cs4281/cs4281pm.h                |   74 
 sound/oss/dm.h                             |   79 
 sound/oss/dmabuf.c                         |   46 
 sound/oss/emu10k1/8010.h                   |  737 --
 sound/oss/emu10k1/Makefile                 |   17 
 sound/oss/emu10k1/audio.c                  | 1588 -----
 sound/oss/emu10k1/audio.h                  |   44 
 sound/oss/emu10k1/cardmi.c                 |  832 --
 sound/oss/emu10k1/cardmi.h                 |   97 
 sound/oss/emu10k1/cardmo.c                 |  229 
 sound/oss/emu10k1/cardmo.h                 |   62 
 sound/oss/emu10k1/cardwi.c                 |  373 -
 sound/oss/emu10k1/cardwi.h                 |   91 
 sound/oss/emu10k1/cardwo.c                 |  643 --
 sound/oss/emu10k1/cardwo.h                 |   90 
 sound/oss/emu10k1/ecard.c                  |  157 
 sound/oss/emu10k1/ecard.h                  |  113 
 sound/oss/emu10k1/efxmgr.c                 |  220 
 sound/oss/emu10k1/efxmgr.h                 |  270 
 sound/oss/emu10k1/emuadxmg.c               |  104 
 sound/oss/emu10k1/hwaccess.c               |  507 -
 sound/oss/emu10k1/hwaccess.h               |  247 
 sound/oss/emu10k1/icardmid.h               |  163 
 sound/oss/emu10k1/icardwav.h               |   53 
 sound/oss/emu10k1/irqmgr.c                 |  113 
 sound/oss/emu10k1/irqmgr.h                 |   52 
 sound/oss/emu10k1/main.c                   | 1475 -----
 sound/oss/emu10k1/midi.c                   |  611 --
 sound/oss/emu10k1/midi.h                   |   78 
 sound/oss/emu10k1/mixer.c                  |  690 --
 sound/oss/emu10k1/passthrough.c            |  235 
 sound/oss/emu10k1/passthrough.h            |   99 
 sound/oss/emu10k1/recmgr.c                 |  147 
 sound/oss/emu10k1/recmgr.h                 |   48 
 sound/oss/emu10k1/timer.c                  |  176 
 sound/oss/emu10k1/timer.h                  |   54 
 sound/oss/emu10k1/voicemgr.c               |  398 -
 sound/oss/emu10k1/voicemgr.h               |  103 
 sound/oss/es1370.c                         | 2818 ---------
 sound/oss/es1371.c                         | 3129 ----------
 sound/oss/esssolo1.c                       | 2514 --------
 sound/oss/forte.c                          | 2137 -------
 sound/oss/gus.h                            |   24 
 sound/oss/gus_card.c                       |  293 -
 sound/oss/gus_hw.h                         |   50 
 sound/oss/gus_linearvol.h                  |   18 
 sound/oss/gus_midi.c                       |  256 
 sound/oss/gus_vol.c                        |  153 
 sound/oss/gus_wave.c                       | 3464 -----------
 sound/oss/harmony.c                        | 1330 ----
 sound/oss/ics2101.c                        |  247 
 sound/oss/mad16.c                          | 1113 ---
 sound/oss/maestro.c                        | 3833 -------------
 sound/oss/maestro.h                        |   60 
 sound/oss/maestro3.c                       | 2973 ----------
 sound/oss/maestro3.h                       |  821 --
 sound/oss/maui.c                           |  478 -
 sound/oss/mpu401.c                         |   13 
 sound/oss/mpu401.h                         |    2 
 sound/oss/nm256.h                          |  292 
 sound/oss/nm256_audio.c                    | 1709 -----
 sound/oss/nm256_coeff.h                    | 4697 ----------------
 sound/oss/opl3sa.c                         |  329 -
 sound/oss/rme96xx.c                        | 1856 ------
 sound/oss/rme96xx.h                        |   78 
 sound/oss/sequencer_syms.c                 |    7 
 sound/oss/sgalaxy.c                        |  207 
 sound/oss/sonicvibes.c                     | 2807 ---------
 sound/oss/sound_calls.h                    |    3 
 sound/oss/sscape.c                         | 1479 -----
 sound/oss/tuning.h                         |   10 
 sound/oss/via82cxxx_audio.c                | 3616 ------------
 sound/oss/wavfront.c                       | 3554 ------------
 sound/oss/wf_midi.c                        |  880 ---
 sound/oss/ymfpci.c                         | 2692 ---------
 sound/oss/ymfpci.h                         |  360 -
 sound/oss/ymfpci_image.h                   | 1565 -----
 sound/oss/yss225.c                         |  319 -
 sound/oss/yss225.h                         |   24 
 sound/sound_core.c                         |   34 
 124 files changed, 11 insertions(+), 90412 deletions(-)

