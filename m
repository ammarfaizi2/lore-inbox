Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267046AbRG1TcP>; Sat, 28 Jul 2001 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbRG1TcF>; Sat, 28 Jul 2001 15:32:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16226 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267046AbRG1TcB>; Sat, 28 Jul 2001 15:32:01 -0400
Date: Sat, 28 Jul 2001 21:32:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        mingo@redhat.com, davem@redhat.com
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
Message-ID: <20010728213242.B11441@athlon.random>
In-Reply-To: <20010728200257.E12090@athlon.random> <200107281902.XAA16831@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107281902.XAA16831@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Jul 28, 2001 at 11:02:07PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 11:02:07PM +0400, kuznet@ms2.inr.ac.ru wrote:
> F.e. Andrea, teach me how to make the following thing (not for released
> kernel, for me): I want to schedule softirq, but I do not want that
> this softirq eat all the cpu. It looks natural to use ksoftirqd for this.

yes, ksoftirqd should just avoid you to eat all the cpu even if you keep
posting the softirq all the time. ksoftirqd is reniced at +20 so it
should be pretty nice with the other tasks in the system.

If you want to delay the softirq and run it at a low frequency then you
should use a timer or another functionality (the softirq is required to
run ASAP always).

I hope I didn't misunderstood the question in such case please correct
me.

Andrea

PS. I will be offline shortly so I may not be able to answer further
emails until Monday.
