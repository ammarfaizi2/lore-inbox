Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWAMSJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWAMSJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbWAMSJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:09:55 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:50891 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422778AbWAMSJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:09:54 -0500
Subject: Re: Dual core Athlons and unsynced TSCs
From: Lee Revell <rlrevell@joe-job.com>
To: thockin@hockin.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060113181631.GA15366@hockin.org>
References: <1137104260.2370.85.camel@mindpipe>
	 <20060113180620.GA14382@hockin.org> <1137175117.15108.18.camel@mindpipe>
	 <20060113181631.GA15366@hockin.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 13:09:51 -0500
Message-Id: <1137175792.15108.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 10:16 -0800, thockin@hockin.org wrote:
> On Fri, Jan 13, 2006 at 12:58:36PM -0500, Lee Revell wrote:
> > > If your BIOS has an ACPI "HPET" table, then the kernel can use the HPET
> > > timer instead.  It doesn't solve the problem for apps or other kernel bits
> > > that use rdtsc directly, but there are other fixes for that floating
> > > around which will hopefully get consideration when they're mature.
> > 
> > The apps can be converted to use clock_gettime(), but that does not help
> > if the kernel can't keep reasonable time on these machines. 
> 
> Some apps/users need higher resolution and lower overhead that only rdtsc
> can offer currently.
> 

But obviously if the TSC gives wildly inaccurate results, it cannot be
used no matter how low the overhead.

> > But if we just use "clock=pmtmr" by default on these machines the TSC is
> > not a problem right?
> 
> I never tried it with pmtimer, we had HPET available.  Empirically TSC did
> not work (and we had a simple test case to show how bad it could get).
> HPET made that go away for users of gettimeofday().
> 
> We're exploring rdtsc-compatible solutions.
> 

Since timekeeping on these machines has always been completely broken,
shouldn't the default time source have been changed to the PM timer or
HPET as soon as the problem was known?

Lee

