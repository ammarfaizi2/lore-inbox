Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSEFIRM>; Mon, 6 May 2002 04:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSEFIRL>; Mon, 6 May 2002 04:17:11 -0400
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:43560 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S310190AbSEFIRK>; Mon, 6 May 2002 04:17:10 -0400
Message-Id: <200205060815.AA00092@prism.kumin.ne.jp>
Date: Mon, 06 May 2002 17:15:20 +0900
To: linux-kernel@vger.kernel.org
Subject: 2.5.14  Kernel panic
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I installed linux-2.5.14 that kernel configuration is as same as linux-2.5.13.
compile is OK, but kernel panic occured at boot up.

=== console log ===

biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
parport0: PC-style at 0x3bc [PCSPP(,...)]
vesafb: framebuffer at 0xe0000000, mapped to 0xc6800000, size 8192k
vesafb: mode is 800x600x8, linelength=800, pages=15
vesafb: protected mode interface info at c000:49a0
vesafb: scrolling: redraw
Unable to handle kernel NULL pointer dereference at virtual address 00000040
 printing eip:
c01a6946
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01a6946>]    Not tainted
EFLAGS: 00010202
eax: 00000020   ebx: 00000040   ecx: 00000008   edx: 00000000
esi: c02a18a0   edi: 00000040   ebp: 00000020   esp: c5f97e50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, threadinfo=c5f96000 task=c5f94040)
Stack: c02a1b88 00000000 c02a1a60 00000000 00005656 00000008 00000010 c01ab1a7
       c022984c c02a1b88 00000000 00000010 00000010 00000000 00000010 c0243c64
       c022984c 00000001 00000000 c02a1a60 00007f58 c029d520 c10da160 00000000
Call Trace: [<c01ab1a7>] [<c01a96c4>] [<c01a96df>] [<c01747d4>] [<c0177f57>]
   [<c01a66f1>] [<c0105023>] [<c010553c>]

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 4c 24 24 8b 44 24
 <0>Kernel panic: Attempted to kill init!

== compile error messages ==

floppy.c: In function `floppy_revalidate':
floppy.c:3856: warning: unused variable `bh'
eepro100.c:2252: warning: `eepro100_remove_one' defined but not used
io_apic.c:221: warning: `move' defined but not used
bsetup.s: Assembler messages:
bsetup.s:1023: Warning: value 0x37ffffff truncated to 0x37ffffff
Root device is (3, 4)
Boot sector 512 bytes.
Setup is 4764 bytes.
System is 685 kB
--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
