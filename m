Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRKNVjn>; Wed, 14 Nov 2001 16:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278042AbRKNVjd>; Wed, 14 Nov 2001 16:39:33 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:34994 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S277949AbRKNVjX>; Wed, 14 Nov 2001 16:39:23 -0500
Message-ID: <3BF2E136.396C35BE@free.fr>
Date: Wed, 14 Nov 2001 22:25:10 +0100
From: Tommasi Marc <marc.tommasi@free.fr>
Reply-To: tommasi@univ-lille3.fr
X-Mailer: Mozilla 4.78 [fr] (X11; U; Linux 2.4.8-26mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mount /mnt/cdrom = segfault
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
  I cannot explain why the mount command issues with a segmentation 
fault. 
  Kernel messages indicates 

Nov 14 20:44:38 marion kernel: devfs: devfs_register(): device already
registered: "cd"
Nov 14 20:44:38 marion kernel: hdc: ide_cdrom_setup failed to register
device with the cdrom driver.
Nov 14 20:44:38 marion kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000028
Nov 14 20:44:38 marion kernel:  printing eip:
Nov 14 20:44:38 marion kernel: c018ba8f
Nov 14 20:44:38 marion kernel: *pde = 00000000
Nov 14 20:44:38 marion kernel: Oops: 0000
Nov 14 20:44:38 marion kernel: CPU:    0
Nov 14 20:44:38 marion kernel: EIP:   
0010:[ide_revalidate_disk+223/272]
Nov 14 20:44:38 marion kernel: EIP:    0010:[<c018ba8f>]
Nov 14 20:44:38 marion kernel: EFLAGS: 00010212
Nov 14 20:44:38 marion kernel: eax: 00000000   ebx: 00001600   ecx:
00001600   edx: 00000000
Nov 14 20:44:38 marion kernel: esi: c03591d0   edi: 00001100   ebp:
00000040   esp: c813dec8
Nov 14 20:44:38 marion kernel: ds: 0018   es: 0018   ss: 0018
Nov 14 20:44:38 marion kernel: Process mount (pid: 2502,
stackpage=c813d000)
Nov 14 20:44:38 marion kernel: Stack: 16000330 00000000 00000330
00000000 c0359498 00000330 c018bb0a 00001600
Nov 14 20:44:38 marion kernel:        00000001 c03591d0 ce8cfc60
00000000 ce8cfc60 c018bbd4 c149a5a0 ce8cfc60
Nov 14 20:44:38 marion kernel:        c0138a38 ce8cfc60 c82447a0
c14c3240 00000000 c14c3244 c015d7df ce8cfc60
Nov 14 20:44:38 marion kernel: Call Trace: [revalidate_drives+74/128]
[ide_open+52/240] [blkdev_open+72/128] [devfs_open+191/416]
[dentry_open+192/336]
Nov 14 20:44:38 marion kernel: Call Trace: [<c018bb0a>] [<c018bbd4>]
[<c0138a38>] [<c015d7df>] [<c0131d60>]
Nov 14 20:44:38 marion kernel:    [filp_open+75/96] [getname+95/160]
[sys_open+54/176] [system_call+51/64]
Nov 14 20:44:38 marion kernel:    [<c0131c8b>] [<c013b45f>] [<c0131f76>]
[<c0106ec3>]
Nov 14 20:44:38 marion kernel:
Nov 14 20:44:38 marion kernel: Code: 8b 40 28 85 c0 74 04 56 ff d0 5b 80
a6 ae 00 00 00 fb 8d 86



I have tried no boot with devfs=nomount but I have still the same kind
of message. 
I whish to be cc'ed the answers.
Thanks a lot.

Marc.
