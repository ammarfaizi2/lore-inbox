Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbTBJW3A>; Mon, 10 Feb 2003 17:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbTBJW3A>; Mon, 10 Feb 2003 17:29:00 -0500
Received: from jabba.hao.ucar.edu ([128.117.16.5]:12449 "EHLO
	jabba.hao.ucar.edu") by vger.kernel.org with ESMTP
	id <S265385AbTBJW2s>; Mon, 10 Feb 2003 17:28:48 -0500
Message-Id: <200302102238.PAA06069@jabba.hao.ucar.edu>
Date: Mon, 10 Feb 2003 15:38:33 -0700 (MST)
From: Barry Gamblin <bgamblin@hao.ucar.edu>
Reply-To: Barry Gamblin <bgamblin@hao.ucar.edu>
Subject: kernel bug in /var/log/messages
To: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: Phe2C6w8N1m+KjG1ZgkjEA==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.3.5 SunOS 5.7 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is running Redhat 7.3 with Kernel 2.4.18-19.7.xsmp on an i686.

It is a dual Xeon Supermicro P4DC6 motherboard. This is the message I 
got over the weekend:

Feb  9 04:02:01 cedar-l syslogd 1.4.1: restart.
Feb  9 04:22:46 cedar-l kernel: Page has mapping still set. This is a 
serious si
tuation. However if you 
Feb  9 04:22:46 cedar-l kernel: are using the NVidia binary only module 
please r
eport this bug to 
Feb  9 04:22:46 cedar-l kernel: NVidia and not to Red Hat Bugzilla or 
the linux 
kernel mailinglist.
Feb  9 04:22:46 cedar-l kernel: ------------[ cut here ]------------
Feb  9 04:22:46 cedar-l kernel: kernel BUG at page_alloc.c:130!
Feb  9 04:22:46 cedar-l kernel: invalid operand: 0000
Feb  9 04:22:46 cedar-l kernel: nfsd autofs nfs lockd sunrpc eepro100 
usb-uhci u
sbcore aic7xxx sd_mod scsi_mod  
Feb  9 04:22:46 cedar-l kernel: CPU:    1
Feb  9 04:22:46 cedar-l kernel: EIP:    0010:[<c013ac4e>]    Not tainted
Feb  9 04:22:46 cedar-l kernel: EFLAGS: 00010282
Feb  9 04:22:46 cedar-l kernel: 
Feb  9 04:22:46 cedar-l kernel: EIP is at __free_pages_ok [kernel] 0x5e 
(2.4.18-
19.7.xsmp)
Feb  9 04:22:46 cedar-l kernel: eax: 00000047   ebx: c173ac60   ecx: 
00000001   
edx: 00000001
Feb  9 04:22:46 cedar-l kernel: esi: 00000000   edi: 00000061   ebp: 
00000000   
esp: e0ff5e64
Feb  9 04:22:46 cedar-l kernel: ds: 0018   es: 0018   ss: 0018
Feb  9 04:22:46 cedar-l kernel: Process awk (pid: 11418, 
stackpage=e0ff5000)
Feb  9 04:22:46 cedar-l kernel: Stack: c024ffc0 c024ff60 c024ff00 
00000001 c1038
030 c0305da4 00000202 ffffffff 
Feb  9 04:22:46 cedar-l kernel:        00020cd6 0001066b c039d65c 
0000001b 00000
061 c1764f00 c012cdfc c173ac60 
Feb  9 04:22:46 cedar-l kernel:        00062000 00000061 00062000 
00000061 080e2
000 e229d084 08400000 c039d5e0 
Feb  9 04:22:46 cedar-l kernel: Call Trace: [<c012cdfc>] 
do_zap_page_range [kern
el] 0x37c (0xe0ff5e9c))
Feb  9 04:22:46 cedar-l kernel: [<c0156f1c>] dput [kernel] 0x1c 
(0xe0ff5ef8))
Feb  9 04:22:46 cedar-l kernel: [<c012d2d0>] zap_page_range [kernel] 
0x50 (0xe0f
f5f10))
Feb  9 04:22:46 cedar-l kernel: [<c012fe2b>] exit_mmap [kernel] 0xdb 
(0xe0ff5f34
))
Feb  9 04:22:46 cedar-l kernel: [<c011bea8>] mmput [kernel] 0x38 
(0xe0ff5f6c))
Feb  9 04:22:46 cedar-l kernel: [<c0120d5c>] do_exit [kernel] 0xdc 
(0xe0ff5f78))
Feb  9 04:22:46 cedar-l kernel: [<c01435c2>] sys_read [kernel] 0x102 
(0xe0ff5f8c
))
Feb  9 04:22:46 cedar-l kernel: [<c012fa55>] sys_munmap [kernel] 0x35 
(0xe0ff5fa
0))
Feb  9 04:22:46 cedar-l kernel: [<c0108c83>] system_call [kernel] 0x33 
(0xe0ff5f
c0))
Feb  9 04:22:46 cedar-l kernel: 
Feb  9 04:22:46 cedar-l kernel: 
Feb  9 04:22:46 cedar-l kernel: Code: 0f 0b 82 00 17 09 25 c0 8b 53 08 
83 c4 0c 
8b 3d d0 82 3c c0 

Today I have experienced several lockups on the system requiring a 
reset. I had to re-install this system on Friday due to a system disk 
that got corrupted. I upgraded the kernel, modutils and glibc, but 
nothing else.

Barry

Barry S. Gamblin, UNIX Administrator III, bgamblin@ucar.edu
High Altitude Observatory - National Center for Atmospheric Research
P.O.Box 3000, Boulder CO 80307-3000
voice - 303-497-1509  fax - 303-497-1589

