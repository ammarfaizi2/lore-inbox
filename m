Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290837AbSARVgb>; Fri, 18 Jan 2002 16:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290842AbSARVgZ>; Fri, 18 Jan 2002 16:36:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29056 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290837AbSARVgK> convert rfc822-to-8bit; Fri, 18 Jan 2002 16:36:10 -0500
Date: Fri, 18 Jan 2002 16:37:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DervishD <raul@viadomus.com>
cc: bgerst@didntduck.org, linux-kernel@vger.kernel.org, yinlei_yu@hotmail.com
Subject: Re: Is there anyway to use 4M pages on x86 linux in user level?
In-Reply-To: <E16RgGu-0005tD-00@DervishD.viadomus.com>
Message-ID: <Pine.LNX.3.95.1020118163202.3008A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, DervishD wrote:

>     Hi Brian :)
> 
> >The large page size is 4MB, except in PAE mode where they are 2MB. 
> >Normal pages are always 4KB.  Noting in the GDT affects the page
> >size.
> 
>     The entries in the GDT, do not set the page size for that
> descriptor? I'm certainly rusted on the i386 O:)))
> 
>     Raúl

Nope! You might be confusing the "granularity" number. This just
tells the CPU how to interpret the rest of the stuff. Right now
the base and limit is set for 32-bits for a, gawd help me, 
`segment`. You can go back to 16-bit segments if you want.

Paging is different, there's a single bit that controls the size
of a page; small or big, nothing in-between.  That's it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


