Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUGHOc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUGHOc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 10:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUGHOc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 10:32:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9350 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261932AbUGHOc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 10:32:56 -0400
Date: Thu, 8 Jul 2004 10:32:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "P. Benie" <pjb1008@eng.cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk>
Message-ID: <Pine.LNX.4.53.0407081030320.21855@chaos>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.53.0407080707010.21439@chaos>
 <Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2004, P. Benie wrote:

> On Thu, 8 Jul 2004, Richard B. Johnson wrote:
> > On Thu, 8 Jul 2004, Herbert Xu wrote:
> > > What's wrong with using 0 as the NULL pointer?
> >
> > Because NULL is a valid pointer value. 0 is not. If you were
> > to make 0 valid, you would use "(void *)0", which is what
> > NULL just happens to be in all known architectures so far,
> > although that could change in an alternate universe.
>
> False. "An integer constant expressions with the value 0, or such an
> expression cast to type void *, is called a null pointer constant. If a
> null pointer constant is assigned to or compared for equality with a
> pointer, the constant is converted to a pointer of that type", and "Any
> two null pointers shall compare equal."
>
> In other words, when you use 0 as a null pointer, you really do get a null
> pointer. If you are working on an architecture where the bit pattern of
> the integer 0 and null pointers are not the same, the compiler will
> perform the appropriate conversion for you, so it is always correct to
> define NULL as (void *)0.

That's NOT what is says. It states that a NULL pointer is converted to
the appropriate type before any comparison is made. It does NOT say
that 0 is a valid null-pointer.

>
> Personally, I always use 0 and NULL for integers and null pointers
> respectively, but that's because of long estalished conventions that make
> the code readabile, rather than anything to do with validity of the code.
>
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


