Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbQLPBGW>; Fri, 15 Dec 2000 20:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130245AbQLPBGM>; Fri, 15 Dec 2000 20:06:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3851 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130204AbQLPBGD>; Fri, 15 Dec 2000 20:06:03 -0500
Subject: Re: lock_kernel() / unlock_kernel inconsistency Don't do this!
To: george@mvista.com (george anzinger)
Date: Sat, 16 Dec 2000 00:37:53 +0000 (GMT)
Cc: jwohlgem@mindspring.com (Jason Wohlgemuth), linux-kernel@vger.kernel.org
In-Reply-To: <3A3AB515.26227812@mvista.com> from "george anzinger" at Dec 15, 2000 04:19:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1475MO-00026g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Both of these methods have problems, especially with the proposed
> preemptions changes.  The first case causes the thread to run with the
> BKL for the whole time.  This means that any other task that wants the
> BKL will be blocked.  Surly the needed protections don't require this. 

The BKL is dropped on rescheduling of that task. Its an enforcement of the
old unix guarantees against other code making the same assumptions. Its also
the standard 2.4 locking for several things still


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
