Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291488AbSBACOp>; Thu, 31 Jan 2002 21:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291487AbSBACOe>; Thu, 31 Jan 2002 21:14:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44933 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290853AbSBACOV>;
	Thu, 31 Jan 2002 21:14:21 -0500
Date: Thu, 31 Jan 2002 21:14:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Kris Urquhart <kurquhart@littlefeet-inc.com>,
        "'Andreas Dilger'" <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: false positives on disk change checks
In-Reply-To: <B9F49C7F90DF6C4B82991BFA8E9D547B12570A@BUFORD.littlefeet-inc.com>
Message-ID: <Pine.GSO.4.21.0201312105210.624-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Jan 2002, Kris Urquhart wrote:

> No patches - linux-2.4.17 right off of www.linux.org.  
> 
> The chipset is an ALI 1487/1489.  
> The disk itself is a JUMPtec DISKchip with a SanDisk 20-99-00024-1 on it.
> 
> The relevant lines from dmesg are:
>  Uniform Multi-Platform E-IDE driver Revision: 6.31
>  ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
>  hda: SunDisk SDTB-128, ATA DISK drive
>  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>  hda: 31360 sectors (16 MB) w/1KiB Cache, CHS=490/2/32
>  Partition check:
>   hda: hda1 hda2 hda3
> 
> % cat /proc/ide/driver
> ide-disk version 1.10
> 
> There is a CONFIG_BLK_DEV_ALI14XX, but apparently it only turns on 
> support for the second channel.  I tried it anyway (along with the 
> ide0=ali14xx boot parameter), but the disk was then not recognized 
> at boot time (busy/timeout during partition check).  A google search 
> did not turn up any problems with ali14xx.c since 2.0.

Andre, looks like setup above gives false positives on disk change check...


