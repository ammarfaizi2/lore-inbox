Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293504AbSBZDoY>; Mon, 25 Feb 2002 22:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293499AbSBZDoQ>; Mon, 25 Feb 2002 22:44:16 -0500
Received: from ns.snowman.net ([63.80.4.34]:27149 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S293503AbSBZDoE>;
	Mon, 25 Feb 2002 22:44:04 -0500
Date: Mon, 25 Feb 2002 22:43:53 -0500 (EST)
From: <nick@snowman.net>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0202252243360.18586-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you list what cards/systems use this driver?  I at least am totally
unsure.
	Thanks
		Nick

On Mon, 25 Feb 2002, David S. Miller wrote:

> 
> This is to announce the first test release of a new Broadcom Tigon3
> driver written by Jeff and myself.  Get it at:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3.patch.gz
> 
> The patch is against 2.4.18 but there is no reason it should be
> difficult to apply this patch to any other tree.
> 
> It is meant to replace Broadcom's driver because frankly their driver
> is junk and would never be accepted into the tree.  For an example of
> why their driver is junk, note that the resulting object file from our
> driver is less than half the size of Broadcom's.  That kind of bloat
> is simply unacceptable.  Next, Broadcom's driver is still way
> non-portable, ioremap() pointers are still dereferenced directly among
> other things.  Finally, their driver is just plain buggy, they have
> code which tries to use page_address() on pages which are potentially
> in highmem and that is guarenteed to oops.
> 
> There are other problems with their driver too, just ask as I'm in a
> good mood to grind my axe about this stuff :-)
> 
> We would also like to give Broadcom a big "no thanks" because
> their lawyers refused to give Jeff the documentation for the Tigon3
> chipset using an NDA that would allow him to write a GPL'd driver
> based upon said documentation.  This means that all that we know about
> the hardware has been reverse engineered from Broadcom's GPL'd driver
> plus some experimenting.  It is why this driver has taken so long to
> finish, because it is hard to find incentive for this kind of brack
> breaking work when the vendor is totally uncooperative.
> 
> I personally think Broadcom has some hidden agenda that requires that
> their driver be "the one".  So instead of just complaining about such
> stupid policy, we've done something about it by doing our own driver
> with all the problems fixed.
> 
> We'd really appreciate if people would test this thing out as hard
> as they can.  I can tell you that I've personally only been able to
> test out the following scenerios so far:
> 
> 1) Both big-endian and little-endian platforms.
> 2) 64-bit on big-endian side, 32-bit on little-endian side.
> 3) IOMMU based PCI dma platform on 64-bit/big-endian side,
>    non-IOMMU based PCI dma platform on 32-bit little-endian side.
> 4) 10baseT half duplex, 100baseT full duplex
> 5) Copper based connectors, as that is all that Jeff and I have.
> 
> Gigabit and fibre are the big areas where our testing has been
> lacking.  We have also not done any tuning of the driver at all,
> although we do consider the driver feature complete.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

