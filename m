Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSBMRVa>; Wed, 13 Feb 2002 12:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSBMRVN>; Wed, 13 Feb 2002 12:21:13 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:62855 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S287886AbSBMRVJ>; Wed, 13 Feb 2002 12:21:09 -0500
Date: Wed, 13 Feb 2002 12:21:06 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202131721.g1DHL6w15916@devserv.devel.redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 sound module problem
In-Reply-To: <mailman.1013591941.29105.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1013591941.29105.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are PCI drivers using the old sound code. Whether it matters is a 
> more complicated question as these devices use ISA DMA emulation or their
> own pseudo DMA functionality.
> 
> Alan

Sometimes it's only a configuration mistake. Not that it mattered,
since "The ALSA is coming! The ALSA is coming!" can be heard from
our forrestals.

--- linux-2.5.4/drivers/sound/Config.in	Sun Feb 10 17:50:10 2002
+++ linux-2.5.4-p3/drivers/sound/Config.in	Mon Feb 11 10:12:51 2002
@@ -164,7 +164,7 @@
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2 and SA3 based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI
+   dep_tristate '    Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_PCI
    dep_mbool '      Yamaha PCI legacy ports support' CONFIG_SOUND_YMFPCI_LEGACY $CONFIG_SOUND_YMFPCI
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 $CONFIG_SOUND_OSS   

