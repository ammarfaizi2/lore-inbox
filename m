Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBNLkm>; Wed, 14 Feb 2001 06:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRBNLkd>; Wed, 14 Feb 2001 06:40:33 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:37170 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129104AbRBNLkR>; Wed, 14 Feb 2001 06:40:17 -0500
Date: Wed, 14 Feb 2001 05:40:03 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.mandrakesoft.com>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Tim Waugh <twaugh@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org, grundler@cup.hp.com
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
In-Reply-To: <Pine.LNX.3.96.1010214051817.12910H-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.3.96.1010214053241.12746C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Jeff Garzik wrote:
> On Wed, 14 Feb 2001, Tim Waugh wrote:
> > +/**
> > + * pci_find_capability - query for devices' capabilities 
> > + * @dev: PCI device to query
> > + * @cap: capability code
> > + *
> > + * Tell if a device supports a given PCI capability.
> > + * Returns the address of the requested capability structure within the device's PCI 
> > + * configuration space or 0 in case the device does not support it.
> > + * Possible values for @flags:
			    ^^^^^^
@cap would make more sense, no ?

> > + *  %PCI_CAP_ID_AGP          Accelerated Graphics Port 
> > + *
> > + *  %PCI_CAP_ID_VPD          Vital Product Data 
> > + *
> > + *  %PCI_CAP_ID_SLOTID       Slot Identification 
> > + *
> > + *  %PCI_CAP_ID_MSI          Message Signalled Interrupts
> > + *
> > + *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
> > + */
> 
> Looks ok, but I wonder if we should include this list in the docs.
> These is stuff defined by the PCI spec, and this list could potentially
> get longer...  (opinions either way wanted...)

I would vote for including those capabilities which are most likely to be
used by drivers (PCI_CAP_ID_PM, and maybe _VPD).  I'm not sure whether the
plan is to have drivers handle MSIs or do it in the generic PCI code.
Grant ?


