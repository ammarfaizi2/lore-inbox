Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267792AbTBKMdu>; Tue, 11 Feb 2003 07:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267794AbTBKMdu>; Tue, 11 Feb 2003 07:33:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50862 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267792AbTBKMdt>;
	Tue, 11 Feb 2003 07:33:49 -0500
Date: Tue, 11 Feb 2003 13:43:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030211124330.GK930@suse.de>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <20030210162301.GB443@elf.ucw.cz> <20030211114936.GE22275@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211114936.GE22275@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11 2003, Andrea Arcangeli wrote:
> On Mon, Feb 10, 2003 at 05:23:02PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > The design I proposed is to have multiple I/O queues, where to apply the
> > > elevator, and to choose the queue in function of the task->pid that is
> > > sumbitting the bh/bio. You'll have to apply an hash to the pid and
> > > you
> > 
> > Well, if you want *fair* scheduler, as in "fair between users", I
> > guess you should base it on task->uid.
> 
> Good idea. All these cases should be optional, and they make plenty of
> sense to me.

Coolest would to simply stack these schedulers any way you want. Sneak
the uid based fairness scheduler in front of the pid based one, and you
have per-user with per-process fairness.

Lets lego.

-- 
Jens Axboe

