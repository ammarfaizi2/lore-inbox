Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130682AbQI3QVV>; Sat, 30 Sep 2000 12:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129382AbQI3QVM>; Sat, 30 Sep 2000 12:21:12 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:59908 "HELO ms2.inr.ac.ru") by vger.kernel.org with SMTP id <S129113AbQI3QU4>; Sat, 30 Sep 2000 12:20:56 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200009301605.UAA30636@ms2.inr.ac.ru>
Subject: Re: Bottom Handles/soft irqs/timer interrupts/SMP .....
To: anton@linuxcare.com (Anton Blanchard)
Date: Sat, 30 Sep 2000 20:05:44 +0400 (MSK DST)
Cc: quintela@fi.udc.ES, linux-kernel@vger.kernel.org
In-Reply-To: <20000929234157.A3637@linuxcare.com> from "Anton Blanchard" at Sep 29, 0 11:41:57 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The slab code was using smp_call_function until davem fixed it.
>
> On sparc blocking interrupts does not block the reception of cpu cross
> calls, so you cannot do anything like grab locks within a called function.

Funny, are IPI really absolute nmi on sparc? I am honestly curious,
for what purpose such IPIs were designed. Theay do not look useful.

The fix is worth than problem was in any case. Waiting for timer
under semaphore is not a good idea.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
