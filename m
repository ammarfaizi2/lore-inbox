Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVJ1Vj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVJ1Vj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVJ1Vj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:39:27 -0400
Received: from maggie.cs.pitt.edu ([130.49.220.148]:27056 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1750766AbVJ1Vj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:39:27 -0400
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: Bug: timer going backward on a dual core
Date: Fri, 28 Oct 2005 23:39:14 +0200
User-Agent: KMail/1.8
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
References: <200510282109.42054.cloud.of.andor@gmail.com> <200510282227.36433.cloud.of.andor@gmail.com> <1130532212.27168.417.camel@cog.beaverton.ibm.com>
In-Reply-To: <1130532212.27168.417.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510282339.16196.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 22:43, john stultz wrote:
> On Fri, 2005-10-28 at 22:27 +0200, Claudio Scordino wrote:
> > > > We have a dual-core AMD64 with the new kernel 2.6.14 and the
> > > > timer goes backward...
> > > >
> > > >
> > > > CONFIGURATION:
> > > >
> > > > Kernel: 2.6.14
> > > > Distribution: Gentoo Linux 2005.0
> > > > Processor: Athlon 64 x2 4200+ (dual core)
> > > > Motherboard: Abit KN8
> > > > Memory: 1GB PC3200
> > > >
> > > >
> > > > PROBLEM:
> > > >
> > > > gettimeofday goes backward and returns values that are not monotonic,
> > > > giving values that are smaller than values returned before.
> > > >
> > > > The system has been tested with timer as PIT, PIT/TSC and PM and the
> > > > problem occurs with all the configurations.
> > > >
> > > > Here is the config file that we used for the PM configuration.
> > > >
> > > > Any suggestion ?
> > >
> > > Booting w/ idle=poll tends to work around this issue. You might check
> > > with your motherboard vendor for an updated BIOS that supports HPET or
> > > the ACPI PM timer.
> >
> > We already updated the BIOS with the latest version.
> >
> > Also the booting command idle=poll doesn't work.
>
> Hmm. Not sure then. Is this a new regression on the same hardware?

Yes, we tried with idle=poll and the problem occurred again.

>
> Also, how are you measuring time going backwards?

With a simple C program that calls gettimeofday and sees if the new value is 
less than the old one.

>
> Would you mind filing a bug (http://bugzilla.kernel.org )on this and
> attaching your config and dmesg there?

Sure.

Thanks,

          Claudio
