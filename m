Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315852AbSEMFvY>; Mon, 13 May 2002 01:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315851AbSEMFvW>; Mon, 13 May 2002 01:51:22 -0400
Received: from violet.setuza.cz ([194.149.118.97]:48395 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S315852AbSEMFuy>;
	Mon, 13 May 2002 01:50:54 -0400
Subject: Re: Ramdisk with kernel 2.4.18
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020510102256Z313305-22651+25859@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 May 2002 07:50:54 +0200
Message-Id: <1021269054.292.0.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-10 at 19:22, VAN DUC UY wrote:
> Hello all, 
> i'm new to linux-kernel so i have some questions for linux kernel .
> 
> Now adays, i try to make a Linux kernel support Ramdisk. i read some 
> documents on internet and follow these document to complete. but the kernel 
> cannot run properly. 
> 
> this is my linuxrc file :
> *******************************************************************
> #!/bin/nash
> 
> echo "Loading jbd module"
> insmod /lib/jbd.o 
> echo "Loading ext3 module"
> insmod /lib/ext3.o 
> mount -t proc /proc /proc
> echo Mounting /proc filesystem
> echo Creating root device
> mkrootdev /dev/root
> echo 0x0100 > /proc/sys/kernel/real-root-dev
> umount /proc
> echo Mounting root filesystem
> <-------------------------------	ERROR during mount rootfs
> mount --ro -t ext2 /dev/root /sysroot
> pivot_root /sysroot /sysroot/initrd
> *********************************************************************
> and my /etc/lilo.conf
> ******************************************
> image=/boot/vmlinux-2.4.18
> 	label="linux-ramdisk"
> 	initrd=/boot/initrd-2.4.18.img
> 	read-only
> 	root=/dev/ram
> 	append="init=/linuxrc"
> 	
> ******************************************	
> Does somebody do it before ?
> can anyone give me some guide to make a linux kernel which root filesystem is 
> on ramdisk?
> 
Hi,

Read the Bootdisk-HOWTO. There you'll find a complete description, what
the kernel needs and does using root on ramdisk.

Regards
Frank

