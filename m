Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266462AbSLJBQU>; Mon, 9 Dec 2002 20:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbSLJBQU>; Mon, 9 Dec 2002 20:16:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54799 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266462AbSLJBQT>; Mon, 9 Dec 2002 20:16:19 -0500
Date: Mon, 9 Dec 2002 20:22:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Roberto Nibali <ratz@drugphish.ch>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
In-Reply-To: <3DEFE86A.8060906@drugphish.ch>
Message-ID: <Pine.LNX.3.96.1021209200239.9066D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Roberto Nibali wrote:

> As mentioned before, you don't necessarily need to patch your kernels, 
> there are other possibilities to overcome the arp problem. You could (if 
> not already done so) consult the LVS howto where solutions are certainly 
> applicable also to non-LVS LBs.

In spite of vast resistance from some developers, it is highly desirable
on some systems to force a packet with a given source IP out an interface
which has that IP assigned. With this capability it is possible to make a
single machine with multiple NICs behave like two machines with individual
NICs. This also solves ARP issues, although it's a much more general
thing.

Think development, think debug, think UML virtual machines, or a machine
with multiple boundary routers which are addressed to separate NICs. The
usual proxy_arp fix doesn't really address these cases. If I have multiple
default routes, the router on which the packet arrived is likely to be on
the route with the fewest hops, randomly using another route doesn't help.

Source routing takes too much overhead for lots of connections, and as I
recall is limited to 256 rules. I'm not sure the hidden interface patch
really does this, although I just looked quickly.

Patches like the hidden interface will continue as long as there are
useful things people want to do with Linux and can't. It's one of many in
the networking area. I don't expect them to be adopted in the main kernel,
but as long as they're easier than making multiple configs, particularly
at runtime, they will be around.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

