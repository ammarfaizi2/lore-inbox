Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130644AbRCIUIW>; Fri, 9 Mar 2001 15:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130656AbRCIUID>; Fri, 9 Mar 2001 15:08:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130644AbRCIUH6>;
	Fri, 9 Mar 2001 15:07:58 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15017.14312.932929.194773@pizda.ninka.net>
Date: Fri, 9 Mar 2001 12:07:04 -0800 (PST)
To: David Brownell <david-b@pacbell.net>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
        linux-usb-devel@lists.sourceforge.net,
        Manfred Spraul <manfred@colorfullife.com>,
        Russell King <rmk@arm.linux.org.uk>, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
 [RFC: API]
In-Reply-To: <06a701c0a8d1$199377e0$6800000a@brownell.org>
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local>
	<00d401c0a5c6$f289d200$6800000a@brownell.org>
	<20010305232053.A16634@flint.arm.linux.org.uk>
	<15012.27969.175306.527274@pizda.ninka.net>
	<055e01c0a8b4$8d91dbe0$6800000a@brownell.org>
	<3AA91B2C.BEB85D8C@colorfullife.com>
	<15017.7950.106874.276894@pizda.ninka.net>
	<20010309133502.R31345@sventech.com>
	<06a701c0a8d1$199377e0$6800000a@brownell.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Brownell writes:
 > Given that some hardware must return the dma addresses, why
 > should it be a good thing to have an API that doesn't expose
 > the notion of a reverse mapping?  At this level -- not the lower
 > level code touching hardware PTEs.

Because its' _very_ expensive on certain machines.  You have to do
1 or more I/O accesses to get at the PTEs.

If you add this reverse notion to just one API (the dma pool one) then
people will complain (rightly) that there is not orthogonality in the
API since the other mapping functions do not provide it.

No, it is unacceptable.

Later,
David S. Miller
davem@redhat.com
