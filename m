Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSJ2KW6>; Tue, 29 Oct 2002 05:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSJ2KW6>; Tue, 29 Oct 2002 05:22:58 -0500
Received: from gate.perex.cz ([194.212.165.105]:21513 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261745AbSJ2KW4>;
	Tue, 29 Oct 2002 05:22:56 -0500
Date: Tue, 29 Oct 2002 11:28:11 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: LKML <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: ALSA update - 0.9.0rc5
Message-ID: <Pine.LNX.4.33.0210291119370.567-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-sound.bkbits.net/linux-sound

  The GNU patch is also available at

	ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2002-10-29.patch.gz

  The most of changes is removal of the snd_ prefix from the kernel module 
parameter names.

This will update the following files:

 include/sound/ac97_codec.h         |    6 
 include/sound/core.h               |    6 
 include/sound/sb.h                 |    1 
 include/sound/version.h            |    8 
 sound/arm/sa11xx-uda1341.c         |   10 
 sound/core/Makefile                |    7 
 sound/core/info.c                  |   18 
 sound/core/oss/pcm_oss.c           |   50 +-
 sound/core/pcm_memory.c            |   20 
 sound/core/rawmidi.c               |   46 +
 sound/core/seq/Makefile            |    2 
 sound/core/seq/seq.c               |   42 -
 sound/core/seq/seq_clientmgr.c     |    6 
 sound/core/seq/seq_timer.c         |   24 
 sound/core/sound.c                 |   56 +-
 sound/core/timer.c                 |    8 
 sound/core/wrappers.c              |   11 
 sound/drivers/dummy.c              |   82 +--
 sound/drivers/mpu401/mpu401.c      |   76 +--
 sound/drivers/mtpav.c              |   97 +--
 sound/drivers/serial-u16550.c      |  156 +++---
 sound/drivers/virmidi.c            |   58 +-
 sound/isa/ad1816a/ad1816a.c        |  180 +++----
 sound/isa/ad1848/ad1848.c          |   90 +--
 sound/isa/als100.c                 |  186 +++----
 sound/isa/azt2320.c                |  198 ++++----
 sound/isa/cmi8330.c                |  218 ++++----
 sound/isa/cs423x/cs4231.c          |  138 ++---
 sound/isa/cs423x/cs4236.c          |  310 ++++++------
 sound/isa/dt019x.c                 |  172 +++----
 sound/isa/es1688/es1688.c          |  130 ++---
 sound/isa/es18xx.c                 |  212 ++++----
 sound/isa/gus/gusclassic.c         |  160 +++---
 sound/isa/gus/gusextreme.c         |  228 ++++-----
 sound/isa/gus/gusmax.c             |  172 +++----
 sound/isa/gus/interwave.c          |  260 +++++-----
 sound/isa/opl3sa2.c                |  268 +++++-----
 sound/isa/opti9xx/opti92x-ad1848.c |  232 ++++-----
 sound/isa/sb/es968.c               |   96 +--
 sound/isa/sb/sb16.c                |  325 ++++++-------
 sound/isa/sb/sb16_main.c           |    4 
 sound/isa/sb/sb8.c                 |   90 +--
 sound/isa/sgalaxy.c                |  104 ++--
 sound/isa/wavefront/wavefront.c    |  326 ++++++-------
 sound/pci/Config.help              |    3 
 sound/pci/ali5451/ali5451.c        |   52 +-
 sound/pci/als4000.c                |   48 -
 sound/pci/cmipci.c                 |   66 +-
 sound/pci/cs4281.c                 |   52 +-
 sound/pci/cs46xx/cs46xx.c          |   68 +-
 sound/pci/emu10k1/emu10k1.c        |  112 ++--
 sound/pci/emu10k1/emufx.c          |    2 
 sound/pci/ens1370.c                |   46 -
 sound/pci/es1938.c                 |   46 -
 sound/pci/es1968.c                 |  104 ++--
 sound/pci/fm801.c                  |   40 -
 sound/pci/ice1712/ak4524.c         |   35 -
 sound/pci/ice1712/delta.c          |   64 ++
 sound/pci/ice1712/delta.h          |   17 
 sound/pci/ice1712/ews.c            |   21 
 sound/pci/ice1712/ice1712.c        |   50 +-
 sound/pci/ice1712/ice1712.h        |    5 
 sound/pci/intel8x0.c               |   94 +--
 sound/pci/korg1212/korg1212.c      |   40 -
 sound/pci/maestro3.c               |   64 +-
 sound/pci/nm256/nm256.c            |  138 ++---
 sound/pci/rme32.c                  |   38 -
 sound/pci/rme96.c                  |   40 -
 sound/pci/rme9652/hammerfall_mem.c |   10 
 sound/pci/rme9652/hdsp.c           |   70 +-
 sound/pci/rme9652/rme9652.c        |   50 +-
 sound/pci/sonicvibes.c             |   86 +--
 sound/pci/trident/trident.c        |   66 +-
 sound/pci/via82xx.c                |   88 +--
 sound/pci/ymfpci/ymfpci.c          |  140 ++---
 sound/ppc/powermac.c               |   48 -
 sound/sparc/amd7930.c              |   38 -
 sound/sparc/cs4231.c               |   38 -
 sound/usb/Config.help              |    4 
 sound/usb/Makefile                 |    8 
 sound/usb/usbaudio.c               |  186 ++++---
 sound/usb/usbaudio.h               |   36 -
 sound/usb/usbmidi.c                |  903 +++++++++++++++----------------------
 sound/usb/usbquirks.h              |   37 -
 84 files changed, 3957 insertions(+), 3985 deletions(-)

through these ChangeSets:

<perex@suse.cz> (02/10/29 1.871)
   ALSA update (0.9.0rc5)
     - ICE1712 - fixed Midiman M-audio Delta1010LT code
     - fixed typos in comments (es1938, intel8x0)
     - fixed quirks for Edirol UA-20 and UA-700 (USB driver)
   

<perex@suse.cz> (02/10/27 1.808.6.4)
   ALSA update
     - USB audio/midi code dependency/detection fixes
       - added a quirk for the Roland UA100 hardware
     - SB16 - added rmidi_callback to avoid dependency for mpu401_uart module
     - HSDP - fixed dependency

<perex@suse.cz> (02/10/22 1.808.6.3)
   ALSA update
     - fixed oops in snd_rawmidi_info()
     - MTPAV driver - fixed spin-deadlock
     - ICE1712 - added Midiman M-Audio Delta1010LT support, fixed spin-deadlock
     - emu10k1 - fixed memory allocation inside spinlock (GFP_ATOMIC)

<perex@suse.cz> (02/10/22 1.808.6.2)
   ALSA update
     - usb midi driver rewritten to use rawmidi interface

<perex@suse.cz> (02/10/22 1.781.8.12)
   ALSA update
     - changed names for module symbols: snd_xxxx ==> xxxx (removed prefix)


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

