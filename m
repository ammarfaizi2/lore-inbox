Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVDBURX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVDBURX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDBURW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:17:22 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24245 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261252AbVDBURT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:17:19 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1112472372.27149.23.camel@localhost.localdomain>
References: <20050325145908.GA7146@elte.hu>
	 <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com>
	 <200504011834.22600.gene.heskett@verizon.net>
	 <20050402051254.GA23786@elte.hu>
	 <1112470675.27149.14.camel@localhost.localdomain>
	 <1112472372.27149.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 15:17:17 -0500
Message-Id: <1112473038.28826.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 15:06 -0500, Steven Rostedt wrote:
> On Sat, 2005-04-02 at 14:37 -0500, Steven Rostedt wrote:
> 
> > Here's the bug I get:
> > 
> 
> FYI
> 
> For kicks I ran this on 2.6.11-rc2-RT-V0.7.36-02 (I still had it as a
> Grub option), and the system just locked up hard.  I just was curious if
> this was from a different change. But at least in the latest it shows
> output, and not just a hard lockup.

I had the same results yesterday, while punishing the swap by building
the kernel with make -j64 over NFS.  It thrashed wildly for 20 minutes
or so then eventually all disk activity stopped.  Of course that stupid
cow continued bouncing up and down...

It wasn't clear from your last mail whether you were using NFS.  If so I
would be suspicious given the NFS changes in the new RT patches.  I'll
try to reproduce the problem on a local fs.

Lee

