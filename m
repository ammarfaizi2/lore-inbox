Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287291AbSACOMa>; Thu, 3 Jan 2002 09:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287292AbSACOMV>; Thu, 3 Jan 2002 09:12:21 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:53769 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S287291AbSACOMJ>; Thu, 3 Jan 2002 09:12:09 -0500
Message-Id: <200201031412.g03EC1s0021730@pincoya.inf.utfsm.cl>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Wed, 02 Jan 2002 21:10:38 CDT." <20020102211038.C21788@thyrsus.com> 
Date: Thu, 03 Jan 2002 11:12:01 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
> Dave Jones <davej@suse.de>:

[...]

> > And if you don't know what hardware you've got in the box your
> > configuring a kernel for, its questionable that you should be
> > doing so in the first place.
> 
> That's exactly the bad assumption we need to dynamite.  Vaporize.  Nuke.

Just why is it a bad assumption?

> It should be possible to build a correctly customized kernel without
> opening the case of your machine.  It should be possible for
> non-technical people to customize kernels.  Kernel customization
> should present an interface based on what you want to *do* with the
> machine, not the specific hardware inside it (because the configurator
> is smart enough to map from the intended-function domain to the hardware-
> specifics domain).

Customized kernels for what? Your end-user will (or should be at least)
quite happy with the vendor kernel. It is not the times anymore where you
had to compile a custom kernel for each machine because there were no
modules, and RAM (and even disk space) was dear. Your customized kernel for
Aunt Tillie (if she wants to compile a kernel) would be more along the
lines of a distribution kernel, with everything possible build as modules.
I think this kind of user would be quite confused if the kernel build on
Uncle Adam's machine doesn't work on Aunt Tillie's.

> Think useability.  On Macintoshes, you configure a kernel by moving the 
> equivalents of modules in and out of a system folder.  Users tune their
> kernels by moving files around -- no muttering of elaborate incantations
> required.  *That's* the direction we should be moving in; there is no 
> good technical reason for the process to be anywhere near as arcane as
> it is now.

On Linux, you modprobe/rmmod them. Nice and easy. Or let automagic take
over the loading/unloading. Works for millions of distribution <foo> users.

> I have spent eighteen months thinking very hard about this problem, and
> whacking a significant piece of it with actual code.  So I can say this:
> the reason linux kernel configuration is still a black art is *only* 
> that lots of people *want it to be that way*.  We have elected to
> treat kernel-building as an initiatory rite that separates the worthy
> geeks from the unwashed technopeasant masses.

That something _can_ be done, and would look *way* cool, doesn't make it
worthwhile in day-to-day use. Just think on _who_ the users of this would
be, and exactly what problems for them it would solve. Aunt Tillie doesn't
build kernels; if she did she'd prefer to build a kernel that works
everywhere. No magic "build a kernel that will _only_ run here_" wellcome,
give her an all-modules .config for starters. Uncle Alan builds kernels for
a living, he does very well know what he wants and what the machine's
inards are. No handholding needed either.

Sure, it would be nice to go to a random machine and find out what it has
inside without opening it. But that is a niche application, and given the
horrible (and ever changing) mess of PC hardware, it is probably hard to
get even 80% right, where for your Aunt Tillie configuration system you
require 100% accuracy.

BTW, you say "kernel configuration is a black art because we want it to
stay that way". It isn't, really (I've gotten unwashed users configure
kernels with menuconfig after a short shower, so it is not _that_ bad), and
little in Linux fails to happen because Ye Gods Forbade Doing It: If
it really was as bad as you say, the pressure to get an easier kernel
configuration system would be quite large. This pressure gave us "make
configure" from the original "edit this funky file, just make sure not to
screw up", and progressed to "make menuconfig" and its ilk with random order
selections. In terms of user interface not much more seems to be needed, as
little (if any) real pressure to change this has been seen in many years. I
dimly remember mechanisms for autodetection and .configure autobuilding,
they never got far. Either because it isn't really needed, or because it is
(or was) just too hard to get it right enough for real use. I'd think both
are partly responsible.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
