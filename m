Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUCaNBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 08:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCaNBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 08:01:49 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:58246 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S261937AbUCaNBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 08:01:41 -0500
Date: Wed, 31 Mar 2004 15:02:19 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update - 1.0.4rc2
Message-ID: <Pine.LNX.4.58.0403311458260.27373@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-03-30.patch.gz

Additional notes:

  - small bugfixes, USB cleanups and documentation update

					Jaroslav

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt |    6 
 Documentation/sound/alsa/Procfile.txt           |  185 +++++++++++++++
 include/sound/ac97_codec.h                      |    2 
 include/sound/cs8427.h                          |    3 
 include/sound/pcm.h                             |    2 
 include/sound/version.h                         |   12 
 sound/core/ioctl32/timer32.c                    |   10 
 sound/core/pcm.c                                |    2 
 sound/core/pcm_lib.c                            |   13 -
 sound/core/pcm_timer.c                          |   12 
 sound/i2c/cs8427.c                              |    9 
 sound/pci/ac97/ac97_codec.c                     |   17 -
 sound/pci/ac97/ac97_patch.c                     |   18 +
 sound/pci/ac97/ac97_pcm.c                       |    4 
 sound/pci/ac97/ac97_proc.c                      |   10 
 sound/pci/au88x0/au88x0.h                       |   17 -
 sound/pci/cs46xx/cs46xx.c                       |   11 
 sound/pci/ice1712/delta.c                       |    2 
 sound/pci/ice1712/ice1712.c                     |   34 +-
 sound/pci/ice1712/ice1712.h                     |    1 
 sound/pci/intel8x0.c                            |   21 +
 sound/pcmcia/pdaudiocf/pdaudiocf.c              |    1 
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c         |    1 
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c          |    1 
 sound/ppc/powermac.c                            |   10 
 sound/usb/usbaudio.c                            |  291 +++++++++++++++++-------
 sound/usb/usbaudio.h                            |    5 
 sound/usb/usbmidi.c                             |    1 
 28 files changed, 535 insertions(+), 166 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/03/30 1.1721)
   ALSA - 1.0.4rc2

<perex@suse.cz> (04/03/30 1.1720)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   au88x0 driver
   Cleanups - removed duplicate PCI IDs

<perex@suse.cz> (04/03/30 1.1719)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   add usb_device->speed wrapper for compiling with 2.2.x kernels

<perex@suse.cz> (04/03/29 1.1692.3.57)
   ALSA - fixed date in version.h

<perex@suse.cz> (04/03/29 1.1692.3.56)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   AC97 Codec Core
   don't clobber other bits in SERIAL_CFG register with AD codecs when changing codec selection bits

<perex@suse.cz> (04/03/29 1.1692.3.55)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   AC97 Codec Core
   fix hang because of uninitialized ad18xx.mutex with AD1985

<perex@suse.cz> (04/03/29 1.1692.3.54)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   AC97 Codec Core
   fix superfluous rate register assignments

<perex@suse.cz> (04/03/29 1.1692.3.53)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   AC97 Codec Core
   fix detection of 2.3 codecs

<perex@suse.cz> (04/03/29 1.1692.3.52)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   IOCTL32 emulation
   disabled the entries conflifting with TIOC* ioctls.

<perex@suse.cz> (04/03/29 1.1692.3.51)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ICE1712 driver
   Fixed Delta410 cs8427 i/o

<perex@suse.cz> (04/03/29 1.1692.3.50)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   CS46xx driver
   mmap_valid is 1 by default

<perex@suse.cz> (04/03/29 1.1692.3.49)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   CS46xx driver
   Added parsing of mmap_valid,external_amp and thinkpad parameters at boot time

<perex@suse.cz> (04/03/29 1.1692.3.48)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PPC PowerMac driver
   Remove global enable variable

<perex@suse.cz> (04/03/29 1.1692.3.47)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Version
   release: 1.0.4rc1

<perex@suse.cz> (04/03/29 1.1692.3.46)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ICE1712 driver
   From: Arjan van de Ven <arjanv@redhat.com>
   
   ice1712.c: move 2 same structs to the top of the function; gcc won't share
   the stackslots anyway

<perex@suse.cz> (04/03/29 1.1692.3.45)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   disable the legacy midi/joystick properly as default.

<perex@suse.cz> (04/03/29 1.1692.3.44)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation,I2C cs8427,ICE1712 driver
   fixed cs8427_timeout option to use the correct value in msec.

<perex@suse.cz> (04/03/29 1.1692.3.43)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Documentation
   Corrected cs8427_timeout

<perex@suse.cz> (04/03/29 1.1692.3.42)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   adjust usb_set_interface() calls for 2.6.5-rc2

<perex@suse.cz> (04/03/29 1.1692.3.41)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PCM Midlevel
   Fix in snd_pcm_timer_resolution_change() - it no longer oops when
   32-bit value overflows.

<perex@suse.cz> (04/03/29 1.1692.3.40)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   fix deadlock on register_mutex and other bugs
   in initialization error paths

<perex@suse.cz> (04/03/29 1.1692.3.39)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Sound Core PDAudioCF driver
   Adrian Bunk <bunk@fs.tum.de>
   Fix warnings (SNDRV_GET_ID is not required since these files don't use get_id).

<perex@suse.cz> (04/03/29 1.1692.3.38)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Documentation
   Added cs8427_timeout to the snd-ice1712 module description

<perex@suse.cz> (04/03/29 1.1692.3.37)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   I2C cs8427,ALSA Version,ICE1712 driver
   Added cs8427_timeout parameter to the ICE1712 driver

<perex@suse.cz> (04/03/29 1.1692.3.36)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   Removed the unprocessed IRQ detection, it seems bogus.

<perex@suse.cz> (04/03/29 1.1692.3.35)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Documentation
   The description about ALSA proc files, including debug information.

<perex@suse.cz> (04/03/29 1.1692.3.34)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   PCM Midlevel
   - suppress the xrun debug output unless xrun_debug proc is set.
   - show stack trace when xrun_debug > 1.

<perex@suse.cz> (04/03/29 1.1692.3.33)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Intel8x0 driver
   added the quirk for Compaq Evo D510C.

<perex@suse.cz> (04/03/29 1.1692.3.32)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   high speed support

<perex@suse.cz> (04/03/29 1.1692.3.31)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   clean up get_iface again :)

<perex@suse.cz> (04/03/29 1.1692.3.30)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   replace usage of interface index with calls to usb_ifnum_to_if (forgot this in 1.88)

<perex@suse.cz> (04/03/29 1.1692.3.29)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   remove calls to usb_driver_release_interface
   (not needed when disconnect is called)


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
