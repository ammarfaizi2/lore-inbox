Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTBKKxO>; Tue, 11 Feb 2003 05:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTBKKxJ>; Tue, 11 Feb 2003 05:53:09 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12548 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267577AbTBKKvz>;
	Tue, 11 Feb 2003 05:51:55 -0500
Date: Mon, 10 Feb 2003 17:23:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Con Kolivas <ckolivas@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210162301.GB443@elf.ucw.cz>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030209144622.GB31401@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The design I proposed is to have multiple I/O queues, where to apply the
> elevator, and to choose the queue in function of the task->pid that is
> sumbitting the bh/bio. You'll have to apply an hash to the pid and
> you

Well, if you want *fair* scheduler, as in "fair between users", I
guess you should base it on task->uid.

That should solve your dbench problems, too, as you are very unlikely
to see two tasks working over same data with different uids.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
