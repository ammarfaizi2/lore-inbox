Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310362AbSCBMEC>; Sat, 2 Mar 2002 07:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310361AbSCBMDz>; Sat, 2 Mar 2002 07:03:55 -0500
Received: from basfegw1.basf-ag.de ([141.6.1.21]:29928 "EHLO
	basfegw1.basf-ag.de") by vger.kernel.org with ESMTP
	id <S310360AbSCBMDq>; Sat, 2 Mar 2002 07:03:46 -0500
Subject: Kernel Hangs 2.4.16 on heay io on a reiserfs mounted on a lvm partition
To: linux-kernel@vger.kernel.org
Cc: alessandro.suardi@oracle.com, suse-oracle@suse.com, suse-linux-e@suse.com,
        mason@suse.com
X-Mailer: Lotus Notes Version 5.0 (Intl)   14. April 1999
Message-ID: <OFC93A704D.4FC6B19A-ONC1256B70.00415E26@bcs.de>
From: Oliver.Schersand@BASF-IT-Services.com
Date: Sat, 2 Mar 2002 13:03:50 +0100
X-MIMETrack: Serialize by Router on EUROPE-Gw03/EUROPE/BASF(Release 5.0.8 |June 18, 2001) at
 02/03/2002 13:03:35
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi i had know the next crash of the system in this case the system crashes
direct after the start of oracle



Mar  2 09:54:59 lxlu1213 kernel:
Mar  2 09:54:59 lxlu1213 kernel: wait_on_irq, CPU 1:
Mar  2 09:54:59 lxlu1213 kernel: irq:  0 [ 0 0 ]
Mar  2 09:54:59 lxlu1213 kernel: bh:   1 [ 1 0 ]
Mar  2 09:54:59 lxlu1213 kernel: Stack dumps:
Mar  2 09:54:59 lxlu1213 kernel: CPU 0: <unknown>
Mar  2 09:54:59 lxlu1213 kernel: CPU 1:c8e95e44 c0263d5d 00000001 00000020 00000000 c0108573 c0263d72 c8c64000
Mar  2 09:54:59 lxlu1213 kernel:        c032d560 c2768ae0 c0193671 c8c64000 c8e77000 c01938af c8c64000 00000000
Mar  2 09:54:59 lxlu1213 kernel:        c8c64000 c8e82000 c2768b04 c0190108 c8c64000 00000000 c032bfe0 c032bfe0
Mar  2 09:54:59 lxlu1213 kernel: Call Trace: [__global_cli+195/304] [n_tty_set_termios+117/512] [n_tty_open+135/160] [init_dev+760/1056]
[tty_open+269/948]
Mar  2 09:54:59 lxlu1213 kernel:    [dput+25/348] [get_chrfops+183/348] [permission+123/132] [chrdev_open+103/144] [dentry_open+228/400]
[filp_open+74/84]
Mar  2 09:54:59 lxlu1213 kernel:    [sys_open+54/204] [system_call+51/64]
Mar  2 09:54:59 lxlu1213 kernel:
Mar  2 10:25:01 lxlu1213 kernel: Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:01 lxlu1213 kernel:  printing eip:
Mar  2 10:25:01 lxlu1213 kernel: c0156cd0
Mar  2 10:25:01 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:01 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:01 lxlu1213 kernel: CPU:    1
Mar  2 10:25:01 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:01 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:01 lxlu1213 kernel: eax: 00003296   ebx: d51cff6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:01 lxlu1213 kernel: esi: d51cff64   edi: c29a9c60   ebp: 000f0000   esp: d51cff14
Mar  2 10:25:01 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:01 lxlu1213 kernel: Process ps (pid: 3504, stackpage=d51cf000)
Mar  2 10:25:01 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 d51cff64 d51cff6c c8dc4000 c89c14a0
Mar  2 10:25:01 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 d51cff6c d51cff64 c8dc4342 00000000
Mar  2 10:25:01 lxlu1213 kernel:        ffffffff f4c97740 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:01 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:01 lxlu1213 kernel:
Mar  2 10:25:01 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:25:01 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:01 lxlu1213 kernel:  printing eip:
Mar  2 10:25:01 lxlu1213 kernel: c0156cd0
Mar  2 10:25:01 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:01 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:01 lxlu1213 kernel: CPU:    1
Mar  2 10:25:01 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:01 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:01 lxlu1213 kernel: eax: 00003296   ebx: f1d8bf6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:01 lxlu1213 kernel: esi: f1d8bf64   edi: c29a9c60   ebp: 000f0000   esp: f1d8bf14
Mar  2 10:25:01 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:01 lxlu1213 kernel: Process ps (pid: 3509, stackpage=f1d8b000)
Mar  2 10:25:01 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f1d8bf64 f1d8bf6c c8dc4000 c89c14a0
Mar  2 10:25:01 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f1d8bf6c f1d8bf64 c8dc4342 00000000
Mar  2 10:25:01 lxlu1213 kernel:        ffffffff c4067aa0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:01 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:01 lxlu1213 kernel:
Mar  2 10:25:01 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:25:37 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:37 lxlu1213 kernel:  printing eip:
Mar  2 10:25:37 lxlu1213 kernel: c0156cd0
Mar  2 10:25:37 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:37 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:37 lxlu1213 kernel: CPU:    1
Mar  2 10:25:37 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:37 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:37 lxlu1213 kernel: eax: 00003296   ebx: f00cbf6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:37 lxlu1213 kernel: esi: f00cbf64   edi: c29a9c60   ebp: 000f0000   esp: f00cbf14
Mar  2 10:25:37 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:37 lxlu1213 kernel: Process ps (pid: 3606, stackpage=f00cb000)
Mar  2 10:25:37 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f00cbf64 f00cbf6c c8dc4000 c89c14a0
Mar  2 10:25:37 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f00cbf6c f00cbf64 c8dc4342 00000000
Mar  2 10:25:37 lxlu1213 kernel:        ffffffff ce7737c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:37 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:37 lxlu1213 kernel:
Mar  2 10:25:37 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:25:46 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:46 lxlu1213 kernel:  printing eip:
Mar  2 10:25:46 lxlu1213 kernel: c0156cd0
Mar  2 10:25:46 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:46 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:46 lxlu1213 kernel: CPU:    1
Mar  2 10:25:46 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:46 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:46 lxlu1213 kernel: eax: 00003296   ebx: d85ebf6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:46 lxlu1213 kernel: esi: d85ebf64   edi: c29a9c60   ebp: 000f0000   esp: d85ebf14
Mar  2 10:25:46 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:46 lxlu1213 kernel: Process ps (pid: 3720, stackpage=d85eb000)
Mar  2 10:25:46 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 d85ebf64 d85ebf6c c8dc4000 c89c14a0
Mar  2 10:25:46 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 d85ebf6c d85ebf64 c8dc4342 00000000
Mar  2 10:25:46 lxlu1213 kernel:        ffffffff d840aaa0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:46 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:46 lxlu1213 kernel:
Mar  2 10:25:46 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:25:46 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:46 lxlu1213 kernel:  printing eip:
Mar  2 10:25:46 lxlu1213 kernel: c0156cd0
Mar  2 10:25:46 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:46 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:46 lxlu1213 kernel: CPU:    1
Mar  2 10:25:46 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:46 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:46 lxlu1213 kernel: eax: 00003296   ebx: d0feff6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:46 lxlu1213 kernel: esi: d0feff64   edi: c29a9c60   ebp: 000f0000   esp: d0feff14
Mar  2 10:25:46 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:46 lxlu1213 kernel: Process ps (pid: 3747, stackpage=d0fef000)
Mar  2 10:25:46 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 d0feff64 d0feff6c c8dc4000 c89c14a0
Mar  2 10:25:46 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 d0feff6c d0feff64 c8dc4342 00000000
Mar  2 10:25:46 lxlu1213 kernel:        ffffffff de72bc40 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:46 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:46 lxlu1213 kernel:
Mar  2 10:25:46 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:25:52 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:52 lxlu1213 kernel:  printing eip:
Mar  2 10:25:52 lxlu1213 kernel: c0156cd0
Mar  2 10:25:52 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:52 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:52 lxlu1213 kernel: CPU:    1
Mar  2 10:25:52 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:52 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:52 lxlu1213 kernel: eax: 00003296   ebx: e1823f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:52 lxlu1213 kernel: esi: e1823f64   edi: c29a9c60   ebp: 000f0000   esp: e1823f14
Mar  2 10:25:52 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:52 lxlu1213 kernel: Process ps (pid: 3853, stackpage=e1823000)
Mar  2 10:25:52 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 e1823f64 e1823f6c c8dc4000 c89c14a0
Mar  2 10:25:52 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 e1823f6c e1823f64 c8dc4342 00000000
Mar  2 10:25:52 lxlu1213 kernel:        ffffffff e02153e0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:52 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:52 lxlu1213 kernel:
Mar  2 10:25:52 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:25:53 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:53 lxlu1213 kernel:  printing eip:
Mar  2 10:25:53 lxlu1213 kernel: c0156cd0
Mar  2 10:25:53 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:53 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:53 lxlu1213 kernel: CPU:    1
Mar  2 10:25:53 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:53 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:53 lxlu1213 kernel: eax: 00003296   ebx: e0e41f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:53 lxlu1213 kernel: esi: e0e41f64   edi: c29a9c60   ebp: 000f0000   esp: e0e41f14
Mar  2 10:25:53 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:53 lxlu1213 kernel: Process ps (pid: 3878, stackpage=e0e41000)
Mar  2 10:25:53 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 e0e41f64 e0e41f6c c8dc4000 c89c14a0
Mar  2 10:25:53 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 e0e41f6c e0e41f64 c8dc4342 00000000
Mar  2 10:25:53 lxlu1213 kernel:        ffffffff d840ab20 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:53 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:53 lxlu1213 kernel:
Mar  2 10:25:53 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:25:59 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:59 lxlu1213 kernel:  printing eip:
Mar  2 10:25:59 lxlu1213 kernel: c0156cd0
Mar  2 10:25:59 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:59 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:59 lxlu1213 kernel: CPU:    0
Mar  2 10:25:59 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:59 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:59 lxlu1213 kernel: eax: 00003296   ebx: e02a9f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:59 lxlu1213 kernel: esi: e02a9f64   edi: c29a9c60   ebp: 000f0000   esp: e02a9f14
Mar  2 10:25:59 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:59 lxlu1213 kernel: Process ps (pid: 3981, stackpage=e02a9000)
Mar  2 10:25:59 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 e02a9f64 e02a9f6c c8dc4000 c89c14a0
Mar  2 10:25:59 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 e02a9f6c e02a9f64 c8dc4342 00000000
Mar  2 10:25:59 lxlu1213 kernel:        ffffffff e475a5c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:59 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:59 lxlu1213 kernel:
Mar  2 10:25:59 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:25:59 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:25:59 lxlu1213 kernel:  printing eip:
Mar  2 10:25:59 lxlu1213 kernel: c0156cd0
Mar  2 10:25:59 lxlu1213 kernel: *pde = 00000000
Mar  2 10:25:59 lxlu1213 kernel: Oops: 0000
Mar  2 10:25:59 lxlu1213 kernel: CPU:    1
Mar  2 10:25:59 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:25:59 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:25:59 lxlu1213 kernel: eax: 00003296   ebx: dfe1bf6c   ecx: 0000329a   edx: 00000001
Mar  2 10:25:59 lxlu1213 kernel: esi: dfe1bf64   edi: c29a9c60   ebp: 000f0000   esp: dfe1bf14
Mar  2 10:25:59 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:25:59 lxlu1213 kernel: Process ps (pid: 4006, stackpage=dfe1b000)
Mar  2 10:25:59 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 dfe1bf64 dfe1bf6c c8dc4000 c89c14a0
Mar  2 10:25:59 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 dfe1bf6c dfe1bf64 c8dc4342 00000000
Mar  2 10:25:59 lxlu1213 kernel:        ffffffff f4c979c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:25:59 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:25:59 lxlu1213 kernel:
Mar  2 10:25:59 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:26:15 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:26:15 lxlu1213 kernel:  printing eip:
Mar  2 10:26:15 lxlu1213 kernel: c0156cd0
Mar  2 10:26:15 lxlu1213 kernel: *pde = 00000000
Mar  2 10:26:15 lxlu1213 kernel: Oops: 0000
Mar  2 10:26:15 lxlu1213 kernel: CPU:    0
Mar  2 10:26:15 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:26:15 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:26:15 lxlu1213 kernel: eax: 00003296   ebx: ea791f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:26:15 lxlu1213 kernel: esi: ea791f64   edi: c29a9c60   ebp: 000f0000   esp: ea791f14
Mar  2 10:26:15 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:26:15 lxlu1213 kernel: Process ps (pid: 4136, stackpage=ea791000)
Mar  2 10:26:15 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 ea791f64 ea791f6c c8dc4000 c89c14a0
Mar  2 10:26:15 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 ea791f6c ea791f64 c8dc4342 00000000
Mar  2 10:26:15 lxlu1213 kernel:        ffffffff e7f77d40 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:26:15 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:26:15 lxlu1213 kernel:
Mar  2 10:26:15 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:26:15 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:26:15 lxlu1213 kernel:  printing eip:
Mar  2 10:26:15 lxlu1213 kernel: c0156cd0
Mar  2 10:26:15 lxlu1213 kernel: *pde = 00000000
Mar  2 10:26:15 lxlu1213 kernel: Oops: 0000
Mar  2 10:26:15 lxlu1213 kernel: CPU:    1
Mar  2 10:26:15 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:26:15 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:26:15 lxlu1213 kernel: eax: 00003296   ebx: ebfb3f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:26:15 lxlu1213 kernel: esi: ebfb3f64   edi: c29a9c60   ebp: 000f0000   esp: ebfb3f14
Mar  2 10:26:15 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:26:15 lxlu1213 kernel: Process ps (pid: 4161, stackpage=ebfb3000)
Mar  2 10:26:15 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 ebfb3f64 ebfb3f6c c8dc4000 c89c14a0
Mar  2 10:26:15 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 ebfb3f6c ebfb3f64 c8dc4342 00000000
Mar  2 10:26:15 lxlu1213 kernel:        ffffffff e81d6ce0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:26:15 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:26:15 lxlu1213 kernel:
Mar  2 10:26:15 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:26:22 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:26:22 lxlu1213 kernel:  printing eip:
Mar  2 10:26:22 lxlu1213 kernel: c0156cd0
Mar  2 10:26:22 lxlu1213 kernel: *pde = 00000000
Mar  2 10:26:22 lxlu1213 kernel: Oops: 0000
Mar  2 10:26:22 lxlu1213 kernel: CPU:    0
Mar  2 10:26:22 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:26:22 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:26:22 lxlu1213 kernel: eax: 00003296   ebx: f29d1f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:26:22 lxlu1213 kernel: esi: f29d1f64   edi: c29a9c60   ebp: 000f0000   esp: f29d1f14
Mar  2 10:26:22 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:26:22 lxlu1213 kernel: Process ps (pid: 4270, stackpage=f29d1000)
Mar  2 10:26:22 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f29d1f64 f29d1f6c c8dc4000 c89c14a0
Mar  2 10:26:22 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f29d1f6c f29d1f64 c8dc4342 00000000
Mar  2 10:26:22 lxlu1213 kernel:        ffffffff e81d6460 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:26:22 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:26:22 lxlu1213 kernel:
Mar  2 10:26:22 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:26:44 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:26:44 lxlu1213 kernel:  printing eip:
Mar  2 10:26:44 lxlu1213 kernel: c0156cd0
Mar  2 10:26:44 lxlu1213 kernel: *pde = 00000000
Mar  2 10:26:44 lxlu1213 kernel: Oops: 0000
Mar  2 10:26:44 lxlu1213 kernel: CPU:    0
Mar  2 10:26:44 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:26:44 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:26:44 lxlu1213 kernel: eax: 00003296   ebx: cfaaff6c   ecx: 0000329a   edx: 00000001
Mar  2 10:26:44 lxlu1213 kernel: esi: cfaaff64   edi: c29a9c60   ebp: 000f0000   esp: cfaaff14
Mar  2 10:26:44 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:26:44 lxlu1213 kernel: Process ps (pid: 4297, stackpage=cfaaf000)
Mar  2 10:26:44 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 cfaaff64 cfaaff6c c8dc4000 c89c14a0
Mar  2 10:26:44 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 cfaaff6c cfaaff64 c8dc4342 00000000
Mar  2 10:26:44 lxlu1213 kernel:        ffffffff f24e52c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:26:44 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:26:44 lxlu1213 kernel:
Mar  2 10:26:44 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:26:46 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:26:46 lxlu1213 kernel:  printing eip:
Mar  2 10:26:46 lxlu1213 kernel: c0156cd0
Mar  2 10:26:46 lxlu1213 kernel: *pde = 00000000
Mar  2 10:26:46 lxlu1213 kernel: Oops: 0000
Mar  2 10:26:46 lxlu1213 kernel: CPU:    0
Mar  2 10:26:46 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:26:46 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:26:46 lxlu1213 kernel: eax: 00003296   ebx: f4cd1f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:26:46 lxlu1213 kernel: esi: f4cd1f64   edi: c29a9c60   ebp: 000f0000   esp: f4cd1f14
Mar  2 10:26:46 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:26:46 lxlu1213 kernel: Process ps (pid: 4309, stackpage=f4cd1000)
Mar  2 10:26:46 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f4cd1f64 f4cd1f6c c8dc4000 c89c14a0
Mar  2 10:26:46 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f4cd1f6c f4cd1f64 c8dc4342 00000000
Mar  2 10:26:46 lxlu1213 kernel:        ffffffff e81d68e0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:26:46 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:26:46 lxlu1213 kernel:
Mar  2 10:26:46 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:26:52 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:26:52 lxlu1213 kernel:  printing eip:
Mar  2 10:26:52 lxlu1213 kernel: c0156cd0
Mar  2 10:26:52 lxlu1213 kernel: *pde = 00000000
Mar  2 10:26:52 lxlu1213 kernel: Oops: 0000
Mar  2 10:26:52 lxlu1213 kernel: CPU:    1
Mar  2 10:26:52 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:26:52 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:26:52 lxlu1213 kernel: eax: 00003296   ebx: c374ff6c   ecx: 0000329a   edx: 00000001
Mar  2 10:26:52 lxlu1213 kernel: esi: c374ff64   edi: c29a9c60   ebp: 000f0000   esp: c374ff14
Mar  2 10:26:52 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:26:52 lxlu1213 kernel: Process ps (pid: 4313, stackpage=c374f000)
Mar  2 10:26:52 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c374ff64 c374ff6c c8dc4000 c89c14a0
Mar  2 10:26:52 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c374ff6c c374ff64 c8dc4342 00000000
Mar  2 10:26:52 lxlu1213 kernel:        ffffffff e81d6560 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:26:52 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:26:52 lxlu1213 kernel:
Mar  2 10:26:52 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:27:01 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:27:01 lxlu1213 kernel:  printing eip:
Mar  2 10:27:01 lxlu1213 kernel: c0156cd0
Mar  2 10:27:01 lxlu1213 kernel: *pde = 00000000
Mar  2 10:27:01 lxlu1213 kernel: Oops: 0000
Mar  2 10:27:01 lxlu1213 kernel: CPU:    1
Mar  2 10:27:01 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:27:01 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:27:01 lxlu1213 kernel: eax: 00003296   ebx: d7b75f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:27:01 lxlu1213 kernel: esi: d7b75f64   edi: c29a9c60   ebp: 000f0000   esp: d7b75f14
Mar  2 10:27:01 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:27:01 lxlu1213 kernel: Process ps (pid: 4315, stackpage=d7b75000)
Mar  2 10:27:01 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 d7b75f64 d7b75f6c c8dc4000 c89c14a0
Mar  2 10:27:01 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 d7b75f6c d7b75f64 c8dc4342 00000000
Mar  2 10:27:01 lxlu1213 kernel:        ffffffff f4c971c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:27:01 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:27:01 lxlu1213 kernel:
Mar  2 10:27:01 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:27:04 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:27:04 lxlu1213 kernel:  printing eip:
Mar  2 10:27:04 lxlu1213 kernel: c0156cd0
Mar  2 10:27:04 lxlu1213 kernel: *pde = 00000000
Mar  2 10:27:04 lxlu1213 kernel: Oops: 0000
Mar  2 10:27:04 lxlu1213 kernel: CPU:    1
Mar  2 10:27:04 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:27:04 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:27:04 lxlu1213 kernel: eax: 00003296   ebx: d7b75f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:27:04 lxlu1213 kernel: esi: d7b75f64   edi: c29a9c60   ebp: 000f0000   esp: d7b75f14
Mar  2 10:27:04 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:27:04 lxlu1213 kernel: Process ps (pid: 4334, stackpage=d7b75000)
Mar  2 10:27:04 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 d7b75f64 d7b75f6c c8dc4000 c89c14a0
Mar  2 10:27:04 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 d7b75f6c d7b75f64 c8dc4342 00000000
Mar  2 10:27:04 lxlu1213 kernel:        ffffffff e84299a0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:27:04 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:27:04 lxlu1213 kernel:
Mar  2 10:27:04 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:27:07 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:27:07 lxlu1213 kernel:  printing eip:
Mar  2 10:27:07 lxlu1213 kernel: c0156cd0
Mar  2 10:27:07 lxlu1213 kernel: *pde = 00000000
Mar  2 10:27:07 lxlu1213 kernel: Oops: 0000
Mar  2 10:27:07 lxlu1213 kernel: CPU:    1
Mar  2 10:27:07 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:27:07 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:27:07 lxlu1213 kernel: eax: 00003296   ebx: c632df6c   ecx: 0000329a   edx: 00000001
Mar  2 10:27:07 lxlu1213 kernel: esi: c632df64   edi: c29a9c60   ebp: 000f0000   esp: c632df14
Mar  2 10:27:07 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:27:07 lxlu1213 kernel: Process ps (pid: 4338, stackpage=c632d000)
Mar  2 10:27:07 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c632df64 c632df6c c8dc4000 c89c14a0
Mar  2 10:27:07 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c632df6c c632df64 c8dc4342 00000000
Mar  2 10:27:07 lxlu1213 kernel:        ffffffff f4c97640 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:27:07 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:27:07 lxlu1213 kernel:
Mar  2 10:27:07 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:27:12 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:27:12 lxlu1213 kernel:  printing eip:
Mar  2 10:27:12 lxlu1213 kernel: c0156cd0
Mar  2 10:27:12 lxlu1213 kernel: *pde = 00000000
Mar  2 10:27:12 lxlu1213 kernel: Oops: 0000
Mar  2 10:27:12 lxlu1213 kernel: CPU:    0
Mar  2 10:27:12 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:27:12 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:27:12 lxlu1213 kernel: eax: 00003296   ebx: c632df6c   ecx: 0000329a   edx: 00000001
Mar  2 10:27:12 lxlu1213 kernel: esi: c632df64   edi: c29a9c60   ebp: 000f0000   esp: c632df14
Mar  2 10:27:12 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:27:12 lxlu1213 kernel: Process ps (pid: 4341, stackpage=c632d000)
Mar  2 10:27:12 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c632df64 c632df6c c8dc4000 c89c14a0
Mar  2 10:27:12 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c632df6c c632df64 c8dc4342 00000000
Mar  2 10:27:12 lxlu1213 kernel:        ffffffff c9a41660 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:27:12 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:27:12 lxlu1213 kernel:
Mar  2 10:27:12 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:27:17 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:27:17 lxlu1213 kernel:  printing eip:
Mar  2 10:27:17 lxlu1213 kernel: c0156cd0
Mar  2 10:27:17 lxlu1213 kernel: *pde = 00000000
Mar  2 10:27:17 lxlu1213 kernel: Oops: 0000
Mar  2 10:27:17 lxlu1213 kernel: CPU:    0
Mar  2 10:27:17 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:27:17 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:27:17 lxlu1213 kernel: eax: 00003296   ebx: c356ff6c   ecx: 0000329a   edx: 00000001
Mar  2 10:27:17 lxlu1213 kernel: esi: c356ff64   edi: c29a9c60   ebp: 000f0000   esp: c356ff14
Mar  2 10:27:17 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:27:17 lxlu1213 kernel: Process ps (pid: 4353, stackpage=c356f000)
Mar  2 10:27:17 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c356ff64 c356ff6c c8dc4000 c89c14a0
Mar  2 10:27:17 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c356ff6c c356ff64 c8dc4342 00000000
Mar  2 10:27:17 lxlu1213 kernel:        ffffffff f4c97a40 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:27:17 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:27:17 lxlu1213 kernel:
Mar  2 10:27:17 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:21 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:21 lxlu1213 kernel:  printing eip:
Mar  2 10:28:21 lxlu1213 kernel: c0156cd0
Mar  2 10:28:21 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:21 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:21 lxlu1213 kernel: CPU:    1
Mar  2 10:28:21 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:21 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:21 lxlu1213 kernel: eax: 00003296   ebx: c454df6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:21 lxlu1213 kernel: esi: c454df64   edi: c29a9c60   ebp: 000f0000   esp: c454df14
Mar  2 10:28:21 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:21 lxlu1213 kernel: Process ps (pid: 4595, stackpage=c454d000)
Mar  2 10:28:21 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c454df64 c454df6c c8dc4000 c89c14a0
Mar  2 10:28:21 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c454df6c c454df64 c8dc4342 00000000
Mar  2 10:28:21 lxlu1213 kernel:        ffffffff efc430a0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:21 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:21 lxlu1213 kernel:
Mar  2 10:28:21 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:23 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:23 lxlu1213 kernel:  printing eip:
Mar  2 10:28:23 lxlu1213 kernel: c0156cd0
Mar  2 10:28:23 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:23 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:23 lxlu1213 kernel: CPU:    1
Mar  2 10:28:23 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:23 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:23 lxlu1213 kernel: eax: 00003296   ebx: f2deff6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:23 lxlu1213 kernel: esi: f2deff64   edi: c29a9c60   ebp: 000f0000   esp: f2deff14
Mar  2 10:28:23 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:23 lxlu1213 kernel: Process ps (pid: 4598, stackpage=f2def000)
Mar  2 10:28:23 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f2deff64 f2deff6c c8dc4000 c89c14a0
Mar  2 10:28:23 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f2deff6c f2deff64 c8dc4342 00000000
Mar  2 10:28:23 lxlu1213 kernel:        ffffffff f4c97bc0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:23 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:23 lxlu1213 kernel:
Mar  2 10:28:23 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:47 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:47 lxlu1213 kernel:  printing eip:
Mar  2 10:28:47 lxlu1213 kernel: c0156cd0
Mar  2 10:28:47 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:47 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:47 lxlu1213 kernel: CPU:    0
Mar  2 10:28:47 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:47 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:47 lxlu1213 kernel: eax: 00003296   ebx: c9423f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:47 lxlu1213 kernel: esi: c9423f64   edi: c29a9c60   ebp: 000f0000   esp: c9423f14
Mar  2 10:28:47 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:47 lxlu1213 kernel: Process ps (pid: 4671, stackpage=c9423000)
Mar  2 10:28:47 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c9423f64 c9423f6c c8dc4000 c89c14a0
Mar  2 10:28:47 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c9423f6c c9423f64 c8dc4342 00000000
Mar  2 10:28:47 lxlu1213 kernel:        ffffffff e81d6a60 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:47 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:47 lxlu1213 kernel:
Mar  2 10:28:47 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:47 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:47 lxlu1213 kernel:  printing eip:
Mar  2 10:28:47 lxlu1213 kernel: c0156cd0
Mar  2 10:28:47 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:47 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:47 lxlu1213 kernel: CPU:    1
Mar  2 10:28:47 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:47 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:47 lxlu1213 kernel: eax: 00003296   ebx: f27e3f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:47 lxlu1213 kernel: esi: f27e3f64   edi: c29a9c60   ebp: 000f0000   esp: f27e3f14
Mar  2 10:28:47 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:47 lxlu1213 kernel: Process ps (pid: 4746, stackpage=f27e3000)
Mar  2 10:28:47 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f27e3f64 f27e3f6c c8dc4000 c89c14a0
Mar  2 10:28:47 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f27e3f6c f27e3f64 c8dc4342 00000000
Mar  2 10:28:47 lxlu1213 kernel:        ffffffff e998e8c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:47 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:47 lxlu1213 kernel:
Mar  2 10:28:47 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:47 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:47 lxlu1213 kernel:  printing eip:
Mar  2 10:28:47 lxlu1213 kernel: c0156cd0
Mar  2 10:28:47 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:47 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:47 lxlu1213 kernel: CPU:    0
Mar  2 10:28:47 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:47 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:47 lxlu1213 kernel: eax: 00003296   ebx: f2c29f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:47 lxlu1213 kernel: esi: f2c29f64   edi: c29a9c60   ebp: 000f0000   esp: f2c29f14
Mar  2 10:28:47 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:47 lxlu1213 kernel: Process ps (pid: 4783, stackpage=f2c29000)
Mar  2 10:28:47 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f2c29f64 f2c29f6c c8dc4000 c89c14a0
Mar  2 10:28:47 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f2c29f6c f2c29f64 c8dc4342 00000000
Mar  2 10:28:47 lxlu1213 kernel:        ffffffff e8938520 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:47 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:47 lxlu1213 kernel:
Mar  2 10:28:47 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:47 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:47 lxlu1213 kernel:  printing eip:
Mar  2 10:28:47 lxlu1213 kernel: c0156cd0
Mar  2 10:28:47 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:47 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:47 lxlu1213 kernel: CPU:    1
Mar  2 10:28:47 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:47 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:47 lxlu1213 kernel: eax: 00003296   ebx: f27e3f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:47 lxlu1213 kernel: esi: f27e3f64   edi: c29a9c60   ebp: 000f0000   esp: f27e3f14
Mar  2 10:28:47 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:47 lxlu1213 kernel: Process ps (pid: 4809, stackpage=f27e3000)
Mar  2 10:28:47 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f27e3f64 f27e3f6c c8dc4000 c89c14a0
Mar  2 10:28:47 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f27e3f6c f27e3f64 c8dc4342 00000000
Mar  2 10:28:47 lxlu1213 kernel:        ffffffff e998e0c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:47 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:47 lxlu1213 kernel:
Mar  2 10:28:47 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:47 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:47 lxlu1213 kernel:  printing eip:
Mar  2 10:28:47 lxlu1213 kernel: c0156cd0
Mar  2 10:28:47 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:47 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:47 lxlu1213 kernel: CPU:    1
Mar  2 10:28:47 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:47 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:47 lxlu1213 kernel: eax: 00003296   ebx: c7a41f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:47 lxlu1213 kernel: esi: c7a41f64   edi: c29a9c60   ebp: 000f0000   esp: c7a41f14
Mar  2 10:28:47 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:47 lxlu1213 kernel: Process ps (pid: 4884, stackpage=c7a41000)
Mar  2 10:28:47 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c7a41f64 c7a41f6c c8dc4000 c89c14a0
Mar  2 10:28:48 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c7a41f6c c7a41f64 c8dc4342 00000000
Mar  2 10:28:48 lxlu1213 kernel:        ffffffff e97ad2e0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:48 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:48 lxlu1213 kernel:
Mar  2 10:28:48 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:48 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:48 lxlu1213 kernel:  printing eip:
Mar  2 10:28:48 lxlu1213 kernel: c0156cd0
Mar  2 10:28:48 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:48 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:48 lxlu1213 kernel: CPU:    1
Mar  2 10:28:48 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:48 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:48 lxlu1213 kernel: eax: 00003296   ebx: c28c5f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:48 lxlu1213 kernel: esi: c28c5f64   edi: c29a9c60   ebp: 000f0000   esp: c28c5f14
Mar  2 10:28:48 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:48 lxlu1213 kernel: Process ps (pid: 4921, stackpage=c28c5000)
Mar  2 10:28:48 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c28c5f64 c28c5f6c c8dc4000 c89c14a0
Mar  2 10:28:48 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c28c5f6c c28c5f64 c8dc4342 00000000
Mar  2 10:28:48 lxlu1213 kernel:        ffffffff f4c978c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:48 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:48 lxlu1213 kernel:
Mar  2 10:28:48 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:48 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:48 lxlu1213 kernel:  printing eip:
Mar  2 10:28:48 lxlu1213 kernel: c0156cd0
Mar  2 10:28:48 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:48 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:48 lxlu1213 kernel: CPU:    1
Mar  2 10:28:48 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:48 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:48 lxlu1213 kernel: eax: 00003296   ebx: c8d35f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:48 lxlu1213 kernel: esi: c8d35f64   edi: c29a9c60   ebp: 000f0000   esp: c8d35f14
Mar  2 10:28:48 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:48 lxlu1213 kernel: Process ps (pid: 4947, stackpage=c8d35000)
Mar  2 10:28:48 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c8d35f64 c8d35f6c c8dc4000 c89c14a0
Mar  2 10:28:48 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c8d35f6c c8d35f64 c8dc4342 00000000
Mar  2 10:28:48 lxlu1213 kernel:        ffffffff e998e640 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:48 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:48 lxlu1213 kernel:
Mar  2 10:28:48 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:49 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:49 lxlu1213 kernel:  printing eip:
Mar  2 10:28:49 lxlu1213 kernel: c0156cd0
Mar  2 10:28:49 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:49 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:49 lxlu1213 kernel: CPU:    0
Mar  2 10:28:49 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:49 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:49 lxlu1213 kernel: eax: 00003296   ebx: ca0b3f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:49 lxlu1213 kernel: esi: ca0b3f64   edi: c29a9c60   ebp: 000f0000   esp: ca0b3f14
Mar  2 10:28:49 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:49 lxlu1213 kernel: Process ps (pid: 5032, stackpage=ca0b3000)
Mar  2 10:28:49 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 ca0b3f64 ca0b3f6c c8dc4000 c89c14a0
Mar  2 10:28:49 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 ca0b3f6c ca0b3f64 c8dc4342 00000000
Mar  2 10:28:49 lxlu1213 kernel:        ffffffff e998e740 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:49 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:49 lxlu1213 kernel:
Mar  2 10:28:49 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:49 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:49 lxlu1213 kernel:  printing eip:
Mar  2 10:28:49 lxlu1213 kernel: c0156cd0
Mar  2 10:28:49 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:49 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:49 lxlu1213 kernel: CPU:    1
Mar  2 10:28:49 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:49 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:49 lxlu1213 kernel: eax: 00003296   ebx: c7225f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:49 lxlu1213 kernel: esi: c7225f64   edi: c29a9c60   ebp: 000f0000   esp: c7225f14
Mar  2 10:28:49 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:49 lxlu1213 kernel: Process ps (pid: 5069, stackpage=c7225000)
Mar  2 10:28:49 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c7225f64 c7225f6c c8dc4000 c89c14a0
Mar  2 10:28:49 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c7225f6c c7225f64 c8dc4342 00000000
Mar  2 10:28:49 lxlu1213 kernel:        ffffffff f11a95c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:49 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:49 lxlu1213 kernel:
Mar  2 10:28:49 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:49 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:49 lxlu1213 kernel:  printing eip:
Mar  2 10:28:49 lxlu1213 kernel: c0156cd0
Mar  2 10:28:49 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:49 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:49 lxlu1213 kernel: CPU:    1
Mar  2 10:28:49 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:49 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:49 lxlu1213 kernel: eax: 00003296   ebx: f0b57f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:49 lxlu1213 kernel: esi: f0b57f64   edi: c29a9c60   ebp: 000f0000   esp: f0b57f14
Mar  2 10:28:49 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:49 lxlu1213 kernel: Process ps (pid: 5095, stackpage=f0b57000)
Mar  2 10:28:49 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 f0b57f64 f0b57f6c c8dc4000 c89c14a0
Mar  2 10:28:49 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 f0b57f6c f0b57f64 c8dc4342 00000000
Mar  2 10:28:49 lxlu1213 kernel:        ffffffff e71b0b60 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:49 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:49 lxlu1213 kernel:
Mar  2 10:28:49 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:49 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:49 lxlu1213 kernel:  printing eip:
Mar  2 10:28:49 lxlu1213 kernel: c0156cd0
Mar  2 10:28:49 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:49 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:49 lxlu1213 kernel: CPU:    1
Mar  2 10:28:49 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:49 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:49 lxlu1213 kernel: eax: 00003296   ebx: c9337f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:49 lxlu1213 kernel: esi: c9337f64   edi: c29a9c60   ebp: 000f0000   esp: c9337f14
Mar  2 10:28:49 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:49 lxlu1213 kernel: Process ps (pid: 5170, stackpage=c9337000)
Mar  2 10:28:49 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c9337f64 c9337f6c c8dc4000 c89c14a0
Mar  2 10:28:49 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c9337f6c c9337f64 c8dc4342 00000000
Mar  2 10:28:49 lxlu1213 kernel:        ffffffff e3658f20 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:49 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:49 lxlu1213 kernel:
Mar  2 10:28:49 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:50 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:50 lxlu1213 kernel:  printing eip:
Mar  2 10:28:50 lxlu1213 kernel: c0156cd0
Mar  2 10:28:50 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:50 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:50 lxlu1213 kernel: CPU:    0
Mar  2 10:28:50 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:50 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:50 lxlu1213 kernel: eax: 00003296   ebx: ca0b3f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:50 lxlu1213 kernel: esi: ca0b3f64   edi: c29a9c60   ebp: 000f0000   esp: ca0b3f14
Mar  2 10:28:50 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:50 lxlu1213 kernel: Process ps (pid: 5207, stackpage=ca0b3000)
Mar  2 10:28:50 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 ca0b3f64 ca0b3f6c c8dc4000 c89c14a0
Mar  2 10:28:50 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 ca0b3f6c ca0b3f64 c8dc4342 00000000
Mar  2 10:28:50 lxlu1213 kernel:        ffffffff e71b09e0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:50 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:50 lxlu1213 kernel:
Mar  2 10:28:50 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:50 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:50 lxlu1213 kernel:  printing eip:
Mar  2 10:28:50 lxlu1213 kernel: c0156cd0
Mar  2 10:28:50 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:50 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:50 lxlu1213 kernel: CPU:    0
Mar  2 10:28:50 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:50 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:50 lxlu1213 kernel: eax: 00003296   ebx: c9337f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:50 lxlu1213 kernel: esi: c9337f64   edi: c29a9c60   ebp: 000f0000   esp: c9337f14
Mar  2 10:28:50 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:50 lxlu1213 kernel: Process ps (pid: 5233, stackpage=c9337000)
Mar  2 10:28:50 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c9337f64 c9337f6c c8dc4000 c89c14a0
Mar  2 10:28:50 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c9337f6c c9337f64 c8dc4342 00000000
Mar  2 10:28:50 lxlu1213 kernel:        ffffffff e7f775c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:50 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:50 lxlu1213 kernel:
Mar  2 10:28:50 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:50 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:50 lxlu1213 kernel:  printing eip:
Mar  2 10:28:50 lxlu1213 kernel: c0156cd0
Mar  2 10:28:50 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:50 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:50 lxlu1213 kernel: CPU:    1
Mar  2 10:28:50 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:50 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:50 lxlu1213 kernel: eax: 00003296   ebx: ca0b3f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:50 lxlu1213 kernel: esi: ca0b3f64   edi: c29a9c60   ebp: 000f0000   esp: ca0b3f14
Mar  2 10:28:50 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:50 lxlu1213 kernel: Process ps (pid: 5308, stackpage=ca0b3000)
Mar  2 10:28:50 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 ca0b3f64 ca0b3f6c c8dc4000 c89c14a0
Mar  2 10:28:50 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 ca0b3f6c ca0b3f64 c8dc4342 00000000
Mar  2 10:28:50 lxlu1213 kernel:        ffffffff db9fb9e0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:50 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:50 lxlu1213 kernel:
Mar  2 10:28:50 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:28:50 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:28:50 lxlu1213 kernel:  printing eip:
Mar  2 10:28:50 lxlu1213 kernel: c0156cd0
Mar  2 10:28:50 lxlu1213 kernel: *pde = 00000000
Mar  2 10:28:50 lxlu1213 kernel: Oops: 0000
Mar  2 10:28:50 lxlu1213 kernel: CPU:    1
Mar  2 10:28:50 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:28:50 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:28:50 lxlu1213 kernel: eax: 00003296   ebx: c95f3f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:28:50 lxlu1213 kernel: esi: c95f3f64   edi: c29a9c60   ebp: 000f0000   esp: c95f3f14
Mar  2 10:28:50 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:28:50 lxlu1213 kernel: Process ps (pid: 5345, stackpage=c95f3000)
Mar  2 10:28:50 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c95f3f64 c95f3f6c c8dc4000 c89c14a0
Mar  2 10:28:50 lxlu1213 kernel:        c8dc4000 000001ff 000001ff 00000053 c95f3f6c c95f3f64 c8dc4342 00000000
Mar  2 10:28:50 lxlu1213 kernel:        ffffffff e71b05e0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:28:50 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:28:50 lxlu1213 kernel:
Mar  2 10:28:50 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:32:02 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:32:02 lxlu1213 kernel:  printing eip:
Mar  2 10:32:02 lxlu1213 kernel: c0156cd0
Mar  2 10:32:02 lxlu1213 kernel: *pde = 00000000
Mar  2 10:32:02 lxlu1213 kernel: Oops: 0000
Mar  2 10:32:02 lxlu1213 kernel: CPU:    1
Mar  2 10:32:02 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:32:02 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:32:02 lxlu1213 kernel: eax: 00003296   ebx: c9a51f6c   ecx: 0000329a   edx: 00000001
Mar  2 10:32:02 lxlu1213 kernel: esi: c9a51f64   edi: c29a9c60   ebp: 000f0000   esp: c9a51f14
Mar  2 10:32:02 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:32:02 lxlu1213 kernel: Process pidof (pid: 5692, stackpage=c9a51000)
Mar  2 10:32:02 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c9a51f64 c9a51f6c c8dc4000 c89c14a0
Mar  2 10:32:02 lxlu1213 kernel:        c8dc4000 00000c00 00001000 00000053 c9a51f6c c9a51f64 c8dc4342 00000000
Mar  2 10:32:02 lxlu1213 kernel:        ffffffff c98e50c0 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:32:02 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:32:02 lxlu1213 kernel:
Mar  2 10:32:02 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06
Mar  2 10:32:17 lxlu1213 kernel:  <1>Unable to handle kernel paging request at virtual address 0000329a
Mar  2 10:32:17 lxlu1213 kernel:  printing eip:
Mar  2 10:32:17 lxlu1213 kernel: c0156cd0
Mar  2 10:32:17 lxlu1213 kernel: *pde = 00000000
Mar  2 10:32:17 lxlu1213 kernel: Oops: 0000
Mar  2 10:32:17 lxlu1213 kernel: CPU:    0
Mar  2 10:32:17 lxlu1213 kernel: EIP:    0010:[collect_sigign_sigcatch+64/104]    Tainted: PF
Mar  2 10:32:17 lxlu1213 kernel: EFLAGS: 00010206
Mar  2 10:32:17 lxlu1213 kernel: eax: 00003296   ebx: c96cbf6c   ecx: 0000329a   edx: 00000001
Mar  2 10:32:17 lxlu1213 kernel: esi: c96cbf64   edi: c29a9c60   ebp: 000f0000   esp: c96cbf14
Mar  2 10:32:17 lxlu1213 kernel: ds: 0018   es: 0018   ss: 0018
Mar  2 10:32:17 lxlu1213 kernel: Process pidof (pid: 5915, stackpage=c96cb000)
Mar  2 10:32:17 lxlu1213 kernel: Stack: c018bc4a c8dc4000 c015723b c8dc4000 c96cbf64 c96cbf6c c8dc4000 c89c14a0
Mar  2 10:32:17 lxlu1213 kernel:        c8dc4000 00000c00 00001000 00000053 c96cbf6c c96cbf64 c8dc4342 00000000
Mar  2 10:32:17 lxlu1213 kernel:        ffffffff c98e5e80 bffff4b4 08078fef 00000000 00000000 00000000 00000000
Mar  2 10:32:17 lxlu1213 kernel: Call Trace: [sys_msgrcv+718/908] [proc_pid_stat+335/716] [proc_info_read+86/276] [sys_read+146/200]
[system_call+51/64]
Mar  2 10:32:17 lxlu1213 kernel:
Mar  2 10:32:17 lxlu1213 kernel: Code: 8b 01 83 f8 01 75 09 8d 42 ff 0f ab 06 eb 0b 90 85 c0 74 06


