Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUCRPVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUCRPUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:20:54 -0500
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:11080
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S262597AbUCRPUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:20:47 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, mjy@geizhals.at,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040318015004.227fddfb.akpm@osdl.org>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random>
	 <20040318015004.227fddfb.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079623222.4167.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 10:20:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 04:50, Andrew Morton wrote:
> I don't recall anyone demonstrating even a 1% impact from preemption.  If
> preemption was really causing slowdowns of this magnitude it would of
> course have been noticed.  Something strange has happened here and more
> investigation is needed.
> 
> > ...
> > I still think after 4 years that such idea is more appealing then
> > preempt, and numbers start to prove me right.
> 
> The overhead of CONFIG_PREEMPT is quite modest.  Measuring that is simple.

Well, I reported an issue on my laptop several weeks ago where network
activity via my aironet wireless adapter would use 60-70% of the CPU but
only when PREEMPT was enabled.  Looking back over the list I see other
similar issues with PREEMPT and various network card drivers (8139too
and ne2k show up), although most of those seem to be against preempt in
2.4.x not 2.6.

I think the user that started this thread was seeing significant
regressions during kernel compiles with PREEMPT enabled while the system
also has some additional load from Apache (perhaps with significant
network activity).  I think there are cases like this where PREEMPT
seems to trip up.

I'll try to reproduce my issue with current generation kernels (last I
tested with PREEMPT was 2.6.1) and see if my problem is still there. 
When I reported the issue last time no one seemed interested so I just
learned to disable preempt.

Later,
Tom


