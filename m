Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286361AbRLTUWN>; Thu, 20 Dec 2001 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286359AbRLTUWE>; Thu, 20 Dec 2001 15:22:04 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:11533 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S286364AbRLTUVz>; Thu, 20 Dec 2001 15:21:55 -0500
Date: Thu, 20 Dec 2001 20:15:26 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [Sparc] Oops in 2.4.17-rc2
Message-ID: <Pine.LNX.4.33.0112202014130.31060-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just had my SS4 gateway blow up in my face with an OOPS. I had to
write down the Oops on paper so I think the resulting ksymoops may be a
bit wonky, but hope this will be of use to someone.

ksymoops 2.4.3 on sparc 2.4.17-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address fa000000
tsk->{mm,active_mm}->context = 000000d7
tsk->{mm,active_mm}->pgd = fc00dc00
swapper(0): Oops
PSR: 048010c5 PC: fe34ac5c NPC: fe34ac40 Y: 00000000    Tainted: P
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: f8ebc400 g1: 00000010 g2: 00000000 g3: 00000000 g4: ff91fa05 g5: 00000000 g6: f000e000 g7: 00000010
o0: 00000000 o1: 384f7b4b o2: f9fffff0 o3: f847e828 o4: 00000018 o5: f013e3e8 sp: f000f820 o7: fe34abac
l0: f6a64670 l1: f6a6465c l2: f531f7e0 l3: 00000000 l4: f6a64654 l5: 00000000 l6: f000e000 l7: f01b4000
i0: 00000000 i1: f847e814 i2: 00000007 i3: f531f7e0 i4: f847e812 i5: f010517c fp: f000f890 i7: fe34f830
Caller[fe34f830]
Caller[fe34f5a8]
Caller[fe34f330]
Caller[fe3545d8]
Caller[fe353404]
Caller[f00a1aa4]
Caller[f002bfec]
Caller[f002f3f8]
Caller[f002bf04]
Caller[f002bd6c]
Caller[f002b8ac]
Caller[f0012cf0]
Caller[f0010584]
Caller[f003549c]
Caller[f0013f18]
Caller[f001002c]
Caller[f018b0c0]
Caller[f018a790]
Caller[00000000]
Instruction DUMP: 22800004  852a6010  10bffffa <c602a010> 84824002  9330a010  92424000  92380009  d237bff2

>>PC;  fe34ac5c <.bss.end+228a/????>   <=====
>>O7;  fe34abac <.bss.end+21da/????>
>>I7;  fe34f830 <.bss.end+6e5e/????>
Trace; fe34f830 <.bss.end+6e5e/????>
Trace; fe34f5a8 <.bss.end+6bd6/????>
Trace; fe34f330 <.bss.end+695e/????>
Trace; fe3545d8 <END_OF_CODE+bc06/????>
Trace; fe353404 <END_OF_CODE+aa32/????>
Trace; f00a1aa4 <flush_to_ldisc+148/158>
Trace; f002bfec <__run_task_queue+8c/a4>
Trace; f002f3f8 <tqueue_bh+1c/2c>
Trace; f002bf04 <bh_action+6c/7c>
Trace; f002bd6c <tasklet_hi_action+c8/14c>
Trace; f002b8ac <do_softirq+a4/14c>
Trace; f0012cf0 <handler_irq+c4/d4>
Trace; f0010584 <patch_handler_irq+0/24>
Trace; f003549c <check_pgt_cache+10/20>
Trace; f0013f18 <cpu_idle+ec/104>
Trace; f001002c <rest_init+24/34>
Trace; f018b0c0 <start_kernel+15c/16c>
Trace; f018a790 <sun4c_continue_boot+314/324>
Trace; 00000000 Before first symbol
Code;  fe34ac50 <.bss.end+227e/????>
0000000000000000 <_PC>:
Code;  fe34ac50 <.bss.end+227e/????>
   0:   22 80 00 04       be,a   10 <_PC+0x10> fe34ac60 <.bss.end+228e/????>
Code;  fe34ac54 <.bss.end+2282/????>
   4:   85 2a 60 10       sll  %o1, 0x10, %g2
Code;  fe34ac58 <.bss.end+2286/????>
   8:   10 bf ff fa       b  fffffffffffffff0 <_PC+0xfffffffffffffff0> fe34ac40 <.bss.end+226e/????>
Code;  fe34ac5c <.bss.end+228a/????>   <=====
   c:   c6 02 a0 10       ld  [ %o2 + 0x10 ], %g3   <=====
Code;  fe34ac60 <.bss.end+228e/????>
  10:   84 82 40 02       addcc  %o1, %g2, %g2
Code;  fe34ac64 <.bss.end+2292/????>
  14:   93 30 a0 10       srl  %g2, 0x10, %o1
Code;  fe34ac68 <.bss.end+2296/????>
  18:   92 42 40 00       addx  %o1, %g0, %o1
Code;  fe34ac6c <.bss.end+229a/????>
  1c:   92 38 00 09       xnor  %g0, %o1, %o1
Code;  fe34ac70 <.bss.end+229e/????>
  20:   d2 37 bf f2       sth  %o1, [ %fp + -14 ]

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

-- 
A big red heart, that's me!

http://www.tahallah.demon.co.uk (updated)

