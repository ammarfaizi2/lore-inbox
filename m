Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSHAWcV>; Thu, 1 Aug 2002 18:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSHAWcV>; Thu, 1 Aug 2002 18:32:21 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:4871 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317280AbSHAWcU>; Thu, 1 Aug 2002 18:32:20 -0400
Date: Fri, 2 Aug 2002 00:35:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.33.0208011430450.1647-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208020009490.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 1 Aug 2002, Linus Torvalds wrote:

> This is not "sloppy programming". See the read() system call manual, which
> says
>
>      Upon successful completion, read(), readv(), and pread() return the num-
>      ber of bytes actually read and placed in the buffer.  The system guaran-
>      tees to read the number of bytes requested if the descriptor references a
>      normal file that has that many bytes left before the end-of-file, but in
>      no other case.
>
> Note the "The system guarantees to read the number of bytes requested .."
> part.

Relying on that the fd will always point to a normal file is only asking
for trouble.

> Stop arguing about this. It's a FACT.

Linus, it's not that I don't want to believe you, but e.g. the SUS doesn't
make that special exception.
Installing signal handlers and not expecting EINTR _is_ sloppy
programming.

bye, Roman

