Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287852AbSANRzM>; Mon, 14 Jan 2002 12:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287848AbSANRzC>; Mon, 14 Jan 2002 12:55:02 -0500
Received: from web14913.mail.yahoo.com ([216.136.225.240]:56843 "HELO
	web14913.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287852AbSANRyr>; Mon, 14 Jan 2002 12:54:47 -0500
Message-ID: <20020114175446.24132.qmail@web14913.mail.yahoo.com>
Date: Mon, 14 Jan 2002 12:54:46 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: "dd" collapsed the loop device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,everyone,I have a problem when I used the loop
device. I don't know whether is a loop device bug. I
used the following commands to connect the loop device
with the floppy disk device.

losetup -e xor /dev/loop0 /dev/fd0
mke2fs /dev/loop0
mount /dev/loop0 /floppy

Then I copy something to the floppy and read it back.
Everything is OK. It works perfectly. 

The problem was happened when I try to copy something
directly from the /dev/fd0. I use the following
demand.

dd if=test.c of=/dev/fd0

The output of the upper command is:
50+1 records in
50+1 records out

Then I used the "ls /floppy". I found nothing copied
to the floppy. Then I used "umount /floppy" to umount
the floppy disk device. After that I used the
following command to try to mount the floppy disk
again.

mount /dev/loop0 /floppy

It returned an error. Say:

mount: wrong fs type. bad option. bad superblock on
/dev/loop0. or too many mounted file systems

It seemed that the "dd if=test.c of=/dev/fd0"
corrupted the data on the floppy disk. What is wrong?
What happened to the floppy disk? Is it a bug of the
loop device?

Thanks

Michael

______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
