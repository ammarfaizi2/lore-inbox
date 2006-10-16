Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWJPUwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWJPUwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbWJPUwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:52:40 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:62032 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161063AbWJPUwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:52:39 -0400
Date: Mon, 16 Oct 2006 22:52:28 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: x86-32/64 switch to pci_get API
Message-ID: <20061016205228.GF5385@rhun.haifa.ibm.com>
References: <1161013892.24237.100.camel@localhost.localdomain> <20061016160759.GA14354@muc.de> <1161017113.24237.115.camel@localhost.localdomain> <20061016162426.GB14354@muc.de> <1161018340.24237.122.camel@localhost.localdomain> <20061016190115.GA45331@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016190115.GA45331@muc.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 09:01:15PM +0200, Andi Kleen wrote:
> On Mon, Oct 16, 2006 at 06:05:40PM +0100, Alan Cox wrote:
> > Ar Llu, 2006-10-16 am 18:24 +0200, ysgrifennodd Andi Kleen:
> > > > You can't hot unplug your MMU
> > > 
> > > Not sure about that. Calgary is afaik in the bridges and since Summit
> > > has pluggable PCI cages and nodes i would assume the MMU instances are also
> > > hot pluggables.
> > 
> > If so Linux doesn't currently support that and the patch keeps things as
> > they are except for using hotplug safe APIs (and since I want to
> > exterminate pci_find_device* shortly thats preferable)
> > 
> 
> Ok i applied the patch to -rc2, but it results in 
> 
> arch/x86_64/pci/built-in.o: In function `pcibios_irq_init':
> irq.c:(.init.text+0xc7e): undefined reference to `pci_get_bus_and_slot'
> 
> That function is also nowhere to be found:
> 
> % gid pci_get_bus_and_slot
> %
> 
> So dropped again.

Alain submitted the patch to add that function roughly at the same
time. See
http://marc.theaimsgroup.com/?l=linux-kernel&m=116101265428620&w=2

Cheers,
Muli
