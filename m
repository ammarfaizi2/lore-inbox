Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318404AbSGSAZq>; Thu, 18 Jul 2002 20:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318405AbSGSAZq>; Thu, 18 Jul 2002 20:25:46 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:52240 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S318404AbSGSAZp>; Thu, 18 Jul 2002 20:25:45 -0400
Date: Thu, 18 Jul 2002 17:27:39 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kurt Garloff <kurt@garloff.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Tyan s2466 stability
In-Reply-To: <1026857446.1688.76.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207181712050.2065-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jul 2002, Alan Cox wrote:

> On Tue, 2002-07-16 at 21:51, Kurt Garloff wrote:
> > > I've seen it with IDE burners too. I don't know what the cause is
> > 
> > Strange SMI stuff, maybe?
> > Bugs with PCI arbitration that are recovered from but take time?
> > 
> > You've probably already looked into those, though.
> 
> I've read the errata but thats not given me any clues. The box is fast,
> including PCI bandwidth measurements but neither PCI card or SCSI
> streaming to tape or CD-R works well. The motherboard IDE works a treat
> and the 64bit slots give me excellent performance (but thats a raid card
> so I can't yet use it for tape)

according to the amd760mpx datasheet, stuff on the 32/33MHz bus isn't 
allowed to busmaster while the 64/66MHz bus is operating at 66MHz. so that 
means the 66MHz bus needs to be throttled to 33MHz either via a 3.3V 33MHz 
card stuck in it, or that pretty blue jumper stuffed on the appropriate 
FORCE 33MHz header on the board.

these kind of problems will cause things like loss of streaming due to the 
inability to busmaster. both of my dual athlon systems here at cti have 
that jumper shorted. sure, i still run into problems, but then again, what 
chipset for amd processors doesn't have a whole load of issues? overall, i 
can't say i'm satisfied with any athlon chipset on the market right now. 
but, the 760mpx has far fewer issues than, say, any garden variety via 
board. (no comments from the peanut gallery -- my mind is made up and in 
this respect, your opinion means nothing to me. via sucks. end of story). 
but, i digress.

aside from these rather annoying pci quirks and a sensors issue (who in 
their right mind assigns the same i2c address for two different chips?!) 
the board works quite well in the configuration i've got it in (beowulf 
cluster).

oh and all the devices on this board are fully acpi controlled. let it be 
known that i hate acpi, and especially the headaches that it causes me. 
the stock bios also sucks quite vigorously and should be avoided at all 
costs (read: upgrade to the latest bios rev immediately).

if you need help integrating one of these boards into your system i may be 
able to provide some insight.

good luck.

 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

