Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130222AbRBKUlc>; Sun, 11 Feb 2001 15:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130285AbRBKUlW>; Sun, 11 Feb 2001 15:41:22 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:47625 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130222AbRBKUlG>; Sun, 11 Feb 2001 15:41:06 -0500
Date: Sun, 11 Feb 2001 20:41:04 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>, <ak@suse.de>
Subject: Re: BUG: SO_LINGER + shutdown() does not block?
In-Reply-To: <200102112021.XAA15811@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0102112035230.16987-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[cc: Andi]

On Sun, 11 Feb 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > I'm not seeing shutdown(2) block on a TCP socket. This is Linux kernel
> > 2.2.16 (RH7.0). Is this a kernel bug, a documentation bug,
>
> Man page is wrong.

Yes, man socket(7) seems to be wrong.

I don't have access to a genuine BSD at the moment, but from man pages:
- HP/UX specifically states that SO_LINGER has no effect on shutdown()
- Solaris SO_LINGER only mentions that close() is affected.
- Likewise FreeBSD

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
