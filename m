Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131173AbRBVW1p>; Thu, 22 Feb 2001 17:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131172AbRBVW1f>; Thu, 22 Feb 2001 17:27:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:31750 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131173AbRBVW1T>; Thu, 22 Feb 2001 17:27:19 -0500
Date: Thu, 22 Feb 2001 18:40:48 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
In-Reply-To: <20010222223811.A29372@athlon.random>
Message-ID: <Pine.LNX.4.21.0102221832470.2401-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Feb 2001, Andrea Arcangeli wrote:

> On Thu, Feb 22, 2001 at 10:59:20AM -0800, Linus Torvalds wrote:
> > I'd prefer for this check to be a per-queue one.
> 
> I'm running this in my tree since a few weeks, however I never had the courage
> to post it publically because I didn't benchmarked it carefully yet and I
> prefer to finish another thing first. 

You want to throttle IO if the amount of on flight data is higher than
a given percentage of _main memory_. 

As far as I can see, your patch avoids each individual queue from being
bigger than the high watermark (which is a percentage of main
memory). However, you do not avoid multiple queues together from being
bigger than the high watermark.



