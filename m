Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRBNVTJ>; Wed, 14 Feb 2001 16:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129299AbRBNVS7>; Wed, 14 Feb 2001 16:18:59 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1316 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129292AbRBNVSs>; Wed, 14 Feb 2001 16:18:48 -0500
Date: Wed, 14 Feb 2001 15:12:22 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.mandrakesoft.com>
To: Grant Grundler <grundler@cup.hp.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Tim Waugh <twaugh@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug 
In-Reply-To: <200102141725.JAA11515@milano.cup.hp.com>
Message-ID: <Pine.LNX.3.96.1010214150801.12746Q-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Grant Grundler wrote:
> Philipp Rumpf wrote:
> > Jeff Garzik wrote:
> > > Looks ok, but I wonder if we should include this list in the docs.
> > > These is stuff defined by the PCI spec, and this list could potentially
> > > get longer...  (opinions either way wanted...)
> 
> Having people look things up in the spec isn't very user friendly.

Having the constants in some well-known header file should be sufficient,
shouldn't it ?

> > I'm not sure whether the
> > plan is to have drivers handle MSIs or do it in the generic PCI code.
> > Grant ?
> 
> Generic PCI code can d very little by itself with MSI since not all
> platforms provide support for it - even within the same arch.

It depends on the platform and maybe the exact PCI slot used, but I don't
think it depends on the driver (unless MSI support is broken in which case
you would want to fix it up in the driver).  At least I can't find
anything in the PCI 2.2 spec that would suggest we need to consult the
driver before enabling MSIs with one message only.

> It's also possible for the driver to just ignore MSI and not use it.
> ie use regular PCI IRQ lines for interrupts.

.. at least until someone comes out with a PCI board that supports MSI
interrupts only.

