Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130622AbRCITQu>; Fri, 9 Mar 2001 14:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130651AbRCITQl>; Fri, 9 Mar 2001 14:16:41 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:61822 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130622AbRCITQ1>; Fri, 9 Mar 2001 14:16:27 -0500
Date: Fri, 9 Mar 2001 14:14:42 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        "David S. Miller" <davem@redhat.com>,
        Russell King <rmk@arm.linux.org.uk>, zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
Message-ID: <20010309141442.A18207@devserv.devel.redhat.com>
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local> <00d401c0a5c6$f289d200$6800000a@brownell.org> <20010305232053.A16634@flint.arm.linux.org.uk> <15012.27969.175306.527274@pizda.ninka.net> <055e01c0a8b4$8d91dbe0$6800000a@brownell.org> <3AA91B2C.BEB85D8C@colorfullife.com> <060e01c0a8c6$ddbcc1e0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <060e01c0a8c6$ddbcc1e0$6800000a@brownell.org>; from david-b@pacbell.net on Fri, Mar 09, 2001 at 10:29:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 09 Mar 2001 10:29:22 -0800
> From: David Brownell <david-b@pacbell.net>

> > > extern void *
> > > pci_pool_dma_to_cpu (struct pci_pool *pool, dma_addr_t handle);
> > 
> > Do lots of drivers need the reverse mapping? It wasn't on my todo list
> > yet.
> 
> Some hardware (like OHCI) talks to drivers using those dma handles.

I wonder if it may be feasible to allocate a bunch of contiguous
pages. Then, whenever the hardware returns a bus address, subtract
the remembered bus address of the zone start, add the offset to
the virtual and voila.

-- Pete
