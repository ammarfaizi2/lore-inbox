Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSJZWrb>; Sat, 26 Oct 2002 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261699AbSJZWrb>; Sat, 26 Oct 2002 18:47:31 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:7366 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261669AbSJZWra>; Sat, 26 Oct 2002 18:47:30 -0400
Date: Sat, 26 Oct 2002 15:53:42 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
Message-ID: <20021026155342.A14378@lucon.org>
References: <1035540031.13032.3.camel@irongate.swansea.linux.org.uk> <20021025091102.A15082@lucon.org> <20021025202600.A3293@lucon.org> <3DBB0553.5070805@pobox.com> <20021026142704.A13207@lucon.org> <3DBB0A81.6060909@pobox.com> <20021026144441.A13479@lucon.org> <3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org> <3DBB1743.6060309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBB1743.6060309@pobox.com>; from jgarzik@pobox.com on Sat, Oct 26, 2002 at 06:29:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 06:29:23PM -0400, Jeff Garzik wrote:
> 
> >I added pci=nobussort since it might not be safe for all MBs. Then I
> >added "pci=bussort". I have no problem taking out "pci=bussort". If you
> >don't want "pci=bussort", please say so. I can provide a new patch which
> >won't define pci_sort_by_bus_slot_func if CONFIG_PCI_SORT_BY_BUS_SLOT
> >is not set and won't have "pci=bussort" either.
> >  
> >
> 
> You're still missing the point here too.
> 
> Your patch has the potential to suddenly make systems unbootable, to 
> suddenly reverse people's ethX interface numbering, etc.  No command 

That is the whole purpose of my patch. But you will only get it when
you set CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC.

> line options in the world will save lkml from being deluged by tons of 
> "my system doesn't network anymore" bug reports.

You will only get it when you set CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC on
purpose by hand.

> 
> The basic point is "let's proceed with caution, and test test test 
> before applying this patch."

Please state clearly what you have in mind. First you were
saying you didn't like pci_sort_by_bus_slot_func defined when
CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC wass not set. Now you were
saying my patch was dangerous. Please make up your mind.


H.J.
