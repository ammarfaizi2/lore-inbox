Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130583AbRCISgU>; Fri, 9 Mar 2001 13:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130539AbRCISgM>; Fri, 9 Mar 2001 13:36:12 -0500
Received: from quattro.sventech.com ([205.252.248.110]:15123 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S130603AbRCISgB>; Fri, 9 Mar 2001 13:36:01 -0500
Date: Fri, 9 Mar 2001 13:35:03 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: Manfred Spraul <manfred@colorfullife.com>,
        David Brownell <david-b@pacbell.net>,
        Russell King <rmk@arm.linux.org.uk>, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
Message-ID: <20010309133502.R31345@sventech.com>
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local> <00d401c0a5c6$f289d200$6800000a@brownell.org> <20010305232053.A16634@flint.arm.linux.org.uk> <15012.27969.175306.527274@pizda.ninka.net> <055e01c0a8b4$8d91dbe0$6800000a@brownell.org> <3AA91B2C.BEB85D8C@colorfullife.com> <15017.7950.106874.276894@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <15017.7950.106874.276894@pizda.ninka.net>; from David S. Miller on Fri, Mar 09, 2001 at 10:21:02AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001, David S. Miller <davem@redhat.com> wrote:
> Manfred Spraul writes:
>  > Do lots of drivers need the reverse mapping? It wasn't on my todo list
>  > yet.
> 
> I am against any API which provides this.  It can be extremely
> expensive to do this on some architectures, and since the rest
> of the PCI dma API does not provide such an interface neither
> should the pool routines.

The API I hacked together for uhci.c didn't have this.

> Drivers can keep track of this kind of information themselves,
> and that is what I tell every driver author to do who complains
> of a lack of a "bus_to_virt()" type thing, it's just lazy
> programming.

Once I worked around not having a "bus_to_virt()" type thing I was happier
with the resulting code. I completely agree.

JE

