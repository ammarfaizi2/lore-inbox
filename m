Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313998AbSDQBPO>; Tue, 16 Apr 2002 21:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314001AbSDQBPN>; Tue, 16 Apr 2002 21:15:13 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:8602 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313998AbSDQBPN>; Tue, 16 Apr 2002 21:15:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 16 Apr 2002 18:22:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: davidm@hpl.hp.com
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <15548.50859.169392.857907@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0204161807570.1460-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, David Mosberger wrote:

> >>>>> On Tue, 16 Apr 2002 10:18:18 -0700 (PDT), Davide Libenzi <davidel@xmailserver.org> said:
>
>   Davide> i still have pieces of paper on my desk about tests done on
>   Davide> my dual piii where by hacking HZ to 1000 the kernel build
>   Davide> time went from an average of 2min:30sec to an average
>   Davide> 2min:43sec. that is pretty close to 10%
>
> The last time I measured timer tick overhead on ia64 it was well below
> 1% of overhead.  I don't really like using kernel builds as a
> benchmark, because there are far too many variables for the results to
> have any long-term or cross-platform value.  But since it's popular, I
> did measure it quickly on a relatively slow (old) Itanium box: with
> 100Hz, the kernel compile was about 0.6% faster than with 1024Hz
> (2.4.18 UP kernel).

uhm, this is quite interesting. it's quite possible at this point that
PROC_CHANGE_PENALTY put an high cs pressure in place, with terrible cache
effects. pretty sadly i was not running the sampler that would have helped
me to detect such behaviour.



- Davide




