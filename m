Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289642AbSAOO3D>; Tue, 15 Jan 2002 09:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSAOO2y>; Tue, 15 Jan 2002 09:28:54 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:41509 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S289762AbSAOO2j>;
	Tue, 15 Jan 2002 09:28:39 -0500
Date: Tue, 15 Jan 2002 23:28:29 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-Id: <20020115232829.023521d4.bruce@ask.ne.jp>
In-Reply-To: <20020115072958.A7900@pimlott.ne.mediaone.net>
In-Reply-To: <20020114125228.B14747@thyrsus.com>
	<20020114125508.A3358@twoflower.internal.do>
	<20020114135412.D17522@thyrsus.com>
	<20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there>
	<20020114173423.A23081@thyrsus.com>
	<20020115080218.7709cef7.bruce@ask.ne.jp>
	<20020115072958.A7900@pimlott.ne.mediaone.net>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This topic is well past the point of being done to death - it's not so much
whipping a dead horse as trying to ride the gravestone, but ah well...

On Tue, 15 Jan 2002 07:29:58 -0500
Andrew Pimlott <andrew@pimlott.ne.mediaone.net> wrote:

> On Tue, Jan 15, 2002 at 08:02:18AM +0900, Bruce Harada wrote:
> > On Mon, 14 Jan 2002 17:34:23 -0500
> > "Eric S. Raymond" <esr@thyrsus.com> wrote:
> > 
> > Aunt Tillie just DOESN'T CARE, OK? She can talk to her vendor if she gets
> > worried about whether her kernel supports the Flangelistic2000 SuperDoodad.
> 
> Ok, Grandpa Willie only cares about support for his doodad.  Why do
> you conclude that he should never build a kernel?

Because it adds extra complexity for very little gain and forces the vendor to
support 10,000 variations on a kernel that would normally only have a dozen or
so at most?

> It's just as easy in principle to write a friendly front-end that
> downloads sources and compiles them, as one that downloads binaries.

We're not talking about a front-end for kernel compilation - the topic is an
autoconfigurator that tries to decide what hardware is available, no matter
what might *need* to be available tomorrow, or next week, or next month.

> - It's easier for third-parties to provide kernel software in source
>   form than in binary form (because binaries must be in the correct
>   package format, and be compiled with the right config options, and
>   adhere to the particular distribution's conventionts; whereas
>   source is relatively neutral).

Except when it requires another source package to compile, which requires
another, and another... and God forbid that some patches conflict. Compiling
from source is a *bad* idea for someone who wants things to just work.

>   Why should Willie be limited to
>   getting his kernels from his vendor?

If he wants ongoing support from his vendor, he damn well better.

>   What if his vendor doesn't
>   support the Flangelistic2000 SuperDoodad yet, but there's a solid
>   driver available from a volunteer?

"Solid" as in "will not eat his hard drive and spit it out as metal shavings
when used in combination with whatever other patches have been applied to the
kernel by the vendor"? Or "solid" as in "works for me, should work OK for you,
and if it doesn't there's always the next version, and hey, don't forget to
submit a bug report"?

>  What if he hears the hype
>   (sorry) about the low latency patch, and decides he wants to try
>   it (maybe his MP3's skip when Netscape thrashes)?

I would say the chance of that level of user hearing about the low-latency
patches is about the same as me becoming an astronaut and flying to the Moon.
And if he does hear about them, the correct place for him to ask about them is
his vendor.

>   Why take the
>   choice out of Willie's hands?

Choice to do what? Break his box beyond hope of repair (by himself, at least)
and lose him any chance of support from the people he paid to do so?

>   And why keep a willing tester and a
>   developer apart?  (If you claim that novice users don't want to
>   install random beta software--that contradicts my experience with
>   lots of Windows users!)

...and how many of those Windows users submitted meaningful bug reports? Or,
indeed, *any* bug reports?

> - It's a system that experts are likely to use as well, because
>   there's a lot of overlap between this system and what experts
>   want.

Er... from the response on the list so far, I somehow doubt that...

>   A nice front-end to browse and manage kernel versions,
>   patches, and drivers; to download, configure, compile and install
>   them?  I might use that.

Again, I believe the topic of this thread was an autoconfiguration system,
not a version management utility.

> - It makes it easier for Willie's hacker grandson to help him.
>   Hackers know all about compiling kernels, but aren't as likely to
>   be familiar with the distribution's binary packaging.

Really?? There aren't that many - RPM, deb, tgz. Anyone who's that familiar
with compiling kernels is rather likely to be able to handle 'man rpm'.

>   The more we
>   all do things the same way, the more we can help each other; when
>   different groups use different tools, the community is fragmented.

Er, so you're one of those "let's all run Red Hat because it'll make things
simpler" people are you? Having a variety of tools that do similar things is
*good*.

> - It can support a graceful transition from beginner to expert.
>   Suppose one day, for whatever reason, Willie really does need to
>   change a compile-time option.  Or, heaven forbid, he gets curious
>   about what his computer is doing when the status line says
>   "compiling".  He's already got all the pieces he needs.  Ideally,
>   he just needs to click on that scary "Advanced options" button.

Who's to say that gcc is even installed on his box? Or Python? Or the userland
utilities required for him to actually make use of that compiletime option?
It's an awfully big jump from "I just want to balance my checkbook" to "let's
see, how do I activate and configure a new QoS algorithm". That's the VENDOR's
job, not Willie's or Penelope's or whoever the random user of the week may be.
If they want to do that, they are by definition no longer an average user.

> You might think these are trifles and < 1% cases.  My intuition
> tells me that they add up in the long run.  At least it's worth
> considering.

What is? A patch and version management utility? Sure - but it doesn't belong
in the kernel tree. An autoconfigurator? Not as it's been described so far by
Eric, and even if his idea wasn't broken it still shouldn't be in the kernel
tree.


Bruce

