Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVAYWrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVAYWrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVAYWpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:45:34 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:49628 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262212AbVAYWoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:44:38 -0500
Date: Tue, 25 Jan 2005 17:44:37 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050125224437.GA19035@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Chris Wright <chrisw@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Jack O'Quin <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
	Con Kolivas <kernel@kolivas.org>,
	linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
	CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
	Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
	Rui Nuno Capela <rncbc@rncbc.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us> <20050125214900.GA9421@elte.hu> <20050125135508.A24171@build.pdx.osdl.net> <20050125215758.GA10811@elte.hu> <20050125140302.C24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125140302.C24171@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:03:02PM -0800, Chris Wright wrote:
> * Ingo Molnar (mingo@elte.hu) wrote:
> > did that thread go into technical details? There are some rlimit users
> > that might not be prepared to see the rlimit change under them. The
> > RT_CPU_RATIO one ought to be safe, but generally i'm not so sure.
> 
> Not really.   I mentioned the above, as well as the security concern.
> Right now, at least the task_setrlimit hook would have to change to take
> into account the task.  And I never convinced myself that async changes
> would be safe for each rlimit.

As was mentioned, but not discussed, in the /proc/<pid>/rlimit thread,
it is not difficult to envision conditions where setrlimit() on another
process could make exploiting an application bug much easier, by, e.g.,
setting number of open files ridiculously low.  So IMHO, it ought require
privileges similar to ptrace() to change some, if not all, of the rlimits.

	Bill Rugolsky
