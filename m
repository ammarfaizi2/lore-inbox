Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUIOBMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUIOBMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUIOBMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:12:06 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:40670 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S266733AbUIOBLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:11:18 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: hotdog day <hotdogday@gmail.com>
Date: Wed, 15 Sep 2004 11:11:14 +1000
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 and Hyperthreading. (SMT)
Message-ID: <20040915011114.GA3195@cse.unsw.EDU.AU>
Mail-Followup-To: hotdog day <hotdogday@gmail.com>,
	linux-kernel@vger.kernel.org
References: <7798951e04091317273b1bed29@mail.gmail.com> <41465244.9010603@yahoo.com.au> <7798951e040913212154d3b3f9@mail.gmail.com> <7798951e04091322402fe830ff@mail.gmail.com> <7798951e040913224462ea2243@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7798951e040913224462ea2243@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, hotdog day wrote:

> Does anyone have any other suggestions on this issue? I know others
> who are experincing the same thing.
> 
> 
> On Tue, 14 Sep 2004 00:40:57 -0500, hotdog day <hotdogday@gmail.com> wrote:
> > Actually, it just hardlocked again. Is there anything else that could
> > be done, or am I stuck without SMP?
> > 
> > 
> > 
> > 
> > On Mon, 13 Sep 2004 23:21:05 -0500, hotdog day <hotdogday@gmail.com> wrote:
> > > Turning off CONFIG_SCHED_SMT has apparently fixed the issue.
> > >
> > > Three Q's:
> > >
> > > 1) Am I taking some kind of performance hit by doing this?
> > >
> > > 2) Is this something we can look forward to seeing fixed?
> > >
> > > 3) Do you need any info from me to help you?
> > >
> > > Thanks,
> > >
> > > Troy McFerron
> > >
> > >
> > >
> > >
> > > On Tue, 14 Sep 2004 12:07:00 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > > >
> > > >
> > > > hotdog day wrote:
> > > > > I have been testing the 2.6.9-rc1, and 2.6.9-rc2 kernel patches over
> > > > > the past couple days and have been having some issues with
> > > > > hyperthreading (SMT) turned on.
I have tested 2.6.9-rc2 on a 3.0 Ghz HT and all seams OK, results of LTP
message, and meminfo at:
http://quasar.cse.unsw.edu.au/~dsw/public-files/x86

Not extensive though no lockups and left running overnight.

> > > > >
> > > > > This problem first exhibited itself when I was testing
> > > > > 2.6.9-rc2-mm2-love2. I noticed the following quirks that ONLY show
> > > > > themselves with hyperthreading enabled on my 3.0C Pentium 4.
> > > > >
> > > > > Random HARD LOCKS. No messages from the kernel. Just a good swift hard lock.
> > > > >
> > > > > Hard locks when mounting two cdrom drives in quick succession.
I'll try this tonight.

> > > > >
> > > > > Turning off hyperthreading solves these issues.  Going back to 2.6.8.1
> > > > > solves these issues.
> > > > >
> > > > > I then tried 2.6.9-rc1 with no mm or love patches. I had the exact same issues.
> > > > >
> > > > > Today I downloaded the prepatch to 2.6.9-rc2 and applied it to clean
> > > > > 2.6.8 source. The issues are still there.
> > > > >
> > > > > I hope someone is paying attention to the way scheduler tweaks and
> > > > > changes are affecting SMT enabled kernels. I don't think anyone wants
> > > > > to disable features of their hardware in order to run an optimized
> > > > > scheduler.
> > > >
> > > > Try turning off CONFIG_SCHED_SMT and see how you go. Thanks.
> > > >
> > >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
