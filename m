Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269542AbRHQD2V>; Thu, 16 Aug 2001 23:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269541AbRHQD2N>; Thu, 16 Aug 2001 23:28:13 -0400
Received: from pioneer.oftheInter.net ([216.61.42.221]:11792 "HELO
	pioneer.oftheInter.net") by vger.kernel.org with SMTP
	id <S269542AbRHQD17>; Thu, 16 Aug 2001 23:27:59 -0400
Date: Thu, 16 Aug 2001 22:28:11 -0500
From: Taylor Carpenter <taylorcc@codecafe.com>
To: linux-kernel@vger.kernel.org
Subject: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
Message-ID: <20010816222811.A1672@pioneer.oftheInter.net>
Mime-Version: 1.0
Content-Type: message/rfc822
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any access to /dev/fd0 gives a kernel oops.  Have not accessed the floppy in a
while, but noticed the complaint when booting and after looking further.

kernel: 2.4.7  (using devfs)
devfsd: 1.3.11


[12]# insmod floppy
Using /lib/modules/2.4.7athlon/kernel/drivers/block/floppy.o
inserting floppy driver for 2.4.7athlon
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077

[13]# ls -l /dev/fd0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c013c4c4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013c4c4>]
EFLAGS: 00010246
eax: 00000000   ebx: 00001000   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: 00000000   ebp: dd439fa4   esp: dd439f5c
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 367, stackpage=dd439000)
Stack: df693ec0 00000000 00001000 c015469b df693ec0 bfffec54 00001000 00000000
       df092840 c01376d2 df693ec0 bfffec54 00001000 df092840 dd438000 bffffead
       00000003 bffffc7c df693ec0 c188e4c0 00003000 dd438000 08057000 00000008
Call Trace: [<c015469b>] [<c01376d2>] [<c0106c2b>]

Code: f2 ae f7 d1 49 89 ce 39 de 0f 47 f3 56 52 8b 44 24 1c 50 e8
Segmentation fault


Please CC replies to taylorcc@codecafe.com as I am not on the list.  Thanks.
