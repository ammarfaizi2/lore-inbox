Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269392AbRGaSJz>; Tue, 31 Jul 2001 14:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbRGaSJg>; Tue, 31 Jul 2001 14:09:36 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:6927 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269390AbRGaSJd>;
	Tue, 31 Jul 2001 14:09:33 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107311808.WAA08841@ms2.inr.ac.ru>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
To: mingo@redhat.com (Ingo Molnar)
Date: Tue, 31 Jul 2001 22:08:41 +0400 (MSK DST)
Cc: torvalds@transmeta.com, andrea@suse.de, maxk@qualcomm.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <Pine.LNX.4.33.0107301444430.28294-100000@devserv.devel.redhat.com> from "Ingo Molnar" at Jul 30, 1 02:50:21 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> nope. i observed latency issues with restart + ksoftirqd as well.

Ingo, what is impact on total performance yet?

Just to remind: simple constantation of the fact that "latency is bad"
still does not imply that dead loops are inevitable.
We really could try to complicate policing of softirqs (f.e. counting cycles
on them and breaking loop with falling to ksoftirqd after it preempts
threads for more than some threshold). But it is still not clear
that it is worth to do. If you see an impact, let's try this way.

Probably, priority on ksoftirqd should be tuned. Seems, it still
should have high priority, a bit less than real-time.

Alexey
