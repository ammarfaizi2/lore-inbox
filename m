Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283463AbRLDVWA>; Tue, 4 Dec 2001 16:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281268AbRLDVVu>; Tue, 4 Dec 2001 16:21:50 -0500
Received: from nrg.org ([216.101.165.106]:35600 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S283463AbRLDVVh>;
	Tue, 4 Dec 2001 16:21:37 -0500
Date: Tue, 4 Dec 2001 13:20:50 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: george anzinger <george@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <3C0D3283.4DA4DD2B@mvista.com>
Message-ID: <Pine.LNX.4.40.0112041314010.595-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, george anzinger wrote:
>                               For example, preemption currently counts
> up on spin_lock and disable irq, counting the spin_lockirq twice.  In

That's not correct: we don't count it twice because we don't count
local_irq_disable etc., only the spin locks.  Because...

>                                               (Oh, and since the irq
> inhibits preemption all by itself, we don't need to count it either.)

...so we don't.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

