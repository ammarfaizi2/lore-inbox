Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277277AbRJEACm>; Thu, 4 Oct 2001 20:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277276AbRJEACd>; Thu, 4 Oct 2001 20:02:33 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:61967 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S277277AbRJEACU>; Thu, 4 Oct 2001 20:02:20 -0400
Date: Fri, 5 Oct 2001 08:04:10 +0800 (SGT)
From: Linux Kernel <linux-kernel@vger.kernel.org>
X-X-Sender: <root@boston.corp.fedex.com>
To: Peter Rival <frival@zk3.dec.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some 2.4.9 vs. 2.4.10 results
In-Reply-To: <3BBCC246.2060206@zk3.dec.com>
Message-ID: <Pine.LNX.4.33.0110050801190.5725-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/05/2001
 08:02:43 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/05/2001
 08:02:47 AM,
	Serialize complete at 10/05/2001 08:02:47 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't have any real benchmark data, but all I want to add it that
2.4.11-pre2 is even faster than 2.4.10.

With 2.4.11-pre2, I can watch DVD (xmovie 1.8) on my IBM 240Z with frame
update a lot faster than 2.4.10.


Thanks,
Jeff
[ jchua@fedex.com ]

On Thu, 4 Oct 2001, Peter Rival wrote:

> Hi all,
>
> 	I just thought I'd pop in my two cents on this whole topic.  In short
> form, on my Alpha GS80 (8 CPUs, 8 GB, 40 U160 disks/4x2channel adapters,
> 2 NUMA nodes) 2.4.9 is almost unusable while 2.4.10 flies quite nicely.
>   Under 2.4.9 even things as simple as a mke2fs on a single 18 GB drive
> took minutes, while under 2.4.10 only seconds.  When I say 2.4.10, it's
> actually 2.4.10+the vm_tweak patch.
>
> 	I'm attaching a copy of the results of an AIM VII "shared" run as well as
> a lockstat report from a 500 user datapoint under 2.4.10.  If there is
> desire, I can generate a lockstat report for 2.4.9 as well.  I'm also
> going to see if I can get our profiling package to work on this system
> again, and if so I'll forward along those results as well.
>
> 	And not to bring up another old string, but just for giggles I removed
> the lock_kernel()/unlock_kernel() in llseek() to see what came of it.
> In short, a 2.2% gain in throughput and nearly 50% drop in the amount of
> time the kernel_lock is taken under this load.  Definitely looking
> forward to 2.5. ;)  Anyway, if there is something else anyone would be
> interested in that would be useful to run under this load (or a
> different set of statistics), feel free to let me know.
>
>   - Pete
>

