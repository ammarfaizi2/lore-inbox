Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286358AbSAMQLd>; Sun, 13 Jan 2002 11:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286365AbSAMQLW>; Sun, 13 Jan 2002 11:11:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23683 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286358AbSAMQLT>;
	Sun, 13 Jan 2002 11:11:19 -0500
Date: Sun, 13 Jan 2002 19:08:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "James C. Owens" <owensjc@bellatlantic.net>
Cc: "'Matti Aarnio'" <matti.aarnio@zmailer.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice macros
In-Reply-To: <000001c19bb7$20756710$0100a8c0@jcowens.net>
Message-ID: <Pine.LNX.4.33.0201131907460.5526-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Jan 2002, James C. Owens wrote:

> Point well made. How about
>
> #define PRIO_TO_TIMESLICE(p) \
>   (MAX_TIMESLICE -
> ((USER_PRIO(p)*(MAX_TIMESLICE-MIN_TIMESLICE))/(MAX_USER_PRIO-1)))
>
> #define RT_PRIO_TO_TIMESLICE(p) \
>   (MAX_TIMESLICE - ((p*(MAX_TIMESLICE-MIN_TIMESLICE))/(MAX_RT_PRIO-1)))

the macros are still not equivalent. Try HZ = 100 and nice == -17 for
example.

	Ingo

