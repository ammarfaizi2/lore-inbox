Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265046AbUETKen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265046AbUETKen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 06:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbUETKen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 06:34:43 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6272 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265046AbUETKea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 06:34:30 -0400
Date: Thu, 20 May 2004 11:40:29 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405201040.i4KAeTN1000458@81-2-122-30.bradfords.org.uk>
To: Rob Landley <rob@landley.net>, Rene Rebe <rene@rocklinux-consulting.de>
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, rock-user@rocklinux.org,
       john@grabjohn.com
In-Reply-To: <200405192059.47056.rob@landley.net> 
References: <409BB334.7080305@pobox.com>
 <200405121412.00068.rob@landley.net>
 <200405190849.i4J8nqfb000280@81-2-122-30.bradfords.org.uk>
 <200405192059.47056.rob@landley.net>
Subject: Re: Distributions vs kernel development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quote from Rob Landley <rob@landley.net>:
> On Wednesday 19 May 2004 03:49, John Bradford wrote:
> > Quote from Rob Landley <rob@landley.net>:
> > > On Sunday 09 May 2004 05:53, John Bradford wrote:
> > > > > And no, it is not like Gentoo where you need to rebuild on each box
> > > > > or so.
> > > >
> > > > I keep hearing about projects which I hope will be what you describe
> > > > above for ROCK Linux.  Unfortunately, I haven't found one that goes far
> > > > enough in that direction yet.  Maybe there just isn't the demand for it
> > > > these days.
> > >
> > > As a side effect of debugging busybox, I created a shellscript that
> > > compiles a stripped down Linux From Scratch system entirely from source.
> >
> > That's interesting - what I find dissapointing about the Linux From Scratch
> > project is that it basically involves first setting up a minimal system,
> > then booting in to that new system at an early stage to complete the
> > construction of the system.
> 
> It's not really a distro.  It's an enormous HOWTO.  (Then again, so's Gentoo, 
> but gentoo does claim to be a distro, which is where I get disappointed...)

I disagree - they supply their own init scripts, for example, rather than
guiding people towards writing their own.  That is not a criticism of Linux
>From Scratch, just an observation.  Ultimately, users are not putting 100%
of their final system together from scratch.

However, in practice you are right it is 99% more like a big HOWTO than a
distribution.

> > Although it lets the user 'escape' their original system quite quickly, my
> > interest lies more in creating a custom Linux installation using an
> > existing development environment.
> 
> Earlier versions of Linux From Scratch did that; they didn't have the 
> intermediate system, you just did a build from the main system to get a 
> result.  Unfortunately, it would do things like break strangely on certain 
> versions of debian due to environment variables or the way they'd patched 
> make, and they had to have various warnings and "if it does this, do this..."
> 
> The two stage thing of minimal build, chroot, build final system made it a lot 
> easier to reproduce regardless of the starting distro.

But it's a lot more difficult to use if the target system is a different
processor which is a lot less powerful than the development environment.

For example, say I wanted to install Linux on something like a VAX 11/780.

Clearly this isn't just going to be a case of put the CD in and press enter
a few times.

I'd much rather set up a cross development environment on this box, and create
a complete Linux-based system on a bootable SCSI disk that can then be plugged
in to the VAX than try to create a minimal environment in which to do the
construction of the system.

> > > As for the rest of your article: don't assume that trading a familiar set
> > > of problems for an unfamiliar set of problems automatically solves more
> > > than it causes.
> >
> > Well, I don't just assume that, but in this case, I think I've demonstrated
> > to myself that pre-compiled binaries are more difficult to support than
> > programs compiled from source.
> 
> And how many users are you trying to support?  (This varies depending on scale 
> of deployment.  Been there, done that...)

Not really sure what you mean, I don't have a specific, fixed userbase to
support.

> Being _able_ to rebuild the system with printf's in it is a Very Good Thing.  
> But presumably, that's what Red Hat's SRPMs are for...

It's not just physically whether the system was compiled from source on the
target machine or not, it's more a case of whether the end user, or in the
case of a company, somebody who is responsible for that department's
computing, made the decisions about what to install and how to install it,
based on their requirements, or whether they did a default installation,
whether that was appropriate for their needs or not.

> > However, surely that is just learning about more and more special cases.
> 
> All tech support is learning about more and more special cases.  You learn how 
> it _should_ work (which is often something you don't start out knowing, 
> because when it's working you don't HAVE to know).  You learn specific ways 
> it can break (by encountering them).  You learn to ask the right questions 
> when the user did something totally unrelated that broke it and doesn't think 
> to volunteer this information because it _IS_ seemingly totally unrelated 
> (like upgrading the kernel or libc, switching on ECN, moving the sucker 
> behind a masquerading router...)

