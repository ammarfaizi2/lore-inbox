Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSIOPPQ>; Sun, 15 Sep 2002 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSIOPPP>; Sun, 15 Sep 2002 11:15:15 -0400
Received: from dsl-213-023-039-078.arcor-ip.net ([213.23.39.78]:37504 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318075AbSIOPPO>;
	Sun, 15 Sep 2002 11:15:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [2.5] DAC960
Date: Sun, 15 Sep 2002 17:23:01 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
References: <E17odbY-000BHv-00@f1.mail.ru> <E17qQum-0001qO-00@starship> <20020915131920.GR935@suse.de>
In-Reply-To: <20020915131920.GR935@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qbEj-0000BP-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 15:19, Jens Axboe wrote:
> Please, the scsi sub system is not a 'festering sore'. Have you even
> taken a decent look at it, or just spreading the usual "I heard SCSI
> dizzed somwhere" fud?

You got me.  First I haven't looked at it yet (this week though)
and second, I have heard that the scsi mid layer is actually pretty
nice.  The "festering sore" part is really the fact we don't use it
for IDE as well.

> Sure there's room for improvement, 2.5 has in fact
> already gotten quite a lot. It's not perfect and there's still stuff
> that can be cleaned up, but that doesn't mean it's crap.

Yup, I know, retracted, back to our regular programming.

> > Linus indicated at the Kernel Summit that he'd like to see a
> > cleaned-up scsi midlayer used as framework for *all* disk IO,
> > including IDE.  Obviously, what with IDE transitions and whatnot, we
> > are far from being ready to attempt that, so see "nursing along"
> > above.  There's no longer any chance that a generic disk midlayer is
> > going to happen in this cycle, as far as I can see.  Still, anybody
> > who is interested would do well by studing the issues, and fixing
> > broken drivers certainly qualifies as a way to come up to speed.
> 
> First of all, I believe Linus' plan is to push more functionality into
> the block layer.

I distinctly heard him say he wanted the scsi mid layer repurposed as
an interface for all disks.  Maybe he changed his mind?

> Generic functionality. And in fact a lot of has already
> happened there, but one does need to pay attention to that sort of thing
> instead of just assuming spouting fud. Examples:
> 
> 	- queue merge and dma mappings. this is all generic block/bio
> 	  functionality now. please compare scsi_merge.c between 2.4 and
> 	  2.5, if you care to.
> 
> 	- highmem bounceless operation also added the possibilty to do
> 	  isa bouncing generically in 2.5. this is also gone from scsi.
> 
> 	- request tagging. 2.5 has a generic implementation, scsi
> 	  transition is not complete though.
> 
> that's just off the top of my head.

Ah, we could use more summaries like that.

Well, you're looking at the situation from the block IO maintainer's
point of view.  We also need certain scsi-style functionality available
across all disk systems, such as barriers in a form usable by
filesystems.  Maybe you *can* suck all that functionality into the
block layer, but maybe it needs higher level support as well.  I'll
bet on the latter, and I won't have to speculate, pretty soon.

> So where am I going with this? I said "don't bother" to the question of
> studying SCSI code, and I stand by that 100%. It would be an absolute
> _waste of time_ if the goal is to make dac960 work in 2.5. I believe why
> should be pretty obvious now.

My own goal is certainly not limited to making the thing work.  I need
to *understand* these systems, because they are important to what I'm
doing and right now they are a big, black hole somewhere over in the
south end of the kernel.

> Daniel, your (seen before) 'clarification' posts are not.

Jens, we just got a whole lot clearer than your "no, don't bother,
possibly" post.  Such posts may feel good to write, but they're not
very helpful.

> I can only note that so far there has been a lot of talk about dac960
> and updating it, and that's about it. Talk/code ratio is very very low,
> I'm tempted to just do the update myself. Might even safe some time.

Counts as more talk ;-)

-- 
Daniel
