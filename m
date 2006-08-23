Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWHWPBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWHWPBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWHWPBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:01:33 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:60645 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964907AbWHWPBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:01:33 -0400
Date: Thu, 24 Aug 2006 00:58:18 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, simon.derr@bull.net, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-ID: <20060823145817.GA28175@krispykreme>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com> <20060821192133.GC8499@krispykreme> <20060821140148.435d15f3.pj@sgi.com> <20060821215120.244f1f6f.akpm@osdl.org> <20060821220625.36abd1d9.pj@sgi.com> <20060821221433.2bc18198.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821221433.2bc18198.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Well...  let's suck it and see (please).  If for some reason it proves
> inadequate and the default kernel behaviour is significantly wrong (it
> seems to be) then there's an argument for modifying (ie: adding complexity
> to) the kernel.

I think there is. We have a userspace visible change to the sched
affinity API when the cpusets option is enabled. Papering over it with a
udev callback doesnt sound like the right solution.

Im struggling to understand why we have this problem at all. If a task
has not been touched by cpuset calls it should be allowed to use any
cpu. I completely agree that once you have partitioned the task with
cpusets then it should never spill onto more recently hotplug added
cpus.

Anton
