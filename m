Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262907AbSJLLzn>; Sat, 12 Oct 2002 07:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbSJLLzn>; Sat, 12 Oct 2002 07:55:43 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:31104 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S262907AbSJLLzm>;
	Sat, 12 Oct 2002 07:55:42 -0400
Date: Sat, 12 Oct 2002 14:01:13 +0200
From: Witek Krecicki <adasi@kernel.pl>
X-Mailer: The Bat! (v1.61) Personal
Reply-To: Witek Krecicki <adasi@kernel.pl>
Organization: PLD
X-Priority: 3 (Normal)
Message-ID: <1053392808.20021012140113@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Oppses while booting (initrd)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's hardware-independend (testen on Asus A7M266 & VMWare)
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

Oops:
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0107a25
*pde = 00000000
Oops: 0002

CPU:    0
EIP:    0060:[<c0107a25>]    Not tainted
EFLAGS: 00000002
EIP is at __down+0x5d/0xf0
eax: c1383e94   ebx: c02266a0   ecx: 00000000   edx: c02266c0
esi: c02266b4   edi: 00000246   ebp: c1380040   esp: c1383e74
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c1382000 task=c1380040)
Stack: c02266a0 00000000 c02266b4 c8fa535c c1382000 00000001 c1380040 c011409c
       c02266c0 00000000 c0107c34 c02266b4 00000001 00000001 c016f176 c020236d
       00000077 c8fc2200 ffffffff c8fc2200 c01697ee c02266a0 00000000 c8fc2200
Call Trace:
 [<c011409c>] default_wake_function+0x0/0x34
 [<c0107c34>] __down_failed+0x8/0xc
 [<c016f176>] .text.lock.util+0x7d/0x97
 [<c01697ee>] devfs_remove_partitions+0x7a/0x84
 [<c0169bd5>] del_gendisk+0x1d/0x3c
 [<c019cbbb>] initrd_release+0x2f/0x7c
 [<c013f236>] __fput+0x2a/0xdc
 [<c013f20b>] fput+0x13/0x14
 [<c013d865>] filp_close+0x99/0xa4
 [<c013d8c8>] sys_close+0x58/0x80
 [<c0108a4f>] syscall_call+0x7/0xb
 [<c0105395>] prepare_namespace+0xa9/0x130
 [<c0105090>] init+0x38/0x188
 [<c0105058>] init+0x0/0x188
 [<c0106f75>] kernel_thread_helper+0x5/0xc

Code: 89 01 ff 46 04 8b 5c 24 10 eb 30 c7 46 04 01 00 00 00 57 9d 
 <0>Kernel panic: Attempted to kill init!
Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c0115214>] __might_sleep+0x54/0x60
 [<c0159321>] get_super_to_sync+0x49/0x90
 [<c0159397>] sync_inodes+0x2f/0x74
 [<c013f71e>] sys_sync+0xe/0x2c
 [<c0116dd5>] panic+0x65/0xe0
 [<c011a853>] do_exit+0x43/0x314
 [<c0109927>] die+0x77/0x78
 [<c0112177>] do_page_fault+0x2f7/0x434
 [<c0111e80>] do_page_fault+0x0/0x434
 [<c010dd7b>] timer_interrupt+0x5b/0x104
 [<c010a67d>] handle_IRQ_event+0x29/0x4c
 [<c011be89>] tasklet_hi_action+0x3d/0x60
 [<c011bcaa>] do_softirq+0x5a/0xac


-- 
Best regards,
 Witek                          mailto:adasi@kernel.pl


