Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281031AbRKOUVz>; Thu, 15 Nov 2001 15:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKOUVq>; Thu, 15 Nov 2001 15:21:46 -0500
Received: from l3ux02.univ-lille3.fr ([194.254.132.192]:56308 "HELO
	tadorne.grappa.fr") by vger.kernel.org with SMTP id <S281029AbRKOUV3>;
	Thu, 15 Nov 2001 15:21:29 -0500
From: Marc Tommasi <tommasi@univ-lille3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15348.9247.86835.895403@pingouin.grappa.fr>
Date: Thu, 15 Nov 2001 21:22:55 +0100
To: Jens Axboe <axboe@suse.de>
Cc: tommasi@univ-lille3.fr, linux-kernel@vger.kernel.org
Subject: Re: mount /mnt/cdrom = segfault
In-Reply-To: <20011115075930.H27010@suse.de>
In-Reply-To: <3BF2E136.396C35BE@free.fr>
	<20011115075930.H27010@suse.de>
X-Mailer: VM 6.94 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 ---| On Wed, Nov 14 2001, Tommasi Marc wrote:
 ---| > I have tried no boot with devfs=nomount but I have still the same kind
 ---| > of message. 
 ---| 
 ---| Please reproduce with devfs=nomount and send in that oops instead,
 ---| thanks.
 ---| 
 ---| -- 
 ---| Jens Axboe

Hello,

    please aplogies. I have an Athlon 800, with kernel 2.4.8 (Mandrake 8.1). It seems that the message is very similar after rebooting with devfs=nomount, but maybe I am wrong. 


Nov 15 20:41:39 marion kernel: ide-floppy driver 0.97
Nov 15 20:41:39 marion kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Nov 15 20:41:39 marion kernel: devfs: devfs_register(): device already registered: "cd"
Nov 15 20:41:39 marion kernel: hdc: ide_cdrom_setup failed to register device with the cdrom driver.
Nov 15 20:41:39 marion kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000028
Nov 15 20:41:39 marion kernel:  printing eip:
Nov 15 20:41:39 marion kernel: c018ba8f
Nov 15 20:41:39 marion kernel: *pde = 00000000
Nov 15 20:41:39 marion kernel: Oops: 0000
Nov 15 20:41:39 marion kernel: CPU:    0
Nov 15 20:41:39 marion kernel: EIP:    0010:[ide_revalidate_disk+223/272]
Nov 15 20:41:39 marion kernel: EIP:    0010:[<c018ba8f>]
Nov 15 20:41:39 marion kernel: EFLAGS: 00010212
Nov 15 20:41:39 marion kernel: eax: 00000000   ebx: 00001600   ecx: 00001600   edx: 00000000
Nov 15 20:41:39 marion kernel: esi: c03591d0   edi: 00001100   ebp: 00000040   esp: c68d7ee8
Nov 15 20:41:39 marion kernel: ds: 0018   es: 0018   ss: 0018
Nov 15 20:41:39 marion kernel: Process mount (pid: 2168, stackpage=c68d7000)
Nov 15 20:41:39 marion kernel: Stack: 16000330 00000000 00000330 00000000 c0359498 00000330 c018bb0a 00001600
Nov 15 20:41:39 marion kernel:        00000001 c03591d0 cf675760 00000000 c148a070 c018bbd4 c149a2a0 cf675760
Nov 15 20:41:39 marion kernel:        c0138a38 cf675760 c6973680 c6973680 cf675760 c1447320 c0131d60 cf675760
Nov 15 20:41:39 marion kernel: Call Trace: [revalidate_drives+74/128] [ide_open+52/240] [blkdev_open+72/128] [dentry_open+192/336] [filp_open+75/96]
Nov 15 20:41:39 marion kernel: Call Trace: [<c018bb0a>] [<c018bbd4>] [<c0138a38>] [<c0131d60>] [<c0131c8b>]
Nov 15 20:41:39 marion kernel:    [getname+95/160] [sys_open+54/176] [system_call+51/64]
Nov 15 20:41:39 marion kernel:    [<c013b45f>] [<c0131f76>] [<c0106ec3>]
Nov 15 20:41:39 marion kernel:
Nov 15 20:41:39 marion kernel: Code: 8b 40 28 85 c0 74 04 56 ff d0 5b 80 a6 ae 00 00 00 fb 8d 86
