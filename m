Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSHJTwW>; Sat, 10 Aug 2002 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSHJTwV>; Sat, 10 Aug 2002 15:52:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43536 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317298AbSHJTwV>; Sat, 10 Aug 2002 15:52:21 -0400
Date: Sat, 10 Aug 2002 16:55:45 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>, <frankeh@watson.ibm.com>,
       <davidm@hpl.hp.com>, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <m1ofcar2y1.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44L.0208101654270.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Aug 2002, Eric W. Biederman wrote:
> Andrew Morton <akpm@zip.com.au> writes:
> >
> > The other worry is the ZONE_NORMAL space consumption of pte_chains.
> > We've halved that, but it will still make high sharing levels
> > unfeasible on the big ia32 machines.

> There is a second method to address this.  Pages can be swapped out
> of the page tables and still remain in the page cache, the virtual
> scan does this all of the time.  This should allow for arbitrary
> amounts of sharing.  There is some overhead, in faulting the pages
> back in but it is much better than cases that do not work.  A simple
> implementation would have a maximum pte_chain length.

Indeed.  We need this same thing for page tables too, otherwise
a high sharing situation can easily "require" more page table
memory than the total amount of physical memory in the system ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

