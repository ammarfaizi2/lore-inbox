Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130048AbRB1Clg>; Tue, 27 Feb 2001 21:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130050AbRB1Cl1>; Tue, 27 Feb 2001 21:41:27 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:20728 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S130048AbRB1ClL>;
	Tue, 27 Feb 2001 21:41:11 -0500
Date: Tue, 27 Feb 2001 18:41:09 -0800
To: Greg KH <greg@wirex.com>, Dag Brattli <dag@brattli.net>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] patch-2.4.2-irda1 (irda-usb)
Message-ID: <20010227184109.B6898@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20010227093329.A10482@wirex.com> <200102272032.UAA74232@tepid.osl.fast.no> <20010227135810.E910@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010227135810.E910@wirex.com>; from greg@wirex.com on Tue, Feb 27, 2001 at 01:58:11PM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 01:58:11PM -0800, Greg KH wrote:
> On Tue, Feb 27, 2001 at 08:32:28PM +0000, Dag Brattli wrote:
> > > I'd recommend that this file be in the /drivers/usb directory, much like
> > > almost all other USB drivers are.
> > 
> > Yes, but do we want to spread the IrDA code around? The same argument
> > applies to IrDA device drivers!?
> 
> I agree, and am not saying that it _has_ to be there.  Just a
> suggestion, and if you're comfortable with it in the irda directory,
> that's fine.
> 
> thanks,
> 
> greg k-h

	Hi,

	First thanks for Dag for bringing me into the conversation. I
may add my little bit of spice, especially that I was the one pushing
for having the driver in .../drivers/net/irda.
	By the way, Greg, sorry if I hurt your feeling, I don't want
to put down any of the great work that has been done on the USB stack.

	My feeling is that devices are mostly defined by their higher
level interface, because this is what is closer to the user.
	If I look at a Pcmcia Ethernet card, I will tend to associate
more with a PCI Ethernet card rather than a Pcmcia SCSI card. Both
card have the same high level interface (TCP/IP) even if their low
level interface is different (Pcmcia, PCI).
	People tend to agree with that, and that's why you have
directories called drivers/net, drivers/scsi and driver/sound, rather
that drivers/pci, drivers/isa, drivers/mca and drivers/pcmcia.

	If I get an IrDA-USB dongle, the feature that matter the most
is that it does IrDA, the fact that it connect to my PC via USB is
rather secondary.
	That's it. I hope it explain some of the rationale and why we
departed from the usual drivers/usb arrangement. Actually, I think
that stuffing all USB drivers in drivers/usb is not that great, but
that's not my call...

	Have fun...

	Jean
