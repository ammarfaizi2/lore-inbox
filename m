Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSAII2i>; Wed, 9 Jan 2002 03:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289259AbSAII22>; Wed, 9 Jan 2002 03:28:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36529 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289255AbSAII2U>;
	Wed, 9 Jan 2002 03:28:20 -0500
Date: Wed, 9 Jan 2002 11:25:43 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <20020108193904.A1068@w-mikek2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0201091122060.2276-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Jan 2002, Mike Kravetz wrote:

> --------------------------------------------------------------------
> Chat - VolanoMark simulator.  Result is a measure of throughput.
>        Higher is better.

very interesting numbers, nice work Mike! I'd suggest the following
additional test: please also run tests like VolanoMark with 'nice -n 19'.
The O(1) scheduler's task-penalty method works in our favor in this case,
since we know the test is CPU-bound we can move all processes to nice
level 19.

	Ingo

