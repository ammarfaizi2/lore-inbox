Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264475AbRFOSqE>; Fri, 15 Jun 2001 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264485AbRFOSpq>; Fri, 15 Jun 2001 14:45:46 -0400
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:58554 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S264479AbRFOSpc>; Fri, 15 Jun 2001 14:45:32 -0400
Message-ID: <3B2A577C.9FDD2AAF@uu.net>
Date: Fri, 15 Jun 2001 14:44:12 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: David Christensen <David_Christensen@Phoenix.com>
CC: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: [Acpi] APM, ACPI, and Wake on LAN - the bane of my existance
In-Reply-To: <D973CF70008ED411B273009027893BA401BE6B22@irv-exch.phoenix.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll try to take a look at the source if I get a chance next
week.  Any tulip developers out there know off hand if this is enabled?
Or can be disabled?

Thanks,

Alex

David Christensen wrote:
> 
> Alex,
> 
> Looking at the back of a Linksys EtherFast 10/100 manual I happen to have,
> they describe two different remote wake-up events, Magic Packet and Link
> Change.  The first one is pretty obvious and is probably not related to
> your problems, but the second one may be.  The manual states ""Link Change
> is a remote wake up event that is triggered by any change in the EtherFast
> card's link state."  Plugging in a LAN cable is the example given that
> would turn the system on.  You may have to look at the driver source to see
> if this is enabled by default or you may have to modify the driver to
> disable this "feature" on the card.
> 
> Regarding the WOL cable, this was used for older motherboards before PCI
> 2.2,
> though it is still present on newer motherboards to support older PCI cards.
> A PCI 2.2 compliant motherboard and NIC use the #PME signal on the PCI bus
> to signal the wake.
> 
> Dave
> 
> >
> > I have an athlon system with a iwill kk266 motherboard (via
> > kt133A).  I
> > have a linksys 10/100 PCI ethernet card with wake on lan
> > capabilities.
> > Anyway, when I shut the PC down it turns off, but refuses to
> > stay off.
> > Within a minute or two, it turns itself on again.  If i run over and
> > turn it off by hitting the power putton, it turns off, but then comes
> > back on again at a later somewaht arbitrary time (1 minute to several
> > hours later).  I originally got the WOL card so I could
> > remotely boot my
> > PC, but at this point it has turned out to be more trouble than it's
> > worth.  I tried to disable WOL inthe BIOS, but that didn't change
> > anything.  So I removed the three pin cross connect that connects the
> > card to the WOL header on the motherboard.  That fixed it for a few
> > days, but now it's doing it again, even without the cable installed.
> > the only fix is to unplug the ethernet cable when I turn it off.
> >
> > I suspect the problem has something to do with WOL vs. resume on LAN.
> > the system should only turn on when it recieves a magic packet, but it
> > seems that any packet may cause it to boot (or resume, but since it is
> > in the "off" state, boot).  I've only been using APM, but perhaps acpi
> > is required for this to work properly.  As far as why it does
> > this when
> > the 3 pin WOL connector was not used, I'm not sure, maybe something to
> > do with PCI 2.2.
