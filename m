Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284136AbRLFQfv>; Thu, 6 Dec 2001 11:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbRLFQfm>; Thu, 6 Dec 2001 11:35:42 -0500
Received: from ns.ithnet.com ([217.64.64.10]:32270 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S284136AbRLFQfa>;
	Thu, 6 Dec 2001 11:35:30 -0500
Date: Thu, 6 Dec 2001 17:34:55 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: erich@uruk.org
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Loadable drivers [was SMP/cc Cluster description ]
Message-Id: <20011206173455.104b6a02.skraw@ithnet.com>
In-Reply-To: <E16BjQJ-0005EA-00@trillium-hollow.org>
In-Reply-To: <20011205212844.451f8781.skraw@ithnet.com>
	<E16BjQJ-0005EA-00@trillium-hollow.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2001 13:17:47 -0800
erich@uruk.org wrote:

> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> > You can only be plain kidding with this statement. If you split the
> > drivers from the rest of the kernel, you managed to get rid of this
> > nice (yes, I really meant nice) monolithic design, where I only need
> > a simple config file to _update_ to a new kernel revision (_up_, not
> > _down_) and be happy (including all the drivers).
> 
> Hmm.  There is little fundamentally incompatible with having splits in
> the core kernel and sets of drivers, and getting most of what you want
> here.

There is. You double the administrational work. Most updates are performed
because you want the latest bugfixes. If you get more bugfixes than you
intended - lucky.
Currently you draw the latest kernel-tree (or the latest _you_ like to use),
use your old .config and it works out - as long as you do not use closed-source
drivers.
If you split things up, you draw _two_ archives, compile and install both.

> However, the comment about being "happy (including all the drivers)"
> seems a bit naive in my experience.  That makes the assumption that the
> drivers in the new/old/whatever kernel you change to are necessarily of
> the same caliber as the ones you came from, and that is not always true
> by any means.

Oops. Then you have a severe problem in understanding how linux _should_ be
worked with. Obviously you can go and buy some distribution and it may work out
pretty well. But being a serious administrator you _will_ do kernel updates
apart from the distro (sooner or later). If there are drivers in a newer kernel
release, that do not work any longer, compared to an older release, you should
say so. Best place would be the listed maintainer. Because if it doesn't do the
job for your configuration any longer, chances are high others were hit, too.
The maintainer cannot know, if you do not tell him.
I guess we have the mutual agreement here, that maintained drivers should get
better not worse through the revisions. This means configurations once
successful are not meant to break later on.
This basically is what I intended to say with "being happy" :-)

> Also, in a world where one values stability, being able to rev
> backward is quite important also.  The lack of software package tools
> like rpm being able to "downgrade" software easily is a serious one in
> my mind.  What do you do when you install something major and it
> breaks, but it has interdependencies on multiple other things?

This isn't kernel-related, is it? You can always boot the previous kernel (and
drivers), if you updated correctly. I am talking about revision-updates, not
major updates (like from 2.0 to 2.2). Major update will break mostly. But -
frankly spoken - it should. If you are using a bunch of very old binaries, you
should be driven to update these anyway.

> I don't object to producing well-tested full sets of driver source that
> go with kernel versions, I just don't want them to be tied if I have
> a need to pull something apart (a driver from one version and from
> another are the only ones that run stably), which frankly happens too
> often for my taste.  Even if it didn't I'd still want it as much as
> possibly for the fall-back options it provides.

Can you give a striking example for this? (old driver ok, new driver broken,
both included in kernel releases)

> I didn't go far enough with my comment.  I should have said that the
> lack of a common driver framework base that works between *all* (or nearly
> all, some obsolescence is ok) their Windows versions is a problem.

Which means: it does not work there.

> In the consumer line (win3.1/95/98/me) where they were keeping very good
> compatibility across some kinds of drivers (it had it's problems, to be
> sure), they were trying the hardest because they recognized that the
> most important thing was to just have things work in the first place.

