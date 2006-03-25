Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWCYJQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWCYJQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 04:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWCYJQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 04:16:00 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:4058 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751117AbWCYJQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 04:16:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [ck] [benchmark] Interbench 2.6.16-ck/mm
Date: Sat, 25 Mar 2006 20:15:36 +1100
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org,
       "=?iso-8859-1?q?Andr=E9_Goddard?= Rosa" <andre.goddard@gmail.com>,
       linux list <linux-kernel@vger.kernel.org>
References: <200603251351.57341.kernel@kolivas.org> <200603251928.39190.kernel@kolivas.org> <200603250946.42867.astralstorm@gorzow.mm.pl>
In-Reply-To: <200603250946.42867.astralstorm@gorzow.mm.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603252015.37219.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 19:46, Radoslaw Szkodzinski wrote:
> On Saturday 25 March 2006 09:28, Con Kolivas wrote yet:
> > On Saturday 25 March 2006 19:21, Radoslaw Szkodzinski wrote:
> > > On Saturday 25 March 2006 05:01, Con Kolivas wrote yet:
> > > > I don't expect that staircase will be better in every single
> > > > situation. However it will be better more often, especially when it
> > > > counts (like audio or video skipping) and far more predictable. All
> > > > that in 300 lines less code :)
> > >
> > > I thinks the main difference is those other scheduler improvements.
> > > Some of them are compatible with staircase.
> > > Could you also try a mixed and matched 2.6.16-ck1+mm?
> >
> > You're kidding, right? Check the code.
>
> Yes and no. I was kidding about "scheduler improvements" part.
> (they're mostly NUMA-only)
>
> But of course memload, read and write latencies aren't necessarily caused
> by scheduler itself.
> (burn also reads a file)
>
> The easiest thing to do would be to add staircase to -mm and see what
> happens. It shouldn't be hard to port. (in fact, it may apply cleanly)

Yes it would be nice to believe that taking some -mm components into -ck would 
actually make -ck better than everything across the board. However the policy 
changes that make up staircase are not compatible with most other changes in 
-mm, and most of the differences are due to the difference between the 
mainline scheduler and staircase. There are some vm tweaks and the like in 
-ck which only show up when you nice things though and that would improve the 
results if we were comparing different nice values on interbench. 
Furthermore,  Mike's changes that Andre tested only worsen interbench results 
so they would make staircase/ck look even better than -mm than it currently 
does. Some of the things Andre found better on -mm with Mike's changes may 
well be fairness related because staircase is more effective at maintaining 
fairness than mainline without any special throttling.

Cheers,
Con
