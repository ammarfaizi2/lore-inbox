Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbUJ0PVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbUJ0PVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbUJ0PSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:18:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32911 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262449AbUJ0PNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:13:18 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041027150548.GA11233@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
	 <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com>
	 <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com>
	 <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com>
	 <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com>
	 <20041027150548.GA11233@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 11:13:13 -0400
Message-Id: <1098889994.1448.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 17:05 +0200, Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > I use the rtc-debug and amlat to generate histograms of latencies
> > which is what I was trying to do when I found the rtc problem the
> > first time.  I believe that rtc-debug/amlat is much more accurate for
> > generating histograms of latencies than realfeel is because the
> > instrumentation is in the kernel rather than a userspace program.
> 
> ah, ok - nice. So rtc-debug+amlat is the only known-reliable way to
> produce latency histograms?
> 

Yes, I think it is the most reliable way because the measurement is done
in the kernel.  At least, this is what AM's notes say.  There are any
number of ways to generate these with userspace programs (jackd,
realfeel, etc).

Here is a more up to date version of the rtc-debug patch:

http://lkml.org/lkml/2004/9/9/307

There is still a bit of 2.4 cruft in there but it works well.  Maybe
this could be included in future patches.

Lee

