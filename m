Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTANTqt>; Tue, 14 Jan 2003 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbTANTqt>; Tue, 14 Jan 2003 14:46:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59014 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265099AbTANTqs> convert rfc822-to-8bit; Tue, 14 Jan 2003 14:46:48 -0500
Date: Tue, 14 Jan 2003 14:56:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DervishD <raul@pleyades.net>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <20030114195005.GD162@DervishD>
Message-ID: <Pine.LNX.3.95.1030114145417.13752A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, DervishD wrote:

>     Hi Richard :)
> 
> > >     Any header where I can see the length for argv[0] or is this some
> > > kind of unoficial standard? Just doing strcpy seems dangerous to me
> > > (you can read 'paranoid'...).
> > They need to have space for _POSIX_PATH_MAX (512 bytes), to
> > claim POSIX compatibility so any POSIX system will have at
> > least 512 bytes available because the pathname of the executable
> > normally goes there.
> 
>     Enough for me, then. Thanks a lot :)) Just one more thing: in my
> Single Unix Spec v3 says that the minimum value of _POSIX_PATH_MAX is
> 256, not 512, and the libc manual says just the same :??
> 
>     Anyway, 256 bytes is a fair large amount ;))))
> 
>     Thanks again, Richard.
> 
>     Raúl
> 
Well I just grepped through usr/include/bits/posix1_lim.h and it
shows 255 (with this 'C' library) so you are probably right.

In any event, a "whole line of text" isn't going to overrun it. 


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


