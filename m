Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSILWtH>; Thu, 12 Sep 2002 18:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSILWtH>; Thu, 12 Sep 2002 18:49:07 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:53459 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317365AbSILWtG>; Thu, 12 Sep 2002 18:49:06 -0400
Message-ID: <3D811B12.A6615688@bigpond.com>
Date: Fri, 13 Sep 2002 08:54:10 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Fowler <simon@himi.org>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400 and 
 agpgart
References: <3D7FF444.87980B8E@bigpond.com.suse.lists.linux.kernel> <p73ptvjpmec.fsf@oldwotan.suse.de> <20020912213201.GA9168@himi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Fowler wrote:
> 
> On Thu, Sep 12, 2002 at 11:50:19AM +0200, Andi Kleen wrote:
> > Allan Duncan <allan.d@bigpond.com> writes:
> > >
> > > Any suggestions of how to improve the error messages around the failure point
> > > are welcome.  Nothing is written into dmesg at the time of failure.
> >
> > You're booting with mem=nopentium right ? It should go away when you turn
> > that off. I'm working on a fix. You can safely turn it off for now, the
> > old problems that it worked around are fixed.
> >
> The problem goes away without mem=nopentium - I've just booted into
> 2.4.20-pre5aa2 and fired up X.

Not in my case, at least for 2.4.20-pre4.

At which kernels does the nopentium become obsolete?  Alan Cox mentioned some
confusion about this.  Obviously the latest ones, but does this extend as far
back as 2.4.19?

In order to close in on what changes are triggering this, I found the patch for
sched.c for -pre3 and ran that, and find that -pre3  is fine with or without
nopentium, so that narrows it to what was altered pre3 to pre4.

There was nothing obvious in Marcelo's log of changes, so I will trawl through
the diffs themselves tonight.

At the same time, I noticed that there seems to a fair bit of touchy
behaviour of AGP out there, so maybe what is proving fatal to me is the same as
the cause of flaky for others.
