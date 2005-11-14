Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVKNXZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVKNXZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVKNXZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:25:25 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:6790 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751312AbVKNXZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:25:24 -0500
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
From: john stultz <johnstul@us.ibm.com>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <437918A0.8000308@tuxrocks.com>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
	 <4378FFFF.4010706@tuxrocks.com> <1132004327.4668.30.camel@leatherman>
	 <4379074D.5060308@tuxrocks.com> <1132005736.4668.34.camel@leatherman>
	 <437918A0.8000308@tuxrocks.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 15:25:23 -0800
Message-Id: <1132010724.4668.40.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 16:07 -0700, Frank Sorenson wrote:
> >>john stultz wrote:
> >>>Hmm... Not sure if this is mis-calibration or just bad-interaction w/
> >>>kthrt. Mind sending a dmesg to me?
> 
> Okay, the c3tsc clock drift is definitely not an interaction with kthrt.
>  Here is 2.6.14-mm2 + the TOD B10 patches:
> 14 Nov 15:54:52   offset: -0.003031       drift: -3091.0 ppm
> 14 Nov 15:55:52   offset: -0.184073       drift: -3018.57377049 ppm
> 14 Nov 15:56:52   offset: -0.345268       drift: -2853.95041322 ppm
> 14 Nov 15:57:53   offset: -0.463002       drift: -2544.2967033 ppm
> 14 Nov 15:58:53   offset: -0.587743       drift: -2428.93801653 ppm
> 
> Running just 2.6.14-mm2 + TOD B10, I seem to be unable to reproduce the
> Badness errors, and the clocksource has not frozen at one setting.
> 
> I can provide a dmesg if needed.

Hrm.. How about sending a dmesg of just vanilla 2.6.14-mm2? Also does
the behavior change booting w/ idle=poll ?

Thanks so much for the problem report and testing, btw!
-john

