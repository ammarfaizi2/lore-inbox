Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278940AbRJaBdK>; Tue, 30 Oct 2001 20:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278892AbRJaBdA>; Tue, 30 Oct 2001 20:33:00 -0500
Received: from mel-rti21.wanadoo.fr ([193.252.19.94]:61321 "EHLO
	mel-rti21.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278940AbRJaBcv>; Tue, 30 Oct 2001 20:32:51 -0500
Date: Wed, 31 Oct 2001 02:27:31 +0100 (CET)
From: Pascal Lengard <pascal.lengard@wanadoo.fr>
X-X-Sender: <plg@co2.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Samuli Suonpaa <suonpaa@iki.fi>, <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken ?
In-Reply-To: <E15yXjJ-0006Hr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110310208410.2024-100000@co2.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Alan Cox wrote:

> > I, byt the way, had my Latitude suspend perfectly with 2.4.12-ac5.
> > Now, with 2.4.13-ac[34] pressing Fn+Suspend just blanks the screen (it
> > doesn't shut it off, _just_ blanks it) and hangs the machine.
> > 
> > Any ideas on how to proceed in order to find out where the problem
> > lies?
> 
> Find exactly which -ac it broke in. If you do a binary search through a few
> patch levels you should be able to pin it down. At that point I can chase it

I tested "plain" 2.4.12 from Linus and it suffer the same problem.
Pressing Fn+Suspend does nothing on my Dell Latitude C600, so I thought
it would not be usefull to test against 2.4.12-ac. Tell me if I am plain
wrong on this, otherwise, I guess my problem is not exactly the same than 
Samuli Suonpaa's.

>From the last thread on this subject, I could narrow down the problem
between 2.4.9 (working) and 2.4.10 (broken), so I did not test against -ac.
I rather tested against 2.4.10-preXX. I hope this is not a problem.

Sumary:
-------
Hardware: Dell Latitude C600
When apm is broken, pressing Fn+Suspend does nothing and launching "apm -s"
returns "apm: Resource temporarily unavailable".

2.4.9 ==> apm works
2.4.10-pre8 ==> apm works
2.4.10-pre10 ==> apm works
2.4.10-pre11 ==> apm works
2.4.10-pre12 ==> apm broken
2.4.10 ==> apm broken
2.4.12 ==> apm broken 
2.4.13 ==> apm broken

The problem appeared in 2.4.10-pre12. I read the Changelog but it is not 
precise enough for me :-), I started to diff between pre11 and pre12 but
I need a sleep now ... I already compiled to much kernels for tonight !

I am ready to test other things if I can help on this issue.
Where could I get patches between pre11 and pre12 in small chunks to start
some experimentation ?

Pascal

