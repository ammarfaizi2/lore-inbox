Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSEQUeC>; Fri, 17 May 2002 16:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSEQUeB>; Fri, 17 May 2002 16:34:01 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55787 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316678AbSEQUeB>;
	Fri, 17 May 2002 16:34:01 -0400
Date: Sat, 18 May 2002 06:29:16 +1000
From: Anton Blanchard <anton@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug with shared memory.
Message-ID: <20020517202916.GA13581@krispykreme>
In-Reply-To: <20020515154200.B8975@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.3.96.1020517135011.15351A-100000@gatekeeper.tmr.com> <20020517130707.C1549@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> No I did not intend to imply this. AFAIK 'CONFIG_DEBUG_SPINLOCK=y'
> works fine on x86 (although I'm not a user myself).  My intention
> was only to add additional features to x86, that appear to only exist
> for sparc64.

It would be nice to see some of these things end up in a generic
place. Now that we can wrap our spinlocks easily (preempt changed
all the spinlocks to _raw_*) we could create a generic debug option
that checked:

uninitialised lock, timeout on deadlock, double lock by same cpu,
unlock by another cpu, unlock when not locked, scheduling with lock held,
read lock when same cpu has write lock.

And Im sure there are some more useful tests. 

Anton
