Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263585AbTCUKNx>; Fri, 21 Mar 2003 05:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263586AbTCUKNx>; Fri, 21 Mar 2003 05:13:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41229 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263585AbTCUKNw>; Fri, 21 Mar 2003 05:13:52 -0500
Date: Fri, 21 Mar 2003 11:24:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
Message-ID: <20030321102453.GB2458@atrey.karlin.mff.cuni.cz>
References: <20030319232157.GA13415@elf.ucw.cz.suse.lists.linux.kernel> <p7365qe5284.fsf@amdsimf.suse.de> <20030320193315.GB312@elf.ucw.cz> <1048192010.15510.192.camel@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048192010.15510.192.camel@averell>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > --- linux-test/include/linux/compat_ioctl.h	2003-03-20 00:08:12.000000000 +0100
> > > > +++ linux/include/linux/compat_ioctl.h	2003-03-19 23:36:24.000000000 +0100
> > > > @@ -0,0 +1,641 @@
> > > > +/* List here explicitly which ioctl's are known to have
> > > > + * compatible types passed or none at all...
> > > > + */
> > > > +/* Big T */
> > > > +COMPATIBLE_IOCTL(TCGETA)
> > > 
> > > Shouldn't you put the include files needed for all that in there
> > > too?
> > 
> > List of includes is *way* shorter than 600 lines of
> > COMPATIBLE_IOCTL. I prefer to keep it simple for now.
> 
> I disagree. The big issue with the duplicated code is not how long it
> is, but that it needs N changesets to fix something instead of one.

Well, there are two of them... 600 lines of duplicated code is great
for differences starting to creep in...

> Typically a new ioctl also adds a new include.
> If you keep the includes separated it'll have even more mainteance
> overhead than before (you need N+1 commits to add the new ioctl)

Okay, I'll think what to do with it.
						Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
