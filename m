Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVAYWFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVAYWFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVAYWFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:05:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:28830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262184AbVAYWDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:03:47 -0500
Date: Tue, 25 Jan 2005 14:03:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <joq@io.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: /proc/sys/kernel/rt_cpu_limit tunable
Message-ID: <20050125140302.C24171@build.pdx.osdl.net>
References: <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us> <20050125214900.GA9421@elte.hu> <20050125135508.A24171@build.pdx.osdl.net> <20050125215758.GA10811@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050125215758.GA10811@elte.hu>; from mingo@elte.hu on Tue, Jan 25, 2005 at 10:57:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> * Chris Wright <chrisw@osdl.org> wrote:
> > * Ingo Molnar (mingo@elte.hu) wrote:
> > > well, there's setrlimit, so you could add a jackd client callback that
> > > instructs all clients to change their RT_CPU_RATIO rlimit. In theory we
> > > could try to add a new rlimit syscall that changes another task's rlimit
> > > (right now the syscalls only allow the changing of the rlimit of the
> > > current task) - that would enable utilities to change the rlimit of all
> > > tasks in the system, achieving the equivalent of a global sysctl.
> > 
> > We've talked about smth. similar in another thread.  I'm not opposed
> > to the idea.
> 
> did that thread go into technical details? There are some rlimit users
> that might not be prepared to see the rlimit change under them. The
> RT_CPU_RATIO one ought to be safe, but generally i'm not so sure.

Not really.   I mentioned the above, as well as the security concern.
Right now, at least the task_setrlimit hook would have to change to take
into account the task.  And I never convinced myself that async changes
would be safe for each rlimit.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
