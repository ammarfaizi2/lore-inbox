Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSHHIR2>; Thu, 8 Aug 2002 04:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSHHIR2>; Thu, 8 Aug 2002 04:17:28 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7430 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S317373AbSHHIR1>;
	Thu, 8 Aug 2002 04:17:27 -0400
Date: Thu, 8 Aug 2002 10:20:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Bruce M Beach <brucemartinbeach@21cn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE numbers
Message-ID: <20020808082059.GD943@alpha.home.local>
References: <Pine.LNX.4.43.0208081211180.224-100000@systemx.zsu.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0208081211180.224-100000@systemx.zsu.edu.cn>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 12:19:22PM +0000, Bruce M Beach wrote:
 
>   time cp TEMP.tar ... hda3->hda1   49m18.320s ~  3,339,200.9 bytes/s

slow because it's the same disk, so the head constantly move back and forth
between hda1 and hda3. You are limited by seek time.

>   time cp TEMP.tar ... hdc1->sda1   51m16.493s

are you sure it was "hdc1" ? I can't see it in your dmesg below.

>   time cp TEMP.tar ... sda1->scb1    5m41.388s ~ 28,936,063   bytes/s

seems correct to me, I had the same numbers with 7200 RPM seagate drives too.

Regards,
Willy

>   PCI_IDE: not 100% native mode: will probe irqs later
>       ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
>       ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
>   hda: ST360021A, ATA DISK drive
>   hdb: 16X10, ATAPI CD/DVD-ROM drive
>   ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>   hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63
>   Partition check:
>    /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
