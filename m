Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSFUQ46>; Fri, 21 Jun 2002 12:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSFUQ45>; Fri, 21 Jun 2002 12:56:57 -0400
Received: from mail.storm.ca ([209.87.239.66]:58255 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S316397AbSFUQ45>;
	Fri, 21 Jun 2002 12:56:57 -0400
Message-ID: <3D134DC3.7CE36DB4@storm.ca>
Date: Fri, 21 Jun 2002 12:01:07 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206201428481.8225-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Integration is _not_ "just another way".
> 
> Integration fundamentally changes the whole equation.
> 
> When you integrate the SMP capabilities on the CPU, suddenly the world
> changes, because suddenly SMP is cheap and easy to do for motherboard
> manufacturers that would never have done it before. Suddenly SMP is
> available at mass-market prices.
> 
> When you integrate multiple CPU's on one standard die (either HT or real
> CPU's), the same thing happens.
> 
> When you start integrating crossbars etc "numa-like" stuff, like Hammer
> apparently is doing, you get the same old technology, but it _behaves_
> differently.
> 
> You see this outside CPU's too.
> 
> When people started integrating high-performance 3D ...

It seems to me we're talking about several different ways to get
parralllelism in volume hardware. SMP, smarter peripherals, and
various sorts of cluster (beowulf compute engines, redundant for
high availability, load sharing for web servers or other I/O
bound loads, ...). Great. All have their place.

I wonder, though, about one that doesn't seem to be discussed
much: asymmetric multiprocessing.

One example is IBM mainframes with their channel processors; not
just smart peripherals but whole CPUs dedicated to I/O control.
Another was the VAX 782, two 780s with a fat bus-to-bus cable
and each CPU getting DMA into the other's memory. One CPU ran
most of the kernel, the other all the user processes.

To what extent is this becoming relevant to Linux with the port
to System 390 and the trend to I20 devices in PCs? How does it
affect the overall design?

I rather like the notion of a machine with most of the kernel,
including all disk and net I/O, running on, say, a pair of ARMs
while a quad of 64-bit whatevers run the user proceses. This
might give better $/power/heat/... tradeoffs than just goiing
to 8-way systems.
