Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVATUwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVATUwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVATUwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:52:12 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:63753 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261402AbVATUwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:52:08 -0500
Date: Thu, 20 Jan 2005 21:52:04 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andries Brouwer <aebr@win.tue.nl>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
Message-ID: <20050120205204.GB11170@pclin040.win.tue.nl>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120171544.GN12647@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120171544.GN12647@dualathlon.random>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: pastinakel.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 06:15:44PM +0100, Andrea Arcangeli wrote:

> > Yes, the fact that the oom-killer exists is a serious problem.
> > People work on trying to tune it, instead of just removing it.
> 
> I'm working on fixing it, not just tuning it. The bugs in mainline
> aren't about the selection algorithm (which is normally what people
> calls oom killer). The bugs in mainline are about being able to kill a
> task reliably, regardless of which task we pick, and every linux kernel
> out there has always killed some task when it was oom. So the bugs are
> just obvious regressions of 2.6 if compared to 2.4.

Yes, earlier one lost a job once in a great while, these days it is
once in a while - the frequency has gone up.

But let me stress that I also consider the earlier situation
unacceptable. It is really bad to lose a few weeks of computation.

You talk about "when it is oom", as if it would be unavoidable,
an act of nature. But it can be avoided, and should be avoided,
unless the sysadmin explicitly says that oom is OK for him.

(Compare allowing oom with overclocking - there is a trade-off
between speed and reliability. It must be possible to choose
for reliability. Indeed, reliability must be the default.)

Andries

