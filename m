Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263193AbUDZSjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUDZSjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUDZSjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:39:55 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:22982 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S263193AbUDZSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:39:52 -0400
Date: Mon, 26 Apr 2004 11:39:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rene Rebe <rene@rocklinux-consulting.de>
Cc: linux-kernel@vger.kernel.org, valentin@rocklinux-consulting.de
Subject: Re: [PATCH] fix compilation of ppc embedded configs
Message-ID: <20040426183939.GG19246@smtp.west.cox.net>
References: <20040422.103620.607961025.rene@rocklinux-consulting.de> <20040426164641.GB19246@smtp.west.cox.net> <20040426.202257.884025800.rene@rocklinux-consulting.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426.202257.884025800.rene@rocklinux-consulting.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 08:22:57PM +0200, Rene Rebe wrote:

> Hi, (un CC'ed Linus)
> 
> On: Mon, 26 Apr 2004 09:46:41 -0700,
>     Tom Rini <trini@kernel.crashing.org> wrote:
> 
> > I'd like to see the hunks that aren't tested dropped as I strongly
> 
> If you think so - I found it logical to fix the found on the way and
> not to let too much bit-rot ...
> 
> If I have to work with one of those boards in the future I want to
> track the real problems I might encounter - and not to fix 20 obvious
> compile issues first ...

I'd really rather see a loudly broken platform than a silently broken
platform until someone with the hardware steps up and verifies that
things actually work still.

> > suspect there's more subtle errors in these platforms, if the call to
> > openpic_init hasn't been changed.  Also, why is:
> 
> > > --- linux-2.6.6-rc2/arch/ppc/platforms/pplus.c	2004-04-22 10:27:16.000000000 +0200
> > > +++ linux-2.6.5-wip/arch/ppc/platforms/pplus.c	2004-04-18 22:36:08.000000000 +0200
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/init.h>
> > > +#include <linux/initrd.h>
> > >  #include <linux/ioport.h>
> > >  #include <linux/console.h>
> > >  #include <linux/pci.h>
> > 
> > Needed?  Thanks.
> 
> To get the file compile - otherwise you get:
> 
> arch/ppc/platforms/pplus.c: In function `pplus_setup_arch':
> arch/ppc/platforms/pplus.c:569: `initrd_start' undeclared (first use in this function)
> arch/ppc/platforms/pplus.c:569: (Each undeclared identifier is reported only once
> arch/ppc/platforms/pplus.c:569: for each function it appears in.)
> 
> and since I do not have all the kernel kernel in my memory and the
> other files include initrd.h I thought it is the most logical thing to try ...

Good enough, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
