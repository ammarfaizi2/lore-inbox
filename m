Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288716AbSANDH6>; Sun, 13 Jan 2002 22:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288725AbSANDHt>; Sun, 13 Jan 2002 22:07:49 -0500
Received: from codepoet.org ([166.70.14.212]:14257 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288716AbSANDHc>;
	Sun, 13 Jan 2002 22:07:32 -0500
Date: Sun, 13 Jan 2002 20:07:34 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: drivers missing __devexit_p in 2.4.18pre3
Message-ID: <20020114030734.GB17592@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick check of the source code shows that the following drivers
appear to still be lacking the devinit fixes which are needed for
the kernel to compile when using newer versions of binutils.

Each of these files probably needs the following (though I'm too
lazy to do it all myself, since my kernel doesn't use any of this
stuff):

	s/remove:\(.*\)/remove:__devexit_p(\1)/g

drivers/net/wan/dscc4.c
drivers/net/tokenring/abyss.c
drivers/net/tokenring/tmspci.c
drivers/net/pcnet32.c
drivers/net/sis900.c
drivers/net/dmfe.c
drivers/net/rcpci45.c
drivers/net/hamachi.c
drivers/net/wireless/orinoco_plx.c
drivers/char/synclink.c
drivers/char/n_r3964.c
drivers/char/wdt_pci.c
drivers/scsi/tmscsim.c
drivers/scsi/aic7xxx/aic7xxx_linux_pci.c
drivers/sound/es1370.c
drivers/sound/maestro.c
drivers/sound/trident.c
drivers/sound/es1371.c
drivers/sound/cs4281/cs4281m.c
drivers/sound/i810_audio.c
drivers/sound/sonicvibes.c
drivers/sound/esssolo1.c
drivers/sound/maestro3.c
drivers/sound/cs46xx.c
drivers/sound/nm256_audio.c
drivers/sound/via82cxxx_audio.c
drivers/sound/rme96xx.c
drivers/sound/ite8172.c
drivers/sound/nec_vrc5477.c
drivers/video/matrox/matroxfb_base.c
drivers/video/matrox/matroxfb_crtc2.c
drivers/video/matrox/matroxfb_g450.c
drivers/ieee1394/pcilynx.c
drivers/mtd/ftl.c
drivers/mtd/mtdchar.c
drivers/mtd/nftlcore.c
drivers/message/fusion/mptscsih.c
drivers/hotplug/cpqphp_core.c

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
