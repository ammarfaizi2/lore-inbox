Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVJ3WNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVJ3WNR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVJ3WNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:13:17 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:14028 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S1751221AbVJ3WNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:13:17 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: Bug: timer going backward on a dual core
Date: Sun, 30 Oct 2005 23:13:01 +0100
User-Agent: KMail/1.8
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
References: <200510282109.42054.cloud.of.andor@gmail.com> <200510282339.16196.cloud.of.andor@gmail.com> <1130535889.27168.423.camel@cog.beaverton.ibm.com>
In-Reply-To: <1130535889.27168.423.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510302313.02738.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > We have a dual-core AMD64 with the new kernel 2.6.14 and the
> > > > > > timer goes backward...
> > > > > >
> > > > > >
> > > > > > CONFIGURATION:
> > > > > >
> > > > > > Kernel: 2.6.14
> > > > > > Distribution: Gentoo Linux 2005.0
> > > > > > Processor: Athlon 64 x2 4200+ (dual core)
> > > > > > Motherboard: Abit KN8
> > > > > > Memory: 1GB PC3200
> > > > > >
> > > > > >
> > > > > > PROBLEM:
> > > > > >
> > > > > > gettimeofday goes backward and returns values that are not
> > > > > > monotonic, giving values that are smaller than values returned
> > > > > > before.
> > > > > >
> > > > > > The system has been tested with timer as PIT, PIT/TSC and PM and
> > > > > > the problem occurs with all the configurations.
> > > > > >
> > > > > > Here is the config file that we used for the PM configuration.
> > > > > >
> > > > > > Any suggestion ?
> > > > >
> > > > > Booting w/ idle=poll tends to work around this issue. You might
> > > > > check with your motherboard vendor for an updated BIOS that
> > > > > supports HPET or the ACPI PM timer.
> > > >
> > > > We already updated the BIOS with the latest version.
> > > >
> > > > Also the booting command idle=poll doesn't work.
> > >
> > > Hmm. Not sure then. Is this a new regression on the same hardware?
> >
> > Yes, we tried with idle=poll and the problem occurred again.
>
> Sorry for the confusion, I meant if the problem is new to 2.6.14, or if
> it also happened with 2.6.13?

Sorry, I didn't understand. It happened also with the old versions of the 
kernel. The only temporary solution that we've found is to disable one 
processor :(

>
> > > Would you mind filing a bug (http://bugzilla.kernel.org )on this and
> > > attaching your config and dmesg there?
> >
> > Sure.
>
> Please assign it to me or add me to the cc list.

Done.

Thanks,

                Claudio
