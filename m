Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWCNLwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWCNLwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 06:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWCNLwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 06:52:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10689 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751850AbWCNLwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 06:52:14 -0500
Date: Tue, 14 Mar 2006 12:51:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Message-ID: <20060314115145.GL10870@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060313113631.GA1736@elf.ucw.cz> <200603132303.18758.kernel@kolivas.org> <200603141613.10915.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603141613.10915.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 4) Congratulations, you are right person to help. Could you test if
> > > Con's patches help?
> >
> > Ok this patch is only compile tested only but is reasonably straight
> > forward. (I have no hardware to test it on atm). It relies on the previous
> > 4 patches I sent out that update swap prefetch. To make it easier here is a
> > single rolled up patch that goes on top of 2.6.16-rc6-mm1:
> >
> > http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_su
> >spend_test.patch
> 
> Since my warning probably scared anyone from actually trying this patch I've 
> given it a thorough working over on my own laptop, booting with mem=128M. The 
> patch works fine and basically with the patch after resuming from disk I have 
> 25MB more memory in use with pages prefetched from swap. This makes a 
> noticeable difference to me. That's a pretty artificial workload, so if 
> someone who actually has lousy wakeup after resume could test the patch it 
> would be appreciated.

Thanks for the patch...

BTW.. if you want this maximally useful, it would be nice to have
userspace interface for this. swsusp is done from userspace these days
(-mm kernel), and I guess it would be useful for "we have just
finished big&ugly memory trashing job, can we get our interactivity
back"? Like I'd probably cron-scheduled it just after updatedb, and
added it to scripts after particular lingvistic experiments...
								Pavel
-- 
27:{
