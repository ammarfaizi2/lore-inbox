Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSEJKW6>; Fri, 10 May 2002 06:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313557AbSEJKW5>; Fri, 10 May 2002 06:22:57 -0400
Received: from [203.162.5.30] ([203.162.5.30]:65284 "HELO tlnet.com.vn")
	by vger.kernel.org with SMTP id <S313305AbSEJKW4>;
	Fri, 10 May 2002 06:22:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: VAN DUC UY <ducuy@tlnet.com.vn>
Reply-To: ducuy@tlnet.com.vn
To: linux-kernel@vger.kernel.org
Subject: Ramdisk with kernel 2.4.18
Date: Fri, 10 May 2002 17:22:42 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020510102256Z313305-22651+25859@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, 
i'm new to linux-kernel so i have some questions for linux kernel .

Now adays, i try to make a Linux kernel support Ramdisk. i read some 
documents on internet and follow these document to complete. but the kernel 
cannot run properly. 

this is my linuxrc file :
*******************************************************************
#!/bin/nash

echo "Loading jbd module"
insmod /lib/jbd.o 
echo "Loading ext3 module"
insmod /lib/ext3.o 
mount -t proc /proc /proc
echo Mounting /proc filesystem
echo Creating root device
mkrootdev /dev/root
echo 0x0100 > /proc/sys/kernel/real-root-dev
umount /proc
echo Mounting root filesystem
<-------------------------------	ERROR during mount rootfs
mount --ro -t ext2 /dev/root /sysroot
pivot_root /sysroot /sysroot/initrd
*********************************************************************
and my /etc/lilo.conf
******************************************
image=/boot/vmlinux-2.4.18
	label="linux-ramdisk"
	initrd=/boot/initrd-2.4.18.img
	read-only
	root=/dev/ram
	append="init=/linuxrc"
	
******************************************	
Does somebody do it before ?
can anyone give me some guide to make a linux kernel which root filesystem is 
on ramdisk?

Thanks in advances
DUC UY