I honour they were _trying_, only it was not successful. I wrote drivers for
all noted versions above and can tell you: it is a _mess_.

> NOTE:  I'm not endorsing their overall API convenience (driver or
> Win16/Win32), stability, suitability, merchantability, whatever, I'm
> just talking about drivers and their distribution model at the moment.

Ok, lets put it this way: they use a completely split up model of driver
maintenance to get the most out of the market (anybody can release anything at
anytime and any quality and interoperability), and therefore everything tends
to be severly broken and complex in administration. You have to draw the latest
drivers for your graphics card, scsi card, scanner, printer, USB equipment,
even monitor from the respective source (manufacturer), install it seperately
and pray it does not shoot your last driver installation from different
hardware component - which it does in a significant percentage. And if you
upgrade from (e.g.) win95 to win98, you will draw all drivers again and
completely reinstall everything.
To tell the pure truth: nobody cares about anything on w*indoze.

> > Reading between your lines, I can well see that you are most probably
> > talking about closed-source linux-drivers breaking with permanently
> > released new kernel revisions. But, in fact, this is the closed-source
> > phenomenon, and _not_ linux.
> 
> No, though I don't object to closed-source in general per se.  I hate it
> for myself and businesses I've worked for because I like to be able to
> fix/improve/whatever code, but I recognize that the majority of users
> out there would never touch code.

They _should_ not do that. And they _need_ not do that today. The distros
really got very far on the path to the real lusers, that don't know much and
don't want to learn anything. This is ok.
I mean have you had a look at the latest distros, I found it amazing how far
things have already come. You can install client systems under linux in 20% of
the time you would need for _any_ windows.

> My general feeling is that binary drivers are ok/should be supported well
> across versions since that is the thing you load in at boot/bring-system-
> up time.  Having separate (and usually many) step(s) to getting a driver
> and having it load on your system is a major and I'm thinking artificial
> pain.

I have learned something over the recent years: I guess RMS pointed in the
right direction. I _don't_ think binary drivers are ok. I want to control my
environment, and don't let _anybody_ control it _for_ me. And if something goes
wrong, I have a look. And if I am too dumb, I can ask somebody who isn't. And
there may be a lot of those.

> In general my argument stems from the same basis that the kernel/user-level
> interface does:  keeping interfaces stable and removing packaging/bundling
> requirements across major boundaries almost always yield a win somewhere.

Carl Sagan "The Demon Haunted World":
"If there is a chain of argument every link in the chain must work."

> In the case of MS and drivers, the win they have in convenience to end-users
> of all types, and the ability to mix and match drivers forward or backward
> up to some limitations in API revisions.

Ah, yes. Indeed I am one of those thinking that a driver should _work_, I do
not measure its quality on the number of versions available - and loadable in
my environment. If I have to this, the driver is _broken_.
But yes, you are right: 99% of all w-users obviously think internet is designed
for downloading the latest w-drivers, and it is a definitive must to have all
revisions to find one working.

> > I tend to believe we could just wait another two MS cycles to have even
> > the biggest MS-fans converted to kernel-hackers, only because of being
> > real fed up with the brilliant, long term driver design.
> 
> Most people will never touch code or a compiler, and just want a simple
> obvious formula or even to have the system automagically do the Right
> Things for you.  Even many programmers have limitations of curiousity or
> energy, and it isn't a bad thing to organize even core system things to
> be easy.

I talked about the developers, but even talking about users, I do believe that
...

> MS may be stupid/annoying in other ways, but they know this and have
> moved toward it, albeit sluggishly at times.

... it is not their ultimate goal to let MS control their lives. You think this
is over-estimation? They are already handing out electronic _passports_, sorry,
but in my understanding of democracy this is not done by commercial companies.
This is what a state is all about - knowing and identifying its citizens - and
no one _else_.

MS is not stupid. I won't tell you what it is though, find out yourself.

Regards,
Stephan

