Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbUCRMLk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbUCRMLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:11:39 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:38321 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262568AbUCRMLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:11:07 -0500
Date: Thu, 18 Mar 2004 13:07:37 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA 2.6 update
Message-ID: <Pine.LNX.4.58.0403181300570.1835@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-03-18.patch.gz

Additional notes:

  - fixes compilation and ommited code problems regarding reworked memory 
    allocation
  - fixes from Dave Jones - all modules can be loaded without crashing
    even when hardware is not present
  - au88x0 update
  - usbaudio code update and cleanups
  - fixed ALC650 AC'97 codec initialization

The pull command will update the following files:

 sound/core/init.c                    |    3 
 sound/core/memalloc.c                |    2 
 sound/drivers/mpu401/mpu401.c        |   39 ++++++-----
 sound/drivers/serial-u16550.c        |    5 -
 sound/i2c/cs8427.c                   |    1 
 sound/isa/dt019x.c                   |    8 +-
 sound/isa/es1688/es1688.c            |    7 +-
 sound/isa/es18xx.c                   |   12 ++-
 sound/isa/gus/gusclassic.c           |    7 +-
 sound/isa/gus/gusextreme.c           |  117 +++++++++++++++--------------------
 sound/isa/gus/gusmax.c               |    7 +-
 sound/isa/gus/interwave.c            |   12 ++-
 sound/isa/sb/es968.c                 |   17 ++---
 sound/isa/sb/sb16.c                  |   11 ++-
 sound/isa/sb/sb8.c                   |    7 +-
 sound/pci/ac97/ac97_patch.c          |   20 +++--
 sound/pci/au88x0/au8810.h            |   10 --
 sound/pci/au88x0/au8820.h            |    8 --
 sound/pci/au88x0/au8830.h            |   10 --
 sound/pci/au88x0/au88x0.c            |   44 +++++++------
 sound/pci/au88x0/au88x0.h            |   39 +++++++----
 sound/pci/au88x0/au88x0_core.c       |   28 ++++----
 sound/pci/au88x0/au88x0_pcm.c        |   38 ++++++++---
 sound/pci/emu10k1/emu10k1_callback.c |    2 
 sound/pci/emu10k1/memory.c           |    2 
 sound/pci/trident/trident_memory.c   |    6 -
 sound/ppc/pmac.c                     |    2 
 sound/sparc/cs4231.c                 |    4 -
 sound/usb/usbaudio.c                 |   24 +++----
 sound/usb/usbaudio.h                 |    4 -
 sound/usb/usbmidi.c                  |   19 +++++
 sound/usb/usbmixer.c                 |    2 
 32 files changed, 284 insertions(+), 233 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/03/18 1.1809)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   USB generic driver
   Returned back get_iface() macro for quirks
   Removed extra variable to avoid warning

<perex@suse.cz> (04/03/18 1.1808)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   add comments in USB MIDI vendor-specific detection functions

<perex@suse.cz> (04/03/18 1.1807)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   replace usage of interface index with calls to usb_ifnum_to_if

<perex@suse.cz> (04/03/18 1.1806)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   fix get_iface_desc macro

<perex@suse.cz> (04/03/18 1.1805)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   AC97 Codec Core
   added the quirk for Compaq Evo D510C.

<perex@suse.cz> (04/03/18 1.1804)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   PPC PMAC driver
   Fix against the new DMA API

<perex@suse.cz> (04/03/18 1.1803)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   USB generic driver
   don't resubmit unlinked urbs;
   move interface releasing after urb unlinking

<perex@suse.cz> (04/03/18 1.1802)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   au88x0 driver
   Manuel Jander <mjander@elo.utfsm.cl>:
   clean up and small bugfixes, the routing code fix for multiple streams.

<perex@suse.cz> (04/03/18 1.1801)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   SPARC cs4231 driver
   fixed the compilation error (missing comma).

<perex@suse.cz> (04/03/18 1.1800)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   SPARC cs4231 driver
   fixed the dma allocation type.

<perex@suse.cz> (04/03/18 1.1799)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   MPU401 UART
   use global variable to count cards

<perex@suse.cz> (04/03/18 1.1798)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   MPU401 UART
   don't use negative return value as card count

<perex@suse.cz> (04/03/18 1.1797)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   MPU401 UART
   don't use acpi_disabled because it isn't exported in all archs

<perex@suse.cz> (04/03/15 1.1630.7.13)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ES968 driver
   Fix against Dave's fix: put back the behaviour common to all ISA PnP modules

<perex@suse.cz> (04/03/15 1.1630.7.12)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   GUS Extreme driver
   Fixed typo

<perex@suse.cz> (04/03/15 1.1630.7.11)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   DT019x driver
   Added missing pnp_unregister_card_driver call

<perex@suse.cz> (04/03/15 1.1630.7.10)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   DT019x driver,ES968 driver
   <davej@redhat.com>
   Miscellaneous junk, indentation fixes and the like.

<perex@suse.cz> (04/03/15 1.1630.7.9)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ES968 driver
   <davej@redhat.com>
   This oopses on rmmod, as we do pnp_unregister_card_driver twice.

<perex@suse.cz> (04/03/15 1.1630.7.8)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ES18xx driver,ES1688 driver,GUS Classic driver,GUS Extreme driver
   GUS MAX driver,AMD InterWave driver,SB16/AWE driver,SB8 driver
   <davej@redhat.com>
   This is a *really* silly one.  The various probing routines in these
   drivers can return -ENODEV, -ENOMEM etc.. so when we do something like
   
   cards += probe_routine()
   
   In some situations we can end up with -13 sound cards, and other
   such nonsense. Result : lots of fun oopses.

<perex@suse.cz> (04/03/15 1.1630.7.7)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   ALSA Core
   <davej@redhat.com>
   Try modprobing a driver that the hardware doesn't exist for.
   In a few situations, you'll hit an oops due to proc_id not
   being filled out that early.

<perex@suse.cz> (04/03/15 1.1630.7.6)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   GUS Extreme driver
   <davej@redhat.com>
   Whilst chasing an oops, I shortened some error paths.

<perex@suse.cz> (04/03/15 1.1630.7.5)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   Memalloc module
   fixed the compilation with sparc sbus support.

<perex@suse.cz> (04/03/15 1.1630.7.4)
   ALSA CVS update - Takashi Iwai <tiwai@suse.de>
   EMU10K1/EMU10K2 driver,Trident driver
   fixed the mapping of silent pages on emu10k1 and trident SG buffers.

<perex@suse.cz> (04/03/15 1.1630.7.3)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Generic drivers
   Clean the 'AUTO' checking

<perex@suse.cz> (04/03/15 1.1630.7.2)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   I2C cs8427
   Don't reset chip when PCM rate was not changed


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
