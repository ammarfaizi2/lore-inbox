Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSEIOh4>; Thu, 9 May 2002 10:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313189AbSEIOhz>; Thu, 9 May 2002 10:37:55 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46609 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313184AbSEIOhx>; Thu, 9 May 2002 10:37:53 -0400
Date: Thu, 9 May 2002 10:34:18 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ng Pek Yong <npy@mailhost.net>
cc: DervishD <raul@viadomus.com>, linux-kernel@vger.kernel.org
Subject: Re: Slow harddisk
In-Reply-To: <Pine.LNX.4.33.0205091900410.3354-100000@lal.cablix.com>
Message-ID: <Pine.LNX.3.96.1020509103129.7914C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, Ng Pek Yong wrote:

> It got worse ;)
> 
> (note: I can;t get dma to work; see below)
> 
> # hdparm -X69 -d1 -u1 -c1 -m16 /dev/hde
> 
> /dev/hde:
>  setting 32-bit I/O support flag to 1
>  setting multcount to 16
>  setting unmaskirq to 1 (on)
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  setting xfermode to 69 (UltraDMA mode5)
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  0 (off)
> [root@lal root]# hdparm  -Tt /dev/hde

Time to investigate why DMA doesn't work, rather than spending time trying
to run without it. Did you build your kernel with DMA in the IDE part, by
default, and enable chip specific features? I suspect the chipset is not
being DMA enbled, as was the case when I had a similar issue.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

