Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTFJSsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTFJSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:43:48 -0400
Received: from gate.perex.cz ([194.212.165.105]:46607 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S264025AbTFJSh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:28 -0400
Date: Tue, 10 Jun 2003 20:50:58 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH/BK] ALSA update
Message-ID: <Pine.LNX.4.44.0306102046350.4730-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-06-10.patch.gz

Additional notes:

  Warning and compilation cleanups.
  This update will add missing symbols to the PnP layer, too.

The pull command will update the following files:

 drivers/pnp/isapnp/core.c     |    1 +
 drivers/pnp/pnpbios/core.c    |    2 ++
 include/linux/isapnp.h        |    4 ++--
 include/sound/sndmagic.h      |    4 ++--
 include/sound/version.h       |    2 +-
 sound/core/Kconfig            |    2 +-
 sound/isa/cs423x/cs4236_lib.c |    2 +-
 sound/isa/gus/interwave.c     |    2 +-
 sound/pci/ac97/ac97_patch.c   |   13 ++++++-------
 sound/pci/emu10k1/emufx.c     |    1 -
 sound/pci/ice1712/Makefile    |    9 +++++----
 sound/pci/ice1712/ak4xxx.c    |    4 ++++
 sound/pcmcia/vx/Makefile      |    9 +++++----
 sound/pcmcia/vx/vx_entry.c    |    5 -----
 sound/pcmcia/vx/vxpocket.c    |   31 ++++++++++++++++---------------
 15 files changed, 47 insertions(+), 44 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/06/10 1.1318)
   ALSA micro update - fixed compilation of VXPocket drivers (missing symbols)

<perex@suse.cz> (03/06/10 1.1243.56.1)
   ALSA update
     - fixed undefined symbols in PnP layer
     - fixed various warnings
     - azt3328 - fixed compilation in debug mode
     - ice17xx drivers - fixed compilation when both are built-in
     - vxpocket and vxp440
       - fixed compilation against the latest PCMCIA interface
       - fixed compilation when both drivers are built-in
     - removed empty sound/pci/ice1712/ak4524.c


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

