Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270986AbTHLSUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270987AbTHLSUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:20:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:62865 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270986AbTHLSUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:20:31 -0400
Message-Id: <5.2.1.1.2.20030812193758.0197b9c0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 12 Aug 2003 20:24:41 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
Cc: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200308130040.50090.kernel@kolivas.org>
References: <3F38FCBA.1000008@rogers.com>
 <3F22F75D.8090607@rogers.com>
 <200307292246.36808.kernel@kolivas.org>
 <3F38FCBA.1000008@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:40 AM 8/13/2003 +1000, Con Kolivas wrote:
>On Wed, 13 Aug 2003 00:42, gaxt wrote:
> > Photoshop 6 (yes, legal owned version) in wine is flawless (as it was
> > with 2.6.0-test3)
> >
> > Galciv plays videos quite smoothly but as soon as I run it it will
> > freeze the cursor for 12-15 seconds every half-minute or so even within
> > the game itself which is turn-based strategy without a lot of whizbang
> > stuff. In the past, the videos would stutter but the game would not
> > suffer from more than short pauses now and then.
>
>Yes, herein lies one of those mysteries that still eludes me but I have been
>investigating it. I can now reproduce in other applications what appears to
>be the problem - Two cpu hogs, X and evolution for example are running and
>evolution is making X the cpu hog. The problem is that X gets demoted whereas
>evolution doesn't. Strangely, dropping evolution to nice +1 or making X -1
>seems to change which one gets demoted, and X is now much smoother. I assume
>the same thing is happening here between wine and wineserver, which is why
>you've seen reversal of priorities in your previous posts. See if renicing
>one of them +1 helps for the time being. I will continue investigating to
>find out why the heck this happens and try and fix it.
>
>Con
>
>P.S. I've cc'ed MG because he has seen the scheduler do other forms of
>trickery and may have thoughts on why this happens.

That sounds suspiciously similar to my scenario, but mine requires a third 
element to trigger.

<scritch scritch scritch>

What about this?  In both your senario and mine, X is running low on cash 
while doing work at the request of a client right?  Charge for it.  If X is 
lower on cash than the guy he's working for, pick the client's pocket... 
take the remainder of your slice from his sleep_avg for your trouble.  If 
you're not in_interrupt(), nothing's free.  Similar to Robinhood, but you 
take from the rich, and keep it :)  He's probably going straight to the 
bank after he wakes you anyway, so he likely won't even miss it.  Instead 
of backboost of overflow, which can cause nasty problems, you could try 
backtheft.

         -Mike 

