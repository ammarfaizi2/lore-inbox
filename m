Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291387AbSBHD1g>; Thu, 7 Feb 2002 22:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291389AbSBHD10>; Thu, 7 Feb 2002 22:27:26 -0500
Received: from [200.228.132.206] ([200.228.132.206]:3456 "EHLO
	BolivaR.Underground-R.org") by vger.kernel.org with ESMTP
	id <S291387AbSBHD1V>; Thu, 7 Feb 2002 22:27:21 -0500
Message-ID: <3C62E261.4030703@santiagonet.com.br>
Date: Thu, 07 Feb 2002 18:24:01 -0200
From: R-ealitY <jalves@santiagonet.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MATSHITA CR-581 doesn't work under 2.4.17
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I have a MATSHITA CR-581 which works under 2.2.19 but not 2.4.17.

Here's the dmesg output:

2.2.19:

hdc: MATSHITA CR-581, ATAPI CDROM drive
hdc: ATAPI 4X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A

2.4.17:

hdc: MATSHITA CR-581, ATAPI CD/DVD-ROM drive
hdc: ATAPI 4X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
VFS: Disk change detected on device ide1(22,0)
hdc: irq timeout: status=0xd8 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: tray open
end_request: I/O error, dev 16:00 (hdc), sector 64
isofs_read_super: bread failed, dev=16:00, iso_blknum=16, block=32

lsmod:

2.2.19:

ide-cd                 24288   1 (autoclean)
cdrom                  27264   0 (autoclean) [ide-cd]
isofs                  16864   1 (autoclean)

2.4.17:

ide-cd                 25008   0 (autoclean)
cdrom                  27008   0 (autoclean) [ide-cd]
isofs                  24976   0 (autoclean)
inflate_fs             18032   0 (autoclean) [isofs]


The error appears when I try to mount it:

$ mount /mnt/cdrom
mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
        or too many mounted file systems

mount output from 2.2.19:

/dev/hdc on /mnt/cdrom type iso9660 (ro,noexec,nosuid,nodev,user=borracho)

Anybody know what's wrong with the 2.4.17 driver ?




