Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287831AbSAFLxW>; Sun, 6 Jan 2002 06:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287832AbSAFLxM>; Sun, 6 Jan 2002 06:53:12 -0500
Received: from [195.66.192.167] ([195.66.192.167]:38405 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S287831AbSAFLxC>; Sun, 6 Jan 2002 06:53:02 -0500
Message-Id: <200201061151.g06BpvE04632@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: "vda@port.imtp.ilyichevsk.odessa.ua" 
	<vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 6 Jan 2002 13:51:58 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201050355300.11089-100000@shell1.aracnet.com>
In-Reply-To: <Pine.LNX.4.33.0201050355300.11089-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 January 2002 10:59, M. Edward (Ed) Borasky wrote:

> OK, here's some pseduo-code for a real-world test case. I haven't had a
> chance to code it up, but I'm guessing I know what it's going to do. I'd
> *love* to be proved wrong :).
>
> # build and boot a kernel with "Magic SysRq" turned on
> # echo  1 > /proc/sys/kernel/sysrq
> # fire up "nice --19 top" as "root"
> # read "MemTotal" from /proc/meminfo
>
> # now start the next two jobs concurrently
>
> # write a disk file with "MemTotal" data or more in it

Like dd if=/dev/zero of=/tmp/file bs=... count=... ?

> # perform a 2D in-place FFT of total size at least "MemTotal/2" but less
> # than "MemTotal"

I'm willing to try. What program can I use for FFT?

> What's worse is if the page cache gets so big that the FFT has to start
> swapping. For those who aren't familiar with 2D FFTs, they take two
> passes over the data. The first pass will be unit strides -- sequential
> addresses. But the second pass will be large strides -- a power of two.
> That second pass is going to be brutal if every page it hits has to be
> swapped in!

Can you describe FFT memory access pattern in more detail?
I'd like to write a simple testcase with similar 'bad' pattern.
--
vda
