Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTBCXmW>; Mon, 3 Feb 2003 18:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbTBCXmW>; Mon, 3 Feb 2003 18:42:22 -0500
Received: from ns.suse.de ([213.95.15.193]:49169 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266998AbTBCXmU>;
	Mon, 3 Feb 2003 18:42:20 -0500
Date: Tue, 4 Feb 2003 00:51:50 +0100
From: Andi Kleen <ak@suse.de>
To: jt@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 32bit emulation of wireless ioctls
Message-ID: <20030203235150.GA22202@wotan.suse.de>
References: <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com> <20030203201255.GA32689@wotan.suse.de> <20030203214325.GA28330@bougret.hpl.hp.com> <20030203224619.GA6405@wotan.suse.de> <20030203231740.GA29267@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203231740.GA29267@bougret.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 03:17:40PM -0800, Jean Tourrilhes wrote:
> > Anyways: for me it is just slightly annoying to not have 32bit 
> > emulation for something, but for other ports like sparc64/ppc64/mips64 
> > it can be show stopper because they only have 32bit userland.
> 
> 	<Puzzled of why you would *not* want a 64 bit userland>

Of course I want to have a 64bit userland. In fact I have one.

Just we offer the users the choice to boot 32bit distributions with
64bit kernels too, in case they only need a single application
that needs 64bit or similar. I'm also prepared to rip out or ignore
very obscure parts of the 32bit emulation (in fact I did that already),
but if it's used commonly or even called in bootup it should be supported.

Short term I will just settle on getting that message away so that
RedHat users won't bother me anymore. Can you suggest a good way to 
handle SIOCGIWNAME? Should I just make it return -EINVAL?

> > Expect trouble when DaveM wants to plug a wireless card into one of 
> > his sparc64 boxes ;-)
> 
> 	I want to see that ;-)
> 	I've always been telling David and Stephane here that they
> should loan me an Itanium box to make sure IrDA and Wireless LAN work
> properly, for the day we will release a PDA with an Itanium processor.

I understand why you don't see much point to run 32bit on Itanium
because of the performance.  But that's not a problem on all 64bit ports...

-Andi

