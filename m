Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWGYS00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWGYS00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWGYS00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:26:26 -0400
Received: from [212.76.91.144] ([212.76.91.144]:56840 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751466AbWGYS0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:26:25 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
Date: Tue, 25 Jul 2006 21:27:14 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607241857.52389.a1426z@gawab.com> <200607250757.10722.a1426z@gawab.com> <44C5AFC3.4020405@bigpond.net.au>
In-Reply-To: <44C5AFC3.4020405@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607252127.14024.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > Peter Williams wrote:
> >> Al Boldi wrote:
> >>> Peter Williams wrote:
> >>>> This version removes the hard/soft CPU rate caps from the SPA
> >>>> schedulers.
> >>>>
> >>>> A patch for 2.6.18-rc2 is available at:
> >>>>
> >>>> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.4-for-2.6.18-rc
> >>>>2. pat ch?download>
> >>>>
> >>>> Very Brief Documentation:
> >>>>
> >>>> You can select a default scheduler at kernel build time.  If you wish
> >>>> to boot with a scheduler other than the default it can be selected at
> >>>> boot time by adding:
> >>>>
> >>>> cpusched=<scheduler>
> >>>
> >>> Any reason dynsched couldn't be merged with plugsched?
> >>
> >> None that I know of (but I'm not familiar with dynsched).  Patches to
> >> add it to the mix would be accepted and once in I would try to keep it
> >> in step with kernel changes.
> >
> > I thought dynsched patches against plugsched, what else is needed?
>
> Hopefully, nothing but it may be necessary to modify the plugsched
> interface if dynsched can't be implemented against it "as is".  E.g.
> both staircase and nicksched needed changes to what was required for
> ingosched and the SPA schedulers.
>
> >>>> to the boot command line where <scheduler> is one of: ingosched,
> >>>> ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr,
> >>>> spa_ebs or zaphod.  If you don't change the default when you build
> >>>> the kernel the default scheduler will be ingosched (which is the
> >>>> normal scheduler).
> >>>>
> >>>> The scheduler in force on a running system can be determined by the
> >>>> contents of:
> >>>>
> >>>> /proc/scheduler
> >>>
> >>> It may be really great, to allow schedulers perPid parent, thus
> >>> allowing the stacking of different scheduler semantics.  This could
> >>> aid flexibility a lot.
> >>
> >> I'm don't understand what you mean here.  Could you elaborate?
> >
> > i.e:  Boot the kernel with spa_no_frills, then start X with spa_ws.
>
> It's probably not a good idea to have different schedulers managing the
> same resource.  The way to do different scheduling per process is to use
> the scheduling policy mechanism i.e. SCHED_FIFO, SCHED_RR, etc.
> (possibly extended) within each scheduler.  On the other hand, on an SMP
> system, having a different scheduler on each run queue (or sub set of
> queues) might be interesting :-).  

What's wrong with multiple run-queues on UP?

> The schedulers would probably have to
> have a common idea of how the run queue works though and this would
> restrict the choice of schedulers.

Probably.

> I have no intentions (at the moment) of going down this path myself.
>
> However, I am thinking about making it possible to switch between the
> various SPA schedulers on a running system.  A extension to this could
> be to attempt automatic selection of which scheduler to use possibly
> based on which users are logged in.

Thanks a lot!

--
Al

