Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWCDFil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWCDFil (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 00:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWCDFil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 00:38:41 -0500
Received: from xenotime.net ([66.160.160.81]:25229 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751232AbWCDFik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 00:38:40 -0500
Date: Fri, 3 Mar 2006 21:40:02 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Mike Galbraith <efault@gmx.de>
Cc: kernel@kolivas.org, pwil3058@bigpond.net.au, linux-kernel@vger.kernel.org,
       mingo@elte.hu, nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com,
       akpm@osdl.org
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling
 patch 1 of 2
Message-Id: <20060303214002.f36ce0b4.rdunlap@xenotime.net>
In-Reply-To: <1141450187.7703.40.camel@homer>
References: <1140183903.14128.77.camel@homer>
	<4408FC8B.4050802@bigpond.net.au>
	<1141449654.7703.36.camel@homer>
	<200603041624.06656.kernel@kolivas.org>
	<1141450187.7703.40.camel@homer>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Mar 2006 06:29:47 +0100 Mike Galbraith wrote:

> On Sat, 2006-03-04 at 16:24 +1100, Con Kolivas wrote:
> > On Saturday 04 March 2006 16:20, Mike Galbraith wrote:
> > > On Sat, 2006-03-04 at 13:33 +1100, Peter Williams wrote:
> > > > >  include/linux/sched.h |    3 -
> > > > >  kernel/sched.c        |  136
> > > > > +++++++++++++++++++++++++++++--------------------- 2 files changed, 82
> > > > > insertions(+), 57 deletions(-)
> > > > >
> > > > > --- linux-2.6.16-rc5-mm2/include/linux/sched.h.org	2006-03-01
> > > > > 15:06:22.000000000 +0100 +++
> > > > > linux-2.6.16-rc5-mm2/include/linux/sched.h	2006-03-02
> > > > > 08:33:12.000000000 +0100 @@ -720,7 +720,8 @@
> > > > >
> > > > >  	unsigned long policy;
> > > > >  	cpumask_t cpus_allowed;
> > > > > -	unsigned int time_slice, first_time_slice;
> > > > > +	int time_slice;
> > > >
> > > > Can you guarantee that int is big enough to hold a time slice in
> > > > nanoseconds on all systems?  I think that you'll need more than 16 bits.
> > >
> > > Nope, that's a big fat bug.
> > 
> > Most ints are 32bit anyway, but even a 32 bit unsigned int overflows with 
> > nanoseconds at 4.2 seconds. A signed one at about half that. Our timeslices 
> > are never that large, but then int isn't always 32bit either.
> 
> Yup.  I just didn't realize that there were 16 bit integers out there.

LDD 3rd ed. doesn't know about them either.  Same for me.

---
~Randy
