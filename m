Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbTBDVcK>; Tue, 4 Feb 2003 16:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbTBDVcK>; Tue, 4 Feb 2003 16:32:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14606 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267399AbTBDVcJ>; Tue, 4 Feb 2003 16:32:09 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: gcc 2.95 vs 3.21 performance
Date: Tue, 4 Feb 2003 21:38:48 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b1pbt8$2ll$1@penguin.transmeta.com>
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net>
X-Trace: palladium.transmeta.com 1044394865 8168 127.0.0.1 (4 Feb 2003 21:41:05 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Feb 2003 21:41:05 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200302041935.h14JZ69G002675@darkstar.example.net>,
John Bradford  <john@grabjohn.com> wrote:
>>    I'm hesitant to enter into this.  But from my own experience
>> the issue with big companies supporting these sort of changes 
>> in gcc have more to do with the acceptance process of changes 
>> into gcc than a lack of desire on the large companies part.
>
>Maybe we should create a KGCC fork, optimise it for kernel
>complilations, then try to get our changes merged back in to GCC
>mainline at a later date.

That's not really the problem.

I think the problem with gcc is that many of the developers are actually
much more interested in Ada or C++ (or even Fortran!), than in plain
old-fashioned C.  So it's not a kernel issue per se, gcc is slow to
compile _any_ C project. 

And a lot of the optimizations gcc does aren't even interesting to most
C projects.  Most "old-fashioned" C projects tend to be written in ways
that mean that the most important optimizations are the truly trivial
ones, and then doing good register allocation.

I'd love to see a small - and fast - C compiler, and I'd be willing to
make kernel changes to make it work with it.  

Let's see. There's been some noises on the gcc lists about splitting up
the languages for easier maintenance, we'll see what happens.

		Linus

