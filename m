Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263517AbSJNJ4k>; Mon, 14 Oct 2002 05:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263571AbSJNJ4k>; Mon, 14 Oct 2002 05:56:40 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:8966 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S263517AbSJNJ4i>; Mon, 14 Oct 2002 05:56:38 -0400
Date: Mon, 14 Oct 2002 11:01:50 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Linux v2.5.42
Message-ID: <20021014100150.GC2518@fib011235813.fsnet.co.uk>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Fri, Oct 11, 2002 at 09:59:58PM -0700, Linus Torvalds wrote:
> PS: NOTE - I'm not going to merge either EVMS or LVM2 right now as things
> stand.  I'm not using any kind of volume management personally, so I just
> don't have the background or inclination to walk through the patches and
> make that kind of decision. My non-scientific opinion is that it looks 
> like the EVMS code is going to be merged, but ..
> 
> Alan, Jens, Christoph, others - this is going to be an area where I need
> input from people I know, and preferably also help merging. I've been 
> happy to see the EVMS patches being discussed on linux-kernel, and I just 
> wanted to let people know that this needs outside help.

I've just got a few comments to make:

Yes, there has been a lot more discussion of EVMS than device-mapper
in the last couple of weeks, however not much of it was complimentary.
I feel like adding some obvious design flaws to device-mapper so that
Christoph will give me some free publicity too ;)

I've always tried to argue for the inclusion of device-mapper in the
kernel, rather than the exclusion of EVMS.  Admittedly I don't agree
with their design, if I did I would have continued developing the LVM1
driver.  However I don't see why we have to deliberately upset to
either the large LVM or EVMS userbase by not supporting their software
- unless the respective driver is too broken.

Some people seem to misunderstand the status of the LVM2 system.

i) I consider the software to be more stable than LVM1 and would
   always use it in preference, and have done for the last year.

ii) It is backwards compatible with LVM1, the tools look and behave in
    an almost identical manner to the LVM1 tools.  To migrate from
    LVM1 to LVM2 you compile a kernel with dm, compile the userland tools
    and use them.

iii) The only major feature that LVM2 doesn't have compared to LVM1 is
     'pvmove'.  This feature is broken/dangerous in LVM1.  EVMS also
     doesn't have a pvmove.

The LVM1 driver recieved a lot of abuse of the last 2 years, I believe
we've addressed these problems very well with the dm driver.  I have
also argued why a new driver was neccessary rather than fixing LVM1,
and think the vast majority of people agree with me.  The LVM users
want to continue with the toolset they are familiar with, so why are
we even considering not continuing to support them by leaving dm out
of 2.5 ?

- Joe
