Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285098AbRLQMJY>; Mon, 17 Dec 2001 07:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285118AbRLQMIm>; Mon, 17 Dec 2001 07:08:42 -0500
Received: from mail.elte.hu ([157.181.151.13]:38409 "HELO mail.elte.hu")
	by vger.kernel.org with SMTP id <S285098AbRLQMIc>;
	Mon, 17 Dec 2001 07:08:32 -0500
Date: Mon, 17 Dec 2001 13:08:31 +0100
From: BURJAN Gabor <burjang@elte.hu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.17-rc1 kernel panic at boot
Message-ID: <20011217120831.GA31447@csoma.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Accept-Language: en, hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with booting 2.4.17-rc1 on a RS/6000 (43P-140), when
Vortex support is compiled into the kernel.

01:03.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
        Flags: bus master, medium devsel, latency 32, IRQ 24
        I/O ports at 3f7ffc00 [disabled] [size=64]
        Expansion ROM at feef0000 [disabled] [size=64K]


Oops data:

ksymoops 2.4.3 on ppc 2.4.17-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.4.17-rc1/ (default)
     -m /boot/System.map-2.4.17-rc1.vortex (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Oops: kernel access of bad area, sig: 11
NIP: C0264050 XER: 00000000 LR: C0263F28 SP: C0E05DF0 REGS: c0e05d40 TRAP: 0300d
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0e04000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000800 C0E05DF0 C0E04000 C0368000 00000000 00000000 C03685FC C02A0000
GPR08: 00000368 BF7FFC0E 80000000 70000200 24000024 00000000 00000000 C0E08800
GPR16: C026F594 00000000 3F7FFC00 00000000 003FF000 00000000 00000000 00000000
GPR24: 00000000 C0370400 40000000 00000000 00000018 C0370540 FFFFFFF4 FFFFFFFF
Call backtrace:
C0263F28 C0263C94 C010E230 C010E2C4 C0264998 C02507AC C02507F8
C0003B08 C000659C
Kernel panic: Attempted to kill init!
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c0264050 <vortex_probe1+394/cbc>   <=====
Trace; c0263f28 <vortex_probe1+26c/cbc>
Trace; c0263c94 <vortex_init_one+44/6c>
Trace; c010e230 <pci_announce_device+54/80>
Trace; c010e2c4 <pci_register_driver+68/90>
Trace; c0264998 <vortex_init+20/bc>
Trace; c02507ac <do_initcalls+30/50>
Trace; c02507f8 <do_basic_setup+2c/3c>
Trace; c0003b08 <init+14/1ac>
Trace; c000659c <kernel_thread+2c/38>

1 warning and 1 error issued.  Results may not be reliable.


I tried older kernels (2.4.15, 2.4.16) too, the error remained.

	buga
