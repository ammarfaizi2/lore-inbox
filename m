Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278394AbRJMUTm>; Sat, 13 Oct 2001 16:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278395AbRJMUTc>; Sat, 13 Oct 2001 16:19:32 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:30078 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278394AbRJMUTW>; Sat, 13 Oct 2001 16:19:22 -0400
Date: Sat, 13 Oct 2001 15:19:15 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI device search.
In-Reply-To: <20011013145100.A25027@ontario.alcove-fr>
Message-ID: <Pine.LNX.3.96.1011013151817.28071A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Oct 2001, Stelian Pop wrote:

> On Fri, Oct 12, 2001 at 04:15:54PM -0500, Jeff Garzik wrote:
> 
> > > I'd say 1.  If a device is hotpluggable or not does not matter.  For
> > > 2.5, the boot process will be able to load modules for all PCI
> > > devices seen in the system.  In order for that to happen, they need to
> > > use the MODULE_DEVICE structure and the 2.4 pci driver subsystem.
> > 
> > I'd say 1.5.  :)  For the "newer hardware" consider using the PCI host
> > bridge or ISA bridge for your "container" PCI device.
> 
> You mean putting PCI_CLASS_BRIDGE_PCI as pattern in the pci
> search table, yes ?

Close but not quite.  Look at drivers/char/i810_rng.c.  It uses PCI ids
for Intel PCI bridge to search for, since the RNG itself doesn't have a
PCI id.

	Jeff




