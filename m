Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbTHTTRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbTHTTRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:17:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47109 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262202AbTHTTRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:17:38 -0400
Date: Wed, 20 Aug 2003 15:08:03 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: dang@fprintf.net, alan@lxorguk.ukuu.org.uk, richard@aspectgroup.co.uk,
       skraw@ithnet.com, willy@w.ods.org, carlosev@newipnet.com,
       lamont@scriptkiddie.org, bloemsaa@xs4all.nl, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
In-Reply-To: <20030820100044.3127d612.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1030820150110.15623A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003, David S. Miller wrote:

> On Wed, 20 Aug 2003 12:49:14 -0400 (EDT)
> Bill Davidsen <davidsen@tmr.com> wrote:
> 
> > On 19 Aug 2003, Daniel Gryniewicz wrote:
> > 
> > I have been asking for a similar thing as well, David mentioned some
> > things that would break, but I believe they break if you use source
> > routing, so that seems not to be a real objection.
> 
> It's not about source routing.  It's about failover and being
> able to use ARP on interfaces which don't have addresses assigned
> to them yet.

David mentioned that you could solve the problem by using *rp_filter and
source routing. I don't think that's entirely true, but doing so has the
same drawbacks and breaks the same things as a flag to make Linux behave
like Sun/BSD/Windows (and work with Cisco is the cases previously
mentioned).

> 
> > I find it interesting that we can't change networking because a few
> > complex systems would have to be reconfigured, but we *can* change modules
> > which requires config changes on probably 90% of all systems (commercial
> > distributions).
> 
> Decisions about Networking will always be in a different domain
> because the way one behaves has effects upon other systems not
> just the local one.

Yes, that's exactly the point, the way Linux works has bad effects on
certain other machines, as in leaves them disconnected to the Linux
system.

> 
> BTW, another thing which makes the source address selection for
> outgoing ARPs a real touchy area is the following.  Some weird
> configurations actually respond with different ARP answers based upon
> the source address in the ARP request.  You can ask Julian Anastasov
> about such (arguably pathological) setups.
> 

I don't think anyone is asking for a change in the default behaviour
(although my point about breaking modules does apply), people would be
satisfied, even ecstatic, if we had a simple way (flag) to set to make
Linux work without setting /proc filters, using arpfilter, applying source
routes (David's suggestion) and generally jumping through hoops.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

