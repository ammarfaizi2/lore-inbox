Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVHaE6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVHaE6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 00:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVHaE6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 00:58:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:17938 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932361AbVHaE6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 00:58:38 -0400
Date: Wed, 31 Aug 2005 06:51:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nathan Becker <nbecker@physics.ucsb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange CPU speedups with SMP on Athlon 64 X2
Message-ID: <20050831045131.GG10110@alpha.home.local>
References: <Pine.LNX.4.63.0508301153340.10786@claven.physics.ucsb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508301153340.10786@claven.physics.ucsb.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

stupid question : isn't it possible that your motherboard does some sort of
overclocking when it detects high cpu usage (bus activity, etc...) ? It
should not be easy to check (rdtsc every second ?), but you might want to
explore such a possibility.

Regards,
willy

On Tue, Aug 30, 2005 at 12:16:04PM -0700, Nathan Becker wrote:
> Hi,
> 
> I'm having a strange problem when I benchmark some of my physics 
> simulation code on my new Athlon 64 X2 4800 machine.  It occurs on all 
> current kernels that I have tested including 2.6.12.5 and 2.6.13.
> 
> If I run my benchmark single threaded, so that one of the two CPU cores 
> is just idling then the calculation goes pretty fast.  But if I load both 
> CPU cores simultaneously but with INDEPENDENT calculations, then each 
> calculation runs about 12-15% faster than when running alone.  I have 
> found this to be always reproducible.  There is no disk access involved 
> in the calculation and RAM usage is fairly minimal so this is not caused 
> by caching. Also, if I compile the kernel to disable SMP then the machine 
> runs a single calculation at the same speed as when running alone when 
> SMP is enabled.
> 
> I am aware of the timing issues on these machines (especially since I 
> reported the bug http://bugzilla.kernel.org/show_bug.cgi?id=5105 ). 
> However, I double-checked my benchmark with a stop-watch, so this is 
> independent of something strange happening in the timer.
> 
> I also checked the cpufreq governor and according to the logs, my CPU is 
> holding steady at the maximum setting of 2.4GHz.  I set the governor to 
> "performance" mode which should prevent unintended downclocking.
> 
> I would be happy to post my exact C source that I use to do the 
> benchmark, but I wanted to get some feedback first in case I'm just doing 
> something stupid.  Also, since I'm not subscribed to this list, please cc 
> me directly regarding this topic.
> 
> Thanks very much,
> 
> Nathan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
