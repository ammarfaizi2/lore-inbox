Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318175AbSHIH53>; Fri, 9 Aug 2002 03:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318177AbSHIH52>; Fri, 9 Aug 2002 03:57:28 -0400
Received: from vic7-adsl-050.tpgi.com.au ([203.213.71.50]:63377 "EHLO
	coralshark.bluereef.com.au") by vger.kernel.org with ESMTP
	id <S318175AbSHIH51>; Fri, 9 Aug 2002 03:57:27 -0400
Message-ID: <079d01c23f7b$e3cf34d0$2b01010a@bluereef.local>
From: "Andrew" <temp01@bluereef.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.20 ramdisk(initrd) not found by kernel
Date: Fri, 9 Aug 2002 18:08:05 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem that I have been wrestling with now for a number of days
with no solution, and I'm hoping someone can help.

My problem is that when the 2.2.20 kernel loads, lilo doesn't seem to load
the rootfs.img into RAM or it gets dropped before the kernel finds it. That
is I don't get the
kernel message 'RAMDISK found at block 0' message and thus Linux panics with
something like "root file system not found on dev 1:0".

I have a stock 2.2.20 kernel with ramdisk and initrd support compiled in.
RAMdisk size is 64MB although I've also tried 32MB and 128MB.
I have tried kernel builds with module support and without (everything
compiled in)
I'm using the latest lilo I can find with the following config:

boot=/dev/hdc
disk=/dev/hdc
 bios=0x80
map=/map
install=/boot.b
backup=/boot.1600
prompt
linear
timeout=50
password=maintenance
restricted
image=/vmlinuz-2.2.20up
        label=test
        ramdisk=65536
        initrd=/rootfs.img
        root=/dev/ram

The server is a uni processor PIII server with 512MB of RAM

The sizes of my rootfs.img and kernel are:
 8713856 Aug  7 12:55 rootfs.img (this is an ext2 compressed image)
 787022 Aug  7 12:17 vmlinuz-2.2.20up (this is a monolithic bzImage kernel)

Lilo when building doesn't report any errors in fact it says it successfully
maps the RAMdisk ok

It almost seems like there is some finite size or block limit that my
rootfs.img+kernel is greater than, that stops the
RAMdisk being loaded or being found if it is infact being loaded at all.

Is there a finite limit on the size initrd can be? Enlarging the ramdisk
size or altering the block size of the image doesn't seem to make any
difference.

Any help much appreciated.

Andrew.
ps. Can you please reply to me directly, thanks.

