Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135239AbREHUI1>; Tue, 8 May 2001 16:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbREHUIK>; Tue, 8 May 2001 16:08:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20230 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135239AbREHUHB>;
	Tue, 8 May 2001 16:07:01 -0400
Date: Tue, 8 May 2001 22:06:43 +0200
From: Jens Axboe <axboe@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20010508220643.S505@suse.de>
In-Reply-To: <Pine.LNX.3.95.1010508154726.29540A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010508154726.29540A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, May 08, 2001 at 03:48:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08 2001, Richard B. Johnson wrote:
> 
> To driver wizards:
> 
> I have a driver which needs to wait for some hardware.
> Basically, it needs to have some code added to the run-queue
> so it can get some CPU time even though it's not being called.
> 
> It needs to get some CPU time which can be "turned on" or
> "turned off" as a result of an interrupt or some external
> input from  an ioctl().
> 
> So I thought that the "tasklet" would be ideal. However, the
> scheduler "thinks" that a tasklet is an interrupt, so any
> attempt to sleep in the tasklet results in a kernel panic,
> "ieee scheduling in an interrupt..., BUG sched.c line 688".

Use a kernel thread? If you don't need to access user space, context
switches are very cheap.

> So, what am I supposed to do to add a piece of driver code to the
> run queue so it gets scheduled occasionally?

Several, grep for kernel_thread.

-- 
Jens Axboe

