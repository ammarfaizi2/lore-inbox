Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVANRdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVANRdB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVANRdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:33:01 -0500
Received: from pop.gmx.net ([213.165.64.20]:47015 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262034AbVANRc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:32:58 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050114171907.00c05e38@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 14 Jan 2005 18:20:35 +0100
To: "Jack O'Quin" <joq@io.com>, Arjan van de Ven <arjanv@redhat.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <87oefs9a8z.fsf@sulphur.joq.us>
References: <20050113214320.GB22208@devserv.devel.redhat.com>
 <20050111214152.GA17943@devserv.devel.redhat.com>
 <200501112251.j0BMp9iZ006964@localhost.localdomain>
 <20050111150556.S10567@build.pdx.osdl.net>
 <87y8ezzake.fsf@sulphur.joq.us>
 <20050112074906.GB5735@devserv.devel.redhat.com>
 <87oefuma3c.fsf@sulphur.joq.us>
 <20050113072802.GB13195@devserv.devel.redhat.com>
 <878y6x9h2d.fsf@sulphur.joq.us>
 <20050113210750.GA22208@devserv.devel.redhat.com>
 <1105651508.3457.31.camel@krustophenia.net>
 <20050113214320.GB22208@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0453-1, 12/31/2004), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:31 PM 1/13/2005 -0600, Jack O'Quin wrote:
>Arjan van de Ven <arjanv@redhat.com> writes:
>
> > On Thu, Jan 13, 2005 at 04:25:08PM -0500, Lee Revell wrote:
> >> The basic issue is that the current semantics of SCHED_FIFO seem make
> >> the deadlock/data corruption due to runaway RT thread issue difficult.
> >> The obvious solution is a new scheduling class equivalent to SCHED_FIFO
> >> but with a mechanism for the kernel to demote the offending thread to
> >> SCHED_OTHER in an emergency.
> >
> > and this is getting really close to the original "counter proposal" to the
> > LSM module that was basically "lets make lower nice limit an rlimit, and
> > have -20 mean "basically FIFO" *if* the task behaves itself".
>
>Yes.  However, my tests have so far shown a need for "actual FIFO as
>long as the task behaves itself."

I for one wonder why that appears to be so.  What happens if you use 
SCHED_RR instead of SCHED_FIFO?

(ie is the problem just one of running out of slice at a bad time, or is it 
the dynamic priority adjustment)

         -Mike 

