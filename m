Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbTBPUdu>; Sun, 16 Feb 2003 15:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbTBPUdu>; Sun, 16 Feb 2003 15:33:50 -0500
Received: from gate.perex.cz ([194.212.165.105]:46353 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267482AbTBPUds>;
	Sun, 16 Feb 2003 15:33:48 -0500
Date: Sun, 16 Feb 2003 21:43:33 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update
Message-ID: <Pine.LNX.4.44.0302162141320.1060-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-02-16.patch.gz

The pull command will update the following files:

 include/sound/ac97_codec.h       |   10 ++
 include/sound/pcm.h              |   14 ++
 include/sound/pcm_sgbuf.h        |   12 +-
 include/sound/version.h          |    2 
 sound/arm/sa11xx-uda1341.c       |    6 -
 sound/core/hwdep.c               |    2 
 sound/core/isadma.c              |    2 
 sound/core/oss/pcm_oss.c         |    5 -
 sound/core/pcm_lib.c             |  108 ++++++++++++++-------
 sound/core/pcm_memory.c          |  192 +++++++++++++++++++++++----------------
 sound/core/pcm_native.c          |   15 ++-
 sound/core/pcm_sgbuf.c           |  143 ++++++-----------------------
 sound/core/seq/seq_device.c      |    2 
 sound/core/seq/seq_midi_emul.c   |    4 
 sound/core/timer.c               |    3 
 sound/drivers/mtpav.c            |   19 +++
 sound/i2c/l3/uda1341.c           |   14 +-
 sound/isa/cs423x/cs4231_lib.c    |   26 +++--
 sound/isa/cs423x/cs4236.c        |    2 
 sound/isa/cs423x/cs4236_lib.c    |    2 
 sound/isa/gus/interwave.c        |    2 
 sound/isa/sb/emu8000_pcm.c       |    2 
 sound/pci/ac97/ac97_codec.c      |   82 ++++++++++++++++
 sound/pci/ali5451/ali5451.c      |    2 
 sound/pci/cs46xx/cs46xx_lib.c    |   14 +-
 sound/pci/emu10k1/emufx.c        |    2 
 sound/pci/emu10k1/emupcm.c       |    2 
 sound/pci/emu10k1/memory.c       |   14 ++
 sound/pci/intel8x0.c             |    4 
 sound/pci/maestro3.c             |    6 -
 sound/pci/nm256/nm256.c          |    2 
 sound/pci/rme9652/hdsp.c         |    2 
 sound/pci/trident/trident_main.c |    6 -
 sound/pci/via82xx.c              |   21 ++--
 sound/usb/usbaudio.c             |   62 +++++++++++-
 sound/usb/usbaudio.h             |    3 
 sound/usb/usbquirks.h            |   16 +++
 37 files changed, 514 insertions(+), 311 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/02/16 1.1044)
   ALSA update
     - AC'97 - added quirks for tuning of hardware configuration
     - PCM midlevel - improved ring buffer allocation
     - sa11xx-uda1341 - small fixes
     - ISA - fixed ring buffer pointer calculation
     - OSS PCM - fixed deadlock (rate plugin)
     - timer - fixed deadlock when user interface is used
     - CS4232 - added detection of plain CS4236
     - USB driver - added boot quirk for SoundBlaster Extigy


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

