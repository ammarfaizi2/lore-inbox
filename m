Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSCVL0P>; Fri, 22 Mar 2002 06:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311212AbSCVL0F>; Fri, 22 Mar 2002 06:26:05 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15111
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311211AbSCVLZv>; Fri, 22 Mar 2002 06:25:51 -0500
Date: Fri, 22 Mar 2002 03:24:38 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Langford <jcl@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <3C9B0D9F.5030102@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203220309400.10409-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

You go and play in 2.5, please.

The correct answer is ....

Because of the requirements of WinXP, where as NO resources can be
assigned to the device(PCI) until they are setup by the HOST OS, otherwise
it will skip the device since it will assume it already registered.

Since you are so knowledgeble about ATA, I am shocked that such as simple
concept and a requirement of WHQL (Windows Hardware Qualifications Lab)
tool kit is not in the front of you mind.  Do yourself a favor, and go
learn about the hardware and what the REAL CUSTOMERS are requiring of it
and then come back to play.  You are truly showing your total lack of
knowledge of the global hardware industry.

So please continue on the top layer interface that we both know you
clearly are better in implimentation, and one day I will come back and fix
the basics of the transport layer provided you leave something in tact.
By now if you or your friends understood the transport layer you would
have fixed it.  Since there are hardware requirements that are not x86
centric under Linux, you may want to start considering a broader vision of
the driver.

The answer you all can not figure out and I will now take you to school so
you, Jens, Pavel, and Vojtech will learn something, gawd willing ...

Here is your hint.

HOW does the command block execution enter the data handler?
HOW does driver expect the data handler to be entered?

Please go look at -ac5 for a clue.

Now I would like to thank you for the clean ups you did and have borrowed
a few and will acknowledge the point.

Cheers,


Andre Hedrick
LAD Storage Consulting Group


On Fri, 22 Mar 2002, Martin Dalecki wrote:

> Alan Cox wrote:
> >>There seems to be some fundamental incompatibility between the kernel
> >>and the IDE chipset.  On several kernels in the 2.4 series including
> >>2.4.18, I observe a hang in the bootsequence at:
> >>
> >>ALI15X3: IDE controller on PCI bus 00 dev 78
> >>PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
> >>ALI15X3: chipset revision 195
> >>ALI15X3: not 100% native mode: will probe irqs later
> >><hang>
> > 
> > 
> > And does pci=bios help ?
> 
> There is a but in this driver, where it is refferencing hwif->index instead
> of hwif->channel. It may cause a hossed setup.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



