Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279356AbRJWKZh>; Tue, 23 Oct 2001 06:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279358AbRJWKZ1>; Tue, 23 Oct 2001 06:25:27 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:7437 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S279356AbRJWKZI>;
	Tue, 23 Oct 2001 06:25:08 -0400
Message-ID: <20011023143324.B3949@castle.nmd.msu.ru>
Date: Tue, 23 Oct 2001 14:33:24 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, cfriesen@nortelnetworks.com
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
In-Reply-To: <20011020145515.A17623@castle.nmd.msu.ru> <200110211721.VAA31390@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <200110211721.VAA31390@ms2.inr.ac.ru>; from "A.N.Kuznetsov" on Sun, Oct 21, 2001 at 09:21:32PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 21, 2001 at 09:21:32PM +0400, A.N.Kuznetsov wrote:
> 
> > What do you think will happen when a broadcast ARP request for 1.2.3.4
> > arrives to both eth0 and eth2?
> 
> Nothing. Linuxes attached to the segment even will not notice this.
> Just check and guess why. :-)
> 
> Windows will dump a funny popup saying that someone uses
> their address, but however will continue to work. Probably
> with short periods of service deaths if the router is not a router
> really, but drops everything instead.

Are you saying that proxy_delay is sufficient protection from diverting other
hosts to this "proxy", and from starting to answer proxy's own requests sent
to eth2 and seen on eth0?

> > How can it be done better?
> 
[snip]
> If you broke them f.e. announcing a pseudo-router with forwarding
> enabled but dropping everything with a firewall rule, ARP must not
> take care of this. That part of code which drops IP is responsible

I would prefer to put it this way: with this kind of firewall rule, the
question of working ARP needs to be taken care.
I've been doing it by setting up necessary ARP entries manually, the feature
you're going to remove from ip :-)

> for ARPing being in sync to its rules.

	Andrey
