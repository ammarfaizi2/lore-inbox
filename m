Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSEaSVU>; Fri, 31 May 2002 14:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSEaSVT>; Fri, 31 May 2002 14:21:19 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:58760 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S316187AbSEaSVR>; Fri, 31 May 2002 14:21:17 -0400
Date: Fri, 31 May 2002 20:21:10 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: do_mmap
In-Reply-To: <Pine.LNX.3.95.1020531140509.2447A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.4.05.10205312012330.10681-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick,

--snip/snip


> > btw, is err should (according to alans explaination be):
> > 
> > 	return (unsigned long)ptr > (unsigned long)-1024UL;
> > 
> > 	tm
> > 
> 
> At the user-mode API, we get to (void *) -1, defined in sys/mman.h
> (actually (__ptr_t) -1); so whatever you do, the 'C' runtime library
> has to 'know' about your return values if this propagates to
> sys-calls.

the code right now, will pass all the errors through to the user
space in any case (beside a handful internal kernel-functions).

by changing unsigned long to void * everything should stay the same
(at least for todays architectures) - well if i'm wrong, please
enlighten me :)

also using IS_ERR is essentially the same as the other approaches
to check for errors (beside the check for == 0).

this means by "cleaning up" the internal functions, _nothing_ should
me impacted, even if the changes are step by step, function by function,
beside some gcc warnings (the well known: "assignment makes pointer from
integer without a cast").

cheers,

	tm

-- 
in some way i do, and in some way i don't.

