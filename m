Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTAPOO2>; Thu, 16 Jan 2003 09:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTAPOO2>; Thu, 16 Jan 2003 09:14:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11657 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267117AbTAPOO1>; Thu, 16 Jan 2003 09:14:27 -0500
Date: Thu, 16 Jan 2003 09:25:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux Geek <bourne@ToughGuy.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tar'ing /proc ???
In-Reply-To: <3E26BF92.3020303@ToughGuy.net>
Message-ID: <Pine.LNX.3.95.1030116092224.4430B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Linux Geek wrote:

> 
> 
> Richard B. Johnson wrote:
> 
> >Normally, you do `tar -clf`
> >                        |________ stay on the same file-system.
> >Otherwise toy need to use --exclude /proc.  Proc is a virtual
> >file-system that contains things like kcore. You can get into
> >a deadlock when reading kcore and you don't want this in your
> >backup anyway.
> >
> >
> >  
> >
> so it means,  I can read /proc , write through sysctl interface but no 
> 'copy' business ;-) .

Well you can use `cp` or `cat` because they don't use large amounts
of data that gets extended by calling the kernel to set the break
address (which can cause a deadlock). `tar` keeps allocating more
memory when it reads this large 'file'.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


