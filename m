Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRHRTPv>; Sat, 18 Aug 2001 15:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRHRTPl>; Sat, 18 Aug 2001 15:15:41 -0400
Received: from astcc-153.astound.net ([24.219.123.215]:45319 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266448AbRHRTPZ>; Sat, 18 Aug 2001 15:15:25 -0400
Date: Sat, 18 Aug 2001 12:14:26 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Frank Neuber <frank.neuber@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUGFIX: UDMA-SiS5513 chipset support
In-Reply-To: <Pine.LNX.3.96.1010818151105.1982A-200000@mars.private.de>
Message-ID: <Pine.LNX.4.10.10108181211530.24147-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Frank,

Not the correct solution, you should not set autodma.
This will prevent DMA from being used at INIT; however, you can still
attempt it later.  This patch is an invalid solution, period.

Regards,

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Tel: (510) 857-0055
38875 Cherry Street                           Fax: (510) 857-0010
Newark, CA 94560                              Web: www.aslab.com

On Sat, 18 Aug 2001, Frank Neuber wrote:

> Hi,
> recently I did an upgrade of my old computer (ASUS SP97-V) to
> the kernel-2.4.7.
> 
> Problem:
>   My system was crashing even when I load the module ide-disk.o
> Solution:
>   Because of the broken hardware (some UDMA problems with an non
>   UDMA-Cabel to the drive) the linux kernel hangs during ide_dma_check.
>   Even if UDMA is disabeld in the bios, the kernel detect this drive as
>   an udma drive. And this is wrong!!
>   My solution was simply to comment out the ide_dma_check in ide.c.
>   You can find this patch as attachment.
> 
> Frank	
> 
> -- 
>      _/_/_/_/ _//   _/ Frank Neuber
>     _/       _/_/  _/  frank.neuber@gmx.de (private)
>    _/_/_/   _/ _/ _/
>   _/       _/  _/_/    neuber@opensource-systemberatung.de
>  _/       _/    // http://www.opensource-systemberatung.de
> 

