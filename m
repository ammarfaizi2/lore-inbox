Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVKNVis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVKNVis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVKNVis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:38:48 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51873 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932160AbVKNVir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:38:47 -0500
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
From: john stultz <johnstul@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <4378FFFF.4010706@tuxrocks.com>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
	 <4378FFFF.4010706@tuxrocks.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 13:38:45 -0800
Message-Id: <1132004327.4668.30.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 14:22 -0700, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> john stultz wrote:
> > All,
> > 	I had hoped to submit this to -mm today, but since Ingo pointed
> > out an issue in the __delay code, I'm going to wait a week so the new fix
> > can be better tested.
> 
> I replaced the TOD parts of the kthrt patchset with TOD B10.  It seems
> there is something wrong with 'c3tsc' and 'pit', though.
> 
> c3tsc appears to run fast:
> 14 Nov 12:02:13         offset: -0.00247        drift: -2502.0 ppm
> 14 Nov 12:03:14         offset: -0.145203       drift: -2342.5 ppm
> 14 Nov 12:04:14         offset: -0.329381       drift: -2700.10655738 ppm
> 14 Nov 12:05:14         offset: -0.532767       drift: -2927.46703297 ppm
> 14 Nov 12:06:15         offset: -0.638096       drift: -2626.04115226 ppm

Hmm... Not sure if this is mis-calibration or just bad-interaction w/
kthrt. Mind sending a dmesg to me?

> and 'pit' seems to produce errors (system will not switch from pit to
> another clocksource anymore):

Do the TOD patches have this issue by themselves, or is this only with
kthrt? I know I had some issues with non-continuous clocksources (pit,
jiffies) with the kthrt patch, where it wouldn't fall back to
non-high-res when the clocksource stopped supporting it.

thanks
-john


