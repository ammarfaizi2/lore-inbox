Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289600AbSAPWWT>; Wed, 16 Jan 2002 17:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289859AbSAPWWK>; Wed, 16 Jan 2002 17:22:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:51329 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289861AbSAPWV6>; Wed, 16 Jan 2002 17:21:58 -0500
Date: Wed, 16 Jan 2002 17:23:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Zealey <mark@zealos.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: floating point exception
In-Reply-To: <20020116221247.GA3769@itsolve.co.uk>
Message-ID: <Pine.LNX.3.95.1020116172116.15534A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Mark Zealey wrote:

> On Wed, Jan 16, 2002 at 05:05:55PM -0500, Richard B. Johnson wrote:
> 
> >     for(;;)
> >     {
> >         srand(seed); 
            ^^^^^^^^^^^^^^^^

> >         z = x;
> >         for(i = 0; i < MAX_FLOAT; i++)
> >             *z++ = cos((double) rand());
> >         srand(seed);
            ^^^^^^^^^^^^^

> >         z = y;
> >         for(i = 0; i < MAX_FLOAT; i++)
> >             *z++ = cos((double) rand());
> >         if(memcmp(x, y, MAX_FLOAT * sizeof(double)))
> >             break;
> >         seed = rand();
> 
> Um, maybe I'm not reading this properly.. why are you randing, doing 1 set and
> then using different random values for the other set ?

I am NOT. I am setting the seed BACK to whatever it was for the first
set with srand(seed). After the compare, I change the seed.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


