Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268909AbRHLBp0>; Sat, 11 Aug 2001 21:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268913AbRHLBpQ>; Sat, 11 Aug 2001 21:45:16 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:35725
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268909AbRHLBpD>; Sat, 11 Aug 2001 21:45:03 -0400
Date: Sat, 11 Aug 2001 18:44:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available.
Message-ID: <20010811184447.A17435@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010811150255.G4657@cpe-24-221-152-185.az.sprintbbd.net> <4736.997579282@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4736.997579282@ocs3.ocs-net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 11:21:22AM +1000, Keith Owens wrote:
> On Sat, 11 Aug 2001 15:02:55 -0700, 
> Tom Rini <trini@kernel.crashing.org> wrote:
> >On Sun, Aug 12, 2001 at 01:03:00AM +1000, Keith Owens wrote:
> >
> >> Changes from Release 1.
> >[snip]
> >>   Document kbuild targets and C to assembler conversions.  As always,
> >>   Documentation/kbuild/kbuild-2.5.txt is your friend.
> >
> >Okay, I've played with this a bit on PPC, and got it working to boot :)
> >Now here's what I see as the slight problems with it.  At least on PPC
> >what we do is generate the offset bits, and then have another file,
> >arch/ppc/kernel/ppc_asm.h include that file and have some other useful
> >macros for .S files.  So any of the .S files which include ppc_asm.h
> >would need an additional
> >extra_aflags(foo.o $(src_includelist /arch/$(ARCH)))
> 
> That will be required for all asm code that includes offsets.h, on all
> architectures, I doubt there will be more than 10 on any arch.

Hopefully not much more than 10, I hope.

> The alternative of having code in some arch directory updating
> include/asm-$(ARCH)/offsets.h is worse.  It is a terrible design to
> have code in one makefile updating files in another directory.  It is a
> layer violation which is always a bad idea.

Right.  I figured it'd be worth pointing out, if nothing else.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
