Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSEaSiF>; Fri, 31 May 2002 14:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSEaSiE>; Fri, 31 May 2002 14:38:04 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18816 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316538AbSEaSiD>; Fri, 31 May 2002 14:38:03 -0400
Date: Fri, 31 May 2002 14:38:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: do_mmap
In-Reply-To: <Pine.GSO.4.05.10205312012330.10681-100000@mausmaki.cosy.sbg.ac.at>
Message-ID: <Pine.LNX.3.95.1020531143216.2645A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2002, Thomas 'Dent' Mirlacher wrote:

> Dick,
> 
> --snip/snip
> 
> 
> > > btw, is err should (according to alans explaination be):
> > > 
> > > 	return (unsigned long)ptr > (unsigned long)-1024UL;
> > > 
> > > 	tm
> > > 
> > 
> > At the user-mode API, we get to (void *) -1, defined in sys/mman.h
> > (actually (__ptr_t) -1); so whatever you do, the 'C' runtime library
> > has to 'know' about your return values if this propagates to
> > sys-calls.
> 
> the code right now, will pass all the errors through to the user
> space in any case (beside a handful internal kernel-functions).
> 
> by changing unsigned long to void * everything should stay the same
> (at least for todays architectures) - well if i'm wrong, please
> enlighten me :)
> 
> also using IS_ERR is essentially the same as the other approaches
> to check for errors (beside the check for == 0).
> 
> this means by "cleaning up" the internal functions, _nothing_ should
> me impacted, even if the changes are step by step, function by function,
> beside some gcc warnings (the well known: "assignment makes pointer from
> integer without a cast").
> 
> cheers,
> 
> 	tm
> 

Good. It was just a 'sanity-check' as these things caught my
eye. Because I have to fix a lot of junk code that others have
written (here at work), as they become Peter-principled to
higher-level positions, I get sensitized to these things.
No complaint -- I like fixing junk code!
The previously line was written for Network Security Administrators
(Hello Thor).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

