Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbUCONwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 08:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUCONwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 08:52:37 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:10903 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262571AbUCONwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 08:52:34 -0500
Date: Mon, 15 Mar 2004 14:50:39 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA build fixes
Message-ID: <Pine.LNX.4.58.0403151448430.13684@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-03-15.patch.gz

Additional notes:

  - added MPU-401 ACPI PnP code
  - fixed building of Aureal code (au88x0)

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt |    4 
 include/sound/ac97_codec.h                      |    4 
 sound/drivers/mpu401/mpu401.c                   |  216 +++++++++++++++++++++---
 sound/pci/ac97/ac97_codec.c                     |    1 
 sound/pci/ac97/ac97_patch.c                     |   15 +
 sound/pci/ac97/ac97_patch.h                     |    1 
 sound/pci/au88x0/au88x0.c                       |    4 
 sound/pci/au88x0/au88x0_a3d.c                   |    2 
 sound/pci/au88x0/au88x0_core.c                  |    4 
 sound/pci/au88x0/au88x0_game.c                  |    9 +
 sound/pci/intel8x0.c                            |   17 +
 11 files changed, 246 insertions(+), 31 deletions(-)

through these ChangeSets:

<perex@suse.cz> (04/03/15 1.1614.4.29)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   au88x0 driver
   Fixed gameport dependency and solid kernel build

<perex@suse.cz> (04/03/15 1.1614.4.28)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   au88x0 driver
   Make mchannels and rampchs static

<perex@suse.cz> (04/03/15 1.1614.4.27)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   Intel8x0 driver
   add Intel ICH6 and ESB

<perex@suse.cz> (04/03/15 1.1614.4.26)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   au88x0 driver
   fix compilation on gcc 2.95.x

<perex@suse.cz> (04/03/15 1.1614.4.25)
   ALSA CVS update - Clemens Ladisch <clemens@ladisch.de>
   Documentation,MPU401 UART
   integrate MPU-401 ACPI PnP from alsa-driver

<perex@suse.cz> (04/03/15 1.1614.4.24)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   AC97 Codec Core
   Kevin Mack <kevmack@accesscomm.ca>
   Here's a quick and dirty patch that's given me basic sound from
   my Gateway M675 notebook (Sigmatel 9758 AC97 codec).

<perex@suse.cz> (04/03/15 1.1614.4.23)
   ALSA CVS update - Jaroslav Kysela <perex@suse.cz>
   Intel8x0 driver
   Added slot definitions for s/pdif pcm - ICH4

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
