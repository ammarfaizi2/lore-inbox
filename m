Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269951AbRHQIni>; Fri, 17 Aug 2001 04:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269944AbRHQIn2>; Fri, 17 Aug 2001 04:43:28 -0400
Received: from ns.suse.de ([213.95.15.193]:18189 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269951AbRHQInN>;
	Fri, 17 Aug 2001 04:43:13 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <Your message of "Fri, 17 Aug 2001 00:35:02 +0100."  <5.1.0.14.2.20010817002825.00b1e4e0@pop.cus.cam.ac.uk.suse.lists.linux.kernel> <5.1.0.14.2.20010817015007.045689b0@pop.cus.cam.ac.uk.suse.lists.linux.kernel> <3B7C7846.FD9DEE68@zip.com.au.suse.lists.linux.kernel> <20010816.185319.88475216.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Aug 2001 09:30:18 +0200
In-Reply-To: "David S. Miller"'s message of "17 Aug 2001 03:59:36 +0200"
Message-ID: <oupofpfw3cl.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Thu, 16 Aug 2001 18:49:58 -0700
> 
>    int test(int __x, int __y)
>    {
>            return min(__x, __y);		/* sic */
>    }
> 
> People are expected not to use underscore prefixed
> variables in normal C code, this is why macros
> in the kernel make liberal use of them for locals.

You are joking, right?  The kernel is full of double under score prefixed
identifiers, for functions that do slighter lower level things than others.
While this expectation may exist in POSIX/C89 and is frequently violated there,
in kernel C nobody cares about it at all.

It doesn't matter anyways, the way C macro expansion works guarantees that
only macro arguments written in the macro get expanded; the arguments are not
recursively expanded. Therefore any games with "magic" macro names 
is totally unnecessary.

-Andi