I strongly, strongly, disagree here.

In my opinion this is a prime reason why users have so many problems with
many aspects of computing today.

Support should absolutely NOT be about learning specific problems and
specific solutions to them.

Just because it may seem to work 95% of the time is no excuse for justifying
what I consider to be a pathetic way of supporting any computing application.

It seems to work so well simply because this kind of support effectively
restricts how users can use their machines so much that it is possible for
"support staff" to learn most of the problems they are likely to encouter.

In turn, this devalues free, open source software, because it's removing one
of it's key advantages over proprietrary software - the ability to do highly
customised installtions with comparitive ease.

It's disgusting that users are effectively discouraged from using software
which isn't included in their chosen distribution, simply because they can't
get support.

> > It might even be possible to learn about such a large number of special
> > cases that a user can solve all the problems they encounter without any
> > generic knowledge of a system, but I think that is a bad thing to
> > encourage.
> 
> I.E. if the user becomes enough of an expert they don't need you to support 
> them anymore.

I find that quite insulting.

It seems to me that you are basically saying that users should stick to using
the arbitrary, limited building blocks that a typical distribution provides in
the form of pre-compiled binaries, just so that they are protected to a large
extent from messing up their systems to the degree that few people are skilled
enough to fix them.

Free software is about freedom - and yet you seem to be suggesting that users
place arbitrary restrictions upon themselves.

I believe that the existance of a highly bespoke support service, which is
available at fairly short notice most hours of the day, and charged at an
hourly rate, rather than a requiring a pre-existing support contract, helps
to remove such a restriction from users.

> 
> > If I get a phone call asking for help with a program I've never heard of
> > before, possibly on a distribution I've never heard of before, I belive
> > that I can offer much better generic advice based on an overall knowledge
> > of the system if everything is source-based, than if a distribution's
> > pre-compiled binaries have been installed.  To me, those pre-compiled
> > binaries are "non-standard".
> 
> Red Hat _is_ source based.  So is Debian.  The fact they build it on their 
> servers rather than the target machine doesn't mean they don't give you the 
> source to build it yourself if you want to.  However, figuring out how to 
> reproduce their build process can be a flaming pain.

See above - I said that it's not a case of which machine it's physically built
upon.

> The same is true with build-on-the-target-system distributions.  I put 
> together one based on a bash script, which is as simple as I could make it 
> and designed to have the bits cut and pasted out if you need to rebuild 
> stuff, but you've still got to remember to set the right environment 
> variables for source and target directories.

I believe that 'distributions' of any kind run the risk of encouraging the
bad support methods I described above.  This is not necessarily the fault of
the distributions - I am not particularly interested in apportioning blame,
rather I am pointing out the problem as I see it - support by learning
arbitrary specific cases is bad for the end user overall, in my opinion.

> > This is one reason why I do not advertise support services for proprietrary
> > systems.  I do not want to fix problems by learning about many, many,
> > special cases - I want to use my generic knowledge of computers to fix
> > problems, and I believe that it is a better way to use computers in
> > general.
> 
> I.E. you don't want to do tech support.

I don't want to do 'everyday' tech support.  My prices reflect that.

> Even with all the source, tech support is STILL knowing about many many 
> special cases.  Yes, you can work it out from first principles, and having 
> the source code in a readily buildable state where you can compile and drop 
> in functional replacements (this is NOT the same thing as just having the 
> source code) can help.
> 
> But if you're working out the answer from first principles every time you 
> provide somebody with tech support, you're going to be an amazingly 
> inefficient support person.

Less efficient than somebody who has seen that exact problem before, quite
possibly.

So, is your suggestion to users that they only cause problems that they know
their local technical support service is capable of fixing, and has seen
before?

If I can fix a user's machine, and practically nobody else can, or is
prepared to travel across the country in the middle of the night to do it
in time for business the next day, it's the user's choice whether they want
to pay for what you seem to describe as an "inefficient" support person, or
not.

Again, it's about offering a choice.  Nobody has an on-going support contract
with me.  Therefore, they don't have to worry about stepping outside what it
covers.

Ultimately there will always be a need for generically-knowledgable people to
solve some computing problems.

