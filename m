Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTBYCHa>; Mon, 24 Feb 2003 21:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTBYCHa>; Mon, 24 Feb 2003 21:07:30 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:18050 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S264875AbTBYCH3>; Mon, 24 Feb 2003 21:07:29 -0500
Date: Mon, 24 Feb 2003 18:17:36 -0800
To: yodaiken@fsmlabs.com
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       lm@work.bitmover.com, mbligh@aracnet.com, davidsen@tmr.com,
       greearb@candelatech.com, linux-kernel@vger.kernel.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225021736.GB4507@gnuppy.monkey.org>
References: <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org> <20030224004005.5e46758d.akpm@digeo.com> <20030224085031.GP10411@holomorphy.com> <20030224091758.A11805@hq.fsmlabs.com> <20030224231341.GQ10411@holomorphy.com> <20030224162754.A24766@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224162754.A24766@hq.fsmlabs.com>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 04:27:54PM -0700, yodaiken@fsmlabs.com wrote:
> I'm not sure what you are complaining about. I don't think there is good
> or even marginal data or explanations of this "effect". 

You don't need data. It's conceptually obvious. If you have a higher
priority thread that's not running because another thread of lower priority
is hogging the CPU for some unknown operation in the kernel, then you're
going be less able to respond to external events from the IO system and
other things with respect to a Unix style priority scheduler.

That's why we have fully preemptive RTOS to deal with that and priority
inheritence, both of which are fundamental to any kind of fixed-priority
RTOS.

If you're scheduler is scheduling crap, then it's not going to be very
effective and scheduling...

Rhetorical question... what the hell do you think this is about ?

	http://linuxdevices.com/articles/AT5698775833.html

It's about getting relationship inside the kernel to respect and be
controllable by the scheduler in some formal manner, not some random
not-so-well-though-out hack of the day.

bill

