Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbTAJS0N>; Fri, 10 Jan 2003 13:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbTAJSZY>; Fri, 10 Jan 2003 13:25:24 -0500
Received: from [193.158.237.250] ([193.158.237.250]:56711 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265636AbTAJSZI>; Fri, 10 Jan 2003 13:25:08 -0500
Date: Fri, 10 Jan 2003 19:33:51 +0100
Message-Id: <200301101833.h0AIXpj03277@mail.intergenia.de>
To: linux-kernel@vger.kernel.org
From: Ludovic Drolez <ludovic.drolez@freealter.com>
Subject: BLKBSZSET still not working on 2.4.18 ? [rescued]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to backup a partition on an IDE drive which has an odd number 
of sectors (204939). With a stock open/read you cannot access the last 
sector, and that why I tried the BLKBSZSET ioctl to set the basic read 
block size to 512 bytes. I verified the writen value with BLKBSZGET 
ioctl, but I still cannot read this last sector !

I've tried also this:
- FreeBSD : works but it don't want to port all my software to it
- raw devices: can't read the last sector:

# raw  /dev/raw1 /dev/hda2
# dd if=/dev/raw1 of=C bs=512
dd: reading `/dev/raw1': No such device or address
204938+0 records in
204938+0 records out


What can it do ? Wait for a patch in 2.5.xxx ?

TIA,

    Ludovic Drolez.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

