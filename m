Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSLHQ46>; Sun, 8 Dec 2002 11:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSLHQ46>; Sun, 8 Dec 2002 11:56:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2826 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S261356AbSLHQ45>;
	Sun, 8 Dec 2002 11:56:57 -0500
Date: Sun, 8 Dec 2002 18:01:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Roberto Nibali <ratz@drugphish.ch>, willy@w.ods.org,
       linux-kernel@vger.kernel.org
Subject: Re: hidden interface (ARP) 2.4.20
Message-ID: <20021208170135.GA354@alpha.home.local>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> <1039124530.18881.0.camel@rth.ninka.net> <20021205140349.A5998@ns1.theoesters.com> <3DEFD845.1000600@drugphish.ch> <20021205154822.A6762@ns1.theoesters.com> <3DF2848F.2010900@drugphish.ch> <20021208170336.5f4deaf1.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021208170336.5f4deaf1.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 05:03:36PM +0100, Stephan von Krawczynski wrote:
> > Not with a HW LB, and with a SW LB (LVS-NAT) you can very well sustain 
> > 20000 NAT'd load balanced connections with 5 minutes of stickyness 
> > (persistency) with 1GB RAM and a PIII Tualatin with 512 kb L2 cache. I'm 
> > not sure if you meant this when mentioning pain.
> 
> I guess he probably meant a _bit_ more. I may add some zeros to your 20000 to
> give you a glimpse of a _standard_ load we are talking about. And you can
> easily do this with the hardware you mentioned _not_ using NAT (of course ;-).

You're right, we have been discussing this privately and agreed we were both
talking about higher numbers ; Robert seems to have a good experience of very
high traffic ;-)

> I guess it would really be a great help if someone did tests like Cons'
> "overall performance" ones for network performance explicitly. Like e.g.
> performance for various packet-sizes of all available protocol types, possibly
> including NAT connections. We have no comparable figures at hand right now, I
> guess.

Why not ?
I've often been doing this to check the reliability of the network layer of
kernels that I distribute. I often use Tux for this, because it can easily
sustain 10k hits/s during months. But Tux is not in mainstream kernel, we have
to use other tools. Since I'm working on a task scheduler, I may soon have the
base to rewrite my injecter and a fake server to do these tests on mainstream
kernels. I think that several tools already exist for this. You can take a look
at the C10K project to find links. I don't have the URL in mind, google is your
friend.

Cheers,
Willy

