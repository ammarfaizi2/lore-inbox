Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSLJNBf>; Tue, 10 Dec 2002 08:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSLJNBe>; Tue, 10 Dec 2002 08:01:34 -0500
Received: from mail.ithnet.com ([217.64.64.8]:27661 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261398AbSLJNBa>;
	Tue, 10 Dec 2002 08:01:30 -0500
Date: Tue, 10 Dec 2002 14:09:12 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: hidden interface (ARP) 2.4.20 / network performance
Message-Id: <20021210140912.7a9092b6.skraw@ithnet.com>
In-Reply-To: <3DF5C492.1070103@drugphish.ch>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>
	<1039124530.18881.0.camel@rth.ninka.net>
	<20021205140349.A5998@ns1.theoesters.com>
	<3DEFD845.1000600@drugphish.ch>
	<20021205154822.A6762@ns1.theoesters.com>
	<3DF5C492.1070103@drugphish.ch>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002 11:40:18 +0100
Roberto Nibali <ratz@drugphish.ch> wrote:

> > This is unfortunately not sufficient, not even close to. If you really want
> > to have a good idea what is going on you should as well check out what is
> > happening with packet sizes a lot smaller than 1500 (normal mtu). Check
> > data rate an packet loss with packet sizes around 80 bytes or so to get an
> > idea what bothers us :-)
> 
> But this doesn't have anything to do with the hidden patch! It can be 
> multiple things:
> 
> o missing TCP segment offload support
> o inefficient zerocopy DMA support

cannot comment these.

> o IRQ routing problems

no.

> o wrong QoS settings

no.

> Could you please be more specific on what exactly you're trying to 
> achieve? Do you want to load balance an application whose average 
> package size is 80 bytes? How many sustained connections per seconds do 
> you have?

Well, what I am trying to say is this: my experience is that under load with
small sized packets even standard routing/packet forwarding becomes lossy. If I
put NAT and other nice netfilter features on top of such a situation things get
a lot worse (obviously) - no comparison to building the "application" (e.g.
cluster) with routing and hidden-patch (mainly because of its pure simplicity I
guess).
Don't get me wrong: I am pretty content with the hidden-patch and my setup
without NAT. But I wanted to point to the direction of possible further routing
performance improvement in 2.4.X tree. Is it correct that I can expect higher
data-rates (concerning small packets) if using higher HZ ?
Someone selling E3 cards told me he cannot manage loads like these (small
packet stuff) with a stock kernel, and that you _at least_ have to increase HZ
to get acceptable throughput results.

-- 
Regards,
Stephan
