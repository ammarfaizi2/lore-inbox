Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030654AbWI0TPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030654AbWI0TPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030652AbWI0TPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:15:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:40675 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030654AbWI0TPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:15:10 -0400
Subject: Re: 2.6.18 Nasty Lockup
From: john stultz <johnstul@us.ibm.com>
To: caglar@pardus.org.tr
Cc: Greg Schafer <gschafer@zip.com.au>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
In-Reply-To: <200609271245.39591.caglar@pardus.org.tr>
References: <20060926123640.GA7826@tigers.local>
	 <200609270015.51465.caglar@pardus.org.tr>
	 <1159311057.17071.5.camel@localhost>
	 <200609271245.39591.caglar@pardus.org.tr>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Sep 2006 12:14:59 -0700
Message-Id: <1159384500.29040.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 12:45 +0300, S.Çağlar Onur wrote:
> 27 Eyl 2006 Çar 01:50 tarihinde, john stultz şunları yazmıştı: 
> > On Wed, 2006-09-27 at 00:15 +0300, S.Çağlar Onur wrote:
> > > 26 Eyl 2006 Sal 15:36 tarihinde, Greg Schafer şunları yazmıştı:
> > > > This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> > > > completely dead machine with only option the reset button. Usually
> > > > happens within a couple of minutes of desktop use but is 100%
> > > > reproducible. Problem is still there in a fresh checkout of current
> > > > Linus git tree (post 2.6.18).
> > >
> > > Same symptoms here and its reproducible after starting the irqbalance
> > > (0.12 or 0.13), if i disable irqbalance then everything is going fine.
> >
> > Hmm.. Not sure about the connection to irqbalance. You're using the TSC
> > clocksource, so I'm curious if your cpu TSC's are out of sync. Can you
> > boot w/ "clocksource=acpi_pm" to see if that resolves it?
> 
> Yep, it solves the problem and system boot normally with irqbalance enabled.

Ok. Good to hear you have a workaround. Now to sort out why your TSCs
are becoming un-synced. From the dmesg you sent me privately, I noticed
that while you have 4 cpus, the following message only shows up once:

ACPI: Processor [CPU1] (supports 8 throttling states)

Does disabling cpufreq change anything?

thanks
-john


