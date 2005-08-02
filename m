Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVHBLcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVHBLcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVHBLcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:32:12 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:47272 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261505AbVHBLbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:31:52 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 2 Aug 2005 04:31:38 -0700
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Message-ID: <20050802113137.GK15903@atomide.com>
References: <200508021443.55429.kernel@kolivas.org> <200508021739.20347.kernel@kolivas.org> <20050802081512.GI15903@atomide.com> <200508022054.22276.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508022054.22276.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [050802 03:54]:
> On Tue, 2 Aug 2005 18:15, Tony Lindgren wrote:
> > * Con Kolivas <kernel@kolivas.org> [050802 00:36]:
> > > On Tue, 2 Aug 2005 05:17 pm, Tony Lindgren wrote:
> > > > But this you can verify by booting to single user mode and then running
> > > > pmstats 5, and if ticks is not below 25HZ, there's something in the
> > > > kernel polling.
> > >
> > > I'm removing modules and they don't seem to do anything so I'm not sure
> > > what else to try.
> >
> > If you have 130HZ in single user mode, it's some kernel driver.
> > You could printk the the next timer, then grep for that in System.map:
> 
> I kept pulling modules and eventually got to 27Hz so something was definitely 
> happening.

Cool.

> I need to ask you why you think limiting the maximum Hz is a bad idea? On a 
> laptop, say we have set the powersave governor, we have already told the 
> kernel we are interested in maximising power saving at the expense of 
> performance. Would it not be appropriate for this to be linked in a way that 
> sets maximum Hz to some value that maximises power save (whatever that value 
> is) at that time?

With dyntick the system will run at max HZ only when busy. It is possible
that cutting down max HZ might cause some savings while busy, but I would
assume the savings are minimal.

I personally prefer to have the performance available when needed, and
max savings while idle.

Tony
