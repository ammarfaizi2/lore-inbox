Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129582AbQKIBTg>; Wed, 8 Nov 2000 20:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129688AbQKIBTZ>; Wed, 8 Nov 2000 20:19:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24458 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129582AbQKIBTN>;
	Wed, 8 Nov 2000 20:19:13 -0500
Date: Wed, 8 Nov 2000 17:04:34 -0800
Message-Id: <200011090104.RAA17535@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: mkravetz@sequent.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20001108151148.B25050@w-mikek.des.sequent.com> (message from
	Mike Kravetz on Wed, 8 Nov 2000 15:11:49 -0800)
Subject: Re: test9: running tasks not in run-queue
In-Reply-To: <20001108151148.B25050@w-mikek.des.sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 8 Nov 2000 15:11:49 -0800
   From: Mike Kravetz <mkravetz@sequent.com>

   The following code in __wake_up_common() is then
   executed:

	   if (best_exclusive)
		   best_exclusive->state = TASK_RUNNING;
	   wq_write_unlock_irqrestore(&q->lock, flags);

test10 fixes this error, now it sets TASK_RUNNING and
adds the task back to the runqueue all under the runqueue
lock.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
