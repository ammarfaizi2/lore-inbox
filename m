Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRAWRJQ>; Tue, 23 Jan 2001 12:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131422AbRAWRJH>; Tue, 23 Jan 2001 12:09:07 -0500
Received: from gateway.sequent.com ([192.148.1.10]:50136 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S131382AbRAWRI7>; Tue, 23 Jan 2001 12:08:59 -0500
Date: Tue, 23 Jan 2001 09:08:49 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Jun Nakajima <jun@sco.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] multi-queue scheduler update
Message-ID: <20010123090849.A959@w-mikek2.sequent.com>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <LYR76657-1923-2001.01.23-08.54.49--mikek#sequent.com@lyris.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <LYR76657-1923-2001.01.23-08.54.49--mikek#sequent.com@lyris.sequent.com>; from jun@sco.com on Tue, Jan 23, 2001 at 11:49:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 11:49:27AM -0500, Jun Nakajima wrote:
> I tried to run SDET (Software Development Environment Throughput), which
> basically is a system level, throughput oriented benchmark, on the 2.4.0
> kernel and 2.4.0 kernel with this patch. 

Thanks for running this.  I too remember SDET, but I won't claim
to be old. :)

We were doing some more analysis on the multi-queue scheduler and
noticed that performance has regressed since posting preliminary
numbers with the 2.4.0-test10 kernel.  After comparing the code,
it looks like I have over-engineered for the worst case of lock
contention.  This was done at the expense of the normal case.
I'm currently working on this situation and expect to have a new
patch out in the not too distant future.

I expect the numbers will get better.
-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
