Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264084AbRFETGP>; Tue, 5 Jun 2001 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264082AbRFETFz>; Tue, 5 Jun 2001 15:05:55 -0400
Received: from cs.huji.ac.il ([132.65.16.10]:16101 "EHLO cs.huji.ac.il")
	by vger.kernel.org with ESMTP id <S264081AbRFETFu>;
	Tue, 5 Jun 2001 15:05:50 -0400
Date: Tue, 5 Jun 2001 22:05:47 +0300 (IDT)
From: Tsafrir Dan <dants@cs.huji.ac.il>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: linux-kernel@vger.kernel.org, feit@cc.huji.ac.il, etsman@cs.huji.ac.il,
        dants@cs.huji.ac.il
Subject: Re: the value of PROC_CHANGE_PENALTY
In-Reply-To: <Pine.LNX.4.10.10106042004010.8516-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.10.10106051957330.20547-100000@pomela4.cs.huji.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Jun 2001, Mark Hahn wrote:

> > am I correct ?
> > and if so, is this what the authors meant, or did they simply forget
> > to update PROC_CHANGE_PENALTY's value when moving from 2.2 to 2.4 ?
>
> I don't believe anyone has proposed a relation between nice
> and cpu-affinity; the latter has always been a fairly arbitrary 
> constant.

I see, but even so, in linux-2.2 this arbitrary constant allows a non
realtime task to migrate, and totally prohibits it in linux-2.4 (unless
some other cpu is idle).
i.e. maybe there is no relation between the max value of the static 
priority and PROC_CHANGE_PENALTY, but you get a scheduler that behaves
quite differently when you change one without the other.

I think that if it's indeed an arbitrary value, then it should have 
been modified along with the modification of the quantum's length,
because this way the 2.2 behavior (which I assume somebody adopted for
a reason) would have remained the same.

However, if you say that PROC_CHANGE_PENALTY does somehow embody the
cpu-time wasted because of migration (due to cache etc.) regardless of
the quantum's length, then PROC_CHANGE_PENALTY should probably remain 
the same and I got my answer.

Is this what you mean ?

thanks, Dan.


