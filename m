Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315926AbSENRvQ>; Tue, 14 May 2002 13:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSENRvP>; Tue, 14 May 2002 13:51:15 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:33042 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S315926AbSENRto>;
	Tue, 14 May 2002 13:49:44 -0400
Date: Tue, 14 May 2002 18:49:48 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Dead2 <dead2@circlestorm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Initrd or Cdrom as root
In-Reply-To: <Pine.LNX.4.33.0205141837310.1577-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0205141848100.1577-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also, don't forget to pass "rootfstype=iso9660" if your cdrom's filesystem
is iso9660. It shouldn't be needed because the kernel tries to mount using
all registered filesystem types in turn, but specifying rootfstype
explicitly avoids silly messages from FAT about wrong sector size so I
always pass it.

On Tue, 14 May 2002, Tigran Aivazian wrote:

> did you forget to pass "rootcd=1" in the boot command line?
>
> When the kernel boots it shows the command line like this:
>
>   Kernel command line: BOOT_IMAGE=linux-nopae ro root=305 BOOT_FILE=/boot/vmlinuz-2.4.18 rootcd=1
>
> What does it look like in your case?
>
> On Tue, 14 May 2002, Dead2 wrote:
>
> > I tested the patch, but it still does not work..
> >
> > These are the error messages I get:
> > (lines 1,2,3,6 and 7 are prolly not relevant)
> >
> > ---
> > SCSI subsystem driver Revision: 1.00
> > 3ware Storage Controller device driver for Linux v1.02.00.016.
> > 3w-xxxx: No cards with valid units found.
> > request_module[scsi_hostadapter]: Root fs not mounted
> > request_module[scsi_hostadapter]: Root fs not mounted
> > pci_hotplug: PCI Hot Plug PCI Core version: 0.3
> > cpqphp.o: Compaq Hot Plug PCI Controller Driver version 0.9.6
> > VFS: Cannot open root device "" or 48:03
> > Please append a correct "root=" boot option
> > Kernel panic: VFS: Unable to mount root fs on 48:03
> > ---
> >
> > I have compiled in a lot of scsi drivers that are not used, so
> > the kernel will be able to boot on just about any system.
> > The cdrom on the test computer is on /dev/hdc. But I have
> > also tested it on several other computers with no luck.
> >
> > Attached: My kernel .config
> >
> > -=Dead2=-
> >
>
>

