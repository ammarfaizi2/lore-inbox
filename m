Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030804AbWI0Uze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030804AbWI0Uze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030830AbWI0Uzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:55:33 -0400
Received: from colin.muc.de ([193.149.48.1]:42763 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030804AbWI0Uzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:55:33 -0400
Date: 27 Sep 2006 22:55:31 +0200
Date: Wed, 27 Sep 2006 22:55:31 +0200
From: Andi Kleen <ak@muc.de>
To: john stultz <johnstul@us.ibm.com>
Cc: caglar@pardus.org.tr, Greg Schafer <gschafer@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 Nasty Lockup
Message-ID: <20060927205531.GB36261@muc.de>
References: <20060926123640.GA7826@tigers.local> <200609270015.51465.caglar@pardus.org.tr> <1159311057.17071.5.camel@localhost> <200609271245.39591.caglar@pardus.org.tr> <1159384500.29040.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159384500.29040.3.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 12:14:59PM -0700, john stultz wrote:
> On Wed, 2006-09-27 at 12:45 +0300, S.??a??lar Onur wrote:
> > 27 Eyl 2006 ??ar 01:50 tarihinde, john stultz ??unlar?? yazm????t??: 
> > > On Wed, 2006-09-27 at 00:15 +0300, S.??a??lar Onur wrote:
> > > > 26 Eyl 2006 Sal 15:36 tarihinde, Greg Schafer ??unlar?? yazm????t??:
> > > > > This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> > > > > completely dead machine with only option the reset button. Usually
> > > > > happens within a couple of minutes of desktop use but is 100%
> > > > > reproducible. Problem is still there in a fresh checkout of current
> > > > > Linus git tree (post 2.6.18).
> > > >
> > > > Same symptoms here and its reproducible after starting the irqbalance
> > > > (0.12 or 0.13), if i disable irqbalance then everything is going fine.
> > >
> > > Hmm.. Not sure about the connection to irqbalance. You're using the TSC
> > > clocksource, so I'm curious if your cpu TSC's are out of sync. Can you
> > > boot w/ "clocksource=acpi_pm" to see if that resolves it?
> > 
> > Yep, it solves the problem and system boot normally with irqbalance enabled.
> 
> Ok. Good to hear you have a workaround. Now to sort out why your TSCs
> are becoming un-synced. From the dmesg you sent me privately, I noticed

On Intel it seems to happen when people overclock their systems.

> that while you have 4 cpus, the following message only shows up once:
> 
> ACPI: Processor [CPU1] (supports 8 throttling states)
> 
> Does disabling cpufreq change anything?

Throttling has nothing to do with cpufreq
(at least not until you use the broken P4 throttling cpufreq
driver, which nobody should). It is normally only used when
the CPU overheats.

-Andi

