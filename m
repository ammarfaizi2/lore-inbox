Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265538AbSJSGxd>; Sat, 19 Oct 2002 02:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265539AbSJSGxd>; Sat, 19 Oct 2002 02:53:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31729 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265538AbSJSGxb>;
	Sat, 19 Oct 2002 02:53:31 -0400
Message-ID: <3DB102BC.F181BC1F@mvista.com>
Date: Fri, 18 Oct 2002 23:59:08 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jim Houston <jim.houston@attbi.com>, linux-kernel@vger.kernel.org
Subject: Re: POSIX clocks & timers - more choices
References: <200210190252.g9J2quf16153@linux.local.suse.lists.linux.kernel> <p73r8ennltj.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
~snip~
Since he picked this up from my code...
> 
> > +/*
> > + * For some reason mips/mips64 define the SIGEV constants plus 128.
> > + * Here we define a mask to get rid of the common bits.       The
> > + * optimizer should make this costless to all but mips.
> > + */
> > +#if (ARCH == mips) || (ARCH == mips64)
> > +#define MIPS_SIGEV ~(SIGEV_NONE & \
> > +                   SIGEV_SIGNAL & \
> > +                   SIGEV_THREAD &  \
> > +                   SIGEV_THREAD_ID)
> > +#else
> > +#define MIPS_SIGEV (int)-1
> > +#endif
> 
> This definitely needs to be cleaned up.
> 
What do you suggest?  Changing mips?  I would like this
number to go away also, but with the mips assignments it is
a bit of a bother.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
