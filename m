Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbRHFUAO>; Mon, 6 Aug 2001 16:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268973AbRHFUAE>; Mon, 6 Aug 2001 16:00:04 -0400
Received: from mx1.afara.com ([63.113.218.20]:51343 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S268971AbRHFT75>;
	Mon, 6 Aug 2001 15:59:57 -0400
Subject: Re: How does "alias ethX drivername" in modules.conf work?
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: Chris Wedgwood <cw@f00f.org>, Mark Atwood <mra@pobox.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108042028320.16941-100000@infradead.org>
In-Reply-To: <Pine.LNX.4.33.0108042028320.16941-100000@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 06 Aug 2001 12:59:22 -0700
Message-Id: <997127962.6478.31.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 06 Aug 2001 19:56:44.0356 (UTC) FILETIME=[EAFCB840:01C11EB1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Aug 2001 20:35:37 +0100, Riley Williams wrote:

> One of my systems has SIX ethernet cards, these being three ISA and
> two PCI NE2000 clones and a DEC Tulip. Here's the relevant section of
> modules.conf on the system in question:
> 
>  Q> alias eth0 ne
>  Q> options eth0 io=0x340
>  Q> alias eth1 ne
>  Q> options eth1 io=0x320
>  Q> alias eth2 ne
>  Q> options eth2 io=0x2c0
>  Q> alias eth3 ne2k-pci
>  Q> alias eth4 ne2k-pci
>  Q> alias eth5 tulip
> 
> Best wishes from Riley.

ok, well this makes sense for the ISA cards.  I have card A in my hand,
I set the jumpers on it to an io port 0x340, stick it in slot X on my
computer, plug the wire into it from network 1, then I mentally can map
all the stuff together, so I know how to setup the network in Linux

eth0 == io 0x340 == card A == slot X in my computer == network 1

but, how can you tell the difference between eth3 and eth4 -- and
specify which *physical* card gets assigned to which virtual eth?
name...ie, how do I know which pci slot is which eth?  besides reading
the motherboard documentation and maybe learning which direction and how
the pci bus is ordered...which can differ between motherboard
manufacturers and BIOS's, etc, etc. 

and how do I change it if I don't like the default order (based off of
pci scan order).  what if I want card B, a pci card stuck in PCI slot Y
to be eth4?

hope this is clearer...

thanks,

-tduffy

