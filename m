Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289098AbSAUJHg>; Mon, 21 Jan 2002 04:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSAUJH1>; Mon, 21 Jan 2002 04:07:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60683 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287573AbSAUJHS>;
	Mon, 21 Jan 2002 04:07:18 -0500
Date: Mon, 21 Jan 2002 10:07:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121100707.Q27835@suse.de>
In-Reply-To: <20020121100042.P27835@suse.de> <Pine.LNX.4.10.10201210058480.13727-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201210058480.13727-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Andre Hedrick wrote:
> > This really sucks, it means we cannot safely use multi mode for a
> > variety of request sizes. I agree with your earlier comment. Here's what
> > I think we should be doing: when requesting multi mode, limit to 8
> > sectors like in your patch. This is by far the most commen multiple,
> > that's why. When starting a request, use WIN_MULT* only for cases where
> > (rq->nr_sectors % drive->mult_count) == 0. If that doesn't hold, simply
> > use WIN_READ or WIN_WRITE.
> > 
> > Applied the 2.5.3-pre2 sched SMP fix, booting -pre2 and then hacking up
> > a patch.
> 
> Why I have already done it, just take and apply.

Cool, where is it?

-- 
Jens Axboe

