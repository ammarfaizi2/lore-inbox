Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWJGWLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWJGWLg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 18:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWJGWLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 18:11:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34310 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750929AbWJGWLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 18:11:35 -0400
Date: Sat, 7 Oct 2006 21:57:49 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Bryce Harrington <bryce@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       hotplug_sig@osdl.org, lhcs-devel@lists.sourceforge.net
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061007215749.GC4277@ucw.cz>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006231012.GH22139@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1.  Oops offlining cpu twice on AMD64 (but not on EM64t)
>     with the 2.6.18-git22 kernel
> 
>     Reported to hotplug lists 10/05:
>       http://lists.osdl.org/pipermail/hotplug_sig/2006-October/000680.html
> 
>     To recreate: offline, online, and then offline a CPU, then oopses
>       http://crucible.osdl.org/runs/2397/sysinfo/amd01.console
>       http://crucible.osdl.org/runs/2397/sysinfo/amd01.2/proc/config
> 
>     Here's a snippet of the oops:
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> 
>  Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
>  [<ffffffff80255287>] __drain_pages+0x29/0x5f
> PGD 7e56d067 PUD 7ee80067 PMD 0
> Oops: 0000 [1] PREEMPT SMP
> CPU 0
> Modules linked in:
> Pid: 7203, comm: bash Tainted: G   M  2.6.18-git22 #1
                                 ~~~~~
kernel is unhappy here. Forced module unload?

-- 
Thanks for all the (sleeping) penguins.
