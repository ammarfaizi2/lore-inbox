Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUHYPuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUHYPuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHYPuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:50:22 -0400
Received: from web14925.mail.yahoo.com ([216.136.225.11]:31831 "HELO
	web14925.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268025AbUHYPuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:50:15 -0400
Message-ID: <20040825155014.66390.qmail@web14925.mail.yahoo.com>
Date: Wed, 25 Aug 2004 08:50:14 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Matthew Wilcox <willy@debian.org>
Cc: Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040825153640.GF16196@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Matthew Wilcox <willy@debian.org> wrote:
> On Wed, Aug 18, 2004 at 11:13:10AM -0700, Jon Smirl wrote:
> > I haven't received any comments on pci-sysfs-rom-17.patch. Is
> everyone
> > asleep or is it ready to be pushed upstream? I'm still not sure
> that
> > anyone has tried it on a ppc machine.
> 
> I'm now working on something that could use the ROM mapping facility.
> However, I know that I only need the first 64k of the ROM.  Would it
> be reasonable to check the value passed in to pci_map_rom() in *size
> and only automatically set it if it's 0?

pci_map_rom doesn't really consume much in the way of system resources.
64K vs 128KB is just a little address space usage that is freed as soon
as you do pci_unmap_rom().

pci_map_rom_copy() is the only call that consumes significant resource.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
