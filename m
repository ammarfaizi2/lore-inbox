Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288159AbSACDRj>; Wed, 2 Jan 2002 22:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288156AbSACDR3>; Wed, 2 Jan 2002 22:17:29 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:59268
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288158AbSACDRV>; Wed, 2 Jan 2002 22:17:21 -0500
Date: Wed, 2 Jan 2002 22:03:33 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102220333.A26713@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102211038.C21788@thyrsus.com> <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de>; from davej@suse.de on Thu, Jan 03, 2002 at 03:44:03AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> See other posting with examples of dramatic failures of
> 'slots in box, but dmi says none' and 'no slots, dmi says some'.
> still think this is usable ? You're nuts.

One of my background assumptions is that the older a machine is, the
more likely it is that the person doing the config will have a clue about
what they're doing.   These days hardware is so cheap that only geeks try
to cram Linux onto old systems -- and even the geeks mostly do it just to
prove they can.

Thus I'm not very worried about DMI read failing on older hardware.
My main objective is to make configuration painless on modern PCI-only
hardware -- which is why I want to be able to tell when there are no
ISA slots, so I can deep-six questions about ISA drivers.

> You're solving a non-problem.
> Some examples of target audience you're aiming for in your previous
> mail were I believe..
> 
> o  The geek next door who wants to tinker and learn about the kernel.
>    Said geek is going to learn a damn sight more currently than he will
>    with a dumbed down pointy clicky "build me a kernel" button.

Your "they must show willingness to suffer pain, otherwise they're not worthy"
attitude is really showing here.

I'm not proposing that the "dumbed-down" version be the only version, but that
the kernel and the config tools make "build me a kernel at the push of a
button *possible* for those who don't want to go any deeper.  
 
> o  Aunt Tilley.
>    Vendors already ship an array of kernels which should make it
>    unnecessary for her to have to build a kernel.

Yes. But *I* want Aunt Tilley to be able to download the latest kernel
sources and build/install them herself, without ever feeling that the task 
is beyond her capabilities.  

Part of the reason I want this is for the capability itself; partly I want
it pour encourager les autres -- to demonstrate, by tackling one of the 
toughest cases, that much of the complexity and anti-useability of Linux
is an artificial and unnecessary creation of the culture that created it,
rather than a result of actual technical depth of the problem.

I believe we need to learn the discipline of useability and take it seriously.
Because talk plus code is much more convincing than just talk, I'm trying
to demonstrate this by coding.  But I'll talk about it too :-).

> If you still think world domination is going to appear by idiotproofing
> the kernel build process, I think you're in for a surprise.
> We have far bigger usability problems in userspace. The point is that
> $newcomertolinux doesn't need to know what a kernel is, let alone
> have to build one. They just see "Booting progress" "Log in" "Desktop".

Sure we have bigger idiotproofing problems.  But this is the one that 
(a) my skillset is well matched to, and (b) no one else is worrying about.

World domination will happen, if it happens, because lots of people
are willing to obsess about useability issues at *all* levels of the 
system.  Including this one.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Don't ever think you know what's right for the other person.
He might start thinking he knows what's right for you.
	-- Paul Williams, `Das Energi'
