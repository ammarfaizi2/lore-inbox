Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311586AbSCTGSB>; Wed, 20 Mar 2002 01:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311587AbSCTGRv>; Wed, 20 Mar 2002 01:17:51 -0500
Received: from [202.135.142.194] ([202.135.142.194]:60176 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311586AbSCTGRh>; Wed, 20 Mar 2002 01:17:37 -0500
Date: Wed, 20 Mar 2002 17:20:27 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ulrich Drepper <drepper@redhat.com>
Cc: martin.wirth@dlr.de, pwaechtler@loewe-komp.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Message-Id: <20020320172027.79a70ecd.rusty@rustcorp.com.au>
In-Reply-To: <1016510722.2194.101.camel@myware.mynet>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Mar 2002 20:05:22 -0800
Ulrich Drepper <drepper@redhat.com> wrote:

> On Mon, 2002-03-18 at 19:28, Rusty Russell wrote:
> 
> > What do you WANT in a kernel primitive then?  Given that we now have mutexes,
> > what else do we need to make pthreads relatively painless?
> 
> I think wrt to the mutexes only wake-all is missing.  I don't think that
> semaphore semantic is needed in the kernel.

And have all the waiters exit with errno = EAGAIN?  ("You didn't get it but
someone wanted you all woken").

It can be done, I'd have to see if is sufficient to implement pthreads.

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
