Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSBVCO2>; Thu, 21 Feb 2002 21:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291297AbSBVCOS>; Thu, 21 Feb 2002 21:14:18 -0500
Received: from ginsberg.uol.com.br ([200.231.206.26]:61126 "EHLO
	ginsberg.uol.com.br") by vger.kernel.org with ESMTP
	id <S291272AbSBVCOM>; Thu, 21 Feb 2002 21:14:12 -0500
Date: Thu, 21 Feb 2002 23:14:11 -0300 (BRT)
From: Cesar Suga <sartre@linuxbr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: HPT366: DMA errors?
Message-ID: <Pine.LNX.4.40.0202212304240.438-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, all.

	I am using an ABIT BP6 board (SMP, 2 Celerons at 366MHz, none
overclocked, *very* stable) which uses the HPT366 controller. I am getting
through these messages when using the *original* ATA cable (never touched
before) or a replacement one:

hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

	(when the drive first fscks from a dirty reboot)

	And, in kernel messages, whilst doing hdparm -tT /dev/hde3:

->	invalidate: busy buffer
	(from fs/buffer.c)

	(yes, it is wrong to use hde3, but when I use hde, but whatever;
using hda3 or hda did not matter when I used this *same* HDD with normal
IDE cable (not using HPT366))

	I am not using *any* special features (untuned HDD), drive was set
to DMA mode 4 at the HPT BIOS.

	Any clues on this? I am using kernel 2.4.17, libc 2.2.4, hdparm
4.1.

	PS: For now, I'll use this HDD with the normal cables, as I fear
corruption. (yes, the drive runs *perfectly* with the normal cables and
not connected to the HPT366 IDE. It is a Seagate ST310211A HDD.)

	Thanks,
	Cesar Suga <sartre@linuxbr.com>

