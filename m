Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144146AbRA1Ute>; Sun, 28 Jan 2001 15:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144147AbRA1UtY>; Sun, 28 Jan 2001 15:49:24 -0500
Received: from [193.100.254.1] ([193.100.254.1]:1552 "EHLO mail.philosys.de")
	by vger.kernel.org with ESMTP id <S144146AbRA1UtP>;
	Sun, 28 Jan 2001 15:49:15 -0500
From: Andreas Huppert <Andreas.Huppert@philosys.de>
Message-Id: <200101282049.VAA04880@mail.philosys.de>
Subject: dos-partition mount bug
To: linux-kernel@vger.kernel.org
Date: Sun, 28 Jan 2001 21:49:35 +0100 (CET)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
The following bug-report concerns all linux-versions (inclusive 2.2.18) I have
had to do with!

> I have been trying to mount the dos-partition /dev/hdb1 on /dos/d for
> three years and it fails:
> My /etc/fstab is:
> /dev/hda3 / ext2 defaults 0 1
> /dev/hdb2 /downloads ext2 defaults 0 1
> /proc /proc proc defaults 0 0
> /dev/cdrom /cdrom iso9660 ro,noauto,user,exec 0 0
> /dev/hda4 /usr ext2 defaults 0 2
> /dev/hda1 /dos/c vfat user,noexec,nosuid,nodev 0 2
> /dev/hda5 /dos/e vfat user,noexec,nosuid,nodev 0 2
> /dev/hdb1 /dos/d vfat user,noexec,nosuid,nodev 0 2
> 
> and "mount /dos/d" sais:
> mount: wrong fs type, bad option, bad superblock on /dev/hdb1,
>        or too many mounted file systems
> 
> strace sais:
> mount("/dev/hdb1", "/dos/d", "vfat",
> MS_NOSUID|MS_NODEV|MS_NOEXEC|0xc0ed0000, 0x8056fc8) = -1 EINVAL (Invalid
> argument)
> 
> I don´t need to say, that mounting /dos/c and /dos/e works without any
> problem. On the other hand win'98 works with all dos-partitions normally.
> Thanks
> Andreas Huppert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
