Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSK1Mow>; Thu, 28 Nov 2002 07:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSK1Mow>; Thu, 28 Nov 2002 07:44:52 -0500
Received: from services.cam.org ([198.73.180.252]:65014 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S265085AbSK1Mov>;
	Thu, 28 Nov 2002 07:44:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: oops while booting in 2.5.50
Date: Thu, 28 Nov 2002 07:52:05 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211280752.05981.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following oops when booting 2.5.50.  The fbdev fix for 2.5.49
from Antonino Daplas does not apply and gets 10 out of 10 rejects.

Ideas?
Ed Tomlinson

WARNING: Error inserting /lib/modules/2.5.50/kerLinux agpgart interface v0.99 (c) Jeff Hartmann
nel/ppp_generic.agpgart: Maximum main memory to use for agp memory: 439M
o: File exists
agpgart: Detected Via MVP3 chipset
+ modprobe agpgaagpgart: AGP aperture is 64M @ 0xe0000000
rt
+ modprobe mga
[drm] AGP 0.99 on VIA MVP3 @ 0xe0000000 64MB
[drm] Initialized mga 3.1.0 20021029 on minor 0
+ modprobe matroxfb_base
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xE8000000, mapped to 0xe0b73000, size 33554432
Module matroxfb_base cannot be unloaded due to unsafe usage in drivers/video/fbmem.c:759
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc01eb440, data=0x0
Call Trace:
 [<c011e7e7>] check_timer_failed+0x47/0x60
 [<c01eb440>] cursor_timer_handler+0x0/0x40
 [<c01eb440>] cursor_timer_handler+0x0/0x40
 [<c011e83c>] add_timer+0x3c/0xa0
 [<c01eb7e3>] fbcon_startup+0x43/0x60
 [<c01cc8a9>] take_over_console+0x29/0x1a0
 [<c01188e0>] printk+0x100/0x160
 [<e0b32a00>] <1>Unable to handle kernel paging request at virtual address e0b2e62c
 printing eip:
c0128ac1
*pde = 1fd55067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0128ac1>]    Not tainted
EFLAGS: 00010286
EIP is at __print_symbol+0x41/0x100
eax: 00000000   ebx: e0b32a00   ecx: ffffffff   edx: e0b0200c
esi: e0b2e62c   edi: e0b2e62c   ebp: dee93e20   esp: dee93df0
ds: 0068   es: 0068   ss: 0068
Process modprobe (pid: 403, threadinfo=dee92000 task=dfb01280)
Stack: c0118a5f dee93df0 00002380 00000000 e0b0200c c01188e0 c01188e0 00000286 
       c035a33e e0b32a00 00000000 c02daca8 0000003e c01094e7 c0269397 e0b32a00 
       c02daca8 c01095c9 dee93e9c 0000001e c011e7e7 c0266a26 c01eb440 00000000 
Call Trace:
 [<c0118a5f>] release_console_sem+0xbf/0xe0
 [<c01188e0>] printk+0x100/0x160
 [<c01188e0>] printk+0x100/0x160
 [<e0b32a00>] <1>Unable to handle kernel paging request at virtual address e0b2e62c
 printing eip:
c0128ac1
*pde = 1fd55067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0128ac1>]    Not tainted
EFLAGS: 00010086
EIP is at __print_symbol+0x41/0x100
eax: 00000000   ebx: e0b32a00   ecx: ffffffff   edx: e0b0200c
esi: e0b2e62c   edi: e0b2e62c   ebp: dee93ca0   esp: dee93c70
ds: 0068   es: 0068   ss: 0068
Process modprobe (pid: 403, threadinfo=dee92000 task=dfb01280)
Stack: c0118a5f dee93c70 00002380 00000000 e0b0200c c01188e0 c01188e0 00000002 
       00000001 e0b32a00 00000018 00000068 00000001 c01094e7 c0269397 e0b32a00 
       dee93e50 c01095a2 dee93e18 c0269399 dee93df0 dee93dbc c01096c5 dee93df0 
Call Trace:
 [<c0118a5f>] release_console_sem+0xbf/0xe0
 [<c01188e0>] printk+0x100/0x160
 [<c01188e0>] printk+0x100/0x160
 [<e0b32a00>] <1>Unable to handle kernel paging request at virtual address e0b2e62c

