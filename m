Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267373AbUGNMWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267373AbUGNMWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUGNMVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:21:22 -0400
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:36736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267367AbUGNMTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:19:42 -0400
Date: Wed, 14 Jul 2004 14:19:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lmb@suse.de, arjanv@redhat.com,
       phillips@istop.com, sdake@mvista.com, teigland@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040714121920.GA2350@elf.ucw.cz>
References: <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de> <20040712102818.GB31013@devserv.devel.redhat.com> <20040712115003.GV3933@marowsky-bree.de> <20040712120127.GB16604@devserv.devel.redhat.com> <20040712131312.GY3933@marowsky-bree.de> <40F294D2.3010203@yahoo.com.au> <20040712135432.57d0133c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712135432.57d0133c.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't see why it would be a problem to implement a "this task
> > facilitates page reclaim" flag for userspace tasks that would take
> > care of this as well as the kernel does.
> 
> Yes, that has been done before, and it works - userspace "block drivers"
> which permanently mark themselves as PF_MEMALLOC to avoid the obvious
> deadlocks.

> Note that you can achieve a similar thing in current 2.6 by acquiring
> realtime scheduling policy, but that's an artifact of some brainwave which
> a VM hacker happened to have and isn't a thing which should be relied upon.
> 
> A privileged syscall which allows a task to mark itself as one which
> cleans memory would make sense.

Does it work?

I mean, in kernel, we have some memory cleaners (say 5), and they
need, say, 1MB total reserved memory.

Now, if you add another task with PF_MEMALLOC. But now you'd need
1.2MB reserved memory, and you only have 1MB. Things are obviously
going to break at some point.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
