Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289738AbSAJW03>; Thu, 10 Jan 2002 17:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289736AbSAJW0O>; Thu, 10 Jan 2002 17:26:14 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:17322
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289739AbSAJWZw>; Thu, 10 Jan 2002 17:25:52 -0500
Date: Thu, 10 Jan 2002 15:24:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rob Landley <landley@trommello.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Greg KH <greg@kroah.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020110222457.GE13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <20020110013856.A26151@devcon.net> <20020110024240.GW13931@cpe-24-221-152-185.az.sprintbbd.net> <200201102155.g0ALtkA22362@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201102155.g0ALtkA22362@snark.thyrsus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 09:09:01AM -0500, Rob Landley wrote:
> On Wednesday 09 January 2002 09:42 pm, Tom Rini wrote:
> > On Thu, Jan 10, 2002 at 01:38:56AM +0100, Andreas Ferber wrote:
> > > On Wed, Jan 09, 2002 at 05:25:07PM -0700, Tom Rini wrote:
> > > > > This could be done anyway: just replace the initramfs image built by
> > > > > the kernel build with anotherone built from another source tree. It
> > > > > would be helpful though if the tools were distributed both standalone
> > > > > and included into the kernel tree.
> > > >
> > > > If the kernel is going to build an initramfs option, it also needs a
> > > > way to be given one.  The issue I'm thinking of is I know of a few
> > > > platforms where the initramfs archive will have to be part of the
> > > > 'zImage' file (much like they do for ramdisks now).
> > >
> > > Append it to the zImage and let the kernel look for it there. Plus add
> > > a tool to util-linux (or maybe an option to rdev?) to let you replace
> > > the embedded initramfs in a {,b}zImage with a customized one.
> >
> > Er, 'rdev' is an x86-only program, so lets not add common functionality
> > to that.  And I'd rather not throw something onto the end of the
> > 'zImage' since I just got done removing annoying/broken things like
> > that.
> 
> You want it to be an ELF section then?

I want it to be implementation specific.  The running kernel shouldn't
care how it got the image, just that it did.

And yes, on PPC it will either be given one by a 'real' bootloader
(yaboot, ppcboot) or an ELF section like the kernel itself, ramdisk and
sometimes System.map are.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
