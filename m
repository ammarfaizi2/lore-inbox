Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTKCUT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTKCUT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:19:56 -0500
Received: from imo-d04.mx.aol.com ([205.188.157.36]:52173 "EHLO
	imo-d04.mx.aol.com") by vger.kernel.org with ESMTP id S262827AbTKCUTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:19:53 -0500
Date: Mon, 03 Nov 2003 15:19:33 -0500
From: Boylenate316@aol.com
To: linux-kernel@vger.kernel.org
Subject: OOPS: Something about kswapd
MIME-Version: 1.0
Message-ID: <59D81E86.2137402F.11E481F9@aol.com>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 65.34.105.186
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not on the list.
Kernel: 2.4.22, no patches
CPU: AMD Athlon XP
Memory: 512MB
Swap: 1GB
OOPS during ROCK linux compilation, I don't know which package...
It didn't hang, but kswapd is defunct as I type.
ksymoops output:
ksymoops 2.3.7 on i686 2.4.22.  Options used
     -v /usr/src/linux-2.4.22/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /usr/src/linux-2.4.22/System.map (specified)

Warning (compare_maps): mismatch on symbol tulip_max_interrupt_work  , tulip says e0bf4a2c, /lib/modules/2.4.22/kernel/drivers/net/tulip/tulip.o says e0bf422c.  Ignoring /lib/modules/2.4.22/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol tulip_rx_copybreak  , tulip says e0bf4a30, /lib/modules/2.4.22/kernel/drivers/net/tulip/tulip.o says e0bf4230.  Ignoring /lib/modules/2.4.22/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says e0ba40d0, /lib/modules/2.4.22/kernel/drivers/usb/usbcore.o says e0ba3b50.  Ignoring /lib/modules/2.4.22/kernel/drivers/usb/usbcore.o entry
unable to handle kernel NULL pointer dereference at virtual address 0000001c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0138e64>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: c1435d5c   ecx: c1435d78   edx: cfa9a2c0
esi: 000001d0   edi: 00002d82   ebp: c02d9eb0   esp: c1599f44
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1599000)
Stack: 000001d0 c1435d5c c012f948 c1435d5c 000001d0 c1598000 00000200
000001d0
       00000014 00000020 000001d0 00000020 00000006 c012fb30 00000006
0000000a
       c02d9eb0 00000006 000001d0 c02d9eb0 00000000 c012fb90 00000020
c02d9eb0
Call Trace:    [<c012f948>] [<c012fb30>] [<c012fb90>] [<c012fca0>]
[<c012fd06>]
  [<c012fe2d>] [<c0105000>] [<c0105696>] [<c012fd90>]
Code: 8b 40 1c 85 c0 75 0b 89 d8 89 f2 5b 5e e9 1a 1e 00 00 56 53

>>EIP; c0138e64 <try_to_release_page+24/50>   <=====
Trace; c012f948 <shrink_cache+258/300>
Trace; c012fb30 <shrink_caches+50/80>
Trace; c012fb90 <try_to_free_pages_zone+30/50>
Trace; c012fca0 <kswapd_balance_pgdat+50/a0>
Trace; c012fd06 <kswapd_balance+16/30>
Trace; c012fe2d <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105696 <arch_kernel_thread+26/30>
Trace; c012fd90 <kswapd+0/c0>
Code;  c0138e64 <try_to_release_page+24/50>
00000000 <_EIP>:
Code;  c0138e64 <try_to_release_page+24/50>   <=====
   0:   8b 40 1c                  mov    0x1c(%eax),%eax   <=====
Code;  c0138e67 <try_to_release_page+27/50>
   3:   85 c0                     test   %eax,%eax
Code;  c0138e69 <try_to_release_page+29/50>
   5:   75 0b                     jne    12 <_EIP+0x12>
Code;  c0138e6b <try_to_release_page+2b/50>
   7:   89 d8                     mov    %ebx,%eax
Code;  c0138e6d <try_to_release_page+2d/50>
   9:   89 f2                     mov    %esi,%edx
Code;  c0138e6f <try_to_release_page+2f/50>
   b:   5b                        pop    %ebx
Code;  c0138e70 <try_to_release_page+30/50>
   c:   5e                        pop    %esi
Code;  c0138e71 <try_to_release_page+31/50>
   d:   e9 1a 1e 00 00            jmp    1e2c <_EIP+0x1e2c>
Code;  c0138e76 <try_to_release_page+36/50>
  12:   56                        push   %esi
Code;  c0138e77 <try_to_release_page+37/50>
  13:   53                        push   %ebx


3 warnings issued.  Results may not be reliable.
