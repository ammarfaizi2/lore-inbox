Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290689AbSBYJrP>; Mon, 25 Feb 2002 04:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290756AbSBYJrF>; Mon, 25 Feb 2002 04:47:05 -0500
Received: from Expansa.sns.it ([192.167.206.189]:41221 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S290689AbSBYJq5>;
	Mon, 25 Feb 2002 04:46:57 -0500
Date: Mon, 25 Feb 2002 10:46:52 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Jakub Jelinek <jakub@redhat.com>
cc: "Paul G. Allen" <pgallen@randomlogic.com>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <20020225024817.Q2434@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0202251044040.18205-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 25 Feb 2002, Jakub Jelinek wrote:

> On Mon, Feb 25, 2002 at 01:07:42AM +0100, Luigi Genoni wrote:
> > At this link:
> >
> >  http://www.cs.utk.edu/~rwhaley/ATLAS/gcc30.html
> >
> > you can find an interesting explanation why code compiled with gcc 3.0 is
> > mostly slower than code compiled with gcc 2.95 on x86 CPUs (but it is
> > really faster on other platforms like alpha and sparc64).
> >
> > basically the main reasons semm to be the scheduler algorithm and the fpu
> > stack handling, but I suggest to read the full study.
> >
> >
> > I would be interested to know if this apply to gcc 3.1 too.
>
> Well, concerning reg-stack, you can completely get away without it in 3.1
> by using -mfpmath=sse if you are targeting Pentium 3,4 or Athlon 4,xp,mp
> (for float math, for higher precision only for Pentium 4).

Yes, but the lot of users (like me) who are still using Athlon TB, 1330 or
1400 Mhz, and who do not have any reason to upgrade to MP since the
performance gain is not really considerable, they cannot use sse instructions.
So, what could they do? should they stay with gcc 2.95?



