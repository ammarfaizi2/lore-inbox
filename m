Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKOMJb>; Wed, 15 Nov 2000 07:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbQKOMJV>; Wed, 15 Nov 2000 07:09:21 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:188 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129152AbQKOMJQ>; Wed, 15 Nov 2000 07:09:16 -0500
Message-ID: <3A1275E2.3CD0F192@uow.edu.au>
Date: Wed, 15 Nov 2000 22:39:14 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pawe³ Kot <pkot@linuxnews.pl>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] removal of oops->printk deadlocks
In-Reply-To: <3A1270B9.1A38133@uow.edu.au> <Pine.LNX.4.30.0011151222580.29502-200000@tfuj.ahoj.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pawe³ Kot" wrote:
> 
> In attachment. But don't beat me. I think I found the oops reason.
> /dev/shm was not mounted. After mounting it I couldn't get an oops yet.
> Could this be a reason?

No.

>>EIP; c010b5ee <__read_lock_failed+6/18>   <=====
Trace; c02026f7 <stext_lock+86b/8c14>
Trace; c0120404 <sys_sched_setscheduler+14/18>
                 ^^^^^^^^^^^^^^^^^^^^^^

This was fixed in test11-pre5.   Please retest with that kernel.

Thanks again.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
