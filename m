Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291700AbSBALPN>; Fri, 1 Feb 2002 06:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291704AbSBALOz>; Fri, 1 Feb 2002 06:14:55 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46605
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291701AbSBALOh>; Fri, 1 Feb 2002 06:14:37 -0500
Date: Fri, 1 Feb 2002 03:06:20 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Kris Urquhart <kurquhart@littlefeet-inc.com>,
        "'Andreas Dilger'" <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: false positives on disk change checks
In-Reply-To: <Pine.GSO.4.21.0201312105210.624-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10202010303260.22985-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Alexander Viro wrote:

> 
> 
> On Thu, 31 Jan 2002, Kris Urquhart wrote:
> 
> > No patches - linux-2.4.17 right off of www.linux.org.  
> > 
> > The chipset is an ALI 1487/1489.  
> > The disk itself is a JUMPtec DISKchip with a SanDisk 20-99-00024-1 on it.
> > 
> > The relevant lines from dmesg are:
> >  Uniform Multi-Platform E-IDE driver Revision: 6.31
> >  ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
> >  hda: SunDisk SDTB-128, ATA DISK drive
> >  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> >  hda: 31360 sectors (16 MB) w/1KiB Cache, CHS=490/2/32
> >  Partition check:
> >   hda: hda1 hda2 hda3
> > 
> > % cat /proc/ide/driver
> > ide-disk version 1.10
> > 
> > There is a CONFIG_BLK_DEV_ALI14XX, but apparently it only turns on 
> > support for the second channel.  I tried it anyway (along with the 
> > ide0=ali14xx boot parameter), but the disk was then not recognized 
> > at boot time (busy/timeout during partition check).  A google search 
> > did not turn up any problems with ali14xx.c since 2.0.
> 
> Andre, looks like setup above gives false positives on disk change check...

What do you expect w/ removable media.
Obivious it has to be reporting an media status event change.
Gawd knows where I could find a copy of the hardware to verify.
If it puts a patch of mine on it and it is still present there is a
problem, if it goes away with the patch, the kernel should take the patch.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

