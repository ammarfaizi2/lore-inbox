Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKMAmg>; Sun, 12 Nov 2000 19:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbQKMAmZ>; Sun, 12 Nov 2000 19:42:25 -0500
Received: from atol.icm.edu.pl ([212.87.0.35]:63238 "EHLO atol.icm.edu.pl")
	by vger.kernel.org with ESMTP id <S129047AbQKMAmS>;
	Sun, 12 Nov 2000 19:42:18 -0500
Date: Mon, 13 Nov 2000 01:42:01 +0100
From: Rafal Maszkowski <rzm@icm.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: test11-pre2 (ksymoops output)
Message-ID: <20001113014201.A28197@burza.icm.edu.pl>
In-Reply-To: <Pine.LNX.4.10.10011091748300.2316-100000@penguin.transmeta.com> <20001110202747.A16806@burza.icm.edu.pl> <20001110150652.F27422@cs.cmu.edu> <20001111020839.A29815@burza.icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.1i
In-Reply-To: <20001111020839.A29815@burza.icm.edu.pl>; from rzm@icm.edu.pl on Sat, Nov 11, 2000 at 02:08:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 02:08:39AM +0100, Rafal Maszkowski wrote:
> > > SPARCstation 10, 1 CPU, Fore 200e SBA, 64 MB RAM
> > > gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> > > Linux etest.icm.edu.pl 2.2.17 #1 Fri Oct 27 03:43:05 MEST 2000 sparc unknown


> I will try to analize tomorrow the crash I am getting without mem limit:
> 
> [...]
> bootmem_init: Scan sp_banks,  15MB HIGHMEM available.
> init_bootmem(spfn[1f5],bpfn[1f5],mlpfn[c000])
> free_bootmem: base[0] size[1000000]
> free_bootmem: base[4000000] size[1000000]
> free_bootmem: base[8000000] size[1000000]
> reserve_bootmem: base[0] size[1f5000]
> reserve_bootmem: base[1f5000] size[1800]
> On node 0 totalpages: 53075
> zone(0): 49152 pages.
> zone(1): 0 pages.
> zone(2): 3923 pages.
> Booting Linux...
> Found CPU 0 <node=ffd66140,mid=8>
> Found 1 CPU prom device tree node(s).
> Unable to handle kernel paging request at virtual address fd000000
> tsk->{mm,active_mm}->context = ffffffff
> tsk->{mm,active_mm}->pgd = fc000000
>               \|/ ____ \|/
>               "@'/ ,. \`@"
>               /_| \__/ |_\
>                  \__U_/
> swapper(0): Oops
> PSR: 40801fc2 PC: f01a77ac NPC: f01a77b0 Y: 01c00000
> g0: f000e000 g1: 00000400 g2: fe2fffff g3: f018bc74 g4: 00000000 g5: 00000000 g6: f000e000 g7: 00007fff
> o0: 00000002 o1: fd000000 o2: fd000000 o3: f0155b38 o4: f1800000 o5: f018c8d4 sp: f000fcf8 o7: f01a7760
> l0: f01db400 l1: f01dd400 l2: f018c400 l3: 00000000 l4: f018c800 l5: 00000000 l6: 0ffffc00 l7: 04000000
> i0: 00000026 i1: 00000000 i2: f01c431a i3: 00000025 i4: 00000001 i5: f01c42f3 fp: f000fd90 i7: f01a74c8
> Caller[f01a74c8]
> Caller[f01a7cdc]
> Caller[f01a67c4]
> Caller[f01a4f94]
> Caller[f01a4790]
> Caller[00000000]
> Instruction DUMP: 80a26000  02800005  01000000 <d00a4000> 901220f1  d02a4000  81c7e008  81e80000  9de3bf68
> Kernel panic: Attempted to kill the idle task!
> In idle task - not syncing
> Press L1-A to return to the boot prom
> IO device interrupt, irq = 10
> PC = f002d9d0 NPC = f002d9d4 FP=f000f9d8
> AIEEE
> Kernel panic: bogus interrupt received
> In interrupt handler - not syncing
> [...]

