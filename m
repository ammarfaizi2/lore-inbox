Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267109AbSLDWBX>; Wed, 4 Dec 2002 17:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbSLDWBX>; Wed, 4 Dec 2002 17:01:23 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:54671 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267109AbSLDWBV>; Wed, 4 Dec 2002 17:01:21 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Mike Galbraith <efault@gmx.de>, root@chaos.analogic.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Reserving physical memory at boot time
Date: Wed, 4 Dec 2002 07:15:13 +0100
User-Agent: KMail/1.4.7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1038952684.11426.106.camel@irongate.swansea.linux.org.uk> <5.1.1.6.2.20021204165742.00c6a180@pop.gmx.net>
In-Reply-To: <5.1.1.6.2.20021204165742.00c6a180@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212040715.13409.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 December 2002 17:44, Mike Galbraith wrote:
> At 08:25 AM 12/4/2002 -0500, Richard B. Johnson wrote:
> >On 3 Dec 2002, Alan Cox wrote:
> > > On Tue, 2002-12-03 at 21:11, Richard B. Johnson wrote:
> > > > If you need a certain page reserved at boot-time you are out-of-luck.
> > >
> > > Wrong - you can specify the precise memory map of a box as well as use
> > > mem= to set the top of used memory. Its a painful way of marking a page
> > > and it only works for a page the kernel isnt loaded into.
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

I actually said I was happy to modify the kernel!  As for __alloc_bootmem(),
based on my quick reading of the implementation in 2.5.50, I don't see how
you can be sure it will give you a particular physical page.  I would like to
either get the page I want, or fail.

Thanks for your help,

Duncan.
