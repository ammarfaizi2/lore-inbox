Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266684AbRGQQRJ>; Tue, 17 Jul 2001 12:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266668AbRGQQQ7>; Tue, 17 Jul 2001 12:16:59 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:9743 "EHLO ibg.colorado.edu")
	by vger.kernel.org with ESMTP id <S266656AbRGQQQx>;
	Tue, 17 Jul 2001 12:16:53 -0400
Message-Id: <200107171615.KAA254078@ibg.colorado.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Too much memory causes crash when reading/writing to disk 
In-Reply-To: Andrew Morton's message of Wed, 18 Jul 2001 00:00:54 +1000.
In-Reply-To: <200107171322.HAA245907@ibg.colorado.edu> <3B544516.FF6643E8@uow.edu.au> 
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 8063
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Tue, 17 Jul 2001 10:15:42 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In your message of: Wed, 18 Jul 2001 00:00:54 +1000, you write:
>> I made the patch against
>> 2.4.6, because 2.4.7-pre6 doesn't boot at all (I guess I should send
>> another message about that problem).
>
>If it's locking up just after printing out the `NET3' banner,
>don't bother - known problem with softirqs.  It'll be fixed
>in the next kernel.

Yes, that is the problem.  I'll wait for a future release.

>> >Also (but separately) try enabling the NMI watchdog with
>> >the `nmi_watchdog=1' kernel boot parameter.
>> 
>> This worked, and I recreated the crash:
>
>Wouldn't have a clue.  It isn't spinning on a lock.
>It almost looks as if the timer interrupt isn't getting
>cleared, and the CPU is never leaving the interrupt.  But
>that would cause the timer interrupt count to increase like
>crazy and the NMI would never have kicked in.  Nice one.
>
>For interest's sake, could you please try booting with the
>`noapic' option, and also send another NMI watchdog trace?

I tried that, but the Symbios SCSI controller freaks out with noapic.
I can be more detailed if that would be useful.  I can also try a
non-smp kernel and run the machine with 1 processor and 8GB, if you
think that would be useful in solving the problem.

I appreciate your help in this, as yes, the problem is indeed a nice
one...

--
Jeff Lessem.
