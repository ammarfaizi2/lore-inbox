Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292239AbSBYVbc>; Mon, 25 Feb 2002 16:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292275AbSBYVbU>; Mon, 25 Feb 2002 16:31:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48777 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292254AbSBYVa6>; Mon, 25 Feb 2002 16:30:58 -0500
Date: Mon, 25 Feb 2002 16:34:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Raphael Manfredi <Raphael_Manfredi@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
In-Reply-To: <2871.1014671286@nice.ram.loc>
Message-ID: <Pine.LNX.3.95.1020225163035.29043C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Raphael Manfredi wrote:

> Hi,
> 
> I run:
> 
> 	Linux nice 2.4.18-pre7 #1 SMP Mon Jan 28 23:12:48 MET 2002 i686 unknown
> 
> I noticed that whenever I do:
> 
> 	setsockopt(fd, SOL_SOCKET, SO_SNDBUF....)
> 
> followed by
> 
> 	getsockopt(fd, SOL_SOCKET, SO_SNDBUF....)
> 
> to verify what the kernel has set, I read TWICE as much the amount used
> for the set.  That is, if I set 8192, I read 16384.  Therefore, to set
> the correct size, I need to half the parameter first.

This came up a few months ago. Don't halve the size. The value was
explained to NOT be a bug even though it doesn't make sense to us
mortals. Just set the buffer size without reading anything. It will
be fine. The explaination was somewhat smokey, but It seems as though
two buffers are set aside or something like that. Just don't read
the size. Set it and forget it.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

