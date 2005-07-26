Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVGZUkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVGZUkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVGZUiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:38:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21432 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261896AbVGZUhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:37:50 -0400
Subject: Re: Memory pressure handling with iSCSI
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Sonny Rao <sonny@burdell.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20050726193138.GA32324@kevlar.burdell.org>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726111110.6b9db241.akpm@osdl.org>
	 <1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	 <20050726193138.GA32324@kevlar.burdell.org>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 13:37:36 -0700
Message-Id: <1122410256.6433.43.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 15:31 -0400, Sonny Rao wrote:
> On Tue, Jul 26, 2005 at 11:39:11AM -0700, Badari Pulavarty wrote:
> > On Tue, 2005-07-26 at 11:11 -0700, Andrew Morton wrote:
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > >
> > > > After KS & OLS discussions about memory pressure, I wanted to re-do
> > > >  iSCSI testing with "dd"s to see if we are throttling writes.  
> > > > 
> > > >  I created 50 10-GB ext3 filesystems on iSCSI luns. Test is simple
> > > >  50 dds (one per filesystem). System seems to throttle memory properly
> > > >  and making progress. (Machine doesn't respond very well for anything
> > > >  else, but my vmstat keeps running - 100% sys time).
> > > 
> > > It's important to monitor /proc/meminfo too - the amount of dirty/writeback
> > > pages, etc.
> > > 
> > > btw, 100% system time is quite appalling.  Are you sure vmstat is telling
> > > the truth?  If so, where's it all being spent?
> > > 
> > > 
> > 
> > Well, profile doesn't show any time in "default_idle". So
> > I believe, vmstat is telling the truth.
> 
> Badari,
> 
> You probably covered this, but just to make sure, if you're on a
> pentium4 machine, I usually boot w/ "idle=poll" to see proper idle
> reporting because otherwise the chip will throttle itself back and
> idle time will be skewed -- at least on oprofile.
> 

My machine is AMD64.

- Badari

