Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbTAKTFG>; Sat, 11 Jan 2003 14:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268102AbTAKTFG>; Sat, 11 Jan 2003 14:05:06 -0500
Received: from smtp.terra.es ([213.4.129.129]:51489 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id <S268100AbTAKTFE>;
	Sat, 11 Jan 2003 14:05:04 -0500
Date: Sat, 11 Jan 2003 20:13:06 +0100
From: ----- <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: 2.5.56 lib/kobject.c "badness" (ppp bug?)
Message-Id: <20030111201306.7513bc7e.grundig@teleline.es>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while connected at inet:

Jan 11 17:44:01 estel kernel: Badness in kobject_register at lib/kobject.c:129
Jan 11 17:44:01 estel kernel: Call Trace:
Jan 11 17:44:01 estel kernel:  [kobject_register+88/112] kobject_register+0x58/0x70
Jan 11 17:44:01 estel kernel:  [register_netdevice+447/496] register_netdevice+0x1bf/0x1f0
Jan 11 17:44:01 estel kernel:  [<d0873893>] ppp_create_interface+0x163/0x2f78c8d0 [ppp_generic]
Jan 11 17:44:01 estel kernel:  [<d0874d01>] +0x9d/0x2f78b39c [ppp_generic]
Jan 11 17:44:01 estel kernel:  [<d0870d8a>] ppp_unattached_ioctl+0x15a/0x2f78f3d0 [ppp_generic]
Jan 11 17:44:01 estel kernel:  [<d0870c2b>] ppp_ioctl+0x78b/0x2f78fb60 [ppp_generic]
Jan 11 17:44:01 estel kernel:  [cache_free_debugcheck+393/592] cache_free_debugcheck+0x189/0x250
Jan 11 17:44:01 estel kernel:  [sys_ioctl+349/733] sys_ioctl+0x15d/0x2dd
Jan 11 17:44:01 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 11 17:44:01 estel kernel: 
Jan 11 17:44:01 estel kernel:  printing eip:
Jan 11 17:44:01 estel kernel: c0261f8c
Jan 11 17:44:01 estel kernel: Oops: 0000
Jan 11 17:44:01 estel kernel: CPU:    1
Jan 11 17:44:01 estel kernel: EIP:    0060:[__dev_get_by_name+44/80]    Not tainted
Jan 11 17:44:01 estel kernel: EFLAGS: 00010216
Jan 11 17:44:01 estel kernel: EIP is at __dev_get_by_name+0x2c/0x50
Jan 11 17:44:01 estel kernel: eax: ffffffff   ebx: c9fa5f0c   ecx: 0000000f   edx: 6b6b6b6b
Jan 11 17:44:01 estel kernel: esi: 6b6b6b6b   edi: c9fa5f0c   ebp: c9fa5ed8   esp: c9fa5ecc
Jan 11 17:44:01 estel kernel: ds: 007b   es: 007b   ss: 0068
Jan 11 17:44:01 estel kernel: Process netspeed_applet (pid: 402, threadinfo=c9fa4000 task=ca2c6cc0)
Jan 11 17:44:01 estel kernel: Stack: c9fa5f0c 00000001 c9fa5f0c c9fa5ee4 c0262034 c9fa5f0c c9fa5ef4 c02622f4 
Jan 11 17:44:01 estel kernel:        c9fa5f0c 00008913 c9fa5f38 c02641e9 c9fa5f0c bfffd628 00000020 00000000 
Jan 11 17:44:01 estel kernel:        30707070 08153900 00000050 00210f40 bfffd658 404a3837 081539c8 08171630 
Jan 11 17:44:01 estel kernel: Call Trace:
Jan 11 17:44:01 estel kernel:  [dev_get+52/80] dev_get+0x34/0x50
Jan 11 17:44:01 estel kernel:  [dev_load+20/96] dev_load+0x14/0x60
Jan 11 17:44:01 estel kernel:  [dev_ioctl+153/704] dev_ioctl+0x99/0x2c0
Jan 11 17:44:01 estel kernel:  [inet_ioctl+194/224] inet_ioctl+0xc2/0xe0
Jan 11 17:44:01 estel kernel:  [sock_ioctl+340/832] sock_ioctl+0x154/0x340
Jan 11 17:44:01 estel kernel:  [sys_ioctl+349/733] sys_ioctl+0x15d/0x2dd
Jan 11 17:44:01 estel kernel:  [math_state_restore+41/80] math_state_restore+0x29/0x50
Jan 11 17:44:01 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 11 17:44:01 estel kernel: 
Jan 11 17:44:01 estel kernel: Code: ac ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 74 07 
Jan 11 17:44:02 estel pppd[694]: Exit.
Jan 11 17:44:06 estel kernel:  <1>Unable to handle kernel paging request at virtual address 6b6b6b7f
Jan 11 17:44:06 estel kernel:  printing eip:
Jan 11 17:44:06 estel kernel: c029fbc1
Jan 11 17:44:06 estel kernel: Oops: 0000
Jan 11 17:44:06 estel kernel: CPU:    1
Jan 11 17:44:06 estel kernel: EIP:    0060:[inet_gifconf+33/208]    Not tainted
Jan 11 17:44:06 estel kernel: EFLAGS: 00010202
Jan 11 17:44:06 estel kernel: EIP is at inet_gifconf+0x21/0xd0
Jan 11 17:44:06 estel kernel: eax: 6b6b6b6b   ebx: 00000002   ecx: 00000000   edx: cb555600
Jan 11 17:44:06 estel kernel: esi: 00000040   edi: cb555600   ebp: c99dbec4   esp: c99dbe84
Jan 11 17:44:06 estel kernel: ds: 007b   es: 007b   ss: 0068
Jan 11 17:44:06 estel kernel: Process netspeed_applet (pid: 699, threadinfo=c99da000 task=c4159320)
Jan 11 17:44:06 estel kernel: Stack: cfe1cc50 0000000a c99dbf1d 00000000 00000000 000001d0 c99dbeb8 00000000 
Jan 11 17:44:06 estel kernel:        bfffede0 c99dbec4 c01ae168 c99dbee0 bfffede0 00000002 00000040 cb555600 
Jan 11 17:44:06 estel kernel:        c99dbef4 c0263579 cb555600 00000000 00000000 00000000 00000000 00000000 
Jan 11 17:44:06 estel kernel: Call Trace:
Jan 11 17:44:06 estel kernel:  [copy_from_user+72/76] copy_from_user+0x48/0x4c
Jan 11 17:44:06 estel kernel:  [dev_ifconf+121/224] dev_ifconf+0x79/0xe0
Jan 11 17:44:06 estel kernel:  [dev_ioctl+629/704] dev_ioctl+0x275/0x2c0
Jan 11 17:44:06 estel kernel:  [sock_map_fd+293/336] sock_map_fd+0x125/0x150
Jan 11 17:44:06 estel kernel:  [inet_ioctl+194/224] inet_ioctl+0xc2/0xe0
Jan 11 17:44:06 estel kernel:  [sock_ioctl+340/832] sock_ioctl+0x154/0x340
Jan 11 17:44:06 estel kernel:  [sys_ioctl+349/733] sys_ioctl+0x15d/0x2dd
Jan 11 17:44:06 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 11 17:44:06 estel kernel: 
Jan 11 17:44:06 estel kernel: Code: 8b 40 14 85 c0 89 45 d0 0f 84 7f 00 00 00 90 8b 45 0c 85 c0 


And after rebooting (because ppp did work)
while calling my provider

Jan 11 20:04:14 estel chat[947]: CONNECT
Jan 11 20:04:14 estel chat[947]:  -- got it 
Jan 11 20:04:14 estel chat[947]: send (\d)
Jan 11 20:04:15 estel pppd[946]: Serial connection established.
Jan 11 20:04:15 estel kernel:  printing eip:
Jan 11 20:04:15 estel kernel: c0262060
Jan 11 20:04:15 estel kernel: Oops: 0000
Jan 11 20:04:15 estel kernel: CPU:    0
Jan 11 20:04:15 estel kernel: EIP:    0060:[__dev_get_by_index+16/32]    Not tainted
Jan 11 20:04:15 estel kernel: EFLAGS: 00210202
Jan 11 20:04:15 estel kernel: EIP is at __dev_get_by_index+0x10/0x20
Jan 11 20:04:15 estel kernel: eax: 6b6b6b6b   ebx: c77c7400   ecx: d0871110   edx: 00000005
Jan 11 20:04:15 estel kernel: esi: c77c7200   edi: c77c7400   ebp: c2a87ea8   esp: c2a87ea8
Jan 11 20:04:15 estel kernel: ds: 007b   es: 007b   ss: 0068
Jan 11 20:04:15 estel kernel: Process pppd (pid: 946, threadinfo=c2a86000 task=c45260a0)
Jan 11 20:04:15 estel kernel: Stack: c2a87eb4 c0264437 00000005 c2a87ed8 c02644cd c77c7400 c2a87eec c2a87ed8 
Jan 11 20:04:15 estel kernel:        fffffffb 00000000 c77c7200 c77c7400 c2a87efc d0873893 c77c7400 d0874d01 
Jan 11 20:04:15 estel kernel:        00000000 ffffffef cd6209a4 c004743e cd6209a4 c2a87f24 d0870d8a 00000000 
Jan 11 20:04:15 estel kernel: Call Trace:
Jan 11 20:04:15 estel kernel:  [dev_new_index+39/80] dev_new_index+0x27/0x50
Jan 11 20:04:15 estel kernel:  [register_netdevice+109/496] register_netdevice+0x6d/0x1f0
Jan 11 20:04:15 estel kernel:  [<d0873893>] ppp_create_interface+0x163/0x2f78c8d0 [ppp_generic]
Jan 11 20:04:15 estel kernel:  [<d0874d01>] +0x9d/0x2f78b39c [ppp_generic]
Jan 11 20:04:15 estel kernel:  [<d0870d8a>] ppp_unattached_ioctl+0x15a/0x2f78f3d0 [ppp_generic]
Jan 11 20:04:15 estel kernel:  [<d0870c2b>] ppp_ioctl+0x78b/0x2f78fb60 [ppp_generic]
Jan 11 20:04:15 estel kernel:  [cache_free_debugcheck+393/592] cache_free_debugcheck+0x189/0x250
Jan 11 20:04:15 estel kernel:  [sys_ioctl+349/733] sys_ioctl+0x15d/0x2dd
Jan 11 20:04:15 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 11 20:04:15 estel kernel: 
Jan 11 20:04:15 estel kernel: Code: 39 50 34 74 07 8b 40 28 85 c0 75 f4 5d c3 89 f6 55 89 e5 83 