> > > Build from source has more potential, sure.  And when the standard
> > > laptop has a 10 ghz 64 bit processor and 4 gigabytes of ram, it'll make a
> > > lot of sense
> >
> > I don't think compiling from source is particularly inpractical on a
> > typical modern desktop machine today.
> 
> You've never built kde then.

Actually, my main desktop machine doesn't even have X installed.

However, I can build a 3.1-based kde-base and kde-libs in around an hour each
on a ~2 GHz machine with 512 Mb of RAM.

> > > But compiling stuff from source is HEAVILY dependent on sequencing;
> > > ./configure won't add ncurses support unless you installed ncurses first.
> >
> > That's true for a lot of libraries and basic components of a system, but I
> > don't think it's so much of a problem in general.
> 
> You've tried it, then?

I can't remember the last time I installed a binary from a distribution.

> > > How much stuff do you rebuild because you just added openssl, or switched
> > > to alsa from oss?
> >
> > Not too much to make it impractical, in my opinion.
> 
> And if the end-user decides to upgrade their system with stuff it didn't have 
> before?
> 
> This isn't restricted to source distributions, by the way.  I tried to update 
> a friend's SuSE system to the 2.6 kernel.  I expected to have to upgrade a 
> number of packages, but what I didn't expect was that SuSE doesn't seem to 
> have have ncurses installed (or at least not something make menuconfig can 
> find).  Python in Red Hat didn't have ncurses support last I checked, either.  
> (RH 9, I think...)
> 
> Suppose they don't select OpenSSL because they go "this is a desktop system, 
> not a server", and then they realise later "oh, I need https:// support in 
> Konqueror/Mozilla"...

Well, if a user installed everything, (or more or less everything), from
source, wouldn't they become more aware of the different options, which is
basically what I said right at the start?  It's the basic argument, yes, it
takes longer and is possibly slightly more tedious for a user to build from
source, but it's a good experience, and will teach them about the system,
saving time later on.

Plus, I offer support services to such users, to make it even more of a
practical option.

> > > How do you keep track of the dependencies so it CAN rebuild?
> >
> > In practice, I haven't found it to be particularly complicated.
> 
> How much practice have you found it in?

What?

> > > If your build system is a static command set like my shellscript, "build
> > > this list of packages in this order",
> >
> > It's not.  My 'build system' is basically me sitting at the console.
> 
> I've supported end-users before.  I've built systems for people who can't roll 
> their own.  Lots of the problems they have are non-obvious from the 
> perspective of geekdom.
> 
> > > how much of an improvement is this really
> > > over a binary distro?
> >
> > For the initial installation, maybe not much of an improvement, but for
> > on-going use of a system, I think compiling from source is better overall.
> 
> Name me a Linux distribution that is not "compiled from source".
> 
> You keep saying that installing from source is better, but it seems to be from 
> "gee, wouldn't it be nice if" land rather than due to actual experience.  You 
> _can_ build and install an SRPM into a Red Hat system.  It's too much of a 
> pain to be worth it to me, but it's been an option for years and years.

The initial discussion was about distributions and kernel development.

What I am trying to demonstrate is that users needn't be comitted to a
distribution at all.  They can use one as a base to do their own thing.

> Most desktop users I've seen who modify their own systems dirty them badly 
> enough that they copy their data off and reinstall every year or so anyway,

If the user only has one physical machine, I can understand the logic behind
that.
 
> so your long term support argument is a bit strange.

What long term support argument?

> having the server setup reproducible from a fresh 
> install is just plain good hygiene, anyway.  (Doesn't mean everybody does it, 
> but carrying around verbatim binary images through three or four hardware 
> upgrades is _not_ a recipe for maintainability.  And what do you do if the 
> sucker gets rootkitted, anyway?  Hope you got it all cleaned out?)

If a machine is root compromised, the system should be re-installed.

I'd usually suggest physically replacing the disks, re-installing, and
keeping the old disks for later analysis.

> I'm not saying compiling from source is BAD.  I'm just saying it's not as big 
> an improvement as you seem to think it will be.  It does allow a number of 
> new things to be done, but by itself it doesn't make a major difference.

Maybe because you are knowledgable enough to use the binaries provided by
a distribution, and supplement them with programs compiled from source where
necessary.  I think you probably do that without realising that many users
don't see compiling from source as a realistic option for them, and are
therefore stuck with what distributions provide.

Basically it boils down to arbitrary limits.  I am trying to remove them.
Free, open source software is available to everybody, but many people use
it in the same way as proprietrary software - 'off the shelf' binaries.  I
think that that represents a missed opportunity.

John.
