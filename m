Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSGDCQV>; Wed, 3 Jul 2002 22:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317316AbSGDCQU>; Wed, 3 Jul 2002 22:16:20 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:38405 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S317312AbSGDCQT>; Wed, 3 Jul 2002 22:16:19 -0400
Date: Wed, 3 Jul 2002 19:18:39 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
Message-ID: <20020703191839.F392@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020701140915.23920A-100000@gatekeeper.tmr.com> <20020703173421.B8934@suse.de> <20020703200044.EB039C2C@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020703200044.EB039C2C@merlin.webofficenow.com>; from landley@trommello.org on Wed, Jul 03, 2002 at 10:24:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 10:24:20AM -0400, Rob Landley wrote:
> On Wednesday 03 July 2002 11:34 am, Dave Jones wrote:
> > On Mon, Jul 01, 2002 at 02:25:16PM -0400, Bill Davidsen wrote:
> >  > I suggested that 2.5 be opened when 2.4 came out, so I like the idea of
> >  > 2.7 starting when 2.6 is released. I think developers will maintain the
> >  > 2.6 work out of pride and desire to have a platform for the "next big
> >  > thing." And their code can always be placed on hold for 2.7 until they
> >  > clarify their thinking on 2.6, if that's really needed.
> >
> > Unfortunately, there's the possibility of people thinking
> > "I'll fix it properly in 2.7, and backport", during which time,
> > 2.6 doesn't get fixed any faster.  People diving into 2.7 development
> > and leaving 2.6 to those that actually care about stabilising it was
> > Linus' concern if I understood correctly at the summit.
> 
> And leaving stabilization to the people who care about stabilization would be 
> a bad thing why?  2.4's first ten releases are a marvelous counter-example to 
> the "stonewall new development to speed up bugfixing" theory of software 
> development.  The musical rotating feature freeze/thaw/slush/slurpee halfway 
> through development cycles haven't been that effective either.
> 
> Linus ain't so good at maintenance, and he has said as much on this list.  
> Linus's kernel sets the direction for Linux evolution, but he couldn't get 
> the 2.4.0 VM stabilized and Alan Cox did.  (Better than mainline, anyway.)  
> If Linus had handed over the stable series to Alan right after 2.4.1, taken a 
> month long vacation, and then opened a new branch that was a bit selective at 
> first about what it took and from who, does anybody think 2.4 would have 
> taken any longer to properly stabilize than it wound up doing?  (Did Jens's 
> bio patches really need to wait on the VM stabilization work?  Did Jens help 
> stabilize the 2.4 VM?)
> 
> We live in a world of multiple Linux kernel trees already, each with a 
> different maintainer who is good at different things.  Linus is a brilliant 
> architect who is great at plucking the best ideas from the cream layer of the 
> churning mass of Sturgeon's Law flung at him on a daily basis.  When 
> presented with four ways to do something, he'll spot the hidden fifth better 
> way like nobody else can.  But saying no in such a way as to promote 
> stability is a different skill, and last time Linus went into big time 
> "saying no" mode he wound up dropping VM stabilization patches from the then 
> VM maintainer.  And the feature freezes haven't historically been remarkably 
> effective at producing a stable kernel soon after either.
> 
> A "stabilization fork" off of the development series could be done, as an 
> experiment, during the next "feature slush".  A maintainer who specializes in 
> stabilizing code (You, Alan, and Marcelo are all doing a decent job at this 
> now: it's not a common skill but not as rare as being a brilliant architect 
> like Linus) can fork a "fixes only" tree that may or may not become 2.6, and 
> see how it goes.
> 
> It it works, great, if it doesn't work, fine.  You already maintain a fork 
> off of Linus's tree, and Alan maintains one off of Marcelo's tree.  Red Hat 
> and SuSE maintain their own forks as well.  The existence of such a fork, 
> with a compentent maintainer and its own user base, is not inherently 
> disruptive to the rest of the world.  Feeding patches from one tree into 
> another and dropping the rest until they're merged is what you and Alan do 
> normally anyway, so the down side of it NOT working (giving up after a few 
> months and going "shucks, people just won't listen to anyone but Linus") 
> isn't exactly catastrophic.  As long as the maintainer is competent at 
> merging to clean up the fork afterwards, and if they're not they can't 
> effectively maintain their own tree in the first place anyway.
> 
> An explicit stabilization-only fork could even be a tool to help Linus's fork 
> stabilize (if that is or becomes the goal), by tracking down bugs and 
> performance tuning in a less turbulent environment while trying hard to 
> introduce as few new problems as possible, and that being the ONLY goal of 
> the fork.  Lots of bugs have been tracked down in -dj or -ac and the fix then 
> ported to the appropriate mainline later.
> 
> If the stabilization fork DOES become 2.6, then 2.6 can START with a new 
> maintainer, like Marcelo for 2.4 and Alan for 2.2.  Stable branch maintainers 
> aren't normally expected to make major new architectural decisions anyway, 
> that's what development kernels are for. :)
> 
> And if nothing else, it reduces the likelihood of development being stuck in 
> a nebulous "no new features, well, okay, one more but that's it" mode for 
> most of a year.
> 
> Yes, in theory 2.5 should BECOME a stabilization fork, under Linus, during 
> the feature freeze.  It might even happen this time.  But how would hedging 
> the bet hurt?
> 

Sorry to leave all the above in but it seems all context.

Speaking for the moment as an observer.  It seems that our
two phase process isn't quite satisfactory.   Linus is great
at managing the forward development but dislikes and stinks at
stabilisation and maintenance.  A fair number of people can
handle maintenance.  What it seems we need is an
intermediate person to handle stabilisation.

I see stabilising as requiring its own set of abilities and
credentials and as being very strenuous.  Whoever acts as a
Stabiliser should only have to do so for less than a year.

What i would suggest is that Linus keep 2.5 until he feels
it is feature complete and ready to be stabilised.  At that
point he seeks someone like AC or DJ to accept the torch and
negotiates a hand-off to the official Stabiliser.

Then Linus can take a vacation, visit his children or play
around with the new-feature patches or some idea of his own
while providing some support to the Stabiliser.  At some
point the Stabiliser will declare 2.6 and Linus can fork
2.7.  A bit later the Stabiliser can hand-off to a
Maintainer and take a break himself.

.From that point onward the Maintainer will deal with
bugfixes and back-ported device support as Marcello is now.



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
