Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130843AbRCFCIK>; Mon, 5 Mar 2001 21:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbRCFCH7>; Mon, 5 Mar 2001 21:07:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9991 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130843AbRCFCHq>; Mon, 5 Mar 2001 21:07:46 -0500
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
To: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 6 Mar 2001 02:09:10 +0000 (GMT)
Cc: david-b@pacbell.net (David Brownell),
        manfred@colorfullife.com (Manfred Spraul), zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20010305232053.A16634@flint.arm.linux.org.uk> from "Russell King" at Mar 05, 2001 11:20:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14a6uW-0008Gd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At the time, I didn't feel like creating a custom sub-allocator just
> for USB, and since then I haven't had the inclination nor motivation
> to go back to trying to get my USB mouse or iPAQ communicating via USB.
> (I've not used this USB port for 3 years anyway).
> 
> I'd be good to get it done "properly" at some point though.

Something like

struct pci_pool *pci_alloc_consistent_pool(int objectsize, int align)

pci_alloc_pool_consistent(pool,..
pci_free_pool_consistent(pool,..

??

Where the pool allocator does page grabbing and chaining >


