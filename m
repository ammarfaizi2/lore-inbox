Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315693AbSEIK4O>; Thu, 9 May 2002 06:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315695AbSEIK4N>; Thu, 9 May 2002 06:56:13 -0400
Received: from cm108.omega109.scvmaxonline.com.sg ([218.186.109.108]:24303
	"EHLO lal.cablix.com") by vger.kernel.org with ESMTP
	id <S315693AbSEIK4M>; Thu, 9 May 2002 06:56:12 -0400
Date: Thu, 9 May 2002 19:02:08 +0800 (SGT)
From: Ng Pek Yong <npy@mailhost.net>
To: DervishD <raul@viadomus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Slow harddisk
In-Reply-To: <3CDA50CE.mail6SA113L7B@viadomus.com>
Message-ID: <Pine.LNX.4.33.0205091900410.3354-100000@lal.cablix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, DervishD wrote:

>     Hi, Ng :))
> 
> > I/O support  =  3 (32-bit w/sync)
> 
>     Try w/o sync
> 
> > using_dma    =  0 (off)
> 
>     Enable dma
> 
>     This should increase the speed to normal levels.
> 
>     Raúl
> 

It got worse ;)

(note: I can;t get dma to work; see below)

# hdparm -X69 -d1 -u1 -c1 -m16 /dev/hde

/dev/hde:
 setting 32-bit I/O support flag to 1
 setting multcount to 16
 setting unmaskirq to 1 (on)
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 69 (UltraDMA mode5)
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
[root@lal root]# hdparm  -Tt /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  2.12 seconds = 60.38 MB/sec
 Timing buffered disk reads:  64 MB in 24.37 seconds =  2.63 MB/sec


