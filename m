Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSHOWTW>; Thu, 15 Aug 2002 18:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317587AbSHOWTV>; Thu, 15 Aug 2002 18:19:21 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:2225 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S317544AbSHOWTU>; Thu, 15 Aug 2002 18:19:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Benjamin Geer <ben@beroul.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 ATAPI cdrom I/O errors when reading CD-R
Date: Thu, 15 Aug 2002 23:17:29 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17fT1P-0004tk-00@gadolinium.btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting errors with kernel 2.4.19 when reading a data CD-R burnt 
under Windows (using Adaptec DirectCD).  Kernel 2.2.20 reads the same CD 
with no problems, as does Windows XP.

With kernel 2.4.19, the CD mounts, and ls works, but when I try to copy a 
file from it, the copy is incomplete, and I get a lot of errors like this:

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 999504

I've tried turning off DMA for the drive (hdparm -d0 /dev/hdc), but this 
has no effect.

I've had no problems reading CD-ROMs (including copies of CD-ROMs on CD-R 
media) under kernel 2.4.19.

Here's the drive information as reported by the kernel when it boots:

hdc: HL-DT-STCD-RW/DVD-ROM GCC-4240N, ATAPI CD/DVD-ROM drive
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

The drive is in a Dell Inspiron 4150 laptop.

Benjamin

