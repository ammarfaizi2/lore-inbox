Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSESWTv>; Sun, 19 May 2002 18:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315446AbSESWTu>; Sun, 19 May 2002 18:19:50 -0400
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:35462 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S315293AbSESWTs>; Sun, 19 May 2002 18:19:48 -0400
Message-ID: <003201c1ff83$4552d6a0$6caca8c0@kpfhome>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200205192026.WAA27881@harpo.it.uu.se>
Subject: Re: lost interrupt hell - Plea for Help
Date: Sun, 19 May 2002 15:19:40 -0700
Organization: Laboratory Systems Group, Inc.
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

OK, I'll move the CD drives to the VIA IDE ports and see what happens.
That'll be fun changing around boot drive assignments... And yes, my DVD
drive in my other machine is connected to another Promise Ultra66TX2, and it
works fine under Windows XP.

In the PCI listing, there is an Adaptec PCI SCSI card, but that's just for a
tape drive. I have four hard drives, all as masters (single devices) on the
VIA and FastTrak IDE channels.

Thanks for the info, I'll report back results after I get a chance to open
the machine up.

----- Original Message -----
From: "Mikael Pettersson" <mikpe@csd.uu.se>
To: <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 19, 2002 01:26 PM
Subject: Re: lost interrupt hell - Plea for Help


> On Sun, 19 May 2002 11:43:09 -0700, Kevin P. Fleming wrote:
> >I have just switched motherboards in my file server, which previously had
no
> >problems ripping audio from my Creative 52X drives. The new motherboard
has
> >the KT266A chipset, but the CD drives are _not_ connected to that
chipset's
> >IDE ports. I am getting "lost interrupt" messages when I try to rip audio
> >from the drives, or even mount ISO9660 discs (which do eventually
succeed,
> >they just take over a minute to mount). So far I have done the following:
> >
> >- turned off "dma" and "unmaskirq" for the CD drives
> >- tried ide-scsi/sg instead of ide-cd
> >- tried booting with "noapic"
> >- tried 2.4.19-pre8 and 2.4.19-pre8-ac4
> >
> >Nothing has helped. The machine configuration is an MSI KT7266-Pro2RU
> >motherboard, KT266A chipset with on-board Promise PDC20265R FastTrak
> >"lite"). There is also a Promise PDC20262 (Ultra66TX2) in a PCI slot, and
> >that is where the CD drives are connected. Each CD drive is the master on
> >its channel, and one of them also has a Iomega ZIP 250 ATAPI drive as its
> >slave. Interestingly, the ZIP drive works perfectly, no "lost interrupt"
> >messages at all.
>
> 1. It's been stated here on LKML several times that optical drives
>    should NOT be connected to Promise chips. It may work with Promise's
>    Windows drivers, but that doesn't help here. A better strategy is to
>    connect your CD-ROMs and Zip drive to the KT266A, and any IDE disks
>    either to the FastTrak or the Ultra66 add-on card (though from your
>    `lspci` I suppose your disks are SCSI).
>
> 2. "noapic" only controls whether the I/O-APIC is used or not.
>    If you want to test without the _local_ APIC being enabled,
>    then I'm afraid you have to rebuild the kernel with
>    CONFIG_X86_UP_APIC disabled.
>
> /Mikael
>
>

