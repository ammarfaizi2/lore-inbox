Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSDQRyp>; Wed, 17 Apr 2002 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311523AbSDQRyo>; Wed, 17 Apr 2002 13:54:44 -0400
Received: from bitmover.com ([192.132.92.2]:35269 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S311454AbSDQRyn>;
	Wed, 17 Apr 2002 13:54:43 -0400
Date: Wed, 17 Apr 2002 10:54:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: "M. R. Brown" <mrbrown@0xd6.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020417105441.Q745@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"M. R. Brown" <mrbrown@0xd6.org>,
	James Simmons <jsimmons@transvirtual.com>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com> <20020417000818.GB5897@0xd6.org> <20020416181034.C24069@work.bitmover.com> <20020417024149.GC5897@0xd6.org> <20020416203721.B27525@work.bitmover.com> <20020417050412.GD5897@0xd6.org> <20020416230355.I27525@work.bitmover.com> <20020417135215.GA7814@0xd6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 08:52:15AM -0500, M. R. Brown wrote:
> > > For the LinuxSH project, we moved from tracking the full kernel tree (via
> > > CVS) to a drop-in tree structure mainly because of the difficulty in
> > > tracking all upstream kernel changes at once.  It wasn't really related to
> > > what CVS did or did not offer.
> > 
> > Disagree.  CVS sucks at tracking an external source of change while
> > maintaining your own changes at the same time, in the same tree.
> > It really sucks at that, you are forced into a broken branching model
> > with awful merge characteristics.  Try the same thing with BK, it's
> > a lot nicer, most stuff just automerges, and the stuff that doesn't
> > only needs to be merged once.  Your claim that it isn't about CVS
> > doesn't make much sense when CVS forces you to split your subtree
> > out.  Having an _option_ to do that is one thing, being forced to
> > do it is another.
> 
> I'd hate to sound like I'm trolling or being a broken record.  But I don't
> currently have that option with BK.  This is the option I want, to be able
> to not have to worry about pulling all changes or being able to cordon off
> only the bit I want/need to work with.  

Here's how you do it with BK.

    a) pick a baseline that you want.  Like 2.4 or 2.5.  clone it.
    b) put your changes on top of it.
    c) for each tree to which you want to apply your changes, clone it,
       and then pull from your tree.

Just go try that for a month's worth of changes and then tell me if it
isn't easier for you.

The deal is that you are trying to take your style of working, which as
far as I can tell, is based on CVS being broken, and insisting on that
style.  If you really want to work that way, you can, you are just losing
a lot in the process.  But whatever.  If you want to maintain a drop in
tree from a BK tree, then just check out the part of the tree you want
and plop the files into CVS.  Cort exported subsets of the trees as
patches for Linus for 2 years, it works.

> > And if that tree has changes in the files that you are "dropping in"?
> > You just stomped on them.  Or you are left with an even more broken
> > merge model than CVS.  And what about file renames.
> 
> When my drop-in tree file changes upstream, I'll find out in the next
> upstream sync.  Obviously if my drop-in tree is current, that file hasn't
> changed yet.  File renames are broken, but I never pretended they weren't.  I
> guess what you're saying is it comes down to me weighing out feature-rich
> set vs. feature-less set, where BK is the former, and I should expect to have
> to sacrifice my entire development model (drop-in trees, not CVS) for the
> bloated model that BK currently *enforces* (see your above paragraph about
> having the option).

That "bloated model" makes all the hard aspects of your model go away.
So you are trading off your model against your time.  That's the whole
point.  For the cost of some local storage, you get some of your time
back to do useful work.  Read that again.  That's the whole point.
An SCM tool is supposed to *save you time*.  What you are doing is
replacing missing features by you manually fixing up the places where
your tools didn't work.

You'd have a strong point if the model that BK was using wasted your time,
but you haven't made that case.

> > Part of the problem I have is that
> > you are, in a public forum, saying that BK is this and that, based on your
> > perceptions from 2 years ago when you said you used it on the ppc tree.
> 
> Nope, I said that based on what I read at www.bitkeeper.com, BK didn't
> support drop-in trees *today*.  I said that the last time I actively used
> the tool was 2 years ago, but I haven't had a reason to use it since then.
> In a public forum, which you use to promote sales and use of your product, I

