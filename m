Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQL0QpI>; Wed, 27 Dec 2000 11:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbQL0Qos>; Wed, 27 Dec 2000 11:44:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28936 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129828AbQL0Qol>;
	Wed, 27 Dec 2000 11:44:41 -0500
Date: Wed, 27 Dec 2000 17:14:12 +0100
From: Jens Axboe <axboe@suse.de>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom changes in test13-pre2 slow down cdrom access by 70%
Message-ID: <20001227171412.C15804@suse.de>
In-Reply-To: <3A43D48D.B1825354@dm.ultramaster.com> <20001223133737.D300@suse.de> <3A4904CA.EA1062AF@dm.ultramaster.com> <3A4911ED.95A73903@dm.ultramaster.com> <20001227063810.E5981@suse.de> <3A4A1383.A262BF38@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A4A1383.A262BF38@dm.ultramaster.com>; from lkml@dm.ultramaster.com on Wed, Dec 27, 2000 at 11:06:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27 2000, David Mansfield wrote:
> > In principle it looks ok, but after some time we are bound to fail 8
> > frame allocations anyway and this patch won't help. For the modular
> > case, preallocation of a bigger chunk at init time is no good either.
> > Builtin would be fine of course. This almost screams sg to me :-)
> > 
> 
> Nonetheless, with your first patch and my patch, the system starts off
> using the old method of trying to allocate 8 frames buffer (which is
> essential for performance) and falls back to the current (as of
> test13-pre2) way in low/fragmented memory situations. To me, that's
> better than either the previous or the current method, with the slight
> increased cost of the failed kmalloc every time in the low/fragmented
> memory case. [...]

Yes I agree, it's better than what is there. All I was saying is that
it could be better :-). I've already put something close to your patch
in my tree, will be sent off the next time

> BTW, have you gotten reports of that kmalloc failing for people?

Of course, otherwise I wouldn't have changed it.

> I've been ripping audio with every kernel since pre4 and have
> never had a failure.  Granted, I put 'workstation' loads on my machine,
> but I run some benchmarks from time-to-time, put memory pressure on
> etc.  (H*ll, just netscape alone is memory pressure enough :-).

Depends on how much RAM you have, and what you are doing.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
