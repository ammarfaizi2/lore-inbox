Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293650AbSCKJdI>; Mon, 11 Mar 2002 04:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293655AbSCKJc7>; Mon, 11 Mar 2002 04:32:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56845 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293650AbSCKJcp>;
	Mon, 11 Mar 2002 04:32:45 -0500
Date: Mon, 11 Mar 2002 10:32:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Scott L. Burson" <gyro@zeta-soft.com>, linux-kernel@vger.kernel.org
Subject: Re: Performance issue on dual Athlon MP
Message-ID: <20020311093217.GB31108@suse.de>
In-Reply-To: <15494.32860.773969.762627@kali.zeta-soft.com> <E16j7Yh-0004CL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16j7Yh-0004CL-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07 2002, Alan Cox wrote:
> > BTW, this doesn't seem like a preemption issue, considering that throughput
> > is very definitely affected as well as latency.
> > 
> > Anyway, please let me know if there's anything I can do, within my
> > constraints, to help.  (As you can guess, though, I don't have any kernel
> > debugging experience.)
> 
> It sounds like the hit you are taking is from highmem and I/O (having to
> copy pages lower into memory so the I/O subsystem can use them). Some of
> that is in the hard to fix for 2.4 category with the x86. There are some
> experimental patches around but they are experimental.

If you are referring to my block-highmem patch, then it's not considered
too experiemental anymore. It's been a long time since any problems have
been reported.

Scott, a small profile run would give us the information needed to tell
whether this is a bounce problem or not. Boot the kernel with profile=2,
then do a readprofile -r ; run problematic stuff ; readprofile >
prof_data

and share the prof_data.

-- 
Jens Axboe

