Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbRE3Kz3>; Wed, 30 May 2001 06:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbRE3KzT>; Wed, 30 May 2001 06:55:19 -0400
Received: from kathy-geddis.astound.net ([24.219.123.215]:25604 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262722AbRE3KzA>; Wed, 30 May 2001 06:55:00 -0400
Date: Wed, 30 May 2001 03:55:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Frederic Soulier <frederic@wallaby.uklinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise Ultra100 TX2 pbm
In-Reply-To: <3B140F85.6FBCD9F1@wallaby.uklinux.net>
Message-ID: <Pine.LNX.4.10.10105300344250.3596-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Until I get some feed back that my patches will be accepted, there are a
lot of fixes and updates on hold.

Promise Ultra100 TX2, AMD760(MP), OSB4/CSB5.

Right now there is a 2.2.19 patch and that is it.

Since there are changes being made without understand the total scope of
the issues at hand, one should expect more problems not less in the
future.

When I finish adding 48-lba addressing, I will post a patch for 2.4.5 but
they will no longer be split up.  There are to many reports of problems an
the next patches will only be complete solutions to correct the current
kludge mess that we have.

Cheers,

On Tue, 29 May 2001, Frederic Soulier wrote:
> Hi Andre,
> 
> Sorry to bother you, I know your time is precious, so pls feel free to
> send this
> to /dev/null if you don't have time :)
> 
> I was wondering if the patch you issued on the 9th of April would fix
> this problem.
> I cannot set -d1 flag on the 2 disks on the Promise Ultra100 TX2
> 
> The throughput of my 2 hard disks on my Promise Controler is
> ridiculous...
> 
> # hdparm -t /dev/hda
> 
> /dev/hda:
>  Timing buffered disk reads:  64 MB in  2.87 seconds = 22.30 MB/sec
> 
> 
> # hdparm -t /dev/hde
> 
> /dev/hde:
>  Timing buffered disk reads:  64 MB in  38.04 seconds = 1.68 MB/sec
> 
> 
> # hdparm -t /dev/hdg
> 
> /dev/hdg:
>  Timing buffered disk reads:  64 MB in  37.13 seconds = 1.72 MB/sec
> 
> 
> .. maybe the reason is that I cannot set DMA for hde and hdf. I do not
> understand.
> 
> # hdparm -d1 /dev/hde
>    /dev/hde:
>     setting using_dma to 1 (on)
>     HDIO_SET_DMA failed: Operation not permitted
>     using_dma    =  0 (off)
> 
> # hdparm -d1 /dev/hdg
>    /dev/hdg:
>     setting using_dma to 1 (on)
>     HDIO_SET_DMA failed: Operation not permitted
>     using_dma    =  0 (off)
> 
> 
> Any help appreciated.
> Thanks
> Fred
> 
> 
> 3 hard disks:-
>    (A) 1 IBM 37Gb ATA/66 on ide0 onboard controler
>    (B) 1 IBM 41Gb GXP60 ATA/100 on ide2 promise controler Ultra100 TX2
>    (C) 1 IBM 25Gb ATA/66 on ide3 promise controler Ultra100 TX2
> 
> hdparm settings are:
> 
> /dev/hda (A)
> ------------
>    /dev/hda:
>     multcount    = 16 (on)
>     I/O support  =  3 (32-bit w/sync)
>     unmaskirq    =  1 (on)
>     using_dma    =  1 (on)
>     keepsettings =  0 (off)
>     nowerr       =  0 (off)
>     readonly     =  0 (off)
>     readahead    =  8 (on)
>    geometry     = 4160/255/63, sectors = 66835440, start = 0
> 
> 
> /dev/hde (B)
> ------------
>    /dev/hde:
>     multcount    = 16 (on)
>     I/O support  =  3 (32-bit w/sync)
>     unmaskirq    =  1 (on)
>     using_dma    =  0 (off)
>     keepsettings =  0 (off)
>     nowerr       =  0 (off)
>     readonly     =  0 (off)
>     readahead    =  8 (on)
>     geometry     = 79780/16/63, sectors = 80418240, start = 0
> 
> 
> /dev/hdg (C)
> ------------
>    /dev/hdg:
>     multcount    = 16 (on)
>     I/O support  =  3 (32-bit w/sync)
>     unmaskirq    =  1 (on)
>     using_dma    =  0 (off)
>     keepsettings =  0 (off)
>     nowerr       =  0 (off)
>     readonly     =  0 (off)   
>     readahead    =  8 (on)
>     geometry     = 53040/16/63, sectors = 53464320, start = 0
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

