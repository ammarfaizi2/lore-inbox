Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278309AbRKAIPh>; Thu, 1 Nov 2001 03:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278338AbRKAIP1>; Thu, 1 Nov 2001 03:15:27 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:64775 "HELO smeg")
	by vger.kernel.org with SMTP id <S278309AbRKAIPL>;
	Thu, 1 Nov 2001 03:15:11 -0500
Message-ID: <2644.192.168.2.1.1004602385.squirrel@mail.mswinxp.net>
Date: Thu, 1 Nov 2001 08:13:05 -0000 (GMT)
Subject: Re: kbuild 2.5 preventing mixture of compilers
From: "Lee Packham" <linux@mswinxp.net>
To: kaos@ocs.com.au
In-Reply-To: <26322.1004575402@kao2.melbourne.sgi.com>
In-Reply-To: <26322.1004575402@kao2.melbourne.sgi.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO, that is a good idea... almost.

What about companies that maintain closed source driver modules for their 
hardware?

I know a lot of people here will say, 'well they should open source them 
then'. However, some companies don't want to for their own reasons and 
this 'could' blow them out the water a bit and affect end users.

>From a stability point of view, this may seem like an excellent idea. I'm 
just scared that this could put companies off producing driver modules for 
their hardware.

Lee Packham

> FYI, kbuild 2.5 will check that all the kernel and modules were
> compiled with the same version of gcc, in particular they must all have
> the same value of
> 
>   $(CC) -v 2>&1 | sed -ne '1s:.*/\([^/]*/[^/]*\)/[^/]\+$:\1:p'
> 
> e.g. i386-redhat-linux/2.96
> 
> Minor version data such as build date is assumed to be irrelevant.
> Anybody who makes significant changes to compiler output without
> changing the version number gets what they deserve.
> 
> Modules built with a different compiler from the kernel will not load
> unless they are forced with insmod -f.
> 
> Is this going to cause problems for anybody?  I see no justification
> for mixing kernel objects built by different compilers and I know of
> problems that have been caused by doing so.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


