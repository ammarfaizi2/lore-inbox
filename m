Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWETMCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWETMCf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 08:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWETMCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 08:02:34 -0400
Received: from mx1.suse.de ([195.135.220.2]:43428 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932341AbWETMCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 08:02:34 -0400
From: Neil Brown <neilb@suse.de>
To: Al Boldi <a1426z@gawab.com>
Date: Sat, 20 May 2006 22:01:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17519.1323.822630.868492@cse.unsw.edu.au>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
In-Reply-To: message from Al Boldi on Saturday May 20
References: <200605200733.08757.a1426z@gawab.com>
	<20060520102526.GH10077@stusta.de>
	<200605201419.55428.a1426z@gawab.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 20, a1426z@gawab.com wrote:
> Adrian Bunk wrote:
> > On Sat, May 20, 2006 at 07:33:08AM +0300, Al Boldi wrote:
> > > Not that I would agree with the in-Kernel X idea per se, but it does
> > > raise the issue of a stable API once more, as it would allow more
> > > freedom to create a module against a version line w/o fear of being
> > > rejected.
> >
> > It does not raise the issue of a stable kernel API:
> >
> > The solution is to work on getting the module included into the kernel.
> > All problems with changing kernel APIs vanish as soon as your module is
> > included. This is independent from what the module in question is doing.
> 
> Yes, but the question is:
> 	What's the trick to get the module into the kernel?

The 'trick' is to write well designed, maintainable code, and accept
all criticism with good grace. (It helps if the code works too)

By far the best approach is to incrementally improve what is already
in the kernel.  In this case, that probably means fbdev and/or DRI.
If you get them to play nicely together and gradually enhance them to
provide the functionality you need, I think you would make a lot of
people happy.

> 
> It seems that we are currently under the mercy of the few, who have the power 
> to control this.  And forking isn't really a solution.

It is true that a thick skin helps.  But if you demonstrate (with
code) that you know what you are talking about, and respond
intelligently to all feedback (even when you don't feel the feedback
itself is intelligent) people will listen to you.

The coin of this realm is very much code.  That is one of the reasons
to start with small patches to existing code: it increases your
credibility with less investment than creating a great big slab of
code. 

> 
> With a stable API, I can just implement whatever w/o caring whether it is 
> included into the kernel.  Now that's freedom!
> 

That's userspace. 

Improve what is in the kernel so that it presents to userspace
whatever API you need, and write stuff in userspace to your hearts
content.  I'm sure that there is no need for the entire 'X' server to
be in the kernel, and I'm equally sure that there are advantages in
the kernel providing more services for an X server than it currently
does.  You need to find that balance.  It may be hard, but there are
people here who will help.  You add bits of functionality - people
will question them and require you to justify them. Some will make it,
some won't.  Bit by bit you will arrive at a workable solution.

As a sort of example: were I to start writing an NFS server for Linux
today, I wouldn't put it all in the kernel.  I would figure out the
minimum services I needed from the kernel and add them one at a time,
at each step modifying the userspace NFS server to use this
functionality.  Some of it would be quite tricky - particularly
achieving zero-copy reads and single-copy writes.  But I'm sure it is
possible, and I'm sure there are people here who would help point me
in the right direction.

NeilBrown
