Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTCEVdB>; Wed, 5 Mar 2003 16:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbTCEVdA>; Wed, 5 Mar 2003 16:33:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12036 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262812AbTCEVc7>; Wed, 5 Mar 2003 16:32:59 -0500
Date: Wed, 5 Mar 2003 22:43:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: sys32_ioctl -> compat_ioctl -- generic
Message-ID: <20030305214329.GJ2958@atrey.karlin.mff.cuni.cz>
References: <20030303232122.GA24018@elf.ucw.cz> <20030305102849.61469d19.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305102849.61469d19.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is generic part of sys32_ioctl -> compat_ioctl. Please apply,
> 
> Thanks for this - you saved me a headache :-)

Well, I fear total sum of headache stayed constant ;-).

Anyway, producing these patches seems "easy" compared to actually
merging them. You seem to have some experience with this, would you be
willing to help?


> Some comments:
> 
> > --- clean/kernel/compat.c	2003-03-03 23:39:39.000000000 +0100
> > +++ linux/kernel/compat.c	2003-02-20 10:48:21.000000000 +0100
> 
> All this really belongs in fs/compat.c ...
> 
> One thing that Linus (and I) wanted from the compatability layer is
> to try to keep all 32 bit assumptions out of the generic code - I
> understand that this my not be possible, but we would like to try.
> 
> So maybe you could start by changing ioctl32 to compat_ioctl everywhere -
> I know that this is just cosmetic, but it gives the better impression of
> what the code is about ...

I thought about that, but I fear resulting diff would be too big (and
would bitrot extremely quickly). I thought I'd try to merge simple (&
small) stuff first, to see how bit it will be.....

						Pavel


-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
