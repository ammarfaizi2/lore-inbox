Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315924AbSENRr3>; Tue, 14 May 2002 13:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315926AbSENRr2>; Tue, 14 May 2002 13:47:28 -0400
Received: from a217-118-40-108.bluecom.no ([217.118.40.108]:59154 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S315924AbSENRr1>; Tue, 14 May 2002 13:47:27 -0400
Message-ID: <009701c1fb6f$68282e90$0d01a8c0@studio2pw0bzm4>
From: "Dead2" <dead2@circlestorm.org>
To: "Tigran Aivazian" <tigran@veritas.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205141837310.1577-100000@einstein.homenet>
Subject: Re: Initrd or Cdrom as root
Date: Tue, 14 May 2002 19:47:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately it boots too fast for me to see that message..

This is my isolinux.cfg file:
---
DEFAULT zoac

LABEL zoac
    KERNEL /boot/bzImage
    APPEND "enableapic rootcd=1"
---
>From what I know, that should work.. right?

-=Dead2=-

----- Original Message -----
From: "Tigran Aivazian" <tigran@veritas.com>
To: "Dead2" <dead2@circlestorm.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, May 14, 2002 7:41 PM
Subject: Re: Initrd or Cdrom as root


> did you forget to pass "rootcd=1" in the boot command line?
>
> When the kernel boots it shows the command line like this:
>
>   Kernel command line: BOOT_IMAGE=linux-nopae ro root=305
BOOT_FILE=/boot/vmlinuz-2.4.18 rootcd=1
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

