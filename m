Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTJUVXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTJUVXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:23:00 -0400
Received: from fmr05.intel.com ([134.134.136.6]:19166 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263300AbTJUVW5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:22:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates toACPIP-state driver
Date: Tue, 21 Oct 2003 14:22:44 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304B038@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 3/3 Dynamic cpufreq governor and updates toACPIP-state driver
Thread-Index: AcOYDWO0vuOy4eiQQXuWOM9lNbqB+wABJTQA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Carl Thompson" <cet@carlthompson.net>
Cc: <arjanv@redhat.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>,
       "linux-acpi" <linux-acpi@intel.com>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Oct 2003 21:22:51.0072 (UTC) FILETIME=[7B898400:01C39819]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's about the frequency of the feedback loop. As we have much lower
> > latency with P-state transitions, the sampling time can be order of
> > millisecond (or shorter if meaningful). A userland daemon can have a
> > high-level policy (preferences, or set of parameters), but it cannot
be
> > part of the real feedback loop. If we combine P-state transitions
and
> > deeper C-state transitions, the situation is worse with a userland
> > daemon.
> 
> You are making the assumption that a higher polling frequency (we'll
say
> 1ms) is in general better than a lower frequency (we'll say 1s).  I
submit
> that it is not.
> 
> If I hit a key on my keyboard and your high frequency loop increases
CPU
> speed so that my word processor displays the letter 0.01s faster, is
that
> really beneficial?  If a window renders in 0.2s seconds instead of
0.3s is
> that a difference I am going to notice?
Then you can put the CPU in C-state or lower P-state after (or even
during) your word processor displays the letter. Even you can type very
fast, the CPU is almost idle. Having frequent feedbacks simply provide
more chances to save power consumption. Then aggregate saving would make
a difference. In addition, penalty of making a wrong decision is cheap.

> 
> On the other hand, if I do a kernel compile and it is done 0.999s
faster
> with the higher frequency loop, am I going to miss that second over
such a
> long duration?  (In reality, the compile with the high-frequency loop
> would
> probably take longer unless it has near zero overhead).
Even if you build a kernel, there are many opportunities for the CPU to
save power consumption without causing visible performance regression.

> 
> In my opinion it is wasteful to increase CPU speed unless there is a
> longer
> term need for it.
> 
> > 	Jun
> 
> Carl Thompson
> 

