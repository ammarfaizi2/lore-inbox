Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTBKLjy>; Tue, 11 Feb 2003 06:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbTBKLjx>; Tue, 11 Feb 2003 06:39:53 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:45187 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267636AbTBKLjw>;
	Tue, 11 Feb 2003 06:39:52 -0500
Date: Tue, 11 Feb 2003 12:49:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Con Kolivas <ckolivas@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030211114936.GE22275@dualathlon.random>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <20030210162301.GB443@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210162301.GB443@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 05:23:02PM +0100, Pavel Machek wrote:
> Hi!
> 
> > The design I proposed is to have multiple I/O queues, where to apply the
> > elevator, and to choose the queue in function of the task->pid that is
> > sumbitting the bh/bio. You'll have to apply an hash to the pid and
> > you
> 
> Well, if you want *fair* scheduler, as in "fair between users", I
> guess you should base it on task->uid.

Good idea. All these cases should be optional, and they make plenty of
sense to me.

> That should solve your dbench problems, too, as you are very unlikely
> to see two tasks working over same data with different uids.

yes, but the main reason we do this isn't for multiuser systems. For
multiuser systems it's true it would solve dbench, but there must be an
option to go with task->pid and being able to specify the latency
criticak tasks from userspace would be a good idea too.

Andrea
