Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285484AbSACLZS>; Thu, 3 Jan 2002 06:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285506AbSACLZJ>; Thu, 3 Jan 2002 06:25:09 -0500
Received: from ui232i20hel.dial.kolumbus.fi ([62.248.189.232]:61833 "HELO
	loppu.net") by vger.kernel.org with SMTP id <S285484AbSACLZA>;
	Thu, 3 Jan 2002 06:25:00 -0500
Date: Thu, 3 Jan 2002 13:25:31 +0200 (EET)
From: Henrik Hovi <henrik.hovi@loppu.net>
X-X-Sender: ferrix@marvin.loppu.net
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102220333.A26713@thyrsus.com>
Message-ID: <Pine.LNX.4.40.0201031150090.2600-100000@marvin.loppu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following will be strictly IMHO. Don't take me too seriosly - even I
can't most of the time.

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> Dave Jones <davej@suse.de>:
> > See other posting with examples of dramatic failures of
> > 'slots in box, but dmi says none' and 'no slots, dmi says some'.
> > still think this is usable ? You're nuts.
>
> One of my background assumptions is that the older a machine is, the
> more likely it is that the person doing the config will have a clue about
> what they're doing.   These days hardware is so cheap that only geeks try
> to cram Linux onto old systems -- and even the geeks mostly do it just to
> prove they can.
>
> Thus I'm not very worried about DMI read failing on older hardware.
> My main objective is to make configuration painless on modern PCI-only
> hardware -- which is why I want to be able to tell when there are no
> ISA slots, so I can deep-six questions about ISA drivers.

These days hardware is cheap. BUT most of the people using their computer
as a typewriter and a means to easily do the important things with the
bank are NOT ready to upgrade to a new state-of-art Itanium 2GHz byte
crusher with a nice GeForce 5 accelerator and an integrated coffee cooker
(okay, they would like that one) even though they were cheaper than a
pair socks. The world doesn't work that way. They don't need such
monsters and that's it.

I thought Linux was also about coding software that would work with all
hardware including computers more than two years old. This DMI thingie
seems like it could pretty efficiently fuck up everything with such
puters. It would be fine for newer Athlons and P3s if one could trust
hardware vendors.

> > You're solving a non-problem.
> > Some examples of target audience you're aiming for in your previous
> > mail were I believe..
> >
> > o  The geek next door who wants to tinker and learn about the kernel.
> >    Said geek is going to learn a damn sight more currently than he will
> >    with a dumbed down pointy clicky "build me a kernel" button.
>
> Your "they must show willingness to suffer pain, otherwise they're not worthy"
> attitude is really showing here.

The geek next door is already capable of compiling the kernel by reading a
bit of the fine manuals and I wouldn't worry a bit about him not becoming
the best kernel hacker in the world. He will get angry with the bugs and
the people supposed to fix them sooner or later. The geek next door is
what we've all been. Even though there was the easy way, we preferred the
hard (and stupid) way.

> I'm not proposing that the "dumbed-down" version be the only version, but that
> the kernel and the config tools make "build me a kernel at the push of a
> button *possible* for those who don't want to go any deeper.
>
> > o  Aunt Tilley.
> >    Vendors already ship an array of kernels which should make it
> >    unnecessary for her to have to build a kernel.
>
> Yes. But *I* want Aunt Tilley to be able to download the latest kernel
> sources and build/install them herself, without ever feeling that the task
> is beyond her capabilities.

Aunt Tilley is the main issue here. An average Aunt Tilley would propably
have an oldish machine she can write amateur romantic novels and emails to
her nephews with. She'll be perfectly happy with it until it crashes. It
is also propable that, if she has Linux on her typewriter, one of her
nephews (let's call him Bob) is doing the administration. Although Aunt
Tilley is the sweetest person on Earth, Bob doesn't much like about
constantly cycling the 20 miles from home to Aunt Tilley's just to compile
a kernel. He will propably try his best to teach Aunt Tilley to install
the newest kernel-image rpm package form the net from time to time.

That should be the direction we're headed. "Forcing" people to use
pre-compiled kernels is what we are doing now (and that's what people in
Redmond are doing too). I wouldn't expect Aunt Tilley to be genuinely
interested in the process of compiling the kernel. She won't know much
about it but still, she should be able to do it. If she happened to have
one of those computers whose DMI sucks big time and we asked her wether
she wanted to get all her ISA devices auto-probed, she would answer yes.
When the kernel would panic, Aunt Tilley would be frightened and never
upgrade anything again or worse: switch back to Windows which she knows
"stable" and "secure".

> Part of the reason I want this is for the capability itself; partly I want
> it pour encourager les autres -- to demonstrate, by tackling one of the
> toughest cases, that much of the complexity and anti-useability of Linux
> is an artificial and unnecessary creation of the culture that created it,
> rather than a result of actual technical depth of the problem.

You cannot tackle this case without first searching an answer which is not
DMI. It seems like there was none. It is safer making the autoconfig guess
the ISA configuration so that it would work with any computer without
non-PNP ISA devices. One or two extra configuration options will hurt no
one.

> I believe we need to learn the discipline of useability and take it seriously.
> Because talk plus code is much more convincing than just talk, I'm trying
> to demonstrate this by coding.  But I'll talk about it too :-).
>
> > If you still think world domination is going to appear by idiotproofing
> > the kernel build process, I think you're in for a surprise.
> > We have far bigger usability problems in userspace. The point is that
> > $newcomertolinux doesn't need to know what a kernel is, let alone
> > have to build one. They just see "Booting progress" "Log in" "Desktop".

A newcomer doesn't know what a kernel is but the security of his/her data
is the reason why we need to tell him/her. Pre-compiled kernels might come
with bugs already fixed (which makes them also wide known).

> Sure we have bigger idiotproofing problems.  But this is the one that
> (a) my skillset is well matched to, and (b) no one else is worrying about.

There is another way to idiotproof software. We need good manuals, not
just the laughable man pages and the Documentation directory in the source
package. WTFM so that $ordinaryperson can RTFM. We should also learn
another thing from the commercial world: product placement. Even though
there are manuals I would classify as average, they are not where they're
supposed to be and people have to do some serious googling before they can
solve a minor problem not covered properly by the man page or linuxdoc.org.

> World domination will happen, if it happens, because lots of people
> are willing to obsess about useability issues at *all* levels of the
> system.  Including this one.

Eric, you're a big dreamer and you have wonderful dreams, but please keep
yourself near to the ground. This is not too big a problem. My P133 has
two ISA devices and they both are ISAPNP. That computer just had it's
seventh birthday. If the automatised configuration makes guesses good
enough, the dear old byte crusher will be just fine.

And Dave, what's wrong with world domination anyway? ;)

Henrik