ksymoops output:

ksymoops 2.3.5 on sparc 2.2.17.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test11 (specified)
     -m /boot/System.map-2.4.0.11.2 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address fd000000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops
PSR: 40801fc2 PC: f01a77ac NPC: f01a77b0 Y: 01c00000
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: f000e000 g1: 00000400 g2: fe2fffff g3: f018bc74 g4: 00000000 g5: 00000000 g6: f000e000 g7: 00007fff
o0: 00000002 o1: fd000000 o2: fd000000 o3: f0155b38 o4: f1800000 o5: f018c8d4 sp: f000fcf8 o7: f01a7760
l0: f01db400 l1: f01dd400 l2: f018c400 l3: 00000000 l4: f018c800 l5: 00000000 l6: 0ffffc00 l7: 04000000
i0: 00000026 i1: 00000000 i2: f01c431a i3: 00000025 i4: 00000001 i5: f01c42f3 fp: f000fd90 i7: f01a74c8
Caller[f01a74c8]
Caller[f01a7cdc]
Caller[f01a67c4]
Caller[f01a4f94]
Caller[f01a4790]
Caller[00000000]
Instruction DUMP: 80a26000  02800005  01000000 <d00a4000> 901220f1  d02a4000  81c7e008  81e80000  9de3bf68

>>PC;  f01a77ac <auxio_probe+14c/160>   <=====
>>O7;  f01a7760 <auxio_probe+100/160>
>>I7;  f01a74c8 <device_scan+240/278>
Trace; f01a74c8 <device_scan+240/278>
Trace; f01a7cdc <paging_init+120/130>
Trace; f01a67c4 <setup_arch+504/514>
Trace; f01a4f94 <start_kernel+10/1ac>
Trace; f01a4790 <sun4c_continue_boot+314/324>
Trace; 00000000 Before first symbol
Code;  f01a77a0 <auxio_probe+140/160>
0000000000000000 <_PC>:
Code;  f01a77a0 <auxio_probe+140/160>
   0:   80 a2 60 00       cmp  %o1, 0
Code;  f01a77a4 <auxio_probe+144/160>
   4:   02 80 00 05       be  18 <_PC+0x18> f01a77b8 <auxio_probe+158/160>
Code;  f01a77a8 <auxio_probe+148/160>
   8:   01 00 00 00       nop 
Code;  f01a77ac <auxio_probe+14c/160>   <=====
   c:   d0 0a 40 00       ldub  [ %o1 ], %o0   <=====
Code;  f01a77b0 <auxio_probe+150/160>
  10:   90 12 20 f1       or  %o0, 0xf1, %o0
Code;  f01a77b4 <auxio_probe+154/160>
  14:   d0 2a 40 00       stb  %o0, [ %o1 ]
Code;  f01a77b8 <auxio_probe+158/160>
  18:   81 c7 e0 08       ret 
Code;  f01a77bc <auxio_probe+15c/160>
  1c:   81 e8 00 00       restore 
Code;  f01a77c0 <auxio_power_probe+0/c8>
  20:   9d e3 bf 68       save  %sp, -152, %sp

Kernel panic: Attempted to kill the idle task!
PC = f002d9d0 NPC = f002d9d4 FP=f000f9d8
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000f810
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000f648
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000f480
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000f2b8
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000f0f0
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000ef28
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000ed60
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000eb98
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000e9d0
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000e808
AIEEE
Kernel panic: bogus interrupt received
PC = f002d9d0 NPC = f002d9d4 FP=f000e640
AIEEE
Kernel panic: bogus interrupt received
PC = 00000004 NPC = 00000003 FP=f0154bd8
Expecting: <1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel paging request at virtual address 87480000
Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference

R.
-- 
W iskier krzesaniu ¿ywem/Materia³ to rzecz g³ówna
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
