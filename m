Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRC3Whw>; Fri, 30 Mar 2001 17:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbRC3Whn>; Fri, 30 Mar 2001 17:37:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64263 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131672AbRC3Whb>; Fri, 30 Mar 2001 17:37:31 -0500
Date: Sat, 31 Mar 2001 00:36:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: geirt@powertech.no, linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
Message-ID: <20010331003645.F1579@atrey.karlin.mff.cuni.cz>
In-Reply-To: <000401c0b319517fea9@local> <20010325231013.A34@(none)> <000401c0b828$bbdf7380$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <000401c0b828$bbdf7380$5517fea9@local>; from manfred@colorfullife.com on Thu, Mar 29, 2001 at 09:58:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Is the computer otherwise idle?
> > > I've seen one unexplainable report with atm problems that
> disappeared
> > > (!) if a kernel compile was running.
> >
> > I've seen similar bugs. If you hook something on schedule_tq and
> forget
> > to set current->need_resched, this is exactly what you get.
> >
> I'm running with a patch that printk's if cpu_idle() is called while a
> softirq is pending.
> If I access the floppy on my K6/200 every track triggers the check, and
> sometimes the console blanking code triggers it.

Seems floppy and console is buggy, then.

> What about creating a special cpu_is_idle() function that the idle
> functions must call before sleeping?

I'd say just fix all the bugs.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
