Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbTBCP3b>; Mon, 3 Feb 2003 10:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTBCP3J>; Mon, 3 Feb 2003 10:29:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:38808 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266777AbTBCP1u>; Mon, 3 Feb 2003 10:27:50 -0500
Date: Mon, 3 Feb 2003 10:39:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
In-Reply-To: <1044285222.2396.14.camel@gregs>
Message-ID: <Pine.LNX.3.95.1030203103314.4658A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Feb 2003, Grzegorz Jaskiewicz wrote:

> few days ago i started to port driver for our hardware in company from
> windows to linux. It is simple ISA card, which gives me interrupt each
> 8ms. So i can check it state and latch some sort of watchdog on it -
> saying that i am still running (just for security, if system hangs card
> is blocking all inputs/outputs). 
> 
> But anyway, i was collecting all data from the card in dynamically
> allocated memory. This gives me at least 300 * 20 bytes allocated. i
> have sigle small allocation running on each interrupt. 
> 
> Driver is working fine under win2k even if i collect as much as 10000
> allocations, afterwards system uses loads of processor. 
> 
> Linux (2.4.19 ,2.4.20, 2.4.21-pre[1,2,3,4] i tried so far) gives me oups
> arount 80th allocation.
> 
> >From http://hit-six.co.uk/~gj/testmod.tar.bz2 you can download simple
> module that shows what happends. But be carefull, it oupses very fast !
> 
> system is running up2dated Debian(stable), and i am using gcc version: 
> gcc version 2.95.4 20011002 

I doubt that there is a bug in vmalloc or kmalloc as you state because
the machine wouldn't work at all. So, I tried to download your sources.
The file web-page claims that it's a ".bz2" file. However, once
downloaded, it becomes a "*.tar.tar" file (whatever that is). An attempt
to extract it with `tar` as `tar -xzf` fails, as does `tar -xf`. Attempts
to un-bz2 it with bzip2 or even bzip2recover fails also.

So, if you want some help finding the problems, please email me
a 'tar.gz` file directly.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


