Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153945AbQBMHO3>; Sun, 13 Feb 2000 02:14:29 -0500
Received: by vger.rutgers.edu id <S153938AbQBMHN6>; Sun, 13 Feb 2000 02:13:58 -0500
Received: from colorfullife.com ([216.156.138.34]:2904 "EHLO colorfullife.com") by vger.rutgers.edu with ESMTP id <S153901AbQBMHNi>; Sun, 13 Feb 2000 02:13:38 -0500
Message-ID: <38A69235.BDF5C7D2@colorfullife.com>
Date: Sun, 13 Feb 2000 12:15:01 +0100
From: Manfred Spraul <manfreds@colorfullife.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: Q: how can I enumerate all mm_struct
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

How can you enumerate all mm_struct's with the new lazy tlb code? Both
ia64 [arch/ia64/mm/tlb.c] and  ppc [arch/ppc/mm/init.c] assume that

	for_each_task(tsk) {
		do_something(tsk->mm);
	}

will reach all mm_structs, but if a thread is running in temporary lazy
tlb mode {start,end}_lazy_tlb(), then this fails.

Is there another way to enumerate all mm_structs, or should I add a new
double linked list?

--
	Manfred

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
