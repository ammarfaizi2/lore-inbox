Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbTBKKy7>; Tue, 11 Feb 2003 05:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbTBKKx0>; Tue, 11 Feb 2003 05:53:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27553 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267553AbTBKKvh>;
	Tue, 11 Feb 2003 05:51:37 -0500
Date: Tue, 11 Feb 2003 12:01:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030211110109.GC930@suse.de>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <20030210164730.GC443@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210164730.GC443@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10 2003, Pavel Machek wrote:
> Hi!
> 
> > The design I proposed is to have multiple I/O queues, where to apply the
> > elevator, and to choose the queue in function of the task->pid that is
> > sumbitting the bh/bio. You'll have to apply an hash to the pid and you
> > probably want a perturbation timer that will change the hash function
> > every 30 sec or so. Plus I want a special queue for everything
> > asynchronoys. So that the asynchronoys queue will be elevated and
> 
> What about adding speicial queue (queues?) for niced things? That way
> nice -20 job would not interfere with normal processes, not even for
> I/O.

Once you have per-process queues, it's fairly trivial to add stuff like
that.

-- 
Jens Axboe

