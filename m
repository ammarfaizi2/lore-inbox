Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUGMXzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUGMXzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267261AbUGMXzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:55:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:49078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267259AbUGMXzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:55:12 -0400
Date: Tue, 13 Jul 2004 16:47:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel  
 Preemption Patch
Message-Id: <20040713164753.5846a958.rddunlap@osdl.org>
In-Reply-To: <cd1nv4$3k7$1@gatekeeper.tmr.com>
References: <1089677823.10777.64.camel@mindpipe>
	<20040709182638.GA11310@elte.hu>
	<20040712174639.38c7cf48.akpm@osdl.org>
	<cd1nv4$3k7$1@gatekeeper.tmr.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004 18:40:30 -0400 Bill Davidsen wrote:

| Andrew Morton wrote:
| > Lee Revell <rlrevell@joe-job.com> wrote:
| > 
| >>>resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
| >>
| >> > fixes ended up breaking the fs in subtle ways and I eventually gave up.
| >> > 
| >>
| >> Interesting.  There is an overwhelming consensus amongst Linux audio
| >> folks that you should use reiserfs for low latency work.
| > 
| > 
| > It seems to be misplaced.  A simple make-a-zillion-teeny-files test here
| > exhibits a 14 millisecond holdoff.
| > 
| > 
| >> Should I try ext3?
| > 
| > 
| > ext3 is certainly better than that, but still has a couple of potential
| > problem spots.  ext2 is probably the best at this time.
| 
| Does anyone have any data points on XFS in this regard? I agree that 
| ext2 is faster than ext3, and ext3 probably has lower latency than 
| reiser3, but I have no info at all on XFS. My JFS experience is all on 
| AIX, as well, so if anyone has that info it might be interesting as well.

Yes, but not recent.  I did lots of journaling-fs testing and
workloads on 2.4.19-pre7 for LinuxWorld Aug. 2004.
Presentation is here:
  http://developer.osdl.org/rddunlap/journal_fs/lwe-jgfs.pdf

Simplified summary:

XFS fared well on (large) sequential IO workloads.
And of course, none of the journaling fs-es beat ext2, but
XFS came the closest.

At the time of that presentation, JFS was very slow.  The JFS team
was working on correctness/robustness only, not performance.
I don't know the status of that today.
It's somewhat of a shame, because on paper JFS looks like a great
filesystem (IMO).

--
~Randy
