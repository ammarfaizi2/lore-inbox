Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271184AbTHCVXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271214AbTHCVXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:23:08 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:34757 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S271184AbTHCVW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:22:59 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Erik Andersen <andersen@codepoet.org>,
       Werner Almesberger <werner@almesberger.net>,
       Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, Nivedita Singhvi <niv@us.ibm.com>
Date: Sun, 3 Aug 2003 14:21:12 -0700 (PDT)
Subject: Re: TOE brain dump
In-Reply-To: <20030803203051.GA9057@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0308031405130.24695-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003, Larry McVoy wrote:

> On Sun, Aug 03, 2003 at 01:13:24PM -0700, David Lang wrote:
> > 2. router nodes that have access to main memory (PCI card running linux
> > acting as a router/firewall/VPN to offload the main CPU's)
>
> I can get an entire machine, memory, disk, > Ghz CPU, case, power supply,
> cdrom, floppy, onboard enet extra net card for routing, for $250 or less,
> quantity 1, shipped to my door.
>
> Why would I want to spend money on some silly offload card when I can get
> the whole PC for less than the card?

you may want to do this for a database box where you want to dedicate your
main processing power to the database task, if you use a seperate box you
still have to talk to that box over a network, if you have it as a card
you can talk to the card much more efficantly then you can talk to the
seperate machine.

if your 8-way opteron database box is already the bottleneck for your
system you will have to spend a LOT of money to get anything that gives
you more available processing power, getting a card to offload any
processing from the main CPU's can be a win.

yes this is somewhat of a niche market, but as you point out adding more
and more processors in a SMP model is not the ideal way to go, either from
performance or from the cost point of view.

on the webserver front there are a lot of companies making a living by
selling cards and boxes to offload processing from the main CPU's of the
webservers (cards to do gzip compression are a relativly new addition, but
cards to do SSL handshakes have been around for a while) used properly
these can be a very worthwhile invenstment for high-volume webserver
companies.

also the cost of an extra box can be considerably higer then just the cost
of the hardware.

I know of one situation where between Linux OS license fees (redhat
advanced server) and security software (intrusion detection, auditing,
privilage management, etc) a company is looking at ~$4000 in licensing
fees for every box they put in their datacenter (and this is for boxes
just running apache, add something like an oracle or J2EE appserver
software and the cost goes up even more). at this point the fact that the
box only cost $200 doesn't really matter, spending an extra $500 each on 4
boxes to eliminate the need for a 5th is easily worth it. (and this
company is re-examining hardwaare raid controllers after having run
software raid for years becouse they are realizing that this is requiring
them to run more servers due to the load on the CPU's)

at the low end you are right, just add another box or add another CPU to
an existing box, but there are conditions that make adding specialized
cards to offload specific functionality a win (for that matter, even at
the low end people routinly offload graphics processing to specialized
cards, simply to make their games run faster)

David Lang
