Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbSLDQv5>; Wed, 4 Dec 2002 11:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbSLDQv5>; Wed, 4 Dec 2002 11:51:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23174 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266976AbSLDQv4>; Wed, 4 Dec 2002 11:51:56 -0500
Date: Wed, 4 Dec 2002 12:01:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Galbraith <efault@gmx.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Duncan Sands <baldrick@wanadoo.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reserving physical memory at boot time
In-Reply-To: <5.1.1.6.2.20021204165742.00c6a180@pop.gmx.net>
Message-ID: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2002, Mike Galbraith wrote:

> At 08:25 AM 12/4/2002 -0500, Richard B. Johnson wrote:
> >On 3 Dec 2002, Alan Cox wrote:
> >
> > > On Tue, 2002-12-03 at 21:11, Richard B. Johnson wrote:
> > > > If you need a certain page reserved at boot-time you are out-of-luck.
> > >
> > > Wrong - you can specify the precise memory map of a box as well as use
> > > mem= to set the top of used memory. Its a painful way of marking a page
> > > and it only works for a page the kernel isnt loaded into.
> > >
> >
> >If you are refering to the "reserve=" kernel parameter, I don't
> >think it works for memory addresses that are inside existing RAM.
> >I guess if you used the "mem=" parameter to keep the kernel from
> >using that RAM, the combination might work, but I have never
> >tried it.
> 
> reserve= is for IO ports (kernel/resource.c). I think Alan was referring to 
> mem=exactmap.
> 
> If Duncan didn't have the pesky requirement that his module work in an 
> unmodified kernel, it would be easy to use __alloc_bootmem() to reserve an 
> address range and expose via /proc.  But alas...
> 
>          -Mike
> 

Well that parameter is not documented in:

        .../linux-2.4.18/Documentation/kernel-parameters.txt.

Perhaps it's a 2.5.++ thing.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


