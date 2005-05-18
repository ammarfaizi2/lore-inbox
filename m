Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVERFQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVERFQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 01:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVERFQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 01:16:45 -0400
Received: from smtp1.pochta.ru ([81.211.64.6]:41021 "EHLO smtp1.pochta.ru")
	by vger.kernel.org with ESMTP id S262094AbVERFQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 01:16:33 -0400
X-Author: graycardinal@pisem.net from dialup9.sibintercom.ru (dialup9.sibintercom.ru [62.76.132.9] (may be forged)) via Free Mail POCHTA.RU
From: Oleg <graycardinal@pisem.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kmem_cache_create: duplicate cache fat_cache
Date: Wed, 18 May 2005 12:17:29 +0400
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505181217.29904.graycardinal@pisem.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] kmem_cache_create: duplicate cache fat_cache
[2.] When I load module vfat, I'm have BUG. vfat is embedded in my kernel.
[3.] modules
[4.] Linux version 2.6.12-rc3-mm3 (root@localhost.localdomain) (gcc version 
3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #18 SMP
[5.] kmem_cache_create: duplicate cache fat_cache
------------[ cut here ]------------
kernel BUG at mm/slab.c:1491!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: fat nls_utf8 nls_cp866 nls_cp855 video hotkey
CPU:    0
EIP:    0060:[<c014a38f>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12-rc3-mm3)
EIP is at kmem_cache_create+0x45f/0x5e0
eax: 00000030   ebx: f7d187b4   ecx: 0000000d   edx: 00000202
esi: c03c91ef   edi: f885ed6e   ebp: f7de1580   esp: f74d1f44
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2487, threadinfo=f74d0000 task=f7eef090)
Stack: c03c6f80 f885ed64 00000004 00020000 f74d1f6c f7de15d8 000000a9 c0000000
       fffffffc 00000004 00000010 f8862540 00000000 0804e130 f74d0000 f8806037
       f885ed64 00000014 00000000 00020000 f8857000 00000000 f88060e5 c013a8f4
Call Trace:
 [<f8806037>] fat_cache_init+0x37/0x80 [fat]
 [<f8857000>] init_once+0x0/0x20 [fat]
 [<f88060e5>] init_fat_fs+0x5/0xc [fat]
 [<c013a8f4>] sys_init_module+0x124/0x1a0
 [<c0103175>] syscall_call+0x7/0xb
Code: 00 04 00 74 ec e9 8a 01 00 00 8b 4c 24 40 c7 04 24 80 6f 3c c0 89 4c 24 
04 e8 4e 44 fd ff f0 ff 05 ac d2 50 c0 0f 8e 73 1a 00 00 <0f> 0b d3 05 95 65 
3c c0 8b 0b e9 65 ff ff ff 8b 47 50 c7 04 24
 ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 21 (level, high) -> 
IRQ 21
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 57069 usecs
intel8x0: clocking to 47503
[6.]
[7.]
[7.1.] Gnu C                  3.3.2
Gnu make               3.79.1
binutils               2.14.90.0.6
util-linux             2.12b
mount                  2.12b
module-init-tools      3.0
e2fsprogs              1.36
jfsutils               1.1.3
reiserfsprogs          2003------------->
reiser4progs           1.0.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
udev                   050
Modules Loaded         snd_intel8x0 snd_ac97_codec fat nls_utf8 nls_cp866 
nls_cp855 video hotkey

[7.2.]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2000+
stepping        : 0
cpu MHz         : 1664.005
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3331.51

[7.3.] snd_intel8x0 29440 - - Live 0xf8864000
snd_ac97_codec 81468 - - Live 0xf887e000
fat 47496 - - Loading 0xf8857000
nls_utf8 2112 - - Live 0xf8827000
nls_cp866 5312 - - Live 0xf8845000
nls_cp855 5056 - - Live 0xf882f000
video 14596 - - Live 0xf8832000
hotkey 7972 - - Live 0xf8829000

[7.4.]
/proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-107f : motherboard
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1020-1027 : GPE0_BLK
1080-10ff : motherboard
  1080-10ff : pnp 00:00
1400-147f : motherboard
  1400-147f : pnp 00:00
1480-14ff : motherboard
  14a0-14af : GPE1_BLK
1800-187f : motherboard
  1800-187f : pnp 00:00
1880-18ff : motherboard
  1880-18ff : pnp 00:00
1c00-1c3f : motherboard
  1c00-1c3f : pnp 00:01
2000-203f : motherboard
  2000-203f : pnp 00:01
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:07.0
    c000-c0ff : 8139too
d400-d4ff : 0000:00:06.0
  d400-d4ff : NVidia nForce2
d800-d87f : 0000:00:06.0
  d800-d87f : NVidia nForce2
e400-e41f : 0000:00:01.1
f000-f00f : 0000:00:09.0
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf3ff : Video ROM
000f0000-000fffff : System ROM
00100000-47feffff : System RAM
  00100000-003af696 : Kernel code
  003af697-004bc2db : Kernel data
47ff0000-47ff2fff : ACPI Non-volatile Storage
47ff3000-47ffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #02
  d0000000-d7ffffff : 0000:02:00.0
d8000000-dbffffff : 0000:00:00.0
dc000000-ddffffff : PCI Bus #02
  dc000000-dcffffff : 0000:02:00.0
de000000-dfffffff : PCI Bus #01
  df000000-df0000ff : 0000:01:07.0
    df000000-df0000ff : 8139too
  df001000-df0013ff : 0000:01:08.0
e0001000-e0001fff : 0000:00:06.0
  e0001000-e0001fff : NVidia nForce2
e0003000-e0003fff : 0000:00:02.0
e0004000-e0004fff : 0000:00:02.1
e0005000-e00050ff : 0000:00:02.2
  e0005000-e00050ff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] required ?
[7.6.] none
[7.7.] module vfat && embedded vfat normal situation, and I'm don't like BUG 
in my dmesg... Sorry, I'm from Russia.


