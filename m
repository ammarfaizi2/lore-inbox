Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161349AbWFVVp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161349AbWFVVp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWFVVp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:45:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53471 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030413AbWFVVp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:45:27 -0400
Date: Thu, 22 Jun 2006 23:44:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       ntl@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-ID: <20060622214414.GA4462@elf.ucw.cz>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com> <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain> <20060622084513.4717835e.rdunlap@xenotime.net> <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com> <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com> <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz> <Pine.LNX.4.64.0606221938410.17581@blonde.wat.veritas.com> <449AEF29.9070300@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449AEF29.9070300@yahoo.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >remove infrastructure which would, for example, allow "ps" to show
> >such tasks.  Perhaps such infrastructure should remain so long as
> >there are tasks there.
> 
> They'll be in the global tasklist, so there should be no reason why
> they couldn't be migrated over to an online CPU with taskset. Shouldn't
> require any rewrites, IIRC.
> 
> But after swsusp comes back up, it will be bringing up the same number
> of CPUs as went down, won't it? So you shouldn't get into that
> situation where you'd need to kill stuff, should you?

Well... unless something goes *very* wrong, we wake with same number
of CPUs. I've seen it fail in error cases (went to sleep with dual
cpus, but could not kick the second cpu to life during resume).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
