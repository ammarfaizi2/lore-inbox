Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154890AbPKESKn>; Fri, 5 Nov 1999 13:10:43 -0500
Received: by vger.rutgers.edu id <S154849AbPKESEM>; Fri, 5 Nov 1999 13:04:12 -0500
Received: from neon-best.transmeta.com ([206.184.214.10]:20553 "EHLO neon.transmeta.com") by vger.rutgers.edu with ESMTP id <S154829AbPKESB7>; Fri, 5 Nov 1999 13:01:59 -0500
Date: Fri, 5 Nov 1999 10:04:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: EISA i/o mem & ioremap vs isa_memcpy
In-Reply-To: <3821F95D.60EC8B0C@yahoo.com>
Message-ID: <Pine.LNX.4.10.9911051003180.1748-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Thu, 4 Nov 1999, Paul Gortmaker wrote:
> 
> My question is: Does adding the isa_ prefix to the memcpy (and readb &
> friends) make sense for these EISA cases or should I just do the ioremap()
> unconditionally and not use the isa_ prefix.  I tend to prefer the latter.

Just do the ioremap() unconditionally.

Note that the isa_xxxx() functions are for old drivers that do NOT know
about ioremap(), and think that the ISA space is always mapped. Think of
it as a band-aid for stupid drivers, making it easier to bring them up to
working order. But the "ioremap()" approach is always the right one.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
