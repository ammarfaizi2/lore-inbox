Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290756AbSBYJ7f>; Mon, 25 Feb 2002 04:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290792AbSBYJ7Z>; Mon, 25 Feb 2002 04:59:25 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60677 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290756AbSBYJ7M>; Mon, 25 Feb 2002 04:59:12 -0500
Date: Mon, 25 Feb 2002 04:59:00 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: "Paul G. Allen" <pgallen@randomlogic.com>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        gcc@gcc.gnu.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
Message-ID: <20020225045859.S2434@devserv.devel.redhat.com>
Reply-To: gcc@gcc.gnu.org
In-Reply-To: <20020225024817.Q2434@devserv.devel.redhat.com> <Pine.LNX.4.44.0202251044040.18205-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0202251044040.18205-100000@Expansa.sns.it>; from kernel@Expansa.sns.it on Mon, Feb 25, 2002 at 10:46:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 10:46:52AM +0100, Luigi Genoni wrote:
> > > At this link:
> > >
> > >  http://www.cs.utk.edu/~rwhaley/ATLAS/gcc30.html
> > >
> > > you can find an interesting explanation why code compiled with gcc 3.0 is
> > > mostly slower than code compiled with gcc 2.95 on x86 CPUs (but it is
> > > really faster on other platforms like alpha and sparc64).
> > >
> > > basically the main reasons semm to be the scheduler algorithm and the fpu
> > > stack handling, but I suggest to read the full study.
> > >
> > >
> > > I would be interested to know if this apply to gcc 3.1 too.
> >
> > Well, concerning reg-stack, you can completely get away without it in 3.1
> > by using -mfpmath=sse if you are targeting Pentium 3,4 or Athlon 4,xp,mp
> > (for float math, for higher precision only for Pentium 4).
> 
> Yes, but the lot of users (like me) who are still using Athlon TB, 1330 or
> 1400 Mhz, and who do not have any reason to upgrade to MP since the
> performance gain is not really considerable, they cannot use sse instructions.
> So, what could they do? should they stay with gcc 2.95?

Linux kernel doesn't use floating point math at all, so this is irrelevant
on lkml, moving to an more appropriate list...

	Jakub
