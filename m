Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288002AbSAHMhn>; Tue, 8 Jan 2002 07:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287995AbSAHMhe>; Tue, 8 Jan 2002 07:37:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60840 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286488AbSAHMhX>;
	Tue, 8 Jan 2002 07:37:23 -0500
Date: Tue, 8 Jan 2002 15:34:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <20020108114355.GA25718@krispykreme>
Message-ID: <Pine.LNX.4.33.0201081533270.7255-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Jan 2002, Anton Blanchard wrote:

> > -	char bitmap[BITMAP_SIZE];
> > +	unsigned long bitmap[3];
> >  	list_t queue[MAX_PRIO];
>
> Sorry, of course this is wrong if sizeof(unsigned long) < 64. But you
> get the idea :)

thanks, i've put the generic fix into the -E1 patch.

> With the patch things look much better (and the kernel boots on my
> ppc64 machine :)

hey it should not even compile, you forgot to send us the PPC definition
of sched_find_first_zero_bit() ;-)

	Ingo

