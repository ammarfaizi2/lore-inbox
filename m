Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282684AbRK0Aoe>; Mon, 26 Nov 2001 19:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282686AbRK0AoO>; Mon, 26 Nov 2001 19:44:14 -0500
Received: from femail42.sdc1.sfba.home.com ([24.254.60.36]:3576 "EHLO
	femail42.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282689AbRK0AoF>; Mon, 26 Nov 2001 19:44:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, landley@trommello.org
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
Date: Mon, 26 Nov 2001 16:42:58 -0500
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com (Linus Torvalds), mfedyk@matchmail.com (Mike Fedyk),
        skraw@ithnet.com (Stephan von Krawczynski),
        kubla@sciobyte.de (Dominik Kubla), marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <E168Szh-0006un-00@the-village.bc.nu>
In-Reply-To: <E168Szh-0006un-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <0111261642580L.02001@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 16:08, Alan Cox wrote:
> > I submit that if the stable tree hasn't calmed down after three or four
> > months, opening a development branch may in fact HELP the situation, and
> > stabilize things faster.  You need to vent the patch pressure.
>
> I'd tend to agree there. The new VM would have gone into 2.5.x and then
> back into 2.4
>
> In terms of release cycles there is a better method, that is simply to
> codify what already happens. In truth we have yearly major releases

I also can't think of a distribution that doesn't have at least a yearly 
major release cycle.

I suspect part of the reason for the long gap between stabilizations is that 
Linus hates maintenance.  Of course it's like visiting the dentist: the 
longer it takes the bigger a deal it is...

> We went
>
> 	1.2
> 	1.3.59
> 	2.0
> 	2.0.30
> 	2.2
> 	2.2.14-18 merge cycle
> 	2.4
>
> What we possibly should do is admit the backport phases (2.0.30/2.2.14/...)
> do in fact occur and go
>
> 	2.5
> 	2.5 seems kind of solid at some random point but not finished
> 	2.6 (2.4 + 2.5 and useful bit driver backport)
> 	2.7 (continued 2.5)
> 	2.8 (actual release containing the grand changes 2.5 started)

This gets back to the idea of "minor" development cycles (for example 2.5 
already HAS enough pending patches for an entire development cycle) that take 
6 months because we know what's going to go into them in the first month or 
two, vs "major" anything-goes phases (3.0, which 2.2 probably should have 
been...) that are a lot more experimental.  Right now, everything's a major 
cycle.  Even though Linus has expressed a desire to do minor ones, it hasn't 
happened yet.

The thing is, with a 6 month development cycle that people BELIEVE will only 
take 6 months, it's ok to say "hold off until the next time".  But asking 
people to "hold it" for two years (even if they only THINK it will be two 
years) doesn't work, they keep pushing to get it in and the patch pressure 
stays high.  So it's a stable 2 state feedback loop: if you can do it you can 
do it, and if you can't you can't.

The "backport release" idea seems like a nice way to do the "short" cycle 
ones.  And the interesting thing about that is Linus doesn't have to be 
directly involved in these intermediate stabilizations: there could be 
another maintainer he could just give his blessing to.  All they need is a 
bit of holy penguin pee to make the number official, and the attention of 
developers (like all those in Red Hat's employ) willing to spend their time 
stabilizing rather than beating fresh trails into the jungle...

A backport release really isn't THAT much different than large changes from 
your tree being merged into Linus's tree.  Just a question of sequencing 
(determining what depends on what), isolating, and porting...

Just a thought...

Rob
