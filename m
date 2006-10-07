Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWJGKYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWJGKYd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 06:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWJGKYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 06:24:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23709 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750781AbWJGKYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 06:24:32 -0400
Date: Sat, 7 Oct 2006 12:24:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Bryce Harrington <bryce@osdl.org>, vatsa@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       hotplug_sig@osdl.org, lhcs-devel@lists.sourceforge.net
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061007102419.GB30034@elf.ucw.cz>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006162924.344090f8.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > How well tested is this?  From my reading, this will cause
> > > enable_nonboot_cpus() to panic.  Is that intended?
> > 
> > I wanted to give you an update on results of cpu testing I've done on
> > recent kernels and several architectures.  Since -rc1 is out, I wanted
> > to give added visibility to the few issues that remain.
> > 
> > The full results are available here:
> > 
> >     http://crucible.osdl.org/runs/hotplug_report.html
> > 
> > This is actually a report for cpu hotplug tests generated hourly,
> > however we run it against all of the kernel -git snapshots posted to
> > kernel.org.  Whereever you see a blank square, it indicates the kernel
> > either failed to build or boot.

So... patch-2.6.18-git4 failed to boot on all architectures? I'm
seeing very little green fields there... actually I only see two green
fields in whole table.

(And it would be nice to call ia64 "ia64", not "ita64" :-)

> Can you describe the nature of the cpu-hotplug tests you're running?  I'd
> be fairly staggered if the kernel was able to survive a full-on cpu-hotplug
> stress test for more than one second, frankly.  There's a lot of code in
> there which is non-hotplug-aware.  Running a non-preemptible kernel would
> make things appear more stable, perhaps.
> 
> iirc Pavel did some testing a month or two ago and was seeing userspace
> misbehaviour?

Pavel did some testing (like two threads trying to plug/unplug cpus at
the same time), and seen machines dying real fast; but that was fixed,
IIRC, and I did not really torture it after that.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
