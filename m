Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUINFoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUINFoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268524AbUINFoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:44:20 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:49370 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268092AbUINFoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:44:16 -0400
Message-ID: <7798951e040913224462ea2243@mail.gmail.com>
Date: Tue, 14 Sep 2004 00:44:07 -0500
From: hotdog day <hotdogday@gmail.com>
Reply-To: hotdog day <hotdogday@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 and Hyperthreading. (SMT)
In-Reply-To: <7798951e04091322402fe830ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7798951e04091317273b1bed29@mail.gmail.com>
	 <41465244.9010603@yahoo.com.au>
	 <7798951e040913212154d3b3f9@mail.gmail.com>
	 <7798951e04091322402fe830ff@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have any other suggestions on this issue? I know others
who are experincing the same thing.


On Tue, 14 Sep 2004 00:40:57 -0500, hotdog day <hotdogday@gmail.com> wrote:
> Actually, it just hardlocked again. Is there anything else that could
> be done, or am I stuck without SMP?
> 
> 
> 
> 
> On Mon, 13 Sep 2004 23:21:05 -0500, hotdog day <hotdogday@gmail.com> wrote:
> > Turning off CONFIG_SCHED_SMT has apparently fixed the issue.
> >
> > Three Q's:
> >
> > 1) Am I taking some kind of performance hit by doing this?
> >
> > 2) Is this something we can look forward to seeing fixed?
> >
> > 3) Do you need any info from me to help you?
> >
> > Thanks,
> >
> > Troy McFerron
> >
> >
> >
> >
> > On Tue, 14 Sep 2004 12:07:00 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > >
> > >
> > > hotdog day wrote:
> > > > I have been testing the 2.6.9-rc1, and 2.6.9-rc2 kernel patches over
> > > > the past couple days and have been having some issues with
> > > > hyperthreading (SMT) turned on.
> > > >
> > > > This problem first exhibited itself when I was testing
> > > > 2.6.9-rc2-mm2-love2. I noticed the following quirks that ONLY show
> > > > themselves with hyperthreading enabled on my 3.0C Pentium 4.
> > > >
> > > > Random HARD LOCKS. No messages from the kernel. Just a good swift hard lock.
> > > >
> > > > Hard locks when mounting two cdrom drives in quick succession.
> > > >
> > > > Turning off hyperthreading solves these issues.  Going back to 2.6.8.1
> > > > solves these issues.
> > > >
> > > > I then tried 2.6.9-rc1 with no mm or love patches. I had the exact same issues.
> > > >
> > > > Today I downloaded the prepatch to 2.6.9-rc2 and applied it to clean
> > > > 2.6.8 source. The issues are still there.
> > > >
> > > > I hope someone is paying attention to the way scheduler tweaks and
> > > > changes are affecting SMT enabled kernels. I don't think anyone wants
> > > > to disable features of their hardware in order to run an optimized
> > > > scheduler.
> > >
> > > Try turning off CONFIG_SCHED_SMT and see how you go. Thanks.
> > >
> >
>
