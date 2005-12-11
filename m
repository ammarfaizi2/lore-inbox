Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVLKTnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVLKTnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVLKTnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:43:43 -0500
Received: from hulk.vianw.pt ([195.22.31.43]:38547 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S1750835AbVLKTnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:43:21 -0500
Message-ID: <439C8140.1000108@esoterica.pt>
Date: Sun, 11 Dec 2005 19:42:56 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: STILL Cannot run linux 2.6.14.3 UML on a x86_64
References: <43924B2C.9000300@esoterica.pt> <20051204043205.GA15425@ccure.user-mode-linux.org> <43926CC8.2030902@esoterica.pt> <20051204162732.GA3692@ccure.user-mode-linux.org> <43978E04.7030000@esoterica.pt> <20051210043122.GC14269@ccure.user-mode-linux.org>
In-Reply-To: <20051210043122.GC14269@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

> ...


>You never answered my question about whether this was a 32 or 64 bit
>filesystem.
>
>  
>
This became a great confusion! I noticed that when
UML crashes, restarting a "previous working copy"
does not work either until a reboot is done (may be
something else could be done ...).

So I decided to start from the scratch ...
I created a disk image with ext2 and a 64 bits gentoo
system (this answers to your question).
Recompiled the kernel (a new copy). Everything
on a 64 bits system. I tried skas and non skas mode.
I'm sending both outputs.
TT mode just crashes.
SKAS mode starts looping somewhere consuming CPU.

The same procedure for 32 bits worked fine for TT mode
only. SKAS mode does not work.

Thank you.


Checking PROT_EXEC mmap in /tmp...OK
UML running in TT mode
tracing thread pid = 19319
[42949372.960000] Checking that ptrace can change system call numbers...OK
[42949372.960000] Checking syscall emulation patch for ptrace...missing
[42949372.960000] Linux version 2.6.14.3 (psergio@Gandalf) (gcc version 
3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 Sun Dec 11 
18:56:37 WET 2005
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: ubd0=/VMs/UML/UML1 mem=250M 
eth0=tuntap,,,192.168.1.100 root=98:0
[42949372.960000] PID hash table entries: 1024 (order: 10, 32768 bytes)
[42949372.960000] Dentry cache hash table entries: 32768 (order: 6, 
262144 bytes)
[42949372.960000] Inode-cache hash table entries: 16384 (order: 5, 
131072 bytes)
[42949372.960000] Memory: 243712k available
[42949373.180000] Mount-cache hash table entries: 256
[42949373.180000] Checking that host ptys support output SIGIO...Yes
[42949373.180000] Checking that host ptys support SIGIO on close...No, 
enabling workaround
[42949373.180000] Checking for /dev/anon on the host...Not available 
(open failed with errno 2)
[42949373.180000] softlockup thread 0 started up.
[42949373.180000] Disabling 2.6 AIO in tt mode
[42949373.180000] 2.6 host AIO support not used - falling back to I/O thread
[42949373.180000] NET: Registered protocol family 16
[42949373.180000] mconsole (version 2) initialized on 
/home/psergio/.uml/Pulga/mconsole
[42949373.180000] Netdevice 0 : TUN/TAP backend - IP = 192.168.1.100
[42949373.180000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[42949373.180000] Initializing Cryptographic API
[42949373.340000] io scheduler noop registered
[42949373.340000] io scheduler anticipatory registered
[42949373.340000] RAMDISK driver initialized: 16 RAM disks of 4096K size 
1024 blocksize
[42949373.340000] loop: loaded (max 8 devices)
[42949373.340000] NET: Registered protocol family 2
[42949373.550000] IP route cache hash table entries: 2048 (order: 2, 
16384 bytes)
[42949373.550000] TCP established hash table entries: 8192 (order: 4, 
65536 bytes)
[42949373.550000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[42949373.550000] TCP: Hash tables configured (established 8192 bind 8192)
[42949373.550000] TCP reno registered
[42949373.550000] TCP bic registered
[42949373.550000] NET: Registered protocol family 1
[42949373.550000] NET: Registered protocol family 17
[42949373.550000] NET: Registered protocol family 15
[42949373.550000] Initialized stdio console driver
[42949373.550000] Console initialized on /dev/tty0
[42949373.550000] Initializing software serial port version 1
[42949373.550000]  ubda: unknown partition table
[42949373.600000] VFS: Mounted root (ext2 filesystem) readonly.
[42949373.650000] Kernel panic - not syncing: Kernel mode fault at addr 
0x0, ip 0x0
[42949373.650000]
[42949373.650000] Modules linked in:
[42949373.650000] Pid: 1, comm: init Not tainted 2.6.14.3
[42949373.650000] RIP: 0000:[<0000000000000000>]
[42949373.650000] RSP: 0000000061383c30  EFLAGS: 00010202
[42949373.650000] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 
00000000601b3c25
[42949373.650000] RDX: 0000000060027e1d RSI: 0000000000000001 RDI: 
0000000061383ad0
[42949373.650000] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[42949373.650000] R10: 0000000000000008 R11: 0000000000000246 R12: 
0000000000000000
[42949373.650000] R13: 0000000000000001 R14: 000000000000000a R15: 
00000000602b1988
[42949373.650000] Call Trace:
[42949373.650000] 613836d8:  [<6001850f>] panic_exit+0x2f/0x50
[42949373.650000] 613836f8:  [<6003e3cb>] notifier_call_chain+0x2b/0x50
[42949373.650000] 61383728:  [<6002d794>] panic+0xe4/0x180
[42949373.650000] 61383768:  [<601b3c25>] sigprocmask+0x11/0x3c
[42949373.650000] 61383798:  [<60017670>] handle_page_fault+0x1d0/0x2b0
[42949373.650000] 61383818:  [<60017944>] segv+0x1f4/0x2f0
[42949373.650000] 61383828:  [<601b3d6d>] sigemptyset+0x15/0x34
[42949373.650000] 61383838:  [<60015611>] change_sig+0x61/0x80
[42949373.650000] 613838a8:  [<601b3d6d>] sigemptyset+0x15/0x34
[42949373.650000] 613838b8:  [<60015681>] change_signals+0x51/0x80
[42949373.650000] 61383928:  [<60017cfe>] segv_handler+0x9e/0xb0
[42949373.650000] 61383968:  [<6001b259>] sig_handler_common_tt+0x109/0x1b0
[42949373.650000] 613839d8:  [<60027e50>] sig_handler+0x10/0x20
[42949373.650000] 613839e8:  [<601b3af0>] __restore_rt+0x0/0x9
[42949373.650000] 61383a78:  [<60027e1d>] run_kernel_thread+0x2d/0x50
[42949373.650000] 61383a88:  [<601b3c25>] sigprocmask+0x11/0x3c
[42949373.650000] 61383ae0:  [<600101b0>] init+0x0/0x160
[42949373.650000] 61383b08:  [<60027e1d>] run_kernel_thread+0x2d/0x50
[42949373.650000] 61383b88:  [<600101b0>] init+0x0/0x160
[42949373.650000] 61383b98:  [<600156ce>] unblock_signals+0xe/0x10
[42949373.650000] 61383ba8:  [<60019706>] new_thread_handler+0x166/0x1a0
[42949373.650000] 61383cd8:  [<601b3c25>] sigprocmask+0x11/0x3c
[42949373.650000]
[42949373.650000]
___________________________________________________________________________________

Checking PROT_EXEC mmap in /tmp...OK
Checking for /proc/mm...not found
Checking for the skas3 patch in the host...not found
UML running in SKAS0 mode
[42949372.960000] Checking that ptrace can change system call numbers...OK
[42949372.960000] Checking syscall emulation patch for ptrace...missing
[42949372.960000] Linux version 2.6.14.3 (psergio@Gandalf) (gcc version 
3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 Sun Dec 11 
19:16:39 WET 2005
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: ubd0=/VMs/UML/UML1 mem=250M 
eth0=tuntap,,,192.168.1.100 root=98:0
[42949372.960000] PID hash table entries: 1024 (order: 10, 32768 bytes)
[42949372.960000] Dentry cache hash table entries: 32768 (order: 6, 
262144 bytes)
[42949372.960000] Inode-cache hash table entries: 16384 (order: 5, 
131072 bytes)
[42949372.960000] Memory: 243712k available
[42949373.190000] Mount-cache hash table entries: 256
[42949373.190000] Checking that host ptys support output SIGIO...Yes
[42949373.190000] Checking that host ptys support SIGIO on close...No, 
enabling workaround
[42949373.190000] Checking for /dev/anon on the host...Not available 
(open failed with errno 2)
[42949373.190000] softlockup thread 0 started up.
[42949373.190000] Using 2.6 host AIO
[42949373.190000] NET: Registered protocol family 16
[42949373.190000] mconsole (version 2) initialized on 
/home/psergio/.uml/Pulga/mconsole
[42949373.190000] Netdevice 0 : TUN/TAP backend - IP = 192.168.1.100
[42949373.190000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[42949373.190000] Initializing Cryptographic API
[42949373.210000] io scheduler noop registered
[42949373.210000] io scheduler anticipatory registered
[42949373.210000] RAMDISK driver initialized: 16 RAM disks of 4096K size 
1024 blocksize
[42949373.210000] loop: loaded (max 8 devices)
[42949373.210000] NET: Registered protocol family 2
[42949373.360000] IP route cache hash table entries: 2048 (order: 2, 
16384 bytes)
[42949373.360000] TCP established hash table entries: 8192 (order: 4, 
65536 bytes)
[42949373.360000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[42949373.360000] TCP: Hash tables configured (established 8192 bind 8192)
[42949373.360000] TCP reno registered
[42949373.360000] TCP bic registered
[42949373.360000] NET: Registered protocol family 1
[42949373.360000] NET: Registered protocol family 17
[42949373.360000] NET: Registered protocol family 15
[42949373.360000] Initialized stdio console driver
[42949373.360000] Console initialized on /dev/tty0
[42949373.360000] Initializing software serial port version 1
[42949373.360000]  ubda: unknown partition table
[42949373.360000] VFS: Mounted root (ext2 filesystem) readonly.

---------- HANGS HERE CONSUMING CPU!

