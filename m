Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbSLDQlN>; Wed, 4 Dec 2002 11:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266918AbSLDQlN>; Wed, 4 Dec 2002 11:41:13 -0500
Received: from pop.gmx.de ([213.165.64.20]:13179 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S266898AbSLDQlL>;
	Wed, 4 Dec 2002 11:41:11 -0500
Message-Id: <5.1.1.6.2.20021204165742.00c6a180@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 04 Dec 2002 17:44:12 +0100
To: root@chaos.analogic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Reserving physical memory at boot time
Cc: Duncan Sands <baldrick@wanadoo.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021204082313.23777A-100000@chaos.analogic.c
 om>
References: <1038952684.11426.106.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:25 AM 12/4/2002 -0500, Richard B. Johnson wrote:
>On 3 Dec 2002, Alan Cox wrote:
>
> > On Tue, 2002-12-03 at 21:11, Richard B. Johnson wrote:
> > > If you need a certain page reserved at boot-time you are out-of-luck.
> >
> > Wrong - you can specify the precise memory map of a box as well as use
> > mem= to set the top of used memory. Its a painful way of marking a page
> > and it only works for a page the kernel isnt loaded into.
> >
>
>If you are refering to the "reserve=" kernel parameter, I don't
>think it works for memory addresses that are inside existing RAM.
>I guess if you used the "mem=" parameter to keep the kernel from
>using that RAM, the combination might work, but I have never
>tried it.

reserve= is for IO ports (kernel/resource.c). I think Alan was referring to 
mem=exactmap.

If Duncan didn't have the pesky requirement that his module work in an 
unmodified kernel, it would be easy to use __alloc_bootmem() to reserve an 
address range and expose via /proc.  But alas...

         -Mike


