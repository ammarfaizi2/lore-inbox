Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289137AbSAGIjW>; Mon, 7 Jan 2002 03:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSAGIjN>; Mon, 7 Jan 2002 03:39:13 -0500
Received: from mail.zmailer.org ([194.252.70.162]:53120 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S289135AbSAGIjD>;
	Mon, 7 Jan 2002 03:39:03 -0500
Date: Mon, 7 Jan 2002 10:38:43 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
Message-ID: <20020107103843.B1914@mea-ext.zmailer.org>
In-Reply-To: <20020104163635.A1268@mea-ext.zmailer.org>, <20020104163635.A1268@mea-ext.zmailer.org>; <20020107100022.A1914@mea-ext.zmailer.org> <3C395A2C.B7A24844@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C395A2C.B7A24844@zip.com.au>; from akpm@zip.com.au on Mon, Jan 07, 2002 at 12:19:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 12:19:56AM -0800, Andrew Morton wrote:
> Matti Aarnio wrote:
> >   I have partial evidence that EXT3 may be part of the problem,
> >   as another machine with RAID-1 disks with EXT2 filesystems
> >   is not hanging up when running RedHat 2.4.16-0.9custom kernel.
> >   That another machine has, however, IDE disks.
> 
> I'd be surprised if an ext3 bug could cause a freeze as solid
> as this one.  ext3's write submission patterns are somewhat different
> from other filesystems, and we've exposed a few problem in underlying
> layers in the past because of this.  But who knows...
> 
> Have you enabled the NMI watchdog?  nmi_watchdog=1 on the LILO
> commandline?

# cat /proc/cmdline 
auto BOOT_IMAGE=up ro root=905 BOOT_FILE=/boot/vmlinuz-2.4.17up nmi_watchdog=1

  This is the apparently stable UP mode kernel, but this option
  has been present at all variants, although I don't recall of
  what the NMI count was previously -- same or lower than that
  of LOC count at  /proc/interrupts.

> Also, I'd be inclined to enable all the kernel debug options,
> including SLAB debug.

CONFIG_SCSI_DEBUG=y
CONFIG_JBD_DEBUG=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_BUGVERBOSE=y

/Matti Aarnio
