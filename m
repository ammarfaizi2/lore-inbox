Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269616AbUIRTSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269616AbUIRTSM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUIRTSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 15:18:12 -0400
Received: from DSL212-235-94-60.bb.netvision.net.il ([212.235.94.60]:20352
	"EHLO localhost") by vger.kernel.org with ESMTP id S269616AbUIRTSJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 15:18:09 -0400
Date: Sat, 18 Sep 2004 23:20:55 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97    
     patch)
Message-ID: <20040918232055.00cb25b0@localhost>
In-Reply-To: <MPG.1bb665cd5b40a4ed9896f1@news.gmane.org>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se>
	<20040912011128.031f804a@localhost>
	<Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net>
	<20040914175949.6b59a032@sashak.lan>
	<MPG.1bb164a85e6c9d459896e9@news.gmane.org>
	<20040915035820.1cdccaa5@localhost>
	<MPG.1bb4d933f584efee9896f0@news.gmane.org>
	<20040918142900.06a9ff96@localhost>
	<MPG.1bb665cd5b40a4ed9896f1@news.gmane.org>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 16:35:32 +0200
Giuseppe Bilotta <bilotta78@hotpop.com> wrote:

> Ok, I found the reason of the latter failure: in 2.6.7 I have 
> ISA-PnP enabled (not in 2.6.5) and this loads the parport 
> driver before the sound driver. parport steals the IRQ.
> 
> Module loading order is important: if I load the i8x0 sound 
> modules first, the messages are more or less the same as the 
> ones in 2.6.5 (including the "MC'97 1 converters and GPIO not 
> ready" message), and then parport accepts IRQ 7 to be taken by 
> resorting to polled operation:
> 
> > parport: PnPBIOS parport detected.
> > parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> > parport0: irq 7 in use, resorting to polled operation

I don't know really, but suppose that parport does not accept irq sharing.

> I will. Do you have any idea on the "not ready" issue?

This one is more interesting, probably special patch is necessary for conexant codec, let's see.

Please report bug to alsa and attach there output of 'lspci -vv' and tar of '/proc/asound' directory (or send to me).

Let's detach from linux-kernel list - things become pure-ALSA related.

Thanks,
Sasha.

