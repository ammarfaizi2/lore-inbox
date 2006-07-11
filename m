Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWGKOTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWGKOTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWGKOTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:19:20 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:1253 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750851AbWGKOTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:19:18 -0400
Message-Id: <200607111416.k6BEGuUD007084@laptop11.inf.utfsm.cl>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
cc: "Pavel Machek" <pavel@ucw.cz>,
       "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report 
In-Reply-To: Message from "Daniel Bonekeeper" <thehazard@gmail.com> 
   of "Mon, 10 Jul 2006 17:34:18 -0400." <e1e1d5f40607101434m25f490c8k2e84f518ea337509@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 11 Jul 2006 10:16:56 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 11 Jul 2006 10:16:56 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper <thehazard@gmail.com> wrote:
> On 7/10/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > Daniel Bonekeeper <thehazard@gmail.com> wrote:
> > > On 7/10/06, Pavel Machek <pavel@ucw.cz> wrote:

[...]

> > > > Well, unless we have some volunteer to go through the bugreports and
> > > > sort them/kill the invalid ones/etc... this is going to do more harm
> > > > than good.

> > > As I told before, I wouldn't care to do that,

> > Who will, then?

> What I meant (as you can read on earlier messages) is that I would do
> everything (from kernelspace stuff to maintain the server[s] that will
> receive the reports and the web interface that will classify them)

But to be able to do a halfway credible job at that you /must/ look at the
(ever changing) data flowing through it, and know enough about what it
means (i.e., be rather intimately involved in its use) to do it right...

[...]

> > > route some reports (mark them as "tainted
> > > modules detected", etc, that sort of mechanical stuff),

> > Mechanical != trivial, and much less == "does it by itself, all alone"...

> The system will be mechanical as long as possible. By mechanical I
> don't mean "automatically detect if the bug was caused by some binary
> nVidia driver messing around, because the automatic disassembler shows
> that the nVidia driver is acquiring a lock and never releasing it
> under that specific circunstance". I mean "if nvidia.ko is loaded,
> mark the report as tainted". I won't let the system just send mails to
> LKML reporting bugs unless I already looked at them and confirmed that
> something is wrong. I never intended to create a system that magically
> analyzes the reports and check the source code for bugs and suggest
> fixes ( Just Impossible(tm) ), but rather have a tool where we can
> know that a certain kind of motherboard or usb controller is Oopsing
> too much, always at some point. Think of it as a really large
> compatibility laboratory.

Sounds like a job for massive data-mining... could it be applied to the
bugzillas of the distributions? I bet they are doing that right now (or
would be, if they had the resources to do so...).

> > > and according
> > > to the frequency of certain bugs, I could check if they are actually
> > > real bugs. If so, they get reported here on LKML.

> > Which helps how in getting more new people up to speed and involved in bug
> > fixing? (Last I heard, that was the current bottleneck...)

> Well, that I don't know. There's already www.kernelnewbies.org for
> that, and I see that lots of higher education institutes (aka
> universities) are starting to include kernel hacking in their programs
> (or at least lots of exercises involving that), so hopefully we'll get
> more new people in a few month/years. Again, I believe that not having
> enough people to work on bugs is not an excuse to not get them
> acknowledged and catalogued. Just because you don't have anybody to
> change your car's tires, does it mean that you don't actually want to
> know that they are flat ?

To see that the tires are flat or that the engine stopped requires very
little knowledge of automotive engineering, to find out why and how to fix
it are in a different league. And adding the right instrumentation points
and the measuring equipment plus "artificial intelligence" to make use of
them in the field was probably a large part of the development effort over
the last decade or so.

> > > Since we can expect,
> > > maybe, dozens of thousands of reports per week, wouldn't be hard to
> > > distinct between real bugs, etc (if we use frequency as a marker). For
> > > example, if the number of reports on Suspend2 get risen up sensitively
> > > on some just-released kernel, this means that something that was added
> > > isn't working (so here comes the personal debug, where we can see if
> > > it's a new bug or a regression)

> > That kind of stuff is currently sitting in bugzillas all over the
> > distributions. And again, what is required is people willing to see if they
> > can reproduce the bug (and that may mean getting an obscure piece of
> > hardware, etc) and then see if they can fix it.

> Yes, they are also full of bug reports for multimedia players,
> editors, etc. I agree, every decent distribution have their bugzillas
> loaded with all kinds of bugs.

Neatly sorted (as to the user's perception) of the cause.

>                                Also, there are probably hundreds of
> distros around the world, with a good number of them being widely
> used. Can you easily let me know if people using those distros are
> having frequent NULL dereferences using sata_via and a VIA VT6420 SATA
> RAID Controller with rev 80, when people with the same driver and
> controller weren't having such problems 2 months ago ? Or that 95% of
> those people have SMP kernels ? You probably can know that, if you
> know what exactly to look for and search using lots of "contains the
> string" (hopefully everything that you need was pasted on the report).
> And then, repeat this for 10 major distros. Understand ? Since our
> developers are so few and so busy, having a tool to automatically
> compare that stuff is handy. Imagine that you want to fix a bug in
> sata_via. You search all references to sata_via module (where EIP is
> on it, for example), and you can have statistics telling you that 70%
> of bugs reported on sata_via are caused by machines using some kind of
> proprietary driver (just made that up). This is already a very decent
> clue (unfortunatelly I don't expect things to be that easy, but it's a
> start).

Problem is that the "propietary driver" will most probably cause all kinds
of /different/ havoc in the various configurations out there. Scribbling
over memory at address foo won't always crash driver bar. And the same can
be said of many other problem origins. So your only reliable bet is to have
a single configuration, i.e., the kernel version shipped by /one/
distribution.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
