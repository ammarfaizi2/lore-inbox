Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144147AbRA1U5E>; Sun, 28 Jan 2001 15:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144182AbRA1U4z>; Sun, 28 Jan 2001 15:56:55 -0500
Received: from www.topmail.de ([212.255.16.226]:29657 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S144180AbRA1U4w> convert rfc822-to-8bit;
	Sun, 28 Jan 2001 15:56:52 -0500
Message-ID: <026f01c0896c$d65a9db0$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>,
        "Andreas Huppert" <Andreas.Huppert@philosys.de>
In-Reply-To: <200101282049.VAA04880@mail.philosys.de>
Subject: Re: dos-partition mount bug
Date: Sun, 28 Jan 2001 20:56:40 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suggest type # fdisk -l /dev/hdb
Maybe it's FAT32 where the others are FAT16?
Try SCANDISK(tm)...
If you're familiar with FAT, you also could use DEBUG, the Norton
Utilities etc. to look for a failure in the filesystem. For FAT16 it's easy.
Bootsector, 2xFAT, root dir, data blocks
Send us a hexdump of the first block. (If it's FAT16)

PS: I'm going to bed now, so could be some time to respond

mirabilos

----- Original Message ----- 
From: "Andreas Huppert" <Andreas.Huppert@philosys.de>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, January 28, 2001 8:49 PM
Subject: dos-partition mount bug


> > Hi,
> The following bug-report concerns all linux-versions (inclusive 2.2.18) I have
> had to do with!
> 
> > I have been trying to mount the dos-partition /dev/hdb1 on /dos/d for
> > three years and it fails:
> > My /etc/fstab is:
> > /dev/hda3 / ext2 defaults 0 1
> > /dev/hdb2 /downloads ext2 defaults 0 1
> > /proc /proc proc defaults 0 0
> > /dev/cdrom /cdrom iso9660 ro,noauto,user,exec 0 0
> > /dev/hda4 /usr ext2 defaults 0 2
> > /dev/hda1 /dos/c vfat user,noexec,nosuid,nodev 0 2
> > /dev/hda5 /dos/e vfat user,noexec,nosuid,nodev 0 2
> > /dev/hdb1 /dos/d vfat user,noexec,nosuid,nodev 0 2
> > 
> > and "mount /dos/d" sais:
> > mount: wrong fs type, bad option, bad superblock on /dev/hdb1,
> >        or too many mounted file systems
> > 
> > strace sais:
> > mount("/dev/hdb1", "/dos/d", "vfat",
> > MS_NOSUID|MS_NODEV|MS_NOEXEC|0xc0ed0000, 0x8056fc8) = -1 EINVAL (Invalid
> > argument)
> > 
> > I don´t need to say, that mounting /dos/c and /dos/e works without any
> > problem. On the other hand win'98 works with all dos-partitions normally.
> > Thanks
> > Andreas Huppert


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
