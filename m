Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271287AbTHCUPM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbTHCUPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:15:11 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:47758 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S271287AbTHCUPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:15:03 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Erik Andersen <andersen@codepoet.org>,
       Werner Almesberger <werner@almesberger.net>,
       Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, Nivedita Singhvi <niv@us.ibm.com>
Date: Sun, 3 Aug 2003 13:13:24 -0700 (PDT)
Subject: Re: TOE brain dump
In-Reply-To: <20030803194011.GA8324@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0308031253240.24695-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003, Larry McVoy wrote:

> On Sun, Aug 03, 2003 at 12:27:55PM -0600, Erik Andersen wrote:
> > On Sun Aug 03, 2003 at 02:57:37PM -0300, Werner Almesberger wrote:
> > > > There is one interesting TOE solution, that I have yet to see created:
> > > > run Linux on an embedded processor, on the NIC.
> > >
> > > That's basically what I've been talking about all the
> > > while :-)
> >
> > http://www.snapgear.com/pci630.html
>
> ipcop plus a new PC for $200 is way higher performance and does more.

however I can see situations where you would put multiple cards in one box
and there could be an advantage to useing PCI (or PCI-X) for you
communications between the different 'nodes' of you routing cluster
instead of gig ethernet.

if this is the approach that the networking guys really want to encourage
how about defining an API that you would be willing to support and you can
even implement it and then any card that is produced would be supported
from day 1.

this interface would not have to cover the configuration of the card (that
can be done with userspace tools that talk to the card over the 'network',
it just needs to cover the ability to do what is effectivly IP over PCI.

Linus has commented that in mahy ways Linux is not designed for any
existing CPU, it's designed for a virtual CPU that implements all the
features we want and those features that aren't implemented in the chips
get emulated as needed (obviously what is actually implemented and the
speed of emulation are serious considerations for performance) why doesn't
the network team define what they thing the ideal NIC interface would be.
I can see three catagories of 'ideal' cards

1. cards that are directly driven by the kernel IP stack (similar to what
we support now, but an ideal version)

2. router nodes that have access to main memory (PCI card running linux
acting as a router/firewall/VPN to offload the main CPU's)

3. router nodes that don't have access to main memory (things like
USB/fibrechannel/infiniband/etc versions of #2, the node can run linux and
deal with the outside world, only sending the data that is needed to/from
the host)

even if nobody makes hardware that supports all the desired features
directly having a 'this is the dieal driver' reference should impruve
furture drivers by letting them use this as the core and implementing code
to simulate the features not in hardware.

they claim they need this sort of performance, you say 'not that way do it
sanely' why not give them a sane way to do it?

David Lang
