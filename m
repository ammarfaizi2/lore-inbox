Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282890AbRK0JfN>; Tue, 27 Nov 2001 04:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282888AbRK0JfD>; Tue, 27 Nov 2001 04:35:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20453 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282890AbRK0Jev>;
	Tue, 27 Nov 2001 04:34:51 -0500
Date: Tue, 27 Nov 2001 12:32:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Joe Korty <l-k@mindspring.com>
Cc: Robert Love <rml@tech9.net>, Ryan Cumming <bodnar42@phalynx.dhs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: procfs bloat, syscall bloat [in reference to cpu affinity]
In-Reply-To: <5.0.2.1.2.20011127022738.009f14b0@pop.mindspring.com>
Message-ID: <Pine.LNX.4.33.0111271227540.9787-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Nov 2001, Joe Korty wrote:

> So my rule is, services of the first kind, the ones that are simple
> and eternal, should be system calls, while the quirky second kind
> should be consigned soley to the proc fs.
>
> I feel that the cpu affinity services are of the first kind.  They are
> very simple, very conceptual services that have absolutely no tie in
> to any architecture other than it be SMP, and even on uniprocessors
> they reduce down gracefully to the null state. [...]

yep, agreed. Also, /proc might not be mounted in eg. a chroot environment.
(a number of security-conscious servers do this.) Or it might not be
mounted at all, for whatever reason.

> I am not against a proc interface per se, I would like a proc
> interface, especially for the reading of affinity values.  But in my
> view the system call interface should also exist and it should be the
> dominate way of communicating affinity to processes.

i'm not against the /proc interface either - on the contrary, i've picked
it when implementing /proc/irq/<NR>/smp_affinity.

	Ingo

