Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319035AbSIDDfL>; Tue, 3 Sep 2002 23:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319036AbSIDDfL>; Tue, 3 Sep 2002 23:35:11 -0400
Received: from mail.michigannet.com ([208.49.116.30]:48134 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S319035AbSIDDfJ>; Tue, 3 Sep 2002 23:35:09 -0400
Date: Tue, 3 Sep 2002 23:39:38 -0400
From: Paul <set@pobox.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
Message-ID: <20020904033938.GB4727@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
References: <1030957927.3d732b67b0257@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030957927.3d732b67b0257@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <conman@kolivas.net>, on Mon Sep 02, 2002 [07:12:07 PM] said:
> Actually Paul was correct; the low latency branch was just -aa but in my never
> ending descent into madness I have decided to add another branch as requested,
> ck5-rl which has lowest latency with -rmap instead of -aa
> 
> Get it at the usual place:
> http://kernel.kolivas.net
> 
> Con.
> 
> P.S. You're welcome Joe.
> 

	Hi;

	pII 400x2 512M SMP
	Running ck5-rl now. Benno's latencytest shows that
schedualing latency is perhaps better than the patchset with
the aa vm. My first run yeilded a max 2.7ms latency-- oddly
during the /proc loading test, instead of disk write which
seems most problematic here. Every other stress test yeilded
1.6ms max latency. A second run managed to pull off 1.5ms
max latency for most, and a 1.7ms latency for disk write.
	Under extreme stress (make -j4 bzImage) while running
the tests, both aa and rmap performed about the same. (3.5ms
max lat.)
	Under more general benchmarks, like lmbench, bonnie,
hdparm, and a kernel build, rmap came out the same or just
a little worse than aa. (in the context of these patchsets)
	Andrew Morton's low latency patch seems to be the
most signifigant aspect in acheiving these low schedualing
latencies-- turning it off in /proc/sys/kernel/lowlatency
results in readings, which are better than 2.4.19 virgin,
but still unworkable for applications which require consistant
low schedualing latency.
	My focus on these tests is related to my (diletante)
interest in audio processing and recording. I think the
interactive 'feel' of the system is improved, but I didnt
really have trouble with vanilla-- on this system, IO is
my real limiter. I am curious how these patchsets affect games,
but I dont have much gaming experience...
	If anyone wants me to run any benchmarks, just
ask. Thanks, Con. (and of course, the authors of the patchs)

Paul
set@pobox.com

