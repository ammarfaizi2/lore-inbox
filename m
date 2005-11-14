Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVKNWCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVKNWCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVKNWCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:02:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:34214 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751285AbVKNWCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:02:20 -0500
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
From: john stultz <johnstul@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <4379074D.5060308@tuxrocks.com>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
	 <4378FFFF.4010706@tuxrocks.com> <1132004327.4668.30.camel@leatherman>
	 <4379074D.5060308@tuxrocks.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 14:02:15 -0800
Message-Id: <1132005736.4668.34.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 14:53 -0700, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> john stultz wrote:
> > Hmm... Not sure if this is mis-calibration or just bad-interaction w/
> > kthrt. Mind sending a dmesg to me?
> 
> dmesg attached

Thanks, I'll start looking into it.

> >>and 'pit' seems to produce errors (system will not switch from pit to
> >>another clocksource anymore):
> 
> Odd.  This time, I got the errors when I switched from acpi_pm (which it
> had defaulted to at bootup) to jiffies.  System has not locked at one
> clocksource yet, though.

Yea, jiffies and pit are similarly non-continuous clocksources.

> > Do the TOD patches have this issue by themselves, or is this only with
> > kthrt? I know I had some issues with non-continuous clocksources (pit,
> > jiffies) with the kthrt patch, where it wouldn't fall back to
> > non-high-res when the clocksource stopped supporting it.
> 
> I only tried with kthrt because I ran into lots of conflicts when
> applying the patches to more recent kernels otherwise.  I can try again
> with 2.6.14-mm2 in order to test it out.

You can alternatively drop the patches in the kthrt set that are after
the timeofday patches in Thomas' series file. Or even just disable the
high-res config option and see if that changes anything.

thanks
-john


