Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271552AbRHUEwh>; Tue, 21 Aug 2001 00:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271553AbRHUEw1>; Tue, 21 Aug 2001 00:52:27 -0400
Received: from www.wen-online.de ([212.223.88.39]:61446 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S271552AbRHUEwN>;
	Tue, 21 Aug 2001 00:52:13 -0400
Date: Tue, 21 Aug 2001 06:52:11 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010820202807Z16262-32383+582@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108210629020.672-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Daniel Phillips wrote:

> On August 20, 2001 09:14 pm, Mike Galbraith wrote:
> > On Mon, 20 Aug 2001, Daniel Phillips wrote:
> > > On August 20, 2001 05:40 pm, Mike Galbraith wrote:
> > > > I'll give your patch a shot.  In the meantime, below is what I did
> > > > to it here.  I might have busted use_once all to pieces ;-) but it
> > > > cured my problem, so I'll show it anyway.
> > >
> > > No, this doesn't break it at all, what it does is require the IO page
> > > to be touched more times before it's considered truly active.  This
> > > partly takes care of the theory that an intial burst of activity on
> > > the page should be considered as only one use.
> >
> > (it turns it into a ~sortof used twiceish in my specific case I think..
>
> Actually, used-thriceish.
>
> > the aging must happen to make it work right though.. very very tricky.
>
> I doubt the aging has much to do with it, what's more important is the length
> of the inactive_dirty queue.  Of course, aging affects that and so does
> scanning policy, both a little "uncalibrated" at the moment.
>
> > Nope, I don't have anything other than a 'rough visual' to work with..
> > might be totally out there ;-)
>
> What made you think of trying the higher activation threshold? ;-)

Well :)) there I sat daydreaming, imagining myself as a bonnie page
running around queues, got dizzy and finally just changed the little
spot that kept attracting my eyeballs.. a hunch.

	-Mike

