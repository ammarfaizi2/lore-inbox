Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRKSIYS>; Mon, 19 Nov 2001 03:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRKSIYL>; Mon, 19 Nov 2001 03:24:11 -0500
Received: from law2-oe70.hotmail.com ([216.32.180.163]:11 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S273622AbRKSIXu>;
	Mon, 19 Nov 2001 03:23:50 -0500
X-Originating-IP: [213.82.66.51]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Date: Mon, 19 Nov 2001 09:23:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <LAW2-OE70z82buW5RNB000007e5@hotmail.com>
X-OriginalArrivalTime: 19 Nov 2001 08:23:44.0277 (UTC) FILETIME=[80B3EC50:01C170D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody.

I have just upgraded my PC from 768MB RAM to 1GB.
I have recompiled the kernel (2.4.14) for hi mem support (4GB).

Now it's appening a very strange behaviour.
I have several file system on the same disk (vfat file system). I have
compiled vfat driver as a module. So before try to mount I must issue a
'modprobe vfat'. I'm using Slackware 8.0. modutils version is 2.4.6

Then if I try to copy a file from that filesystem to the root filesystem
I get this error:

Kernel panic: too few segs for DMA mappings increase AHC_NSEG

Usually this is the procedure:

root login
modprobe vfat
mount /dev/sda2 /mnt   (to mount the fat partition)
cd /usr/src
cp /mnt/linux/kernel/linux-2.2.20.tar.bz2 . (I want to copy kernel
source tarball from the vfat partition to /usr/src)
CRASH..........

My MB is ABIT KT7A (bios rev ID 65  11/07/2001). Two 512 MB SDRAM
(takei).
Other HW: AHA 39160, SCSI IBM HD DDYS 18130, Matrox G450.
gcc version 2.95.3, binutils 2.10.91.0.4 (***not the original slack
8.0***, I have downgraded it for Oracle 9i)

If I compile a kernel without hi mem support all is fine.
