Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270818AbRIFN6s>; Thu, 6 Sep 2001 09:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270823AbRIFN6i>; Thu, 6 Sep 2001 09:58:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:43372 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270818AbRIFN6g>; Thu, 6 Sep 2001 09:58:36 -0400
Date: Thu, 6 Sep 2001 15:59:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, rohit.seth@intel.com
Subject: Re: kiobuf wrong changes in 2.4.9ac9
Message-ID: <20010906155921.F11329@athlon.random>
In-Reply-To: <20010906030228.C11329@athlon.random> <E15eyI5-00080I-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15eyI5-00080I-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Sep 06, 2001 at 01:29:53PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 01:29:53PM +0100, Alan Cox wrote:
> > The above is all about performance and design, about real world
> > showstopper the one in 2.4.9ac9 is that kiobuf allocations are going to
> > fail during read/writes due mem framentation (this is why it was using
> > vmalloc indeed) [those faliures should be easily reprocible on x86 boxes
> 
> Vmalloc is extremely expensive on many platforms. It looks very easy to
> simple flip between slab and vmalloc based on size.

based on size in turn means based on source because the kiobuf has a
fixed size. This is why I'm saying it has to be vmalloced in these
kernel trees until we shrink it and the plan to shrink it is first of
all to split the io backend out of the memory management part.

> Let me know how the testing goes - if it works out well then I'll migrate
> the -ac tree to the -aa patch when I have time to do the merging

btw, I actually don't have the workload here (my software simulations says
it works but it's not exactly the same workload, the workload I
simulated to test it is pure simultaneous rawio I/O load to the same
rawio device via different filp) so I'd like to know too ;)

Andrea
