Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUHTJnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUHTJnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUHTJnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 05:43:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60816 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261724AbUHTJnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 05:43:00 -0400
Subject: Re: [Jackit-devel] Re: little NPTL SCHED_FIFO test program
From: Lee Revell <rlrevell@joe-job.com>
To: martin rumori <lists@rumori.de>
Cc: jackit-devel <jackit-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040820092042.GA2496@amadora.tejo>
References: <20040817121358.5adffd22@mango.fruits.de>
	 <200408172102.00964.pnambic@unu.nu>
	 <20040818004633.35eb6501@mango.fruits.de>
	 <200408180100.04955.pnambic@unu.nu>
	 <20040818023546.03e79fc4@mango.fruits.de>
	 <1092794828.813.49.camel@krustophenia.net>
	 <20040818050708.54a27a7e@mango.fruits.de>
	 <pan.2004.08.19.23.33.47.308243@gmx.de>
	 <1092987523.10063.62.camel@krustophenia.net>
	 <20040820092042.GA2496@amadora.tejo>
Content-Type: text/plain
Message-Id: <1092994979.10063.80.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 05:42:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 05:20, martin rumori wrote:
> On Fri, Aug 20, 2004 at 03:38:44AM -0400, Lee Revell wrote:
> > > I have built a glibc with the patch you (Lee) sent to the bug-report.
> > 
> > This fixes the problem, jackd now works correctly.  I cannot take credit
> > for finding the problem though, Florian did most of the work in tracking
> > this down.
> 
> same here, really great (debian unstable).
> 
> wanted to try the volunteer preempt patch for the first time, (until
> now running 2.6.7-cko5 atm).
> 
> tried to compile 2.6.8.1 with volunteer-preempt-P5 (latest), but
> wasn't able to boot into the new kernel.  shows some lines of ACPI....
> directly after unpacking, then stops for about 1 second (without an
> error message, last line is something with a specific processor flag),
> then reboots.  not long enough to see something meaningful...
> 

I think you have an off-by-one error.  The latest version is -P4.

Try the 'noacpi' boot option.  Also, try disabling all power
management.  I know this is not realistic for a laptop, it's just for
debugging purposes.

> ACPI is disabled in favor of APM, changed that, same behavior: there
> is some lines starting with ACPI on the screen, either way.  applied
> latest acpi.sf.net patch, same thing. would like to keep APM since
> ACPI doesn't work that well with my machine.  stock 2.6.8.1-acpi boots
> fine (with the usual acpi oddities, with or without acpi patch), apm
> with 2.6.8 not yet tried (don't expect problems).
> 
> thinkpad t40p, PM-1600, 512 MB, latest bios/embeddecontroller.
> 
> is there something like that known with volunteer-preempt?  should i
> try an older version (== P4) first?  are there some config options
> which are especially meaningful?
> 

I am adding LKML and Ingo to the cc: list as he has requested any
reports of ACPI problems with the VP patches.

Lee

