Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRCISWj>; Fri, 9 Mar 2001 13:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCISWa>; Fri, 9 Mar 2001 13:22:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2688 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130497AbRCISWO>;
	Fri, 9 Mar 2001 13:22:14 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15017.7950.106874.276894@pizda.ninka.net>
Date: Fri, 9 Mar 2001 10:21:02 -0800 (PST)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: David Brownell <david-b@pacbell.net>, Russell King <rmk@arm.linux.org.uk>,
        zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
In-Reply-To: <3AA91B2C.BEB85D8C@colorfullife.com>
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local>
	<00d401c0a5c6$f289d200$6800000a@brownell.org>
	<20010305232053.A16634@flint.arm.linux.org.uk>
	<15012.27969.175306.527274@pizda.ninka.net>
	<055e01c0a8b4$8d91dbe0$6800000a@brownell.org>
	<3AA91B2C.BEB85D8C@colorfullife.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul writes:
 > Do lots of drivers need the reverse mapping? It wasn't on my todo list
 > yet.

I am against any API which provides this.  It can be extremely
expensive to do this on some architectures, and since the rest
of the PCI dma API does not provide such an interface neither
should the pool routines.

Drivers can keep track of this kind of information themselves,
and that is what I tell every driver author to do who complains
of a lack of a "bus_to_virt()" type thing, it's just lazy
programming.

Later,
David S. Miller
davem@redhat.com
