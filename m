Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUCRPjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbUCRPjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:39:21 -0500
Received: from peabody.ximian.com ([130.57.169.10]:1254 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262703AbUCRPjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:39:18 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Robert Love <rml@ximian.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       mjy@geizhals.at, Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1079623222.4167.52.camel@localhost.localdomain>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random>
	 <20040318015004.227fddfb.akpm@osdl.org>
	 <1079623222.4167.52.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1079624344.2136.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 18 Mar 2004 10:39:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 10:20, Tom Sightler wrote:

> Well, I reported an issue on my laptop several weeks ago where network
> activity via my aironet wireless adapter would use 60-70% of the CPU but
> only when PREEMPT was enabled.  Looking back over the list I see other
> similar issues with PREEMPT and various network card drivers (8139too
> and ne2k show up), although most of those seem to be against preempt in
> 2.4.x not 2.6.

I've only seen these against 2.4, right?

> I think the user that started this thread was seeing significant
> regressions during kernel compiles with PREEMPT enabled while the system
> also has some additional load from Apache (perhaps with significant
> network activity).  I think there are cases like this where PREEMPT
> seems to trip up.

Well, Apache could definitely be the "issue" if it is using CPU time:
more time to Apache and less time to the compiles, assumingly by
design.  To really test kernel preemption's impact on throughput, you
need an idle system, otherwise you also test the improved preemptibility
and fairness.

	Robert Love


