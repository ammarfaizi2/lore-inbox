Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbSKUROd>; Thu, 21 Nov 2002 12:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbSKUROd>; Thu, 21 Nov 2002 12:14:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266936AbSKUROb>;
	Thu, 21 Nov 2002 12:14:31 -0500
Message-ID: <3DDD1611.9010003@pobox.com>
Date: Thu, 21 Nov 2002 12:21:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: Andre Hedrick <andre@linux-ide.org>, Arjan van de Ven <arjanv@redhat.com>,
       David McIlwraith <quack@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
References: <1037875005.1863.0.camel@localhost.localdomain> <Pine.LNX.4.10.10211210503090.3892-100000@master.linux-ide.org> <20021121170224.GB5315@mark.mielke.cc>
In-Reply-To: <1037875005.1863.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:

> On Thu, Nov 21, 2002 at 05:08:45AM -0800, Andre Hedrick wrote:
>
> >On 21 Nov 2002, Arjan van de Ven wrote:
> >
> >>It is if the AUTHOR then decides to distribute the resulting binary
> >>which would contain a mix of GPL and non GPL work..
> >
> >The mix is a direct result of developers knowingly inlining critical C
> >code into the headers.  If this code was placed in proper .c files 
> and not
> >set in a .h then the potential for accidental mixing is removed.
> >This would limit and restrict the headers to being structs and extern
> >functions to call.
>
>
> Some (not all) of the inlined functions are 'inline' to accelerate the
> kernel.
>
> Perhaps, though, the inlined functions should be declared:
>
>    #ifdef __GNUC__
>    #  define INLINE extern inline
>    #else
>    #  define INLINE inline
>    #endif


[...]

Please review prior posts in this thread, notably from Andrew Morton and 
Cort Dougan.  They describe a much better method of doing this.

It still doesn't handle macros, though they are much less of a worry 
since Linux kernel emphasizes inlines over macros.

	Jeff




