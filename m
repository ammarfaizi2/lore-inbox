Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbRLYTkw>; Tue, 25 Dec 2001 14:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285748AbRLYTkm>; Tue, 25 Dec 2001 14:40:42 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:24654 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S285747AbRLYTk1>; Tue, 25 Dec 2001 14:40:27 -0500
Message-ID: <001a01c18d77$a9e92ca0$0801a8c0@Stev.org>
Reply-To: "James Stevenson" <mistral@stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: <jlladono@pie.xtec.es>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3C285B40.91A83EC7@jep.dhis.org>
Subject: Re: 2.4.x kernels, big ide disks and old bios
Date: Tue, 25 Dec 2001 19:09:22 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i have the same problem weith a 40GB disk
its not a linux problem but a bios / disk problem

my workaround:

dont set the jumper on the disk to make it look smaller.
this however will stop it working in the bios so you need to
disable the disk in the bios completly and turn off the ide
auto detection process in the bios this is because it will
probably hang if you try to use it :)

linux will then pick the disk up from the ide controller.

----- Original Message -----
From: "Josep Lladonosa i Capell" <jep@jep.net.dhis.org>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 25, 2001 10:56 AM
Subject: 2.4.x kernels, big ide disks and old bios


> Hello,
>
> the problem is this:
>
> bios only supports disks up to 32 Gb.
>
> hard disk is 60 Gb.
>
> kernel is 2.4.17
>
> hard disk reports its correct size when reading parameters from the
> disk, not from the bios
>
> verd:/proc/ide/hdc# cat geometry
> physical     65530/16/63
> logical      119150/16/63
>
>
> when booting (dmesg):
>
> hdc: IC35L060AVER07-0, ATA DISK drive
> hdc: 66055247 sectors (33820 MB) w/1916KiB Cache, CHS=119150/16/63,
> UDMA(33)
>
>
> Linux adopts the 'false' geometry (65530/16/63) ) to bypass the bios
> boot.
>
>
>
> I know that there are patches for 2.2 kernels and 2.3 kernels, so as
> linux adopts the logical geometry (a kiddy trick with lba size). They
> are very simple (a line), but 2.4 ide implementation is (a little more)
> complicated. Any patch?
>
> Bon Nadal - Merry Christmas
>
> --
> Salutacions...Josep
> http://www.geocities.com/SiliconValley/Horizon/1065/
> --
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


