Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbUCMMfY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 07:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUCMMfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 07:35:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51595 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263083AbUCMMfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 07:35:11 -0500
Date: Sat, 13 Mar 2004 13:28:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@zip.com.au>, torvalds@osdl.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with swsusp vs. pmdisk
Message-ID: <20040313122819.GB3084@openzaurus.ucw.cz>
References: <20040312224645.GA326@elf.ucw.cz> <20040313004756.GB5115@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313004756.GB5115@thunk.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't really like having two implementations of same code in
> > kernel. There are two ways to deal with it:
> > 
> > * remove pmdisk from kernel
> >   + its easy
> > 
> > * remove swsusp from kernel, rename pmdisk to swsusp, fix all bugs
> >   that were fixed in swsusp but not in pmdisk 
> >   + people seem to like pmdisk code more
> >   - will need some testing in -mm series
> > 
> > Which one do you prefer? I can do both...
> 
> 2.6 is allegedly the stable kernel series, so if swsusp is the more
> stable code base at this point, my vote would be to keep swsusp and
> remove pmdisk from the kernel.  If someone wants to maintain a
> separate BK-tree that contains pmdisk renamed to swsusp and fix all
> the bugs, that's great.  On the other hand, there are a group of

I do not have time for that (and nobody else volunteered). Maintaining either
one is fine, but not both of them.

> So if we can somehow go from *three* idependent software suspend
> implementations implementations to something less than three, and
> increase the testing and effort devoting to remaining software suspend
> code bases, this would be a good thing.
> 
> Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
> complaint about it is that since it's maintained outside of the
> kernel, it's constantly behind about 0.75 revisions behind the latest
> 2.6 release.  The feature set of swsusp2, if they can ever get it
> completely bugfree(tm) is certainly impressive.

My biggest problem with swsusp2 is that it is big. Also last time I looked
it had some ugly hooks sprinkled all over the kernel. Then there are some
features I don't like (graphical screens with progress, escape-to-abort)
and ithasvariableslikethis. OTOH it supports highmem and smp.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

