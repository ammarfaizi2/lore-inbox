Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313702AbSEHMTe>; Wed, 8 May 2002 08:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313578AbSEHMTd>; Wed, 8 May 2002 08:19:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49024 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313571AbSEHMTc>; Wed, 8 May 2002 08:19:32 -0400
Date: Wed, 8 May 2002 08:21:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Serguei I. Ivantsov" <administrator@svitonline.com>
cc: linux-gcc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Measure time
In-Reply-To: <abaokj$ugl$1@news.lucky.net>
Message-ID: <Pine.LNX.3.95.1020508081422.3374A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Serguei I. Ivantsov wrote:

> Hello!
> 
> Is there any function for high precision time measuring.
> time() returns only in second. I need nanoseconds.
> 
> --
>  Regards,
>   Serguei I. Ivantsov
>    GSC Game World
> 

gettimeofday() returns seconds/microseconds. If you need nanoseconds,
you can read CPU clock cycles in Intel machines with (assembly) rdtsc
instructions and convert, based upon the CPU clock.

If you really need nanosecond resolution in code that may be
interrupted or preempted at any time, you are in a world of hurt.
I suggest you review the requirement. You may need a TMS320C30 or
similar DSP standing alone.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

