Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBNRXP>; Wed, 14 Feb 2001 12:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBNRWz>; Wed, 14 Feb 2001 12:22:55 -0500
Received: from palrel1.hp.com ([156.153.255.242]:5896 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129066AbRBNRWx>;
	Wed, 14 Feb 2001 12:22:53 -0500
Message-Id: <200102141725.JAA11515@milano.cup.hp.com>
To: Philipp Rumpf <prumpf@mandrakesoft.mandrakesoft.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Tim Waugh <twaugh@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug 
In-Reply-To: Your message of "Wed, 14 Feb 2001 05:40:03 PST."
             <Pine.LNX.3.96.1010214053241.12746C-100000@mandrakesoft.mandrakesoft.com> 
Date: Wed, 14 Feb 2001 09:25:20 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rumpf wrote:
> Jeff Garzik wrote:
> > Looks ok, but I wonder if we should include this list in the docs.
> > These is stuff defined by the PCI spec, and this list could potentially
> > get longer...  (opinions either way wanted...)

Having people look things up in the spec isn't very user friendly.
Finding a copy of the PCI 2.1 or 2.2 spec I could pass on to others
(outside of HP) was a problem last year. The best I could do then
(legally) was point them to "PCI Systems Architecture" published
by MindShare.


> I'm not sure whether the
> plan is to have drivers handle MSIs or do it in the generic PCI code.
> Grant ?

Generic PCI code can d very little by itself with MSI since not all
platforms provide support for it - even within the same arch.
Support for MSI is very platform specific.
Eg for parisc: I expect everything but V-class to support MSI.
There are some subtle differences between transaction based
interrupts used by parisc CPU and MSI. But I don't recall what
they are at the moment - I'd have to look it up again.

I thought any x86 with SAPIC (not sure about APIC) could support
MSI as well. But I don't know the x86 arch nearly as well.

It's also possible for the driver to just ignore MSI and not use it.
ie use regular PCI IRQ lines for interrupts.

grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
