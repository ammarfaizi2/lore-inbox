Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265438AbSKARmj>; Fri, 1 Nov 2002 12:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265481AbSKARmi>; Fri, 1 Nov 2002 12:42:38 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:9626 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id <S265438AbSKARmh>;
	Fri, 1 Nov 2002 12:42:37 -0500
Date: Fri, 1 Nov 2002 11:17:04 -0700
From: Matt Porter <porter@cox.net>
To: Gerald Britton <gbritton@alum.mit.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021101111704.A6733@home.com>
References: <20021031181252.GB24027@tapu.f00f.org> <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com> <20021031194351.GA24676@tapu.f00f.org> <apu6cd$4db$1@penguin.transmeta.com> <20021101105045.A31662@light-brigade.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021101105045.A31662@light-brigade.mit.edu>; from gbritton@alum.mit.edu on Fri, Nov 01, 2002 at 10:50:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 10:50:45AM -0500, Gerald Britton wrote:
> On Fri, Nov 01, 2002 at 03:25:01PM +0000, Linus Torvalds wrote:
> > The question I have is whether such external hardware is even worth it
> > any more for any standard crypto work.  With a regular PCI bus
> > fundamentally limiting throughput to something like a maximum of 66MB/s
> > (copy-in and copy-out, and that's so theoretical that it's not even
> > funny - I'd be surprised if RL throughput copying back and forth over a
> > PCI bus is more than 25-30MB/s), I suspect that you can do most crypto
> > faster on the CPU directly these days. 
> 
> This may be true of a typical workstation or large server, but your router
> may not have such a modern CPU in it.  Crypto accelerators are likely a
> much bigger win on embedded routers or other small appliances with CPUs such
> as the AMD Elan or other 486 to Pentium class processors.

Yes, and as a tangent, the same class of embedded devices also benefit
from TCP/IP offload facilities.  The same argument against a crypto-api
supporting crypto hardware has been used in the past to argue against
a Linux kernel TCP/IP hardware offload layer.  The argument is
completely invalid once one considers the typically lower speed of an
embedded processor going into a crypto or network-edge device.

Even better, synthesizable SoC designs like IBM PPC4xx and reconfigurable
processors architectures have opened further the concept of an on-chip
crypto or tcp/ip offload macro cell which virtually eliminates PCI
speed/latency concerns for these assist engines.  It should be no
surprise that embedded Linux is highly desired in these application
specific processors.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
