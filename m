Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEAcj>; Thu, 4 Jan 2001 19:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEAca>; Thu, 4 Jan 2001 19:32:30 -0500
Received: from patan.Sun.COM ([192.18.98.43]:54146 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S129183AbRAEAcV>;
	Thu, 4 Jan 2001 19:32:21 -0500
Message-ID: <3A55170F.7DF3B5F2@sun.com>
Date: Thu, 04 Jan 2001 16:36:32 -0800
From: ludovic fernandez <ludovic.fernandez@sun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@innominate.de>,
        george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <Pine.LNX.4.05.10101041554520.4946-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:

> On Thu, 4 Jan 2001, ludovic fernandez wrote:
> > This is not the point I was trying to make .....
> > So far we are talking about real time behaviour. This is a very interesting/exciting
> > thing and we all agree it's a huge task which goes much more behind
> > just having a preemptive kernel.
>
> You're right that it is more than just a preemptible kernel, but I don't
> agree that it's all that huge.  But this is the third time I have worked
> on enabling real-time behavior in unix-like OSes, so I may be biased ;-)
>
> > I'm not convinced that a preemptive kernel is interesting for apps using
> > the time sharing scheduling, mainly because it is not deterministic and the
> > price of a mmu conntext switch is still way to heavy (that's my 2 cents belief
> > anyway).
>
> But as Roger pointed out, the number of extra context switches
> introduced by having a preemptible kernel is actually very low.  If an
> interrupt occurs while running in user mode, the context switch it may
> cause will happen even in a non-preemptible kernel.  I think that
> running a kernel compile for example, the number of context switches per
> second caused by kernel preemption is probably between 1% and 10% of the
> total context switches per second.  And it's certainly interesting to me
> that I can listen to MP3s without interruption now, while doing a kernel
> build!
>

I agree Nigel, but as you pointed out you will have to deal with
scheduling behaviour, interrupt latency and priority inversion to
achieve that.
I was just trying to point out that just having kernel preemptable threads
will enable, for example, kswapd to adjust itself more efficiently with the
current load of the system and what it needs to achieve (running from
low priority to non preemptable thread). Providing a better (smoother)
swap behaviour.
Saying that, I definitely agree that I want/need to one day listen to
my MP3s while building  my kernel.

Ludo.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
