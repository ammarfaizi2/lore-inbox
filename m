Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbSKQDnG>; Sat, 16 Nov 2002 22:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbSKQDnG>; Sat, 16 Nov 2002 22:43:06 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:56887
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267447AbSKQDnF>; Sat, 16 Nov 2002 22:43:05 -0500
Date: Sat, 16 Nov 2002 22:53:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.5.47 vanilla oops in device_shutdown
In-Reply-To: <Pine.LNX.4.44.0211162247330.1543-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211162250580.1543-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another one, this one for reboot

Unable to handle kernel paging request at virtual address 5a5a5b3a
 printing eip:
c024e7c6
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<c024e7c6>]    Not tainted
EFLAGS: 00010206
EIP is at device_shutdown+0x46/0x8c
eax: 5a5a5a59   ebx: 5a5a5a5a   ecx: c05ec330   edx: 00000000
esi: 01234567   edi: fee1dead   ebp: bffffdb8   esp: c6207e9c
ds: 0068   es: 0068   ss: 0068
Process reboot (pid: 907, threadinfo=c6206000 task=c6201940)
Stack: 00000000 c0133915 c0664e28 00000001 00000000 c013d6ce 00000000 0000000a 
       c1570a80 00000000 ffffffff c1570a80 c6243a64 00000800 c1746060 c0147967 
       c7f9e408 c1746d74 c1491400 c7f9e408 c1746d78 00000296 c0146bde c7f9e408 
Call Trace:
 [<c0133915>] sys_reboot+0xf5/0x220
 [<c013d6ce>] do_no_page+0x1ce/0x3e0
 [<c0147967>] cache_free_debugcheck+0x117/0x190
 [<c0146bde>] kmem_cache_free+0x2e/0x70
 [<c0147967>] cache_free_debugcheck+0x117/0x190
 [<c0146bde>] kmem_cache_free+0x2e/0x70
 [<c0170f6b>] dput+0x1b/0x160
 [<c015b20c>] __fput+0x12c/0x160
 [<c0158c60>] filp_close+0xa0/0xc0
 [<c0158d05>] sys_close+0x85/0xc0
 [<c010b227>] syscall_call+0x7/0xb

Code: 8b 83 e0 00 00 00 48 83 f8 01 77 05 ba 01 00 00 00 85 d2 74 

0xc024e7e6 is in device_shutdown (include/linux/device.h:371).
366
367     extern int (*platform_notify_remove)(struct device * dev);
368
369     static inline int device_present(struct device * dev)
370     {
371             return (dev && (dev->state == DEVICE_INITIALIZED || dev->state == DEVICE_REGISTERED));
372     }
373
374     /* device and bus locking helpers.
375      *

-- 
function.linuxpower.ca

