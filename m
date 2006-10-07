Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932789AbWJGUZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWJGUZl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932822AbWJGUZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:25:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932789AbWJGUZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:25:41 -0400
Date: Sat, 7 Oct 2006 13:25:21 -0700
From: Bryce Harrington <bryce@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       hotplug_sig@osdl.org, lhcs-devel@lists.sourceforge.net
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061007202521.GA24743@osdl.org>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org> <20061007102419.GB30034@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007102419.GB30034@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 12:24:19PM +0200, Pavel Machek wrote:
> > > > How well tested is this?  From my reading, this will cause
> > > > enable_nonboot_cpus() to panic.  Is that intended?
> > > 
> > > I wanted to give you an update on results of cpu testing I've done on
> > > recent kernels and several architectures.  Since -rc1 is out, I wanted
> > > to give added visibility to the few issues that remain.
> > > 
> > > The full results are available here:
> > > 
> > >     http://crucible.osdl.org/runs/hotplug_report.html
> > > 
> > > This is actually a report for cpu hotplug tests generated hourly,
> > > however we run it against all of the kernel -git snapshots posted to
> > > kernel.org.  Whereever you see a blank square, it indicates the kernel
> > > either failed to build or boot.
> 
> So... patch-2.6.18-git4 failed to boot on all architectures? I'm
> seeing very little green fields there... actually I only see two green
> fields in whole table.

No, it failed to build due to a patching issue that has since been fixed
(I can rerun those older runs if there is interest.)

> (And it would be nice to call ia64 "ia64", not "ita64" :-)

Done

> > Can you describe the nature of the cpu-hotplug tests you're running?  I'd
> > be fairly staggered if the kernel was able to survive a full-on cpu-hotplug
> > stress test for more than one second, frankly.  There's a lot of code in
> > there which is non-hotplug-aware.  Running a non-preemptible kernel would
> > make things appear more stable, perhaps.
> > 
> > iirc Pavel did some testing a month or two ago and was seeing userspace
> > misbehaviour?
> 
> Pavel did some testing (like two threads trying to plug/unplug cpus at
> the same time), and seen machines dying real fast; but that was fixed,
> IIRC, and I did not really torture it after that.

If this test is available, I could include it in my test runs if you
think it would be worth tracking.

Bryce
