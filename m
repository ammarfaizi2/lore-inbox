Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317466AbSFMKEz>; Thu, 13 Jun 2002 06:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317510AbSFMKEy>; Thu, 13 Jun 2002 06:04:54 -0400
Received: from 27.Red-80-59-189.pooles.rima-tde.net ([80.59.189.27]:35315 "EHLO
	femto") by vger.kernel.org with ESMTP id <S317466AbSFMKEs>;
	Thu, 13 Jun 2002 06:04:48 -0400
Date: Thu, 13 Jun 2002 12:03:40 +0200
From: Eric Van Buggenhaut <Eric.VanBuggenhaut@AdValvas.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 ooops when modprobe'ing if pci=biosirq
Message-ID: <20020613100340.GB765@eric.ath.cx>
Reply-To: Eric.VanBuggenhaut@AdValvas.be
In-Reply-To: <20020609173654.GC2350@eric.ath.cx> <E17I4Yd-0007Qg-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Echelon: FBI WTC NSA Handgun Anthrax Afgahnistan Bomb Heroin Laden
X-message-flag: Microsoft discourages the use of Outlook.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 10:36:51AM +0100, Alan Cox wrote:
> > Loading modules: 3c59x Unable to handle kernel paging request at
> > virtual address 00009a28
> >  printing eip:
> > c00f7241
> > *pde = 00000000
> 
> That looks like a bios32 bug not a linux one

Indeed. There seemed to be a problem with IRQ routing in the BIOS. I
updated it and it now works fine. Sorry for the noise.

Still I don't know why the ethernet pci cards worked fine before the
BIOS update and not the CardBus bridge ...

[...]

> 
> What chipset motherboard ?

P133 - motherboard is Biostar MB-8500TAC/SMC

eric@linex:~$ /sbin/lspci
00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
00:07.1 IDE interface: Intel Corporation 82371FB PIIX IDE [Triton I] (rev 02)
00:08.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)
00:09.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)


-- 
Eric VAN BUGGENHAUT
Eric.VanBuggenhaut@AdValvas.be
