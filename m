Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268051AbRG3IWi>; Mon, 30 Jul 2001 04:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRG3IW3>; Mon, 30 Jul 2001 04:22:29 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:38919 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S268051AbRG3IWS>; Mon, 30 Jul 2001 04:22:18 -0400
Date: Mon, 30 Jul 2001 10:24:18 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: what's the semaphore in requests for?
Message-ID: <20010730102418.G1981@suse.de>
In-Reply-To: <200107282234.f6SMY8421363@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107282234.f6SMY8421363@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 29 2001, Peter T. Breuer wrote:
> "A month of sundays ago ptb wrote:"
> > What's the semaphore field in requests for?  Are driver writers supposed
> > to be using it?
> 
> It seems nobody knows.

Seems you don't get mail sent to you?! I answered this on the 24th

http://asimov.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-30/0165.html

> > The reason I ask is that I've been chasing an smp bug in a block driver
> > of mine for a week.  The bug only shows up in 2.4 kernels (not in same
> > code under 2.2.18) and only with smp ("nosmp" squashes it).  It only
> 
> I've made more progress in seeking this bug.  The test is
> just dd if=/dev/mine of=/dev/null bs=4k over 2GB of data.
> 
> 2 processors + 1 userspace helper daemon on device = no bug 
> 2 processors + 2 userspace helper daemon on device = bug  (lockup)
> 1 processors + 1 userspace helper daemon on device = no bug 
> 1 processors + 2 userspace helper daemon on device = no bug 
> 
> Seeing this, I added a semaphore that forces the helper daemons to
> exclude each other as they enter the kernel in their ioctl calls.
> Still the lockup occurred with two processors and two daemons.

And I'll restate here what I said then too -- SHOW THE CODE! Or send me
a crystal ball and I'll be happy to solve your races for you.

-- 
Jens Axboe

