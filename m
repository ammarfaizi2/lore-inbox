Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbTCTUPv>; Thu, 20 Mar 2003 15:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbTCTUPv>; Thu, 20 Mar 2003 15:15:51 -0500
Received: from ns.suse.de ([213.95.15.193]:16146 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261892AbTCTUPt>;
	Thu, 20 Mar 2003 15:15:49 -0500
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030320193315.GB312@elf.ucw.cz>
References: <20030319232157.GA13415@elf.ucw.cz.suse.lists.linux.kernel>
	<p7365qe5284.fsf@amdsimf.suse.de>  <20030320193315.GB312@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Mar 2003 21:26:49 +0100
Message-Id: <1048192010.15510.192.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-20 at 20:33, Pavel Machek wrote:
> Hi!
> 
> > > --- linux-test/include/linux/compat_ioctl.h	2003-03-20 00:08:12.000000000 +0100
> > > +++ linux/include/linux/compat_ioctl.h	2003-03-19 23:36:24.000000000 +0100
> > > @@ -0,0 +1,641 @@
> > > +/* List here explicitly which ioctl's are known to have
> > > + * compatible types passed or none at all...
> > > + */
> > > +/* Big T */
> > > +COMPATIBLE_IOCTL(TCGETA)
> > 
> > Shouldn't you put the include files needed for all that in there
> > too?
> 
> List of includes is *way* shorter than 600 lines of
> COMPATIBLE_IOCTL. I prefer to keep it simple for now.

I disagree. The big issue with the duplicated code is not how long it
is, but that it needs N changesets to fix something instead of one.
Typically a new ioctl also adds a new include.
If you keep the includes separated it'll have even more mainteance
overhead than before (you need N+1 commits to add the new ioctl)

-Andi


