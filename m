Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S160323AbPJUDMe>; Wed, 20 Oct 1999 23:12:34 -0400
Received: by vger.rutgers.edu id <S160819AbPJUDDy>; Wed, 20 Oct 1999 23:03:54 -0400
Received: from linuxcare.canberra.net.au ([203.29.91.49]:3760 "EHLO front.linuxcare.com.au") by vger.rutgers.edu with ESMTP id <S160526AbPJUCnl>; Wed, 20 Oct 1999 22:43:41 -0400
From: Paul Mackerras <paulus@linuxcare.com>
Organization: Linuxcare, Inc.
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: architecture bootup changes..
Date: Thu, 21 Oct 1999 12:33:25 +1000
X-Mailer: KMail [version 1.0.21]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.rutgers.edu
References: <Pine.LNX.4.10.9910201813380.836-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <99102112411604.19371@argo.linuxcare.com.au>
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 21 Oct 1999, Linus Torvalds wrote:

> And some
> things are more "struct page *" based than based on virtual kernel
> addresses, as the high memory support got cleaned up and better integrated
> in the memory management.

There's a problem that doesn't show up on intel, and that is that
flush_page_to_ram() is called with inconsistent arguments.  Sometimes it's
a struct page * (mm/filemap.c and mm/memory.c), in other cases it's a
kernel virtual address (e.g. kernel/ptrace.c, include/linux/highmem.h).

I'm inclined to think it should be a kernel virtual address.  Comments?

Regards,
Paul.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
