Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278739AbRJ3XIE>; Tue, 30 Oct 2001 18:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278736AbRJ3XHr>; Tue, 30 Oct 2001 18:07:47 -0500
Received: from [208.129.208.52] ([208.129.208.52]:524 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278732AbRJ3XGk>;
	Tue, 30 Oct 2001 18:06:40 -0500
Date: Tue, 30 Oct 2001 15:14:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
In-Reply-To: <20011030150429.E490@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.40.0110301513470.1495-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Mike Fedyk wrote:

> On Tue, Oct 30, 2001 at 09:02:54AM -0800, Davide Libenzi wrote:
> > On Tue, 30 Oct 2001, Mike Fedyk wrote:
> >
> > > On Mon, Oct 29, 2001 at 09:38:07PM -0800, Davide Libenzi wrote:
> > > > 2) My Linux Scheduler Stuff Page:
> > > > 	http://www.xmailserver.org/linux-patches/lnxsched.html
> > > >
> > >
> > > Anyone know if this is preempt safe?  It's using processor specific lists,
> > > and might not be.
> >
> > Processor specific lists ?
> > The mss scheduler patch in for x86 but it's trivial ( about 10 lines of
> > code ) to port it to other arcs.
> >
>
> >From the origional:
> The proposed implementation uses a runqueue-per-cpu scheduler where,
> inside each CPU, the scheduler code is exactly the same of the current one.
> The big runqueue_lock has been substituted by locks that protects CPU run
> queues.
> By having separate run queues the length/cost of the goodness() loop
> has been divided by N ( N == number of CPUs ) and the presence of
> per-runqueue locks gives the scheduler a full parallelism between the CPUs.
>
> -------------
>
> Looking at this again, it probably is preempt safe... I probably merged it
> wrong.
>
> I'll try to fit it into my next kernel...

No probably You're right and I posted a wrong patch.
Try to get the one that is here :

http://www.xmailserver.org/linux-patches/mss.html



- Davide


