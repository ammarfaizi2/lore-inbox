Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270359AbRHWVMh>; Thu, 23 Aug 2001 17:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270373AbRHWVM2>; Thu, 23 Aug 2001 17:12:28 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:31627
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270382AbRHWVMK>; Thu, 23 Aug 2001 17:12:10 -0400
Date: Thu, 23 Aug 2001 14:12:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jes Sorensen <jes@sunsite.dk>
Cc: Bob Glamm <glamm@mail.ece.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823141217.B14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu> <20010823085900.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3k7zutw5y.fsf@lxplus051.cern.ch> <20010823124109.S14302@cpe-24-221-152-185.az.sprintbbd.net> <d3g0aituio.fsf@lxplus051.cern.ch> <20010823131348.Y14302@cpe-24-221-152-185.az.sprintbbd.net> <d3bsl6tsl9.fsf@lxplus051.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3bsl6tsl9.fsf@lxplus051.cern.ch>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 10:43:46PM +0200, Jes Sorensen wrote:
> >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> 
> Tom> On Thu, Aug 23, 2001 at 10:02:07PM +0200, Jes Sorensen wrote:
> >>  I am actually much more concerned about bringing up new systems
> >> than embedded however it is not uncommon to have very limited space
> >> to work in (like 64MB).
> 
> Tom> 64mb of space for 'disk' ?  You aren't compiling the kernel
> Tom> anyhow without some serious mucking around.
> 
> You may keep your binaries in flash on system like that.

Yes.  But you need some sort of 'disk' >128MB to extract the kernel
sources to.

> >> My point is that the transport process of the kernel image is
> >> painful. Some of the embedded devices or new systems being brought
> >> up may only have serial some do not have network or floppy. This
> >> makes it *very* painful to move things around because you have to
> >> physically move your disk or similar.
> 
> Tom> And you think that trying to transport the kernel srcs + userland
> Tom> will save you time in the long run?  If you have to physically
> Tom> move your disk to initially put userland on, you can put on
> Tom> python too.  Or go and run the 'freeze' schitt on it and have the
> Tom> C version.  What kind of 'new' systems are you talking about?
> Tom> I'm biased I guess since I'm used to working on documented
> Tom> hardware.  So documents + time + good hw debugger tend to help
> Tom> things along.
> 
> What I am saying is that I do *not* want to transport source
> etc. every time I want to make a kernel change. And no I *cannot* just
> put Python on it if I a) don't have the space or b) haven't brought up
> Python on the system yet.

If you don't have the room to put Python on the box you probably don't have
the room to put the kernel source on the box and compile either.  I've seen
lots of stuff shoved onto a very small ammount of flash (The bloody Agentas 
(sp?) have X on what, 32 megs?)

> I am not speaking of any new systems I am working on right now, I am
> speaking from my experience bringing up systems such as the m68k and
> ia64.

m68k I could understand maybe not having ethernet and small disks.  But
not ia64.  Coming from a PPC background, things tend to have ethernet.  You
tend to want ethernet to be working (basic board bring up, serial, ethernet)
so you can have an NFS root and start playing with the system.

> Tom> Because with the exception of your unique situation in which you
> Tom> have a machine which is stable enough to compile a kernel on and
> Tom> develop but can't run python, it's not a problem.
> 
> As I have pointed out, it *is* indeed a problem to kernel developers
> who are actually working on bringing up systems. Most of the people
> who argue in favor of the Python dependency have never tried bringing
> up a system.

The _only_ problem you've pointed out which seems to be really valid is that
python2 will mean you do need shared library support.  Having worked with
and talked to numerous people in the process of bringing up a new board
(I don't have the time right now to try my hand at it just yet) this
wouldn't be a problem for them.  Initial bring up is usually done from
what I've gathered, by people with a cross-compiler (or another system on
the platform that's known to work) and then feeding the device a kernel.
If you're developing on the machine you're attempting to bring up, you're
always going to be having lots of fun.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
