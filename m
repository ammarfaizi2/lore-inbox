Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135854AbRDTKZq>; Fri, 20 Apr 2001 06:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135855AbRDTKZh>; Fri, 20 Apr 2001 06:25:37 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:35849 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S135854AbRDTKZS>;
	Fri, 20 Apr 2001 06:25:18 -0400
Date: Fri, 20 Apr 2001 12:25:07 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: stefan@jaschke-net.de
Cc: Oliver Teuber <teuber@core.devicen.de>, linux-kernel@vger.kernel.org
Subject: Re: epic100 error
Message-ID: <20010420122507.A32759@se1.cogenit.fr>
In-Reply-To: <20010417184552.A6727@core.devicen.de> <20010418204021.A14531@se1.cogenit.fr> <01042010222601.06730@antares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01042010222601.06730@antares>; from s-jaschke@t-online.de on Fri, Apr 20, 2001 at 10:22:26AM +0200
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Jaschke <s-jaschke@t-online.de> ecrit :
[...]
> I don't believe the motherboard or the BIOS have anything to do with, simply 

It may give a clue because the machine I wrote this mail from is a 
2.4.3 + 2*EtherPower II it looks rather fine (old asus motherbord, BX,
backuped peaceful prod server):
I tried 2.4.3 on some bp6+epic100 (2.4.0/1/2/3 + misc ac). No problems either.

Around the 10 of february, Arnd Bergmandd <std7652@et.FH-Osnabrueck.DE> had
problems with the epic100. These appeared between two revisions of the
driver that differ only in the use of DMA mapping I made at the moment.
<digression>
Fwiw, it was essentially a matter of coding-style as on x86 the DMA mapping
actually called the former virt_to_phys and pci_dma_sync was rather empty.
It made no design change. It may be possible I assumed some data were in
memory as they are still in some cpu registers. I'll re-re-check that.
</digression>

Summary:
Arnd Bergmann:
		orig epic100	"DMA mapped epic100 (any version)"
		(<=2.4.0-ac9)
VT8363	   	ok		fscked but ok after bios update

Daniel Nofftz:
		2.4.2		2.4.3
VT82C595	ok		fscked. (no mention of bios experience)

Oliver Teuber:
		2.2.19		2.4.3-ac7
VT82C598	ok		fscked

Romieu:
		2.2.xx		2.4.[123]
82443BX		ok		ok

Now it's complicated by the fact that between 2.4.2 and 2.4.3, you
have DMA mapping + others changes in epic100 (they make sense imho).

What happen's if you compile 2.4.2 epic100 driver in a 2.4.3 tree (I) ?

[...]
> Something between 2.4.0 and 2.4.3 breaks the epic100 driver. That's it.

So far it's hard to say where it comes from.
I would really appreciate if you could give a look at (I).
If it doesn't change anything and you have spare time, some feedback
from bios experience will be welcome too.

--
Ueimor
