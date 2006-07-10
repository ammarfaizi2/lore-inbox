Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWGJVeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWGJVeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWGJVeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:34:20 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:5757 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965248AbWGJVeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:34:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NBdUyRn8cUUrtvEwloEseGjibHRzuC8kyTM0WTknxMu2lMkVY6cVgFKULO76RB3riJw/ZL8OSRBices3nNBZBx+RMhgCgSDHiTQU7IH8mR0JQscdBFC/jYPp4zuzQcCwBmeOQD0MTcvFsm96RoTZ5KmJhHaj+fjPXd5LoSB43LI=
Message-ID: <e1e1d5f40607101434m25f490c8k2e84f518ea337509@mail.gmail.com>
Date: Mon, 10 Jul 2006 17:34:18 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Automatic Kernel Bug Report
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200607101841.k6AIfXgp012297@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <thehazard@gmail.com>
	 <e1e1d5f40607101040u3baf0da7r43d5538700b02e2@mail.gmail.com>
	 <200607101841.k6AIfXgp012297@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Daniel Bonekeeper <thehazard@gmail.com> wrote:
> > On 7/10/06, Pavel Machek <pavel@ucw.cz> wrote:
> > > Hi!
> >
> > Hi ! =)
>
>
> Hi all out there!

Hi Horst!

> > > Well, unless we have some volunteer to go through the bugreports and
> > > sort them/kill the invalid ones/etc... this is going to do more harm
> > > than good.
>
> > As I told before, I wouldn't care to do that,
>
> Who will, then?

What I meant (as you can read on earlier messages) is that I would do
everything (from kernelspace stuff to maintain the server[s] that will
receive the reports and the web interface that will classify them)

> >  as long as I know that
> > it is actually being used (and useful).
>
> If you don't care about the data...

I do! So much that I even suggested the system. =)

> > The system (at the server
> > side) could automatically
>
> /Someone/ will have to program/configure/tweak/maintain that...
>

I'll program, configure and maintain the whole system. By
"automatically" I mean classify each report by distribution (when
possible), kernel version, release, architecture, type of hardware,
function (EIP) where the bug happened, type of bug (null point
dereference, or BUG_ON(), etc), that kind of stuff that is already on
the report, I'll just parse it using regular expressions to extract it
and classify (so I don't need to manually check boxes for every report
that comes).

> > route some reports (mark them as "tainted
> > modules detected", etc, that sort of mechanical stuff),
>
> Mechanical != trivial, and much less == "does it by itself, all alone"...
>

The system will be mechanical as long as possible. By mechanical I
don't mean "automatically detect if the bug was caused by some binary
nVidia driver messing around, because the automatic disassembler shows
that the nVidia driver is acquiring a lock and never releasing it
under that specific circunstance". I mean "if nvidia.ko is loaded,
mark the report as tainted". I won't let the system just send mails to
LKML reporting bugs unless I already looked at them and confirmed that
something is wrong. I never intended to create a system that magically
analyzes the reports and check the source code for bugs and suggest
fixes ( Just Impossible(tm) ), but rather have a tool where we can
know that a certain kind of motherboard or usb controller is Oopsing
too much, always at some point. Think of it as a really large
compatibility laboratory.

> > and according
> > to the frequency of certain bugs, I could check if they are actually
> > real bugs. If so, they get reported here on LKML.
>
> Which helps how in getting more new people up to speed and involved in bug
> fixing? (Last I heard, that was the current bottleneck...)
>

Well, that I don't know. There's already www.kernelnewbies.org for
that, and I see that lots of higher education institutes (aka
universities) are starting to include kernel hacking in their programs
(or at least lots of exercises involving that), so hopefully we'll get
more new people in a few month/years. Again, I believe that not having
enough people to work on bugs is not an excuse to not get them
acknowledged and catalogued. Just because you don't have anybody to
change your car's tires, does it mean that you don't actually want to
know that they are flat ?

> > Since we can expect,
> > maybe, dozens of thousands of reports per week, wouldn't be hard to
> > distinct between real bugs, etc (if we use frequency as a marker). For
> > example, if the number of reports on Suspend2 get risen up sensitively
> > on some just-released kernel, this means that something that was added
> > isn't working (so here comes the personal debug, where we can see if
> > it's a new bug or a regression)
>
> That kind of stuff is currently sitting in bugzillas all over the
> distributions. And again, what is required is people willing to see if they
> can reproduce the bug (and that may mean getting an obscure piece of
> hardware, etc) and then see if they can fix it.

Yes, they are also full of bug reports for multimedia players,
editors, etc. I agree, every decent distribution have their bugzillas
loaded with all kinds of bugs. Also, there are probably hundreds of
distros around the world, with a good number of them being widely
used. Can you easily let me know if people using those distros are
having frequent NULL dereferences using sata_via and a VIA VT6420 SATA
RAID Controller with rev 80, when people with the same driver and
controller weren't having such problems 2 months ago ? Or that 95% of
those people have SMP kernels ? You probably can know that, if you
know what exactly to look for and search using lots of "contains the
string" (hopefully everything that you need was pasted on the report).
And then, repeat this for 10 major distros. Understand ? Since our
developers are so few and so busy, having a tool to automatically
compare that stuff is handy. Imagine that you want to fix a bug in
sata_via. You search all references to sata_via module (where EIP is
on it, for example), and you can have statistics telling you that 70%
of bugs reported on sata_via are caused by machines using some kind of
proprietary driver (just made that up). This is already a very decent
clue (unfortunatelly I don't expect things to be that easy, but it's a
start).


-- 
What this world needs is a good five-dollar plasma weapon.
