Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSELIMs>; Sun, 12 May 2002 04:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSELIMr>; Sun, 12 May 2002 04:12:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37361 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311749AbSELIMr>;
	Sun, 12 May 2002 04:12:47 -0400
Message-ID: <3CDE23DE.FF27427F@mvista.com>
Date: Sun, 12 May 2002 01:12:14 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Russell King <rmk@arm.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
In-Reply-To: <16925.1021163466@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 12 May 2002 01:01:21 +0100,
> Russell King <rmk@arm.linux.org.uk> wrote:
> >On Sun, May 12, 2002 at 09:38:48AM +1000, Keith Owens wrote:
> >> Any reason that you are using sed and not cpp like the other
> >> architectures?
> >
> >Only historical and a hatred of cpp's "# line file" stuff, and the fact
> >that ARM needs to use sed elsewhere in the build to get around broken
> >GCC %c0 stuff.

The interesting thing is that, in this case, cpp HAS THE INFO to do the 
job, while it would be a bit of a hassel to round it up for sed.  I.e. the
endian macro is defined in the cpp build, not in macros naturally available
to make or sed.  At the same time any thing make knows can easily be push
into cpp via a command line macro.

~snip
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
