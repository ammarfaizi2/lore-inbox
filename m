Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbRFQUiX>; Sun, 17 Jun 2001 16:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbRFQUiN>; Sun, 17 Jun 2001 16:38:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21242 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262829AbRFQUh6>;
	Sun, 17 Jun 2001 16:37:58 -0400
Date: Sun, 17 Jun 2001 16:37:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Flynn <Dave@keston.u-net.com>, rjd@xyzzy.clara.co.uk,
        Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <0106172208230T.00879@starship>
Message-ID: <Pine.GSO.4.21.0106171628350.15952-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Jun 2001, Daniel Phillips wrote:

> > macro that behaves like `new' in C++:
> > | #define knew(type, flags)	(type *)kmalloc(sizeof(type), (flags))
> >
> > If the types in the assignment don't match, gcc will tell you.
> 
> Well, since we are still beating this one to death, I'd written a "knew" 
> macro as well, and put it aside.  It does the assignment for you too:
> 
>    #define knew(p) ((p) = (typeof(p)) kmalloc(sizeof(*(p)), GFP_KERNEL))
 
> Terse and clear at the same time, and type safe.  I still don't like it much. 

And ungreppable, not to mention gratitious use of GNU extension.

