Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268518AbTBODAL>; Fri, 14 Feb 2003 22:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268520AbTBODAK>; Fri, 14 Feb 2003 22:00:10 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:12928 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S268518AbTBODAI>; Fri, 14 Feb 2003 22:00:08 -0500
Date: Sat, 15 Feb 2003 03:11:57 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@bitmover.com>, "Vlad@geekizoid.com" <vlad@geekizoid.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: openbkweb-0.0
Message-ID: <20030215031157.GA5250@bjl1.jlokier.co.uk>
References: <1045273835.2961.0.camel@irongate.swansea.linux.org.uk> <008e01c2d48d$d0fe28f0$0200a8c0@wsl3> <20030215020044.GG4333@bjl1.jlokier.co.uk> <20030215024102.GA23918@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215024102.GA23918@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> > Fwiw, even though Larry's offered to special-case Alan, (and presumed
> > that Alan's doesn't work for anyone other than Red Hat), in private
> > email Larry made it clear _I_ am not allowed to use Bitkeeper.  This
> > is because I work on scripts which analyse repositories - and even
> > though I was prepared to limit the scope of that work for a time.
> 
> Err, tell the whole story Jamie.

As you insist :)

> You are going down the path of trying to make CVS work as much as
> possible like BitKeeper.  That's a perfectly reasonable thing for
> you to do but we are in no way obligated to help you.

That seems unlikely, as I have never used Bitkeeper and have no idea
what it is like to use other than anecdotes from the LKML.

Anything I come up with comes from (a) good public ideas from many
sources including you; (b) my own experience with CVS and diff+patch.
Any resemblance to Bitkeeper is a result of "great minds think alike" :)

Besides, there is a huge gulf between browsing and monitoring, and
"going down the path" of a version control system.

My ideas are quite different from yours anyway...  (Much more watching
other projects, much less tools for respository mgmt).

I said I'd hold off from considering the programs that, IMHO, are not
like BK at all but which you might not like, for a negotiable time, in
exchange for a BK protocol spec., but you didn't go for it.

(The email I sent you is copied below, for the "whole story".  People
are encouraged to draw their own conclusions on whether those ideas
are like Bitkeeper.  I don't know, having not used it.)

-- Jamie

Date: Sat, 18 Jan 2003 07:28:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@bitmover.com>

Larry,

Thanks for your helpful response.

Larry McVoy wrote:
> How about you tell me why it is that you think that you would violate 
> 3(d)

I'm working on

  (a) a program like cvsview et al. for displaying changeset logs
      on a web page and on the command line.  It is good at computing
      changesets from CVS trees, even though those have to be deduced.

  (b) related to above, a program which displays the diffs of checked
      in files, like cvsview et al. but it shows whole multi-file changes
      (i.e. is useful) rather than singlefile diffs like all the other
      CVS-display programs (i.e. not useful at all).

      It is also quite pretty, in that syntax colouring and folding
      appear on the web page :)  You'd like it.

  (c) programs which extract data from SCCS and CVS/RCS files, obviously
      related to above but could be use for other purposes.

And

  (d) I would like (a)-(c) above to be able to interface to a remote
      bk repository, in the same way as they can analyse local SCCS/RCS
      and remote CVS.

That's a bonus feature, which I expect you'd be least happy with.
It _could_ simply call out to bk itself, though I prefer not.
(You can see why knowing the BK transfer protocol would be useful for _that_)

Perhaps the bk protocol is too complex or variable to do anything
other than call bk, but I would hope not, given the simplicity of the
file format.

I'm not sure whether you'd consider these programs including the (d)
feature to compete with BK-Web or something.  To be sure, you can't
actually do version control with them (because they only read, don't
write).

However one day, when I've finished about a million prerequisites for
doing it properly, and if the moon is out, I have these on my plan:

  (e) definition tracking, i.e. let person A know whenever definiton of
      anything related to B changes in external project C.  For example,
      email whoever is interested whenever the kernel's VFS locking rules
      _might_ have changed, by noting when certain key definitions
      have changed in the kernel tree.  (That's just an example - the
      idea is that a software project might end up tracking hundreds or
      more little aspects of other external software projects, so it
      can keep up to date with reduced human effort).

  (f) patch tracking, not unlike Rusty's trivial patch handler, some
      bug+fix tracking software, or any other bug/feature ticketing
      system you have heard of.

At that point it's possible we are talking about direct competition
for bk, not a clone (I'm not interested in cloning) but change
management nevertheless.  Btw, it's not about politics - like you I've
been thinking about s/w development management tools for years, and
have my own ideas which I simply want to try out.

Though that point is a long way off and may never happen.
So many ideas, so little time, you know how it is :)

   ----

> and we'll take it from there?

Ok.

[ Note that I won't agree to refrain from reverse engineering the
  network protocol, as the price of using BK for free.

  Chances are I'll never bother, but it's not something I'd willingly
  agree to not do, because I prefer to be not allowed to use BK than to
  be effectively bound by an eternal NDA. ]

However, I would be fine to agree that I'll use BK up to the point
where I start work on a certain kind of project, and then stop using
BK, if that would suit you.

An obvious stopping point would be when I wish to develop a program
that does more than just read, display and track information in a
repository.  I.e. when I want to add the capability to write.

If you are into complicated agreements, I could even agree a minimum
time between stopping using BK and starting to develop the latter kind
of program.

Or I could agree anything else you can dream up.  I'm open to
suggestions.  There might some useful business we can do, one day; I'm
not about to throw _that_ chance away.

Thanks again for your constructive response,
-- Jamie