OK, one day this might not be true, but so far, we haven't made a dime
off the people in this forum.  The people reading this forum don't spend
money, they write/read code.  The fact that this forum has not been
a money make for us has been true for 4 years.  I'm not sure how many
years it needs to be true before it might occur to you that the reason
I post here about BK is for some other reason than to make money.

BK is my primary way, these days, of trying to help out with the kernel.
I'd like it to help as many people as possible because I like Linux.
All of these posts are focussed on one thing: making people more productive
while doing development on the kernel.  Your posts annoyed me because they
made it sound like BK slows you down.  In the case you are talking about,
I think the opposite is true.  You might think that too if you actually 
tried it.

> When I decide to start and maintain the "linux toaster
> driver", I pull out the source I need from mainline, and setup my drop-in
> tree from that and my new imports.  The BK way to do it is to simply "clone
> the master" and work from that.  Not a drop-in.

So what?  Do a hardlinked clone, it costs you nothing, and do your work
in there.  BK will solve all the merge/rename problems that are inevitable
and you can focus on your work.

> Are you
> saying the only way for me to evaluate a tool (one that I haven't used in
> ages) is to use it?  

Yes.  Just like the only way to know how an application performs on a
platform is to run it.  Documentation, peer reviews, the words out of
my mouth, they are all like benchmark results, they are noise compared
to you actually trying to do what you want to do.

> It was a good read, and easy to follow, but it still does the opposite of
> what I need to do.  I want multiple small project-specific trees, not a
> myriad of full kernel trees.  Everything else gave me a good starting point
> for doing SCM-controlled kernel development using BK.  Thanks for the
> pointer.

So use hardlinked clones.  See the clone -l, and the relink docs.  You'll
burn 87MB for the baseline and then 1240 inodes for the directories in
each hardlinked clone.  If inodes take 4K each, that's 5MB, which isn't
free, but that's the best we can.  We'll cut that in half when we get
rid of the SCCS directories.

If you wanted to complain that BK doesn't restore the hardlinks after a
file is updated in multiple clones, that's a legit complaint.  You can
solve that with a post-incoming trigger which runs relink, but it would
be nicer if there was a way to make BK do that automagically.

> for me it boils down to using the best tool for the job.

Hey, I'm all for that.  If Arch worked better for Linus and the
maintainers, I'd be the first to urge them to switch.  We aren't getting
financial benefit from the kernel use of BK, which is a bummer, but that
is OK, that wasn't the point.  The point was to reduce the workload on
the critical people in the equation and that's what we focussed on.

I'm not at all convinced that you have explored BK enough to know whether
it will help you or not, and I'd appreciate it if you did so rather than
claiming it doesn't work.  All you are saying is that it doesn't work
exactly how you work now.  That may or may not be the same as saying it
can't help you (or others).  You won't know until you go explore.

Both Linus and I were fairly convinced that the BK take-it-all whether
you want it or not model was a showstopper.  Then Garzik figured out
a way around that which works well enough for now.  A lot of useful
work is happening faster because of what he figured out.  My complaint
with you is that you are assuming that you can't make BK work faster
for you without trying it or thinking about it.  Does BK mimic your
working model?  No.  Does that mean it can't help you?  Not clear.
That's the point.

I think BK can help you and you are so stuck on one way of doing things
that you are ignoring that possibility.  That's OK with me so long as
it is just you, but you're posting in a public forum, to a group of
people that I'm trying to help, and as long as you do, I'll be here,
annoying as heck, explaining why you are wrong.  I'm not saying that you
are wrong about BK drop-ins, you're right about that.  We're fixing it as
fast as we can, it's in my top 3 work items right now.  In the meantime,
if you poked around, there are lots of ways to use BK and I'm 99% sure
you could find one that would result in less work overall for you than
what you are doing now.  I don't care if *you* find one, I care if 
others find one.  We're trying to maximize productive work for the
largest number of people, and I find your posts counterproductive to
that goal.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
