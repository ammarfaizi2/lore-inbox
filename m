Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRADVa5>; Thu, 4 Jan 2001 16:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbRADVar>; Thu, 4 Jan 2001 16:30:47 -0500
Received: from nrg.org ([216.101.165.106]:19236 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129413AbRADVai>;
	Thu, 4 Jan 2001 16:30:38 -0500
Date: Thu, 4 Jan 2001 13:28:58 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Daniel Phillips <phillips@innominate.de>
cc: ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A5427A6.26F25A8A@innominate.de>
Message-ID: <Pine.LNX.4.05.10101041323480.4778-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Daniel Phillips wrote:
> A more ambitious way to proceed is to change spinlocks so they can sleep
> (not in interrupts of course).  There would not be any extra overhead
> for this on spin_lock (because the sleep test is handled off the fast
> path) but spin_unlock gets a little slower - it has to test and jump on
> a flag if there are sleepers.

I already have a preemption patch that also changes the longest
held spinlocks into sleep locks, i.e. the locks that are routinely
held for > 1ms.  This gives a kernel with very good interactive
response, good enough for most audio apps.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
