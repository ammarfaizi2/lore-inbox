Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTJLTBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 15:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTJLTBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 15:01:23 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:6573 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263506AbTJLTBU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 15:01:20 -0400
From: Edward Macfarlane Smith <snowfire@blueyonder.co.uk>
To: "Prashanth A Pandit" <prashanth@prodigylabs.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: problem mounting CD writer in 2.4.20
Date: Sun, 12 Oct 2003 20:01:55 +0100
User-Agent: KMail/1.5.1
References: <000601c38ee7$89ff37e0$0dc809c0@prashanth>
In-Reply-To: <000601c38ee7$89ff37e0$0dc809c0@prashanth>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310122001.55441.snowfire@blueyonder.co.uk>
X-OriginalArrivalTime: 12 Oct 2003 19:01:18.0478 (UTC) FILETIME=[37D6C2E0:01C390F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you got SCSI cdrom selected as an option? On my machine the cd writer is 
/dev/sr0 (SCSI CDROM gives a module sr_mod).
In dmesg I get :
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Do you see anything like this?
Regards,
Edward

On Friday 10 October 2003 05:32, Prashanth A Pandit wrote:
> Hi,
>
> Am facing a problem with my sony cd writer. Unable to mount. It is
> connected to a Cyrix processor based PC 104 board, running linux kernel
> 2.4.20. I have compiled scsi generic driver and related stuffs to kernel.
> Following is the details about my system:
> ---------------------------------------------------------------------------
>- ----
> Configuration in /etc/lilo.conf
> ---------------------------------------------------------------------------
>- ----
> image=/boot/bzImage-2.4.20
> label=linux-2.4.20
> read-only
> root=/dev/hda1
> append="hdb=ide-scsi"
> ---------------------------------------------------------------------------
>- ----
> Extract of 'dmesg' after system boot
> ---------------------------------------------------------------------------
>- ----
> hda: QUANTUM FIREBALL SE2.1A, ATA DISK drive
> hdb: SONY CD-RW CRX225E, ATAPI CD/DVD-ROM drive
> hdc: Hitachi XXM2.3.0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 4124736 sectors (2112 MB) w/80KiB Cache, CHS=1023/64/63
> hdc: 1000944 sectors (512 MB) w/1KiB Cache, CHS=993/16/63
> Partition check:
> hda: hda1 hda2 hda3
> hdc: hdc1
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> Vendor: SONY Model: CD-RW CRX225E Rev: QYB2
> Type: CD-ROM ANSI SCSI revision: 02
> EXT2-fs warning (device ide0(3,3)): ext2_read_super: mounting ext3
> filesystem as ext2
> ---------------------------------------------------------------------------
>- ----
> Output of /proc/devices after system boot
> ---------------------------------------------------------------------------
>- ----
> Character devices:
> 1 mem
> 2 pty
> 3 ttyp
> 4 ttyS
> 5 cua
> 6 lp
> 7 vcs
> 10 misc
> 21 sg
> 29 fb
> 108 ppp
> 128 ptm
> 136 pts
> 162 raw
> Block devices:
> 1 ramdisk
> 2 fd
> 3 ide0
> 7 loop
> 22 ide1
> 31 mtdblock
> 44 ftl
> 93 nftl
> ---------------------------------------------------------------------------
>- ----
> Listing of device files in /dev/ directory
> ---------------------------------------------------------------------------
>- ----
> brw-rw---- 1 root disk 3, 1 Sep 26 15:38 /dev/hda1
> brw-rw---- 1 root disk 3, 2 Sep 26 15:38 /dev/hda2
> brw-rw---- 1 root disk 3, 3 Sep 26 15:38 /dev/hda3
> brw-rw---- 1 root disk 3, 65 Sep 26 15:38 /dev/hdb1
> brw-rw---- 1 root disk 3, 66 Sep 26 15:38 /dev/hdb2
> brw-rw---- 1 root disk 22, 1 Sep 26 15:38 /dev/hdc1
> brw-rw---- 1 root disk 22, 2 Sep 26 15:38 /dev/hdc2
> brw-rw---- 1 root disk 22, 65 Sep 26 15:38 /dev/hdd1
> brw-rw---- 1 root disk 22, 66 Sep 26 15:38 /dev/hdd2
> crw-rw---- 1 root disk 21, 0 Sep 26 15:40 /dev/sg0
> crw-rw---- 1 root disk 21, 1 Sep 26 15:40 /dev/sg1
> lrwxrwxrwx 1 root root 3 Sep 16 17:58 /dev/sga -> sg0
> lrwxrwxrwx 1 root root 3 Sep 16 17:58 /dev/sgb -> sg1
> brw-rw---- 1 root disk 11, 0 Oct 10 14:45 /dev/scd0
> brw-rw---- 1 root disk 11, 1 Oct 10 14:45 /dev/scd1
> ---------------------------------------------------------------------------
>- ----
> Output of cdrecord -scanbus
> ---------------------------------------------------------------------------
>- ----
> Linux sg driver version: 3.1.24
> Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
> Using libscg version 'schily-0.5'
> scsibus0:
> 0,0,0 0) 'SONY ' 'CD-RW CRX225E ' 'QYB2' Removable CD-ROM
> 0,1,0 1) *
> 0,2,0 2) *
> 0,3,0 3) *
> 0,4,0 4) *
> 0,5,0 5) *
> 0,6,0 6) *
> 0,7,0 7) *
> ---------------------------------------------------------------------------
>- ----
> Output of mount /dev/scd0 /mnt/cdrom -text2
> ---------------------------------------------------------------------------
>- ----
> mount: /dev/scd0 is not a valid block device
>
> I have been trying to write to CD as well as read from it through my C
> program. Please help how do I do it?
>
> Thanks in advance.
> - prashanth pandith
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

