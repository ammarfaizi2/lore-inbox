Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSFCV3E>; Mon, 3 Jun 2002 17:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSFCV3D>; Mon, 3 Jun 2002 17:29:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29824 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315593AbSFCV3D>; Mon, 3 Jun 2002 17:29:03 -0400
Date: Mon, 3 Jun 2002 17:30:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Thunder from the hill <thunder@ngforever.de>
cc: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>,
        "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Atomic operations
In-Reply-To: <Pine.LNX.4.44.0206031335090.3833-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.3.95.1020603172937.1840A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Thunder from the hill wrote:

> Hi,
> 
> On Mon, 3 Jun 2002, Richard B. Johnson wrote:
> > atomic_t test_and_set(int i, atomic_t *v)
> > {
> >     int ret;
> > 
> >     __asm__ __volatile__(LOCK "movl (%1), %ecx\n"
> >                          LOCK "orl   %0,  (%1)\n" 
> > 	: "ecx" (ret) 
> > 	: "r" (i), "m" (v)
> > 	: "ecx", "memory" );
> > 
> >     return (ret & i);
> > }
> 
> I'm not an expert, but shouldn't "exc" be quoted here? I'm just 
                                    ecx 
                           Yes, we both make typos!
> wondering...



Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

