Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132145AbRBOCYo>; Wed, 14 Feb 2001 21:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132144AbRBOCYe>; Wed, 14 Feb 2001 21:24:34 -0500
Received: from palrel3.hp.com ([156.153.255.226]:56594 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S131587AbRBOCY0>;
	Wed, 14 Feb 2001 21:24:26 -0500
Message-Id: <200102150227.SAA11922@milano.cup.hp.com>
To: Philipp Rumpf <prumpf@mandrakesoft.mandrakesoft.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Tim Waugh <twaugh@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug 
In-Reply-To: Your message of "Wed, 14 Feb 2001 15:12:22 PST."
             <Pine.LNX.3.96.1010214150801.12746Q-100000@mandrakesoft.mandrakesoft.com> 
Date: Wed, 14 Feb 2001 18:26:55 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rumpf wrote:
> On Wed, 14 Feb 2001, Grant Grundler wrote:
> > Having people look things up in the spec isn't very user friendly.
> 
> Having the constants in some well-known header file should be sufficient,
> shouldn't it ?

I would hope anyone bothering to include the constants in a document would
spend a few minutes explaining them as well. Perhaps a bad assumption
on my part...


> It depends on the platform and maybe the exact PCI slot used, but I don't
> think it depends on the driver (unless MSI support is broken in which case
> you would want to fix it up in the driver).

correct.

> At least I can't find
> anything in the PCI 2.2 spec that would suggest we need to consult the
> driver before enabling MSIs with one message only.

I don't know how BIOS's treat this (if at all). Need to know this first.
If they manage this resource and pre-assign everything, ok.
That's how it goes.

But if generic PCI manages this, I prefer to avoid allocating resources
that may not get used.  The host platform may have a limited pool of
usable MSI data values (think parisc EIRR bits) and some cards may want
to use more than one MSI.

grant

ps. seems this thread has gotten a bit far off from the original subject. :^/

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
