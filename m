Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269926AbRHSDH0>; Sat, 18 Aug 2001 23:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269927AbRHSDHQ>; Sat, 18 Aug 2001 23:07:16 -0400
Received: from mail.mesatop.com ([208.164.122.9]:29706 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S269926AbRHSDHF>;
	Sat, 18 Aug 2001 23:07:05 -0400
Message-Id: <200108190307.f7J373e23205@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Luigi Genoni <kernel@Expansa.sns.it>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: disk I/O slower with kernel 2.4.9
Date: Sat, 18 Aug 2001 21:06:48 -0400
X-Mailer: KMail [version 1.2.3]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108190319080.2859-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0108190319080.2859-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 August 2001 09:19 pm, Luigi Genoni wrote:
> I still have to try it, tomorrow i will post the results....
>
> On Sat, 18 Aug 2001, Rik van Riel wrote:
> > On Sun, 19 Aug 2001, Luigi Genoni wrote:
> > > just making time make -j 2 bzImage with kernel source 2.4.9
> > > gives me:
> > >
> > > real    3m36.041s
> > > user    2m2.950s
> > > sys     0m9.740s
> > >
> > > while compiling the same sources running kernel 2.4.7 gives:
> > >
> > > real    2m28.350s
> > > user    1m56.150s
> > > sys     0m5.262s
> >
> > How does 2.4.8-ac7 do ?
> >
> > Rik

Rik, Luigi:

Excuse me for jumping in, but here are a few more data points,
using a slower system. I built 2.4.8-ac7 with the following kernels, using:

time make -j2 'MAKE = make -j2' bzImage

to produce the output. Yes, I know this is overkill for an UP system.
This version of time is GNU time 1.7.  Each kernel build was performed
right after the boot and login, running KDE 2.2 and an xterm.

The system is UP, PIII 450, 384 MB, ATA-33, /usr/src mounted ReiserFS
on a WDC WD102AA, the rest of the system ReiserFS on a WDC WD136AA.

2.4.7
681.66user 80.16system 13:32.51elapsed 93%CPU (0avgtext+0avgdata 
0maxresident)k

2.4.8
682.90user 83.25system 13:29.98elapsed 94%CPU (0avgtext+0avgdata 
0maxresident)k

2.4.9
684.77user 80.55system 13:32.35elapsed 94%CPU (0avgtext+0avgdata 
0maxresident)k

2.4.8-ac7
683.99user 80.54system 13:21.91elapsed 95%CPU (0avgtext+0avgdata 
0maxresident)k

Steven
