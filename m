Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUCDL52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 06:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUCDL51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 06:57:27 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:43792 "EHLO
	usmimesweeper.bluearc.com") by vger.kernel.org with ESMTP
	id S261853AbUCDL4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 06:56:53 -0500
Message-ID: <AD4480A509455343AEFACCC231BA850FF1013F@ukexchange>
From: Martin Dorey <mdorey@bluearc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: init_dev accesses out-of-bounds tty index
Date: Thu, 4 Mar 2004 11:56:46 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And again:

Mar  4 10:48:08 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:48:36 doozer kernel: Unable to handle kernel paging request at
virtual address e2a1d004
Mar  4 10:48:36 doozer kernel:  printing eip:
Mar  4 10:48:36 doozer kernel: c0248738
Mar  4 10:48:36 doozer kernel: *pde = 0008c067
Mar  4 10:48:36 doozer kernel: Oops: 0000 [#1]
Mar  4 10:48:36 doozer kernel: CPU:    1
Mar  4 10:48:36 doozer kernel: EIP:    0060:[tty_open+858/878]    Not
tainted
Mar  4 10:48:36 doozer kernel: EFLAGS: 00010286
Mar  4 10:48:36 doozer kernel: EIP is at tty_open+0x35a/0x36e
Mar  4 10:48:36 doozer kernel: eax: e2a1d000   ebx: d1149e9c   ecx: fffffffa
edx: 00008802
Mar  4 10:48:36 doozer kernel: esi: 00000000   edi: d6e90f6c   ebp: c61f5f08
esp: c61f5edc
Mar  4 10:48:36 doozer kernel: ds: 007b   es: 007b   ss: 0068
Mar  4 10:48:36 doozer kernel: Process sh (pid: 9713, threadinfo=c61f4000
task=d1bf69d0)
Mar  4 10:48:36 doozer kernel: Stack: d6e90000 c61f5ef4 c011e73a 8802e8d5
00500000 00000000 c01674a0 c0520100 
Mar  4 10:48:36 doozer kernel:        d1149e9c 00000000 c61f4000 c61f5f30
c01670d2 d1149e9c d6e90f6c c61f5f30 
Mar  4 10:48:36 doozer kernel:        c0520100 d6e90f6c d6e90f6c d1149e9c
c0166fa5 c61f5f50 c015ce54 d1149e9c 
Mar  4 10:48:36 doozer kernel: Call Trace:
Mar  4 10:48:36 doozer kernel:  [kernel_map_pages+49/93]
kernel_map_pages+0x31/0x5d
Mar  4 10:48:36 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Mar  4 10:48:36 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Mar  4 10:48:36 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Mar  4 10:48:36 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Mar  4 10:48:36 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Mar  4 10:48:36 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Mar  4 10:48:36 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar  4 10:48:36 doozer kernel: 
Mar  4 10:48:36 doozer kernel: Code: 8b 70 04 80 ce 08 8b 40 08 89 45 f0 89
57 18 e9 11 fd ff ff 
Mar  4 10:48:40 doozer kernel:  <7>request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:48:57 doozer kernel: Unable to handle kernel paging request at
virtual address e2a1d004
Mar  4 10:48:57 doozer kernel:  printing eip:
Mar  4 10:48:57 doozer kernel: c0248738
Mar  4 10:48:57 doozer kernel: *pde = 0008c067
Mar  4 10:48:57 doozer kernel: Oops: 0000 [#2]
Mar  4 10:48:57 doozer kernel: CPU:    0
Mar  4 10:48:57 doozer kernel: EIP:    0060:[tty_open+858/878]    Not
tainted
Mar  4 10:48:57 doozer kernel: EFLAGS: 00010286
Mar  4 10:48:57 doozer kernel: EIP is at tty_open+0x35a/0x36e
Mar  4 10:48:57 doozer kernel: eax: e2a1d000   ebx: d1149e9c   ecx: fffffffa
edx: 00008802
Mar  4 10:48:57 doozer kernel: esi: 00000000   edi: f07aef6c   ebp: dc5eff08
esp: dc5efedc
Mar  4 10:48:57 doozer kernel: ds: 007b   es: 007b   ss: 0068
Mar  4 10:48:57 doozer kernel: Process sh (pid: 12063, threadinfo=dc5ee000
task=eee739d0)
Mar  4 10:48:57 doozer kernel: Stack: f07ae000 dc5efef4 c011e73a 8802e8d5
00500000 00000000 c01674a0 c0520100 
Mar  4 10:48:57 doozer kernel:        d1149e9c 00000000 dc5ee000 dc5eff30
c01670d2 d1149e9c f07aef6c dc5eff30 
Mar  4 10:48:57 doozer kernel:        c0520100 f07aef6c f07aef6c d1149e9c
c0166fa5 dc5eff50 c015ce54 d1149e9c 
Mar  4 10:48:57 doozer kernel: Call Trace:
Mar  4 10:48:57 doozer kernel:  [kernel_map_pages+49/93]
kernel_map_pages+0x31/0x5d
Mar  4 10:48:57 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Mar  4 10:48:57 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Mar  4 10:48:57 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Mar  4 10:48:57 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Mar  4 10:48:57 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Mar  4 10:48:57 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Mar  4 10:48:57 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar  4 10:48:57 doozer kernel: 
Mar  4 10:48:57 doozer kernel: Code: 8b 70 04 80 ce 08 8b 40 08 89 45 f0 89
57 18 e9 11 fd ff ff 
Mar  4 10:48:58 doozer kernel:  <1>Unable to handle kernel paging request at
virtual address e2a1d004
Mar  4 10:48:58 doozer kernel:  printing eip:
Mar  4 10:48:58 doozer kernel: c0248738
Mar  4 10:48:58 doozer kernel: *pde = 0008c067
Mar  4 10:48:58 doozer kernel: Oops: 0000 [#3]
Mar  4 10:48:58 doozer kernel: CPU:    1
Mar  4 10:48:58 doozer kernel: EIP:    0060:[tty_open+858/878]    Not
tainted
Mar  4 10:48:58 doozer kernel: EFLAGS: 00010286
Mar  4 10:48:58 doozer kernel: EIP is at tty_open+0x35a/0x36e
Mar  4 10:48:58 doozer kernel: eax: e2a1d000   ebx: d1149e9c   ecx: fffffffa
edx: 00008802
Mar  4 10:48:58 doozer kernel: esi: 00000000   edi: f0815f6c   ebp: f5f89f08
esp: f5f89edc
Mar  4 10:48:58 doozer kernel: ds: 007b   es: 007b   ss: 0068
Mar  4 10:48:58 doozer kernel: Process sh (pid: 12251, threadinfo=f5f88000
task=e7be99d0)
Mar  4 10:48:58 doozer kernel: Stack: f0815000 f5f89ef4 c011e73a 8802e8d5
00500000 00000000 c01674a0 c0520100 
Mar  4 10:48:58 doozer kernel:        d1149e9c 00000000 f5f88000 f5f89f30
c01670d2 d1149e9c f0815f6c f5f89f30 
Mar  4 10:48:58 doozer kernel:        c0520100 f0815f6c f0815f6c d1149e9c
c0166fa5 f5f89f50 c015ce54 d1149e9c 
Mar  4 10:48:58 doozer kernel: Call Trace:
Mar  4 10:48:58 doozer kernel:  [kernel_map_pages+49/93]
kernel_map_pages+0x31/0x5d
Mar  4 10:48:58 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Mar  4 10:48:58 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Mar  4 10:48:58 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Mar  4 10:48:58 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Mar  4 10:48:58 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Mar  4 10:48:58 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Mar  4 10:48:58 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar  4 10:48:58 doozer kernel: 
Mar  4 10:48:58 doozer kernel: Code: 8b 70 04 80 ce 08 8b 40 08 89 45 f0 89
57 18 e9 11 fd ff ff 
Mar  4 10:49:12 doozer kernel:  <7>request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:49:44 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:50:01 doozer /USR/SBIN/CRON[16852]: (martind) CMD (ping -c 4 kenny
> /dev/null || ~/bin/doozer-to-kenny)
Mar  4 10:50:16 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:50:48 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:51:52 doozer last message repeated 2 times
Mar  4 10:52:24 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:52:35 doozer kernel: Unable to handle kernel paging request at
virtual address 0000109c
Mar  4 10:52:35 doozer kernel:  printing eip:
Mar  4 10:52:35 doozer kernel: c0247554
Mar  4 10:52:35 doozer kernel: *pde = 00000000
Mar  4 10:52:35 doozer kernel: Oops: 0000 [#4]
Mar  4 10:52:35 doozer kernel: CPU:    1
Mar  4 10:52:35 doozer kernel: EIP:    0060:[init_dev+33/1332]    Not
tainted
Mar  4 10:52:35 doozer kernel: EFLAGS: 00010246
Mar  4 10:52:35 doozer kernel: EIP is at init_dev+0x21/0x534
Mar  4 10:52:35 doozer kernel: eax: 4046cbcb   ebx: d1149e9c   ecx: c046a65c
edx: 4046cbcb
Mar  4 10:52:35 doozer kernel: esi: 00001000   edi: de1bdf6c   ebp: e65c1ed4
esp: e65c1e88
Mar  4 10:52:35 doozer kernel: ds: 007b   es: 007b   ss: 0068
Mar  4 10:52:35 doozer kernel: Process sh (pid: 17956, threadinfo=e65c0000
task=db72f9d0)
Mar  4 10:52:35 doozer kernel: Stack: 4046cbcb c14b4588 c14b4588 00000000
e65c1ec0 c011e3e7 00000000 e65c1ec0 
Mar  4 10:52:35 doozer kernel:        c0174e43 c007a6f4 de1bd000 c14b4588
00000000 00000000 e65c1ee0 00000292 
Mar  4 10:52:35 doozer kernel:        d1149e9c 00001000 de1bdf6c e65c1f08
c0248473 00001000 4046cbcb e65c1ef4 
Mar  4 10:52:35 doozer kernel: Call Trace:
Mar  4 10:52:35 doozer kernel:  [__change_page_attr+36/456]
__change_page_attr+0x24/0x1c8
Mar  4 10:52:35 doozer kernel:  [dput+36/607] dput+0x24/0x25f
Mar  4 10:52:35 doozer kernel:  [tty_open+149/878] tty_open+0x95/0x36e
Mar  4 10:52:35 doozer kernel:  [cdev_get+91/185] cdev_get+0x5b/0xb9
Mar  4 10:52:35 doozer kernel:  [chrdev_open+301/698]
chrdev_open+0x12d/0x2ba
Mar  4 10:52:35 doozer kernel:  [chrdev_open+0/698] chrdev_open+0x0/0x2ba
Mar  4 10:52:35 doozer kernel:  [dentry_open+336/545]
dentry_open+0x150/0x221
Mar  4 10:52:35 doozer kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
Mar  4 10:52:35 doozer kernel:  [sys_open+85/133] sys_open+0x55/0x85
Mar  4 10:52:35 doozer kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar  4 10:52:35 doozer kernel: 
Mar  4 10:52:35 doozer kernel: Code: 8b 86 9c 00 00 00 8b 1c 90 85 db 74 62
8b 83 a0 00 00 00 a9 
Mar  4 10:52:54 doozer rpc.mountd: authenticated mount request from
blenkinsop.dev.bluearc.com:879 for /u112/martind (/u112)
Mar  4 10:52:56 doozer kernel:  <7>request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:53:02 doozer /USR/SBIN/CRON[18015]: (mail) CMD (  if [ -x
/usr/sbin/exim -a -f /etc/exim/exim.conf ]; then /usr/sbin/exim -q ; fi)
Mar  4 10:53:28 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:53:54 doozer automount[18035]: running expiration on path
/var/autofs/net/dogsbody.dev.bluearc.com
Mar  4 10:53:54 doozer automount[18035]: expired
/var/autofs/net/dogsbody.dev.bluearc.com
Mar  4 10:54:00 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:54:11 doozer rpc.mountd: authenticated unmount request from
dogsbody.dev.bluearc.com:843 for /u112/martind (/u112)
Mar  4 10:54:32 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:55:01 doozer /USR/SBIN/CRON[18058]: (martind) CMD (ping -c 4 kenny
> /dev/null || ~/bin/doozer-to-kenny)
Mar  4 10:55:04 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:55:36 doozer kernel: request_module: failed /sbin/modprobe --
char-major-6-0. error = 256
Mar  4 10:56:40 doozer last message repeated 2 times
Mar  4 10:57:44 doozer last message repeated 2 times
Mar  4 10:58:48 doozer last message repeated 2 times
Mar  4 11:00:00 doozer syslogd 1.4.1#13: restart.

-- 


*********************************************************************
This e-mail and any attachment is confidential. It may only be read, copied and used by the intended recipient(s). If you are not the intended recipient(s), you may not copy, use, distribute, forward, store or disclose this e-mail or any attachment. If you are not the intended recipient(s) or have otherwise received this e-mail in error, you should destroy it and any attachment and notify the sender by reply e-mail or send a message to sysadmin@bluearc.com
*********************************************************************

