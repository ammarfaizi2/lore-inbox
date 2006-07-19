Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWGSWjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWGSWjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 18:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWGSWjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 18:39:17 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:50884 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932554AbWGSWjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 18:39:17 -0400
Date: Thu, 20 Jul 2006 00:34:08 +0200
To: Tilman Schmidt <tilman@imap.cc>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com
Subject: Re: Reiser4 Inclusion
Message-ID: <20060719223408.GA14875@aitel.hist.no>
References: <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net> <20060717155151.GD8276@merlin.emma.line.org> <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr> <20060718204718.GD18909@merlin.emma.line.org> <fake-message-id-1@fake-server.fake-domain> <84144f020607190403y1a659c99oc795ae244390c2ee@mail.gmail.com> <44BE50A0.9070107@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BE50A0.9070107@imap.cc>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 05:32:48PM +0200, Tilman Schmidt wrote:
> Pekka Enberg wrote:
> 
> > On 7/19/06, Tilman Schmidt <tilman@imap.cc> wrote:
> >> You can't have it both ways. Either you want everything in the main
> >> kernel tree or you don't. Of course there will always be a limbo of
> >> code waiting for inclusion. But if it has to linger there for too
> >> long (again: no matter for what reason) then it invalidates the
> >> whole concept of not having a stable API. And that would be a pity.
> > 
> > You seem to have this idea of everyone having some sacred right of
> > having their code either in the kernel or supported by the kernel
> > developers.
> 
> No, and seriously I cannot see how you could possibly get that
> impression from what I wrote.
> 
> > It is up to the maintainers to decide what's included and what's not.
> 
> Ok. But then it's also up to them to stand by their decision and
> take the heat for it. Don't jump from your left foot to your right
> foot, saying "submit your code to the kernel" if someone wants to
> maintain something off-tree and "maintain it separately" if they
> try to submit it. State clearly: "We do not want Reiser4 in Linux"
> and defend it, instead of creating a string of ifs and then
> complaining that people go on about it.
> 
It really is "_clean up_ and submit your code to the kernel, and then
we _will_ include it _if_ we find it useful!"

Reiserfs4 doesn't go in currently, because  nobody bothered cleaning
it sufficiently up.  Any popular filesystem is considered useful,
so reiserfs4 goes right in as soon as:
1) it gets cleaned up just the way the kernel maintainers wants it. 
   (And yes, that could be some work.  Code with known problems in
    it doesn't go in until they are fixed)
2) Some maintainer have the will and time to look at it and see that it
   is indeed of good quality.  That will is worn thin by reiserfs people
   quarreling with the maintainers, but I guess this could be rectified
   with some apologies and a serious attempt at the above mentioned
   cleanup.

If you want reiserfs4 in - either help the reiserfs team with the
cleanup, or bully _them_ into doing it.  Complaining here won't do the
trick at all, as you are not in a position to put pressure on
the developers. (I.e. you are neither their boss nor their paying
customer.) Linux development isn't market-driven.

> > We obviously don't want _everything_ in the kernel anyway and don't
> > want to stagnate the kernel development because of out-of-tree code
> > either.
> 
> Well, that doesn't make sense. You can't have your cake and eat it
> too. Either you have out-of-tree code or you haven't. Documents
> like stable_api_nonsense.txt explicitly discourage out-of-tree code,
> which is formally equivalent to saying that all kernel code should
> be in-tree. Therefore an attitude which says "go on developing that
> code out-of-tree, it's not ready for inclusion yet" is in direct
> contradiction with the foundations of the no-stable-API policy.
> 
If you think you caught anyone in a self-contradiction, it won't help
you.  It only means the real rules is a bit more complicated:

1. We want in-tree code, and so no attempt is made to make it easy to
have out of tree code
2. High quality code is more important than quantity, so code with
problems don't go in!

It is up to whoever wants a piece of code in, to clean it up so well
that can be added to the kernel tree.  Sometimes a kernel maintainer will
do that job - because he want the stuff in himself.  So he volunteers.
At other times, some piece of code "could be nice to have" but no
maintainer thinks it is so nice that they clean it up themselves.
Reiserfs4 is in this category.  It is then up to reidser4 fans to get
the job done - by doing it themselves or raising enough money to pay
someone to do it.  

> > If you're unhappy about maintainer decisions, feel free to
> > complain to them
> 
> Well, isn't that what the present thread is all about?
> 
> > or better yet, step up to do the necessary legwork to
> > get the code included.
> 
> That's completely beside the point. There are enough people already
> who are willing to do the legwork. The question is whether they and
> the kernel maintainers will be able to bridge their differences
> about how it should be done, and that would not be made easier by
> another party entering the arena.
>
Actually, there is nothing wrong in taking over maintainership of
reiserfs4.  Sure, you will annoy the namesys people but such is the
nature of open source projects - good stuff badly maintained can be
taken over anytime by a better maintainer.  That has happened several
times, look at the history of gcc for example.

If there really was enough people willing to do the legwork - it'd be
done or at least an ongoing effort now.  How to do it is simple - the
way the kernel maintainers tell them to.  There is little use
disagreeing about that.  One can complain to Linus, other than that,
there is no way around the maintainers.

> Seriously, what do you think would happen if I actually took the
> Reiser4 code, modified it according to what I think the kernel
> people would like to see, and submitted the result to lkml? I'll
> tell you what'd happen: I would get heat from both sides, I would
> be blamed both for perceived flaws in the original design and for
> any deviation from it, my motives would be questioned, I would be
> asked whether I'd commit to maintaining that code for the
> foreseeable future, and there would be no right answer to that
> question. No matter what I did, it would only make things worse.
>
The kernel side would not flame you for this - if you did good work and
managed to remain polite.  Of course you wouldn't get it in immediately,
you'd expect to have several iterations of fixing stuff, submitting, get
feedback about more wrong things to fix - but eventually you'd get it
in!

This process can take time, especially with something as big as
reiserfs.  The general opinion here is that the reiserfs developers
didn't do this part properly, when they couldn't get reiserfs4 in
quickly, they argued instead of fixing more.  But that approach doesn't
work.  A "no" or "fix that too" tend to be final around here, and
arguing about it is only considered rude.  And yes - there is the
real risk of annoying a maintainer so bad he won't look at the stuff
again.  The kernel effort is not a company, people here are allowed to
take things personally and bear grudges.  Anyone who want code into the
kernel should therefore consider this be polite at all time - even if 
they get told to "fix more stuff" for the umpteenth time.

Arguing don't work.  Those who try tend to find that clever arguments
fail, and then that resorting to nastier stuff fail even worse.

> (Please note that the scenario above is completely fictitious. I am
> neither capable of, nor interested in, taking over the development
> of Reiser4 or promoting its admission into the kernel tree.)
> 
> > After all, that's how Linux development works.
> 
> Obviously there's more to it than that. There are people involved.

Indeed!

Helge Hafting
