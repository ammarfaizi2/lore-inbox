Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267000AbRG1TCu>; Sat, 28 Jul 2001 15:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbRG1TCa>; Sat, 28 Jul 2001 15:02:30 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:27652 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S266989AbRG1TCW>;
	Sat, 28 Jul 2001 15:02:22 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107281902.XAA16831@ms2.inr.ac.ru>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 28 Jul 2001 23:02:07 +0400 (MSK DST)
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        mingo@redhat.com, davem@redhat.com
In-Reply-To: <20010728200257.E12090@athlon.random> from "Andrea Arcangeli" at Jul 28, 1 08:02:57 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> cpu_raise_softirq is valid in any context. calling cpu_raise_softirq
> there was correct (__cpu_raise_softirq would been too weak).

I see now, the picture clears.


> fix the tasklet problem (only tasklets had a problem in 2.4.7).

I said the problem was not in code. In understanding this.
I am still not 100% sure what is legal, what is not. :-)

F.e. Andrea, teach me how to make the following thing (not for released
kernel, for me): I want to schedule softirq, but I do not want that
this softirq eat all the cpu. It looks natural to use ksoftirqd for this.

Alexey
