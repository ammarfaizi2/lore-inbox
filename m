Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVAKUub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVAKUub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAKUua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:50:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:60385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbVAKUuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:50:10 -0500
Date: Tue, 11 Jan 2005 12:50:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, "Jack O'Quin" <joq@io.com>,
       Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111125008.K10567@build.pdx.osdl.net>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050111191701.GT2940@waste.org>; from mpm@selenic.com on Tue, Jan 11, 2005 at 11:17:02AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Tue, Jan 11, 2005 at 08:05:08AM -0500, Paul Davis wrote:
> > I am not sure what you mean here. I think we've established that
> > SCHED_OTHER cannot be made adequate for realtime audio work. Its
> > intended purpose (timesharing the machine in ways that should
> > generally benefit tasks that don't do a lot and/or are dominated by
> > user interaction, thus rendering the machine apparently responsive) is
> > really at odds with what we need.
> 
> We have not established that at all. In principle, because SCHED_OTHER
> tasks running at full priority lie on the boundary between SCHED_OTHER
> and SCHED_FIFO, they can be made to run arbitrarily close to the
> performance of tasks in SCHED_FIFO. With the upside that they won't be
> able to deadlock the machine.

I don't think they lie quite so neatly on this boundary.  There's one
fundamental difference which is how the dynamic priority is adjusted
which alters the basic preemptibility rules.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
