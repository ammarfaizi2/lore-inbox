Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290785AbSART3p>; Fri, 18 Jan 2002 14:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290786AbSART3d>; Fri, 18 Jan 2002 14:29:33 -0500
Received: from suhkur.cc.ioc.ee ([193.40.251.100]:7677 "HELO suhkur.cc.ioc.ee")
	by vger.kernel.org with SMTP id <S290785AbSART3I>;
	Fri, 18 Jan 2002 14:29:08 -0500
Date: Fri, 18 Jan 2002 21:29:04 +0200 (GMT)
From: Juhan Ernits <juhan@cc.ioc.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: misconfiguration of ne.o module in 2.2.19 damaged hardware. Is
 it normal? 
In-Reply-To: <200201181904.g0IJ4ThP001576@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.GSO.4.21.0201182116001.21822-100000@suhkur.cc.ioc.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Jan 2002, Horst von Brand wrote:

> > I installed linux on this box (Debian 2.2r4, kernel version 2.2.19).
> > Then when configuring the network the module ne.o was chosen. 
> > I was sure about the io address but not so sure about the irq. So I
> > configured the module with only io address parameter.
> 
> This is enough, IRQ can be found from that datum. I assume this is an ISA
> NIC? If PCI, no such parameters are needed. BTW, NE clones are (in)famous
> for their bizarre assortment of bugs, you might have hit one that doesn't
> work with Linux.

It is (was) an ISA nic and the fun part is, that it had been working for
me under minix & linux (under different hardware configuration though).

> What does lsmod(8) tell you? If you do an "modprobe ne io=..." what does it
> say?

The bad part was, that I didnt do lsmod then. After reboot the card was
rendered completely useless (except for a few probably functional diodes
on the pc-board :-). 

> If your guess at IO is wrong, nothing happens. If the NIC is _not_ an NE,
> strange things could very well happen. It might be broken, not installed
> correctly, jumpers set wrong, ...

It was a jumperless ne2000 isa clone. The io adress was right alright, but
i just left irq unspecified. And that fact drove me to bore the people on
this list ...

My question is that how can the module detect false parameters and how is
it possible to make it protect the hardware in such case? 

The module ne.o most probably managed to write some garbage to the nics
flash address somehow and that makes me worry a bit.


Juhan Ernits

