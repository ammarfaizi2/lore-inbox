Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129865AbRBYWso>; Sun, 25 Feb 2001 17:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbRBYWsY>; Sun, 25 Feb 2001 17:48:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30440 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129865AbRBYWsQ>;
	Sun, 25 Feb 2001 17:48:16 -0500
Date: Sun, 25 Feb 2001 17:48:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
In-Reply-To: <20010225233957.R7830@suse.de>
Message-ID: <Pine.GSO.4.21.0102251745560.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Feb 2001, Jens Axboe wrote:

> On Sun, Feb 25 2001, Nate Eldredge wrote:
> > Nate Eldredge writes:
> >  > Kernel 2.4.2-ac3.
> >  > 
> >  >  FLAGS   UID   PID  PPID PRI  NI   SIZE   RSS WCHAN       STA TTY TIME COMMAND
> >  >     40     0   425     1  -1 -20      0     0 down        DW< ?   0:00 (loop0)
> > 
> > It looks like this has been addressed in the thread "242-ac3 loop
> > bug".  Jens Axboe posted a patch, but the list archive I'm reading
> > mangled it.  Jens, could you make this patch available somewhere, or
> > at least email me a copy?  (If it's going in an upcoming -ac patch,
> > then don't bother; I can wait until then.)
> 
> Patch is here, I haven't checked whether Alan put it in ac4 yet (I
> did cc him, but noone knows for sure :-).

Jens, you have a race in lo_clr_fd() (loop-6). I've put the fixed
variant on ftp.math.psu.edu/pub/viro/loop-S2.gz. Diff and you'll
see - it's in the very beginning of the lo_clr_fd().
							Cheers,
								Al

