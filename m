Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160422AbQHBGmM>; Wed, 2 Aug 2000 02:42:12 -0400
Received: by vger.rutgers.edu id <S160421AbQHBGlY>; Wed, 2 Aug 2000 02:41:24 -0400
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:1972 "HELO t1.ctrl-c.liu.se") by vger.rutgers.edu with SMTP id <S160420AbQHBGkn>; Wed, 2 Aug 2000 02:40:43 -0400
Date: 2 Aug 2000 06:52:26 -0000
Message-ID: <20000802065226.29333.qmail@t1.ctrl-c.liu.se>
From: wingel@t1.ctrl-c.liu.se
To: David.Howells@nexor.co.uk
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Newsgroups: linux.kernel
In-Reply-To: <20000801073357Z157113-15702+213@vger.rutgers.edu>
References: <7iw6lD2Xw-B@khms.westfalen.de>
Organization: 
Sender: owner-linux-kernel@vger.rutgers.edu

David.Howells@nexor.co.uk wrote:

>Kai Henningsen wrote:
>> I notice just about everybody suggesting absolute paths.
>>
>> Try relative paths or environment variables instead. This has the  
>> advantage of working anywhere you damn well please.
>
>Relative to what? Which environment variables? Who sets these variables?

Relative to the current directory of course.

I've been propagating for this too, since it makes life so much easier
for people compiling multiple versions of the kernel.

The idea is that you tell people to untar the sources for whatever kernel
related packages at the same place they untarred the kernel sources.  For
most users this will mean /usr/src (i.e. on a RedHat system).

So for the simple case:

    /usr/src/linux
    /usr/src/pcmcia-cs
    /usr/src/my-whizbang-adapter

and the pcmcia-cs and whizbang packages simply have line in Makefile saying:

    KERNELDIR=../linux

For somebody who's playing around with multiple kernels, it would
look something like this:

    /usr/src/kernel-2.2.16/linux
    /usr/src/kernel-2.2.16/pcmcia-cs
    /usr/src/kernel-2.2.16/my-whizbang-adapter

    /usr/src/kernel-2.2.17pre3/linux
    /usr/src/kernel-2.2.17pre3/pcmcia-cs
    /usr/src/kernel-2.2.17pre3/my-whizbang-adapter

And this will work with _no_ modifications to the sources and without
any need to set environment variables.  How much easier can it get?

    /Christer
-- 
"Just how much can I get away with and still go to heaven?"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
