Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWJ1Sh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWJ1Sh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWJ1Sh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:37:58 -0400
Received: from ns2.suse.de ([195.135.220.15]:41679 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751344AbWJ1Sh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:37:57 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: AMD X2 unsynced TSC fix?
Date: Sat, 28 Oct 2006 11:37:22 -0700
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <1162006081.27225.257.camel@mindpipe> <20061028052837.GC1709@1wt.eu>
In-Reply-To: <20061028052837.GC1709@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610281137.22451.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 October 2006 22:28, Willy Tarreau wrote:
> On Fri, Oct 27, 2006 at 11:28:00PM -0400, Lee Revell wrote:
> > On Fri, 2006-10-27 at 18:04 -0700, Andi Kleen wrote:
> > > I don't think it makes too much sense to hack on pure RDTSC when
> > > gtod is fast enough -- RDTSC will be always icky and hard to use.
> >
> > I agree FWIW, our application would be happy to just use gtod if it
> > wasn't so slow on these machines.
>
> Agreed, I had to turn about 20 dual-core servers to single core because
> the only way to get a monotonic gtod made it so slow that it was not
> worth using a dual-core. 

Curious - what workload was that? 

While gtod is time critical and often appears high on profile lists it is 
normally not as time critical as you're claiming it is; especially not
time critical enough to warrant such radical action.

> I initially considered buying one dual-core 
> AMD for my own use, but after seeing this, I'm definitely sure I won't
> ever buy one as long as this problem is not fixed, as it causes too
> many problems.

It's somewhat slower, but I'm not sure what "too many problems" you're
refering to.

-Andi
