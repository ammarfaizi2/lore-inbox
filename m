Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264204AbRFWQBn>; Sat, 23 Jun 2001 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264181AbRFWQBe>; Sat, 23 Jun 2001 12:01:34 -0400
Received: from ns01.vbnet.com.br ([200.230.208.6]:4763 "EHLO iron.vbnet.com.br")
	by vger.kernel.org with ESMTP id <S264204AbRFWQBW>;
	Sat, 23 Jun 2001 12:01:22 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: soma@cs.unm.edu (Anil B. Somayaji), linux-kernel@vger.kernel.org
Subject: Re: plain 2.2.X: no ide CD-RW?
Date: Sat, 23 Jun 2001 13:00:11 -0300
X-Mailer: KMail [version 1.2]
In-Reply-To: <ut2hex7ej69.fsf@lydia.adaptive.net>
In-Reply-To: <ut2hex7ej69.fsf@lydia.adaptive.net>
MIME-Version: 1.0
Message-Id: <01062313001100.01333@skydive.techlinux>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all,


> For a while now, I've been running a 2.4 kernel, but (for my research)
> I need to now run a 2.2 kernel.  I was hoping to just run a stock
> 2.2.19, but I've found that I can't use my CD-RW drive, either as a
> plain IDE cdrom, or as a scsi-emulated one.  (I have ide-scsi, ide-cd,
> and scsi all as modules.)
>
> When I try things as scsi-emulated CD-ROM, I get the following:
>
>   Jun 22 19:58:15 lydia kernel: ide-scsi: The scsi wants to send us
>      more data than expected - discarding data
>   Jun 22 19:58:16 lydia last message repeated 83 times

> Instead, if I try ide-cd, I get these messages:
>
>   Jun 22 20:11:38 lydia kernel: hdc: status error: status=0x58 {
>      DriveReady SeekComplete DataRequest }
>   Jun 22 20:11:38 lydia kernel: hdc: drive not ready for command
>   Jun 22 20:11:38 lydia kernel: hdc: status timeout: status=0xd0 { Busy }
>   Jun 22 20:11:38 lydia kernel: hdc: DMA disabled
>   Jun 22 20:11:38 lydia kernel: hdc: drive not ready for command
>   Jun 22 20:11:38 lydia kernel: hdc: ATAPI reset complete
>   Jun 22 20:11:48 lydia kernel: hdc: irq timeout: status=0x80 { Busy }
>   Jun 22 20:11:48 lydia kernel: hdc: ATAPI reset complete
>   Jun 22 20:11:59 lydia kernel: hdc: irq timeout: status=0x80 { Busy }
>   Jun 22 20:11:59 lydia kernel: end_request: I/O error, dev 16:00
>      (hdc), sector 64
>   Jun 22 20:11:59 lydia kernel: hdc: status timeout: status=0x80 { Busy }
>   Jun 22 20:11:59 lydia kernel: hdc: drive not ready for command
>
> I have these problems with 2.2.1[7-9] & 2.2.20pre5.  However, if I add
> one of the IDE patches, all is well.  2.4 kernels have never given me
> these sorts of problems.
>
> I have a 440LX motherboard (HP Pavilion 8260), hooked up to a Plextor
> PX-W8432T 4/8/32 CD-RW, attached as /dev/hdc.  I also have an OnStream
> DI-30 as /dev/hdd, and a Maxtor 91020D6 10G drive as /dev/hda.
>
> I can live with just running an ide-patched kernel, but it seems very
> odd that I can't even use the drive as an IDE CD-ROM drive with a
> stock 2.2 kernel.  Is this a bug, or a limitation?  I'd be happy to
> perform any tests to try and track this problem down.

Same here Anil,
w/ k2.4.4/2.4.5 in a dual p3 550 ( Intel 440BX ), CREATIVE CD-RW RW8432E (IDE).

< insmod ide-scsi / sr_mod >
ide-scsi: (IO,CoD) != (0,1) while issuing a packet command
hdb: DMA disabled
hdb: ATAPI reset complete
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 256 of 352 bytes
  Vendor: CREATIVE  Model: CD-RW RW8432E     Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 64 of 82 bytes
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 132 of 158 bytes
sr0: scsi3-mmc drive: 264x/359x writer cd/rw xa/form2 cdda cartridge changer
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: transferred 64 of 82 bytes

<mount /mnt/cdrom>
sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
MSDOS: Hardware sector size is 2048
fatfs: bogus cluster size
VFS: Can't find a valid MSDOS filesystem on dev 0b:00.
MSDOS: Hardware sector size is 2048
fatfs: bogus cluster size
VFS: Can't find a valid MSDOS filesystem on dev 0b:00.


cya;

>   --Anil
>
> - --
> Anil Somayaji (soma@cs.unm.edu)
> http://www.cs.unm.edu/~soma
> +1 505 872 3150
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.6 (GNU/Linux)
>
> iEYEARECAAYFAjs0SFkACgkQXOpXEmNZ3SeAtgCeL8j+ZvfANCB0acV6kL6AQFtB
> GdUAnidlfYrkv1o+hSlO4kNoWUNXw43v
> =RqEF
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

