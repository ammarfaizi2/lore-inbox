Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289718AbSAJV52>; Thu, 10 Jan 2002 16:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289716AbSAJV5S>; Thu, 10 Jan 2002 16:57:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44749 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289774AbSAJV5C>;
	Thu, 10 Jan 2002 16:57:02 -0500
Date: Fri, 11 Jan 2002 00:54:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mike Kravetz <kravetz@us.ibm.com>, Anton Blanchard <anton@samba.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <3C3DF575.7ABDC213@mvista.com>
Message-ID: <Pine.LNX.4.33.0201110052240.10579-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, george anzinger wrote:

> Currently this code is called from the interrupt code in timer.  At
> this time the xtime(write) lock is held and interrupts are off.

yes, Linus is right - i've introduced a scheduler_tick() function which is
called with interrupts disabled - thus no __save_flags is needed.

	Ingo

