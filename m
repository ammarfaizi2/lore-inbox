Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRKHSnR>; Thu, 8 Nov 2001 13:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277533AbRKHSnI>; Thu, 8 Nov 2001 13:43:08 -0500
Received: from posta2.elte.hu ([157.181.151.9]:19433 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S277431AbRKHSm6>;
	Thu, 8 Nov 2001 13:42:58 -0500
Date: Thu, 8 Nov 2001 20:40:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <Pine.LNX.4.40.0111080954350.1501-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0111082028430.20248-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Davide Libenzi wrote:

> It sets the time ( in jiffies ) at which the process won't have any
> more scheduling advantage.

(sorry, it indeed makes sense, since sched_jtime is on the order of
jiffies.)

> > and your patch adds a scheduling advantage to processes with more cache
> > footprint, which is the completely opposite of what we want.
>
> It is exactly what we want indeed :

if this is what is done by your patch, then we do not want to do this.
My patch does not give an advantage of CPU-intensive processes over that
of eg. 'vi'. Perhaps i'm misreading your patch, it's full of branches that
does not make the meaning very clear, cpu_jtime and sched_jtime are not
explained. Is sched_jtime the timestamp of the last schedule of this
process? And is cpu_jtime the number of jiffies spent on this CPU? Is
cpu_jtime cleared if we switch to another CPU?

	Ingo


