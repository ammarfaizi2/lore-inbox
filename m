Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUEWO2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUEWO2K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 10:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUEWO2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 10:28:10 -0400
Received: from colin2.muc.de ([193.149.48.15]:12553 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262866AbUEWO2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 10:28:08 -0400
Date: 23 May 2004 16:28:06 +0200
Date: Sun, 23 May 2004 16:28:06 +0200
From: Andi Kleen <ak@muc.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: brettspamacct@fastclick.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Message-ID: <20040523142806.GA33866@colin2.muc.de>
References: <1Y6yr-eM-11@gated-at.bofh.it> <1YbRm-4iF-11@gated-at.bofh.it> <1Yma3-4cF-3@gated-at.bofh.it> <1YmjP-4jX-37@gated-at.bofh.it> <1YmMN-4Kh-17@gated-at.bofh.it> <1Yn67-50q-7@gated-at.bofh.it> <m3lljld1v1.fsf@averell.firstfloor.org> <93090000.1085171530@flay> <40AE93E0.7060308@fastclick.com> <1085272089.25212.6.camel@obsidian.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085272089.25212.6.camel@obsidian.pathscale.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 05:28:09PM -0700, Bryan O'Sullivan wrote:
> On Fri, 2004-05-21 at 16:42, Brett E. wrote:
> 
> > Right now, 5 processes are running taking up a good deal of the CPU 
> > doing memory-intensive work(cacheing) and I notice that none of the 
> > processes seem to have CPU affinity.
> 
> I don't know what kind of system you're running on, but if it's a
> multi-CPU Opteron, it is normally a sufficient fudge to just use
> sched_setaffinity to bind individual processes to specific CPUs.  The
> mainline kernel memory allocator does the right thing in that case, and
> allocates memory locally when it can.
> 
> You can use the taskset command to get at this from the command line, so
> you may not even need to modify your code.

Linus also merged the NUMA API support into mainline now with 2.6.7rc1, so you
can use numactl for more finegrained tuning.

-Andi
