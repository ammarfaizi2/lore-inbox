Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287461AbSAJCns>; Wed, 9 Jan 2002 21:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289121AbSAJCni>; Wed, 9 Jan 2002 21:43:38 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:13216
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287461AbSAJCn0>; Wed, 9 Jan 2002 21:43:26 -0500
Date: Wed, 9 Jan 2002 19:42:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>, Greg KH <greg@kroah.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020110024240.GW13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <20020109214022.GE21963@kroah.com> <5.1.0.14.2.20020109215335.02cfc780@pop.cus.cam.ac.uk> <20020109231528.B25786@devcon.net> <20020110002507.GU13931@cpe-24-221-152-185.az.sprintbbd.net> <20020110013856.A26151@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110013856.A26151@devcon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 01:38:56AM +0100, Andreas Ferber wrote:
> On Wed, Jan 09, 2002 at 05:25:07PM -0700, Tom Rini wrote:
> > > 
> > > This could be done anyway: just replace the initramfs image built by 
> > > the kernel build with anotherone built from another source tree. It
> > > would be helpful though if the tools were distributed both standalone
> > > and included into the kernel tree.
> > If the kernel is going to build an initramfs option, it also needs a way
> > to be given one.  The issue I'm thinking of is I know of a few platforms
> > where the initramfs archive will have to be part of the 'zImage' file
> > (much like they do for ramdisks now).
> 
> Append it to the zImage and let the kernel look for it there. Plus add
> a tool to util-linux (or maybe an option to rdev?) to let you replace
> the embedded initramfs in a {,b}zImage with a customized one.

Er, 'rdev' is an x86-only program, so lets not add common functionality
to that.  And I'd rather not throw something onto the end of the
'zImage' since I just got done removing annoying/broken things like
that.  Mind you I don't think x86 will take advantage (or have reason
to, really) embedded the initramfs image into the bzImage/zImage, unless
we're going to let them run w/o a bootloader still.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
