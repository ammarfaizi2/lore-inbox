Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318514AbSIBVkZ>; Mon, 2 Sep 2002 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSIBVkY>; Mon, 2 Sep 2002 17:40:24 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:49552 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318487AbSIBVkV>; Mon, 2 Sep 2002 17:40:21 -0400
Date: Mon, 2 Sep 2002 23:44:46 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209021538070.7718-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0209022322230.11866-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002, Tobias Ringstrom wrote:

> On 2 Sep 2002, Alan Cox wrote:
> 
> > It isnt a regression, its a bug fix. The nice value is now being
> > honoured properly.
> 
> The problem is that the kernel decided to nice the process (by changing
> the priority, not the nice value) as if it was a background task, but it's
> not a background task.  On the contrary, it's highly interactive.

I think I will have to take this back.  It looks like even the old kernel
treats the game server as a background process, but as you said, it does
not make such a big difference.  Another change is that the prio value 
varies very quickly over time (as seen in top).  I do not recall seeing 
that using the O(1)-scheduler.

But I still do not understand why the process is classified as
non-interactive...  Around 20 times per second it does a nanosleep for
1 ms which takes around 40 ms in reality.  (Seeing this makes me believe 
that I should try to increase HZ, but that is a separate issue.)

/Tobias


