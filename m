Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRHAXJF>; Wed, 1 Aug 2001 19:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbRHAXIz>; Wed, 1 Aug 2001 19:08:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64427 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267621AbRHAXIq>;
	Wed, 1 Aug 2001 19:08:46 -0400
Date: Wed, 1 Aug 2001 19:08:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: bristuccia@starentnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: repeated failed open()'s results in lots of used memory [Was:
 [Fwd: memory consumption]]
In-Reply-To: <200108012254.f71Ms4W14080@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108011901170.27494-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Aug 2001, Linus Torvalds wrote:

>  - make all the things that shrink dentries (notably the
>    shrink_dcache_memory() function) call the above function first. 
> 
> Does that fix the behaviour for you?

That will kill _all_ negative dentries whenever we get any amount of
memory pressure. For stuff a-la $PATH it will get very ugly - currently
we have a lot of negative dentries in /usr/local/bin that prevent tons
of bogus lookups there,

