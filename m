Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUINEWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUINEWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 00:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUINEWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 00:22:12 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:4418 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268890AbUINEVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 00:21:13 -0400
Message-ID: <7798951e040913212154d3b3f9@mail.gmail.com>
Date: Mon, 13 Sep 2004 23:21:05 -0500
From: hotdog day <hotdogday@gmail.com>
Reply-To: hotdog day <hotdogday@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.9-rc2 and Hyperthreading. (SMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41465244.9010603@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7798951e04091317273b1bed29@mail.gmail.com>
	 <41465244.9010603@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turning off CONFIG_SCHED_SMT has apparently fixed the issue. 

Three Q's:

1) Am I taking some kind of performance hit by doing this?

2) Is this something we can look forward to seeing fixed?

3) Do you need any info from me to help you?

Thanks,

Troy McFerron


On Tue, 14 Sep 2004 12:07:00 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
> hotdog day wrote:
> > I have been testing the 2.6.9-rc1, and 2.6.9-rc2 kernel patches over
> > the past couple days and have been having some issues with
> > hyperthreading (SMT) turned on.
> >
> > This problem first exhibited itself when I was testing
> > 2.6.9-rc2-mm2-love2. I noticed the following quirks that ONLY show
> > themselves with hyperthreading enabled on my 3.0C Pentium 4.
> >
> > Random HARD LOCKS. No messages from the kernel. Just a good swift hard lock.
> >
> > Hard locks when mounting two cdrom drives in quick succession.
> >
> > Turning off hyperthreading solves these issues.  Going back to 2.6.8.1
> > solves these issues.
> >
> > I then tried 2.6.9-rc1 with no mm or love patches. I had the exact same issues.
> >
> > Today I downloaded the prepatch to 2.6.9-rc2 and applied it to clean
> > 2.6.8 source. The issues are still there.
> >
> > I hope someone is paying attention to the way scheduler tweaks and
> > changes are affecting SMT enabled kernels. I don't think anyone wants
> > to disable features of their hardware in order to run an optimized
> > scheduler.
> 
> Try turning off CONFIG_SCHED_SMT and see how you go. Thanks.
>
