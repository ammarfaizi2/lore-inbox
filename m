Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSCGCHO>; Wed, 6 Mar 2002 21:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290587AbSCGCHE>; Wed, 6 Mar 2002 21:07:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:42507 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290423AbSCGCG5>; Wed, 6 Mar 2002 21:06:57 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 6 Mar 2002 18:10:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Richard Henderson <rth@twiddle.net>
cc: Hubertus Franke <frankeh@watson.ibm.com>, Robert Love <rml@tech9.net>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
In-Reply-To: <20020306175846.B26064@twiddle.net>
Message-ID: <Pine.LNX.4.44.0203061808100.940-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Richard Henderson wrote:

> On Mon, Mar 04, 2002 at 02:15:58PM -0800, Davide Libenzi wrote:
> > That's great. What if the process holding the mutex dies while there're
> > sleeping tasks waiting for it ?
>
> The lock is lost.  The same thing would happen with locks completely
> implemented in userspace.
>
> I don't see that the kernel should do anything about this.  If a
> thread is killed with predudice (i.e. without pthread_cancel) then
> there are all sorts of cleanups that won't happen.  Having the
> kernel automatically unlock the locks doesn't help much, since
> the data structures are quite likely in an inconsistent state.

agreed, whatever solution does not solve it completely and makes things is
lot more complex. it's not an issue ...



- Davide


