Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSLMTYV>; Fri, 13 Dec 2002 14:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSLMTYU>; Fri, 13 Dec 2002 14:24:20 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:19643 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265285AbSLMTYT> convert rfc822-to-8bit; Fri, 13 Dec 2002 14:24:19 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Margit Schubert-While <margitsw@t-online.de>
Subject: Re: Intel P6 vs P7 system call performance
Date: Fri, 13 Dec 2002 20:32:00 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200212132032.00505.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, in the 2.4.x kernels, the P4 gets compiled as a I686 with NO special
> treatment :-) (Not even prefetch, because of an ifdef bug)
> The P3 at least gets one level of prefetch and the AMD's get special compile
> options(arch=k6,athlon), full prefetch and SSE.
>
> >From Mike Hayward
> >Dual Pentium 4 Xeon 2.4Ghz 2.4.19 kernel 33661.9 lps (10 secs, 6 samples)
>
> Hmm, P4 2.4Ghz , also gcc -O3 -march=i686
>
> margit:/disk03/bytebench-3.1/src # ./hanoi 10
> 576264 loops
> margit:/disk03/bytebench-3.1/src # ./hanoi 10
> 571001 loops
> margit:/disk03/bytebench-3.1/src # ./hanoi 10
> 571133 loops
> margit:/disk03/bytebench-3.1/src # ./hanoi 10
> 570517 loops
> margit:/disk03/bytebench-3.1/src # ./hanoi 10
> 571019 loops
> margit:/disk03/bytebench-3.1/src # ./hanoi 10
> 582688 loops

Apples and oranges? ;-)

dual AMD Athlon MP 1900+, 1.6 GHz
(but single threaded app)
2.4.20-aa1
gcc-2.95.3

unixbench-4.1.0/src> gcc -O -mcpu=k6 -march=i686 -fomit-frame-pointer 
-mpreferred-stack-boundary=2 -malign-functions=4 -o hanoi hanoi.c
unixbench-4.1.0/src> sync
unixbench-4.1.0/src> ./hanoi 10                                                            
565338 loops
unixbench-4.1.0/src> ./hanoi 10
565379 loops
unixbench-4.1.0/src> ./hanoi 10
565448 loops
unixbench-4.1.0/src> ./hanoi 10
565218 loops
unixbench-4.1.0/src> ./hanoi 10
565148 loops
unixbench-4.1.0/src> ./hanoi 10
565136 loops

You should run "./Run hanoi"...

Recursion Test--Tower of Hanoi            58404.5 lps   (19.3 secs, 3 samples)

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
