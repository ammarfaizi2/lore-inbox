Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRDSQrD>; Thu, 19 Apr 2001 12:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRDSQq4>; Thu, 19 Apr 2001 12:46:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28939 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131457AbRDSQqu>; Thu, 19 Apr 2001 12:46:50 -0400
Date: Thu, 19 Apr 2001 09:46:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Alan Cox wrote:
> > can libraries use fast semaphores behind the back of the user? They might
> > well want to use the semaphores exactly for things like memory allocator
> > locking etc. But libc certainly cant use fd's behind peoples backs.
>
> libc is entitled to, and most definitely does exactly that. Take a look at
> things like gethostent, getpwent etc etc.

Ehh.. I will bet you $10 USD that if libc allocates the next file
descriptor on the first "malloc()" in user space (in order to use the
semaphores for mm protection), programs _will_ break.

You want to take the bet?

		Linus

