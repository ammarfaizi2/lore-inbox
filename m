Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129964AbRBEUDb>; Mon, 5 Feb 2001 15:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbRBEUDM>; Mon, 5 Feb 2001 15:03:12 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:23793 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S129964AbRBEUDE>; Mon, 5 Feb 2001 15:03:04 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Robert Guerra" <rob_guerra@usa.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
Date: Mon, 5 Feb 2001 12:03:03 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKOEPFNHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010205043355.12353.qmail@nwcst276.netaddress.usa.net>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David,

>     please try to reply courteously to queries by other people.
> And specially
> when you're the one who's wrong. Mohit is right - Linux had a
> long standing problem where sched_yield() system call didn't work. It
> was only fixed in Linux 2.4.

	Didn't work in accordance with what standard? I just checked SuSv2, and it
appears to me that a 'sched_yield' that had no user-visible affects would be
fully compliant.

> > > Also, it is NOT unrealistic to expect perfect alternation.
> >
> >	Find one pthreads expert who agrees with this claim. Post it to
> > comp.programming.threads and let the guys who created the standard
> > laugh at you. Scheduling is not a substitute for synchronization, ever.
>
> I don't claim mastery over threads. But I have been programming
> with threads
> for a very long time and am well aware of the way OS schedulers
> work. In the example that Mohit posted, it is reasonable to expect
> perfect alternation once both threads have started. And it certainly isn't
> something to laugh at (even if it were wrong).

	No, it is completely unreasonable to expect the scheduler to provide
perfect thread synchronization. Implementations that provide threads in user
space may easily be able to provide this, but implementations of kernel
threads will not have it so easy.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
