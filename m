Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVA1KEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVA1KEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 05:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVA1KEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 05:04:33 -0500
Received: from pop.gmx.net ([213.165.64.20]:15237 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261246AbVA1KE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 05:04:29 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050128104621.00c20650@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 28 Jan 2005 10:51:41 +0100
To: "Jack O'Quin" <joq@io.com>, Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <87vf9i0vx3.fsf@sulphur.joq.us>
References: <20050128084049.GA5004@elte.hu>
 <87hdl940ph.fsf@sulphur.joq.us>
 <20050124085902.GA8059@elte.hu>
 <20050124125814.GA31471@elte.hu>
 <20050125135613.GA18650@elte.hu>
 <87sm4opxto.fsf@sulphur.joq.us>
 <20050126070404.GA27280@elte.hu>
 <87fz0neshg.fsf@sulphur.joq.us>
 <1106782165.5158.15.camel@npiggin-nld.site>
 <20050128080802.GA2860@elte.hu>
 <871xc62bot.fsf@sulphur.joq.us>
 <20050128084049.GA5004@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0453-1, 12/31/2004), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:01 AM 1/28/2005 -0600, Jack O'Quin wrote:
>Ingo Molnar <mingo@elte.hu> writes:
>
> > * Jack O'Quin <joq@io.com> wrote:
> >
> >> > i'm wondering, couldnt Jackd solve this whole issue completely in
> >> > user-space, via a simple setuid-root wrapper app that does nothing else
> >> > but validates whether the user is in the 'jackd' group and then keeps a
> >> > pipe open to to the real jackd process which it forks off, deprivileges
> >> > and exec()s? Then unprivileged jackd could request RT-priority changes
> >> > via that pipe in a straightforward way. Jack normally gets installed as
> >> > root/admin anyway, so it's not like this couldnt be done.
> >>
> >> Perhaps.
> >>
> >> Until recently, that didn't work because of the longstanding rlimits
> >> bug in mlockall().  For scheduling only, it might be possible.
> >>
> >> Of course, this violates your requirement that the user not be able to
> >> lock up the CPU for DoS.  The jackd watchdog is not perfect.
> >
> > there is a legitimate fear that if it's made "too easy" to acquire some
> > sort of SCHED_FIFO priority, that an "arm's race" would begin between
> > desktop apps, each trying to set themselves to SCHED_FIFO (or SCHED_ISO)
> > and advising users to 'raise the limit if they see delays' - just to get
> > snappier than the rest.
> >
> > thus after a couple of years we'd end up with lots of desktop apps
> > running as SCHED_FIFO, and latency would go down the drain again.
>
>I wonder how Mac OS X and Windows deal with this priority escalation
>problem?  Is it real or only theoretical?

WRT the Mac, I thought OS X was created to cure the ills of cooperative 
multi-tasking.  (which the priority arms race reminds me of)

         -Mike 

