Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290281AbSAXHEZ>; Thu, 24 Jan 2002 02:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290285AbSAXHEQ>; Thu, 24 Jan 2002 02:04:16 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:59014 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S290281AbSAXHEF>; Thu, 24 Jan 2002 02:04:05 -0500
Date: Thu, 24 Jan 2002 08:02:55 +0100 (CET)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2 oopses in a row
Message-ID: <Pine.LNX.4.33.0201240759590.11616-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My machine came to halt during a chat session. In the syslog 2 oopses.
I hope they are of any help....

ksymoops 2.4.1 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map.2417 (specified)

Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d0862574, /lib/modules/2.4.17/kernel/drivers/usb/usbcore.o says d0862074.  Ignoring /lib/modules/2.4.17/kernel/drivers/usb/usbcore.o entry
Jan 22 00:20:17 schoen3 kernel:  <1>Unable to handle kernel paging request at virtual address 6964656e
Jan 22 00:20:17 schoen3 kernel: c01308f0
Jan 22 00:20:17 schoen3 kernel: *pde = 00000000
Jan 22 00:20:17 schoen3 kernel: Oops: 0000
Jan 22 00:20:17 schoen3 kernel: CPU:    1
Jan 22 00:20:17 schoen3 kernel: EIP:    0010:[<c01308f0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 22 00:20:17 schoen3 kernel: EFLAGS: 00210887
Jan 22 00:20:17 schoen3 kernel: eax: 6964656e   ebx: 00000000   ecx: c1429160   edx: c14050b0
Jan 22 00:20:17 schoen3 kernel: esi: c14050a0   edi: 00000003   ebp: 00000000   esp: c1421f40
Jan 22 00:20:17 schoen3 kernel: ds: 0018   es: 0018   ss: 0018
Jan 22 00:20:17 schoen3 kernel: Process kswapd (pid: 5, stackpage=c1421000)
Jan 22 00:20:17 schoen3 kernel: Stack: 00000020 000001d0 00000020 00000006 00000020 c037ecc8 c14050b0 c14050a8
Jan 22 00:20:17 schoen3 kernel:        c14050b0 c1429160 c1420000 00000000 00000001 00000001 00000001 c1405840
Jan 22 00:20:17 schoen3 kernel:        c0131b44 00000006 000001d0 c02f9908 00000000 c02f9908 c0131bec 00000020
Jan 22 00:20:17 schoen3 kernel: Call Trace: [<c0131b44>] [<c0131bec>] [<c0131c87>] [<c0131ce6>] [<c0131e0d>]
Jan 22 00:20:17 schoen3 kernel:    [<c01055e8>]
Jan 22 00:20:17 schoen3 kernel: Code: 8b 00 47 39 d0 75 f9 89 fa 89 d9 d3 e2 85 ed 74 15 8d 04 95

>>EIP; c01308f0 <kmem_cache_reap+1c8/380>   <=====
Trace; c0131b44 <shrink_caches+1c/88>
Trace; c0131bec <try_to_free_pages+3c/60>
Trace; c0131c87 <kswapd_balance_pgdat+43/8c>
Trace; c0131ce6 <kswapd_balance+16/34>
Trace; c0131e0d <kswapd+a1/c4>
Trace; c01055e8 <kernel_thread+28/38>
Code;  c01308f0 <kmem_cache_reap+1c8/380>
00000000 <_EIP>:
Code;  c01308f0 <kmem_cache_reap+1c8/380>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c01308f2 <kmem_cache_reap+1ca/380>
   2:   47                        inc    %edi
Code;  c01308f3 <kmem_cache_reap+1cb/380>
   3:   39 d0                     cmp    %edx,%eax
Code;  c01308f5 <kmem_cache_reap+1cd/380>
   5:   75 f9                     jne    0 <_EIP>
Code;  c01308f7 <kmem_cache_reap+1cf/380>
   7:   89 fa                     mov    %edi,%edx
Code;  c01308f9 <kmem_cache_reap+1d1/380>
   9:   89 d9                     mov    %ebx,%ecx
Code;  c01308fb <kmem_cache_reap+1d3/380>
   b:   d3 e2                     shl    %cl,%edx
Code;  c01308fd <kmem_cache_reap+1d5/380>
   d:   85 ed                     test   %ebp,%ebp
Code;  c01308ff <kmem_cache_reap+1d7/380>
   f:   74 15                     je     26 <_EIP+0x26> c0130916 <kmem_cache_reap+1ee/380>
Code;  c0130901 <kmem_cache_reap+1d9/380>
  11:   8d 04 95 00 00 00 00      lea    0x0(,%edx,4),%eax


1 warning issued.  Results may not be reliable.

ksymoops 2.4.1 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map.2417 (specified)

Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d0862574, /lib/modules/2.4.17/kernel/drivers/usb/usbcore.o says d0862074.  Ignoring /lib/modules/2.4.17/kernel/drivers/usb/usbcore.o entry
Jan 22 00:19:47 schoen3 kernel: Unable to handle kernel paging request at virtual address 3562726b
Jan 22 00:19:47 schoen3 kernel: c0148760
Jan 22 00:19:47 schoen3 kernel: *pde = 00000000
Jan 22 00:19:47 schoen3 kernel: Oops: 0000
Jan 22 00:19:47 schoen3 kernel: CPU:    1
Jan 22 00:19:47 schoen3 kernel: EIP:    0010:[<c0148760>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 22 00:19:47 schoen3 kernel: EFLAGS: 00010293
Jan 22 00:19:47 schoen3 kernel: eax: 3562726b   ebx: 00000000   ecx: 00000003   edx: c5094ea0
Jan 22 00:19:47 schoen3 kernel: esi: 00000000   edi: 3562726b   ebp: 00000000   esp: cb14ff20
Jan 22 00:19:47 schoen3 kernel: ds: 0018   es: 0018   ss: 0018
Jan 22 00:19:47 schoen3 kernel: Process xmms (pid: 19838, stackpage=cb14f000)
Jan 22 00:19:47 schoen3 kernel: Stack: 00000000 00000000 0822cf18 00000000 c014885a 00000003 3562726b cb14ff58
Jan 22 00:19:47 schoen3 kernel:        cb14ff5c 00000003 00000000 0822cf18 cb14ffbc cb14e000 00000000 00000000
Jan 22 00:19:47 schoen3 kernel:        c0148a8d 00000003 00000000 00000003 c5094ea0 cb14ffb4 00000002 cb14e000
Jan 22 00:19:47 schoen3 kernel: Call Trace: [<c014885a>] [<c0148a8d>] [<c0106f4b>]
Jan 22 00:19:47 schoen3 kernel: Code: 8b 07 31 f6 85 c0 7c 56 e8 b3 0f ff ff 89 c3 be 20 00 00 00

>>EIP; c0148760 <do_pollfd+14/88>   <=====
Trace; c014885a <do_poll+86/dc>
Trace; c0148a8d <sys_poll+1dd/2f0>
Trace; c0106f4b <system_call+33/38>
Code;  c0148760 <do_pollfd+14/88>
00000000 <_EIP>:
Code;  c0148760 <do_pollfd+14/88>   <=====
   0:   8b 07                     mov    (%edi),%eax   <=====
Code;  c0148762 <do_pollfd+16/88>
   2:   31 f6                     xor    %esi,%esi
Code;  c0148764 <do_pollfd+18/88>
   4:   85 c0                     test   %eax,%eax
Code;  c0148766 <do_pollfd+1a/88>
   6:   7c 56                     jl     5e <_EIP+0x5e> c01487be <do_pollfd+72/88>
Code;  c0148768 <do_pollfd+1c/88>
   8:   e8 b3 0f ff ff            call   ffff0fc0 <_EIP+0xffff0fc0> c0139720 <fget+0/5c>
Code;  c014876d <do_pollfd+21/88>
   d:   89 c3                     mov    %eax,%ebx
Code;  c014876f <do_pollfd+23/88>
   f:   be 20 00 00 00            mov    $0x20,%esi


1 warning issued.  Results may not be reliable.



Kernel: 2.4.17, SMP, 256 MB (dual PIII)

Kees



