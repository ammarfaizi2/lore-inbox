Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318607AbSHUSUP>; Wed, 21 Aug 2002 14:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318608AbSHUSUP>; Wed, 21 Aug 2002 14:20:15 -0400
Received: from gate.perex.cz ([194.212.165.105]:22034 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S318607AbSHUSUN>;
	Wed, 21 Aug 2002 14:20:13 -0400
Date: Wed, 21 Aug 2002 20:21:05 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA 0.9.0rc3
Message-ID: <Pine.LNX.4.33.0208212008330.5936-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Linus, please, apply these patches with latest ALSA code to 2.5 
tree:

Plain patch:
------------

ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-1.489.1.1.patch.gz
ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-1.501.patch.gz

BK send/receive format (including nice per file comments/changelogs):
---------------------------------------------------------------------

ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-1.489.1.1.bk.gz
ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-1.501.bk.gz

BK linux-sound repository
-------------------------

bk pull http://linux-sound.bkbits.net/main

ChangeSets: 1.489.1.1 and 1.501

Web: http://linux-sound.bkbits.net

Description:
------------

ALSA 0.9.0rc3 release

* fixes for x86-64
* fixed ioctl32 wrapper
* removed compatibility __NO_VERSION__ defines
* C99-like structure initializers for all code
* Control interface
  - fixed read() behaviour
* PCM interface
  - added support for more PCM formats (up to 512)
    - added 24-bit formats for USB audio
  - removed drain call from the snd_pcm_close() function, data are 
    always dropped
  - added support for Scatter-Gather DMA
  - added SBUS DMA support by David S. Miller <davem@redhat.com>
* Timer interface
  - fixed kmod behaviour for system timers
  - fixed read() behaviour
* RawMidi interface
  - fixed read() behaviour
* Sequencer interface
  - reset the timer at continue if not initialized yet
  - check the possible infinite loop in priority queues
  - fixed deadlock at snd_seq_timer_start/stop
* intel8x0 driver
  - fixed pci id of AMD8111
* via686 driver
  - added Scatter-Gather DMA support
  - fixes in AC97 codec initialization
* opti92x/93x driver
  - overall fixes
* via8233 driver
  - fixed playback of mono samples
  - added Scatter-Gather DMA support
* EMU10K1/Audigy driver
  - added Scatter-Gather DMA support for playback
  - added workaround for capture (ring buffer pointer)
* NM256 driver
  - fixed the lock up on NM256 ZX (Dell Latitude Cpt)
* CS46xx driver
  - added support for new DSP images
  - experimental rear and SPDIF outputs
* added snd-usbaudio and snd-usbmidi driver
* ymfpci driver
  - fixed GPIO read/write
  - added snd_rear_switch option
* ice1712 driver
* fixed SMP dead-lock (CS8427 I2C code)
* HDSP driver
  - overall code improvement
* CS4236 driver
  - new ISA PnP ID
* CS4281 driver
  - added the power management code
* PPC Keywest
  - fixed the initialization of driver
* serial-u16550
  - added support for generic adapter
* renamed dt0197h -> dt019x driver
* ac97 code
  - added VIA and Conexant codecs
  - added AD1981A codec from Analog Devices
  - added the ids for ITE chips
  - separated codec specific initialization

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

