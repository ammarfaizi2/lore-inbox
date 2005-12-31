Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVLaINk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVLaINk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 03:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVLaINk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 03:13:40 -0500
Received: from mail.gmx.net ([213.165.64.21]:32204 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751312AbVLaINj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 03:13:39 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 31 Dec 2005 09:13:24 +0100
To: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <20051230145221.301faa40@localhost>
References: <200512281027.00252.kernel@kolivas.org>
 <20051227190918.65c2abac@localhost>
 <20051227224846.6edcff88@localhost>
 <200512281027.00252.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0550-0, 12/10/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:52 PM 12/30/2005 +0100, Paolo Ornati wrote:
>WAS: [SCHED] Totally WRONG prority calculation with specific test-case
>(since 2.6.10-bk12)
>http://lkml.org/lkml/2005/12/27/114/index.html
>
>On Wed, 28 Dec 2005 10:26:58 +1100
>Con Kolivas <kernel@kolivas.org> wrote:
>
> > The issue is that the scheduler interactivity estimator is a state 
> machine and
> > can be fooled to some degree, and a cpu intensive task that just 
> happens to
> > sleep a little bit gets significantly better priority than one that is 
> fully
> > cpu bound all the time. Reverting that change is not a solution because it
> > can still be fooled by the same process sleeping lots for a few seconds 
> or so
> > at startup and then changing to the cpu mostly-sleeping slightly 
> behaviour.
> > This "fluctuating" behaviour is in my opinion worse which is why I removed
> > it.
>
>Trying to find a "as simple as possible" test case for this problem
>(that I consider a BUG in priority calculation) I've come up with this
>very simple program:
>
>------ sched_fooler.c -------------------------------

Ingo seems to have done something in 2.6.15-rc7-rt1 which defeats your 
little proggy.  Taking a quick peek at the rt scheduler changes, nothing 
poked me in the eye, but by golly, I can't get this kernel to act up, 
whereas 2.6.14-virgin does.

         -Mike  (off to stare harder rt patch) 

