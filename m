Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbUCPEac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 23:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUCPEac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 23:30:32 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:13186 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262844AbUCPEaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 23:30:25 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
Date: Tue, 16 Mar 2004 10:00:01 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <200403151650.34115.amitkale@emsyssoft.com> <40560962.9050804@mvista.com>
In-Reply-To: <40560962.9050804@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403161000.02223.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Mar 2004 1:22 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > On Friday 12 Mar 2004 1:33 pm, George Anzinger wrote:
> >>Amit S. Kale wrote:
> >>>On Friday 12 Mar 2004 2:58 am, George Anzinger wrote:
> >>>>Amit S. Kale wrote:
> >>>>~
> >>>>
> >>>>>>context any
> >>>>>>
> >>>>>>p fun()
> >>>>>
> >>>>>p fun() will push arguments on stack over the place where irq occured,
> >>>>>which is exactly how it'll run.
> >>>>
> >>>>Is this capability in kgdb lite?  It was one of the last things I added
> >>>>to -mm version.
> >>>
> >>>No! It's not present in kgdb heavy also. All you can do is set $pc,
> >>>continue.
> >>
> >>Possibly I can help here.  I did it for the mm version.  It does require
> >> a couple of asm bits and it sort of messes up the set/fetch memory, but
> >> it does do the job.
> >
> > I have seen that. It's too messy!
>
> You have a better solution?

Nope.

I think this feature is very likely to be abused by programmers. They do 
deserve suffering if they choose to shoot at their own feet.

Kernel programmers have to be aware of implementation of this feature if they 
choose to call arbitrary functions. This includes knowing whether interrupts 
are disabled, handling of exceptions in gdb called functions, whether other 
processors run, that breakpoints are  disabled. Given that kgdb is used for 
learning the kernel, such features are best kept aside.

-Amit
