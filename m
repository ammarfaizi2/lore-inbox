Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267959AbTBYMkC>; Tue, 25 Feb 2003 07:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268066AbTBYMkC>; Tue, 25 Feb 2003 07:40:02 -0500
Received: from mta.sara.nl ([145.100.16.144]:60667 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S267959AbTBYMkB>;
	Tue, 25 Feb 2003 07:40:01 -0500
Date: Tue, 25 Feb 2003 13:50:10 +0100
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-Id: <20030225135010.69f9f58f.r.post@sara.nl>
In-Reply-To: <20030225113557.C9257@flint.arm.linux.org.uk>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se>
	<20030225092520.A9257@flint.arm.linux.org.uk>
	<20030225110704.GD159052@niksula.cs.hut.fi>
	<20030225113557.C9257@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003 11:35:57 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

> On Tue, Feb 25, 2003 at 01:07:04PM +0200, Ville Herva wrote:
> > On Tue, Feb 25, 2003 at 09:25:20AM +0000, you [Russell King] wrote:
> > > Agreed - zImage is already around 1MB on many ARM machines, and since
> > > loading zImage over a serial port using xmodem takes long enough
> > > already, this is one silly feature I'll definitely keep out of the
> > > ARM tree.
> > 
> > Why not make it a config option (like the other (two? three?) rejected
> > patches that implemented this did)?
> 
> I, for one, do not see any point in trying to put more and more crap
> into one file, when its perfectly easy to just use the "cp" command
> to produce the same end result, namely a copy of zImage, System.map
> and configuration, thusly:
> 
> cp arch/$ARCH/boot/zImage /boot/vmlinuz-$VERSION
> cp .config /boot/config-$VERSION
> cp System.map /boot/System.map-$VERSION
> 

Hmm, and how would you implement that on a system (ppc/prep) that could very
easily netboot a kernel... no /boot needed? I for one build kernels on one
box that is more or less production and netboot another just to see it fail
horribly... having all stuff in one file could help....

-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams
