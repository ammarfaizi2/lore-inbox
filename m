Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSGLTAz>; Fri, 12 Jul 2002 15:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSGLTAy>; Fri, 12 Jul 2002 15:00:54 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:7563 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316705AbSGLTAx>; Fri, 12 Jul 2002 15:00:53 -0400
Date: Fri, 12 Jul 2002 12:03:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin MOKREJ? <mmokrejs@natur.cuni.cz>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Missing files in 2.4.19-rc1
Message-ID: <20020712190327.GM695@opus.bloom.county>
References: <20020712185023.GL695@opus.bloom.county> <Pine.OSF.4.44.0207122052150.281934-100000@tao.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.44.0207122052150.281934-100000@tao.natur.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 08:54:46PM +0200, Martin MOKREJ? wrote:
> On Fri, 12 Jul 2002, Tom Rini wrote:
> 
> > On Fri, Jul 12, 2002 at 08:39:18PM +0200, Martin MOKREJ? wrote:
> >
> > > `make dep` gave again:
> > [snip]
> > > au1000_gpio.c:41: asm/au1000.h: No such file or directory
> > > au1000_gpio.c:42: asm/au1000_gpio.h: No such file or directory
> >
> > These aren't an issue, since you're not compiling for MIPS, and that's
> > for the MIPS-specific au1000 GPIO driver.  And those files aren't
> > missing on MIPS.
> 
> Hmm, I just tried with plain 2.4.18 extracted and have the same problem.
> Should I just ignore `make dep` errors and just compile? Probably yes,
> as I'm running 2.4.10-pre2 for some months now with no real troubles
> anyway.

Yes, since they aren't errors, they're warnings really.

> But the source tree is broken, right? ;-)

No.  'make dep' goes and does dependancies on every single file in the
tree (except inside of arch/ where we only go into arch/$(ARCH)) so for
drivers which are specific to certain arches, you might get warnings for
files which don't exit on your $ARCH, but aren't selectible anyhow.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
