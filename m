Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSEaBLd>; Thu, 30 May 2002 21:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSEaBLc>; Thu, 30 May 2002 21:11:32 -0400
Received: from mail.invtools.com ([209.81.227.140]:10756 "EHLO
	mail.invtools.com") by vger.kernel.org with ESMTP
	id <S313628AbSEaBLc>; Thu, 30 May 2002 21:11:32 -0400
From: "Jon Hedlund" <JH_ML@invtools.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 30 May 2002 20:11:16 -0500
Subject: 2.4 bootdisk kernel panic
Message-ID: <3CF68764.12104.BBA8F3A@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to update a 1.44 floppy based linux system to a 
2.4.18 kernel from 2.4.4. However whenever I try to boot the 
updated floppy I get the following kernel panic:

RAMDISK: Compressed image found at block 501
VFS: Mounted root (ext2 filesystem)
Freeing unused kernel memory: 64K freed
Kernel panic: no init found. Try passing init= option to the kernel.

I have tried it with a bunch of kernels, 2.4.4, 2.4.7 and 2.4.9 boot 
fine, 2.4.12, 2.4.13, 2.4.17, and 2.4.18 all give the panic.
I create the bootdisk with the following script:

rdev bzImage /dev/fd0
rdev -R bzImage 0
rdev -r bzImage 16885
# 16885= Don't prompt, Load ramdisk, offset = 501
dd if=bzImage of=tempfi bs=1k conv=sync
cat rootfs.gz >> tempfi
dd if=tempfi of=/dev/fd0 bs=1k

I manually edit the 16885 for whatever the size of the kernel is, just 
over 500KB in this case.
The kernel doesn't use loadable modules.
Modules are compiled into the kernel for the tulip network card, 
iptables, ext2, floppy drive, etc. I can post my config file if more info 
is needed.

JonH

