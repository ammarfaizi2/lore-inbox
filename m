Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUFLAKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUFLAKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUFLAKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:10:16 -0400
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:27301 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S264404AbUFLAKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:10:09 -0400
Message-ID: <40CA49DD.5040500@bigpond.net.au>
Date: Sat, 12 Jun 2004 10:10:05 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shane Shrybman <shrybman@aei.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6.7-rc3] Single Priority Array CPU Scheduler
References: <1086961198.2787.19.camel@mars>
In-Reply-To: <1086961198.2787.19.camel@mars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Shrybman wrote:
> Hi Peter,
> 
> I just started to try out your SPA scheduler patch and found that it is
> noticeably sluggish when resizing a mozilla window on the desktop. I
> have a profile of 2.6.7-rc3-spa and 2.6.7-rc2-mm2 and put them up at:
> http://zeke.yi.org/linux/spa/ . There is also vmstat output there but it
> doesn't look too helpful to me.
> 
> The test was basic and went like this:
> 
> x86, K7, UP, gnome desktop with mozilla (with a bunch of tabs) and a few
> rxvts. cmdline= elevator=cfq profile=1
> 
> readprofile -r
> 
> grab a corner of my mozilla window and continually move it around for
> several seconds
> 
> readprofile -v -m /boot/System.map-2.6.7-rc3|sort -rn +2|head -n30
> 
> do the same while dumping vmstat 1 to a file.
> 
> The kernel with your patch had a much harder time keeping up with the
> window resizing. Moving the entire window did not seem too bad or not
> too noticeable. I tried a similar test while running a kernel compile
> (make -j3) and it made the window resizing _really_ slow to respond.

Thanks for the feedback, I'll add your test to those I perform myself.

Some of the control variables for this scheduler have rather arbitrary 
values at the moment and are likely to be non optimal.  I'm in the 
process of making some of these variables modifiable at run time via 
/proc/sys to enable experimentation with different settings.  Hopefully, 
this will enable settings that improve interactive performance to be 
established.

Once again, thanks for the feedback
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

