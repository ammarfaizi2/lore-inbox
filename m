Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTFFMzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 08:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTFFMzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 08:55:41 -0400
Received: from gate.perex.cz ([194.212.165.105]:6663 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261414AbTFFMzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 08:55:38 -0400
Date: Fri, 6 Jun 2003 15:09:07 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH/BK] ALSA update
Message-ID: <Pine.LNX.4.44.0306061507290.1499-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-06-06.patch.gz

Additional notes:

  - includes the USB compilation fix as well

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |    7 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |  116 
 include/sound/ak4xxx-adda.h                                  |    9 
 include/sound/core.h                                         |    2 
 include/sound/version.h                                      |    2 
 sound/core/Makefile                                          |    1 
 sound/core/init.c                                            |   20 
 sound/core/pcm_native.c                                      |    2 
 sound/core/seq/Makefile                                      |    1 
 sound/core/seq/instr/Makefile                                |    1 
 sound/drivers/mpu401/Makefile                                |    1 
 sound/drivers/opl3/Makefile                                  |    1 
 sound/i2c/other/ak4xxx-adda.c                                |   28 
 sound/pci/Kconfig                                            |    8 
 sound/pci/Makefile                                           |    2 
 sound/pci/ac97/ac97_codec.c                                  |   21 
 sound/pci/azt3328.c                                          | 1621 +++++++++++
 sound/pci/azt3328.h                                          |  165 +
 sound/pci/ens1370.c                                          |    3 
 sound/pci/fm801.c                                            |    1 
 sound/pci/ice1712/Makefile                                   |    2 
 sound/pci/ice1712/ak4xxx.c                                   |   11 
 sound/pci/ice1712/aureon.c                                   |  507 +++
 sound/pci/ice1712/aureon.h                                   |   47 
 sound/pci/ice1712/ice1712.c                                  |    3 
 sound/pci/ice1712/ice1724.c                                  |   43 
 sound/pci/ice1712/revo.c                                     |   11 
 sound/pci/via82xx.c                                          |    1 
 sound/ppc/pmac.c                                             |   18 
 sound/ppc/tumbler.c                                          |   66 
 sound/usb/usbaudio.c                                         |   83 
 31 files changed, 2680 insertions(+), 124 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/06/06 1.1315)
   ALSA update
     - added AZT3328 driver
     - added Terratec Aureon support to ICE1724 driver
     - fixed possible PCI posting problems
       - ENS1370, ENS1371, FM801, ICE1712, ICE1724, VIA82xx
     - AC'97 code
       - added new IDs
       - fixed typo in S/PDIF code
       - C-Media related fixes
     - USB driver
       - added nrpacks module option
       - added hack for AudioTrak Optoplay
       - removed OLD_USB stuff


-----
Jaroslav Kysela <perex@perex.cz>

