Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293622AbSCATDc>; Fri, 1 Mar 2002 14:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293626AbSCATD2>; Fri, 1 Mar 2002 14:03:28 -0500
Received: from pc132.utati.net ([216.143.22.132]:41608 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S293623AbSCATCh>; Fri, 1 Mar 2002 14:02:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Fri, 1 Mar 2002 14:03:24 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>, green@thebsh.namesys.com,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020212190834.W9826@lynx.turbolabs.com> <20020213095502.F25535@lynx.turbolabs.com> <3C766C93.70109@namesys.com>
In-Reply-To: <3C766C93.70109@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020301191122.1522D51A@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm on the road, so this reply probably won't go out for a couple days, but 
I'll queue it in my outbox anyway...

On Friday 22 February 2002 11:06 am, Hans Reiser wrote:
> We need to move from discussing whether Linus can scale to whether the
> Linux Community can scale.
>
> Every organization needs to have clearly defined algorithms for
> determining what work is done by who.  For the linux community, our work
> consists in part of reviewing patches.  Incoherent inconsistent
> delegation is the only reason why we are having scaling problems.  We
> have a consistent recurring problem (yes, I know, a few lucky folks like
> me don't have this problem, but it is clear to see that WE as a
> community have this problem).
>
> It is important that there be  a consistent feeling among patch
> submitters that they know where to send their patches for
> acceptance/rejection.  There should be NO patches which go out, and not
> even a rejection comes back.

This is what the various patchbot projects are trying to address.  
(Unfortunately, they seem to have gotten the idea that they need a complete 
solution to all possible cases before deploying anything.  Just a filtered 
patches-only mailing list would be a start.  I'd put one up if I had a 
server, but as I said I'm moving this month.  If nobody else has done it by 
march, I might.)

The current Linux community structure seems to be four tiers.  Developers, 
maintainers, lieutenants, and linus.  Linus listens to lieutenants, 
lieutenants accept from maintainers, and maintainers accept from developers.

The confusion seems to be that until recently, many maintainers didn't know 
who the lieutenants were (who the people Linus actually listens to are, to at 
the very least explicitly reject patches once these people have reviewed, 
approved, and forwarded them).  Hence stuff was getting to maintainers and 
then being dropped when forwarded straight to Linus.  Linus still hasn't 
quite enumerated his lieutenants, but now that people know they exist I 
expect they'll become apparent eventually...

> Every organization has clearly defined procedures for allocating the
> flow of work.  It is called a management structure.  That is what we
> need, and we need a formal well defined and externally visible one.  An
> informal undefined network of friends is just not suitable for an
> organization where the flow of email is as large as it is in the Linux
> Community.

It's not a binary state.  The fact we need a little more structure doesn't 
mean anybody has to start filling out paperwork and blindly following 
procedures. :)

The "a little more structure" could be a "how to submit patches" FAQ entry 
that says:

1) Develop patch, test, get community feedback if necessary to make sure it 
works.
2) Submit to maintainer, get them to review and sign off.  Resolve any issues 
they have before proceeding.
3) Submit to lieutenant (the maintainer will tell you who this is), get them 
to review and sign off.  Resolve any issues lieutenant has before proceeding.
4) Submit to Linus, with appropriate endorsements.

If Linus ignores everybody except Lieutenants, that's probably workable as 
long as he DOESN'T ignore the lieutenants and people know who the lieutenants 
are, and the lieutenants don't ignore the maintainers and the maintainers 
don't ignore the developers.

If Linus has two levels of sturgeon's law filters (maintainers and 
lieutenants) before he has to explicitly reject something, then asking him 
(nicely) to at least reply thumbs up/thumbs down on patches forwarded to him 
("bad idea", "fix this", "do it this way instead") by the dozen or so people 
he trusts shouldn't overload his bandwidth.  (Whether or not he'd actually do 
it is still up to him, but that strikes me as the minimum workable long-term 
solution.)

So a developer would at least know who they have to please next (maintainer, 
lieutenant, or linus) to forward their patch.  It still might be a lot of 
work to go through the long way, and Linus would probably still accept 
interesting patches directly.  But the failure case of "my patch is getting 
ignored" would have a procedure to go through to get explicitly rejected by 
the appropriate person. :)

By the way, sometimes the answer honestly is "I'm busy, submit again after 
2.5.7".  Which is still better than being ignored.  (Stuff like the ALSA 
drivers: "Good idea, not now."  Ok: When?)

> Linus, I would like you to stop saying that you cannot scale to where
> you can read every email, and start determining what it takes to make
> the Linux Community infrastructure underneath you responsive to patches.

Linus (and the lieutenants under him) have not been the ones experiencing the 
problem.  Linus accepts all the patches he wants to, and the lieutenants tend 
not to be ignored.  The top of the pyramid is not where the motivation for 
change is most strongly felt...

>  Bitkeeper is a great start, but you also need to create  a management
> structure and interface that is clearly defined to the external
> community.  Saying that the maintainers list is ignored by you means
> that you need to create something that is not ignored by you.  You also
> need to create a system (bitkeeper can perhaps help, Larry?) for
> tracking who fails to respond to patches, and (after a few warnings)
> remove them as maintainers.

I don't expect Linus needs to do any of the grunt work here.  He just needs 
to sign off on the design and actually use the finished solution.

We've got some time on this.  If Bitkeeper allows Linus to move to a "pull" 
model with his lieutenants, that should allow the system to scale enough to 
get 2.6 out the door.  It's the layers under those guys who need to shuffle 
around to feed their patches into those bitkeeper trees that Linus pulls from.

Of course to make this work, Bitkeeper will somehow need to let Linus 
cherry-pick patches from the bitkeeper trees under him and reject others.  
I've tried to follow the discussion on this front but I'm not convinced it's 
resolved yet.  But as I said, there's time...

> Our problems are not novel.  Let us apply standard business school
> methodologies to them.

If I remember my kernel-traffic summaries correctly, Eric Raymond was saying 
something like this about two years ago.  Something about the boy genius 
effect? :)

> Hans

Rob

