Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310703AbSCHGa7>; Fri, 8 Mar 2002 01:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310704AbSCHGaq>; Fri, 8 Mar 2002 01:30:46 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:38148 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S310703AbSCHGa2>; Fri, 8 Mar 2002 01:30:28 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 7 Mar 2002 22:34:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Doug Siebert <dsiebert@divms.uiowa.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fast Userspace Mutexes (futex) vs. msem_*
In-Reply-To: <200203080615.g286Fqh24770@server.divms.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0203072232420.938-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Doug Siebert wrote:

> The direction that the futex implementation is going is looking a lot like
> how they are implemented on HP-UX (as well as Tru64 and AIX)  I am curious
> though why the case of "what happens if the process holding the lock dies"
> is considered unimportant by some people.  It wouldn't be all that much
> more work to "do it right" (IMHO) and handle this case.  AFAIK, on HP-UX
> the implementation kept a "locker id" and a linked list of waiters' lock
> ids (to allow first come first served as well as handling the case of a
> lock holder dying)  There was an underlying system call that was made when
> the userspace part in libc found the lock already held and waiting for the
> lock was desired.

Rusty, you should really make a futex-FAQ :-)




- Davide


