Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSEVLMR>; Wed, 22 May 2002 07:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSEVLMQ>; Wed, 22 May 2002 07:12:16 -0400
Received: from lama.euronet.nl ([194.134.128.244]:56078 "EHLO lama.euronet.nl")
	by vger.kernel.org with ESMTP id <S311320AbSEVLMC>;
	Wed, 22 May 2002 07:12:02 -0400
Date: Wed, 22 May 2002 13:12:02 +0200
From: Joris Braakman <jorisb@nl.euro.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 SPARC SMP oops
Message-ID: <20020522131202.B6096@lama.euronet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following oops looks a lot like Tomas Szepe oops, so I copied the
subject.

I could still login with ssh, su to root and issue a reboot, which
didn't work completely, but after a halt command I got the bootprompt 
on the console and issued a boot. Other commands as ps or top didn't
work.  ls did work. It happened under heavy load. The machine was running 
for more than one day with this load.

It is a sparc 5, single processor , 128MB.

Joris. (cc me plz)

cpu             : Fujitsu  MB86904
fpu             : Lsi Logic/Meiko L64804 or compatible
promlib         : Version 3 Revision 2
prom            : 2.15
type            : sun4m
ncpus probed    : 1
ncpus active    : 1
BogoMips        : 109.36
MMU type        : Fujitsu Swift
contexts        : 256
nocache total   : 1048576
nocache used    : 782848

ksymoops 2.4.5 on sparc 2.4.18.  Options used
     -V (default)
     -k 20020521062554.ksyms (specified)
     -l 20020521062554.modules (specified)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is 20020521062554.modules a valid lsmod file?
kernel BUG at srmmu.c:397!
Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 0000001b
tsk->{mm,active_mm}->pgd = fc0f4000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
apache(7990): Oops
PSR: 048000c1 PC: f0020174 NPC: f0020178 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: f0190800 g1: 04800fe7 g2: 00000001 g3: 04400fe0 g4: f00291a0 g5: 53545556 g6: f7174000 g7: 00000000
o0: 0000001b o1: 044000e1 o2: f0190800 o3: f0190994 o4: 0000022b o5: 00000000 sp: f7175a48 o7: f002016c
l0: 049000c2 l1: f0025814 l2: f0025818 l3: 00000010 l4: 00000020 l5: 00000000 l6: f67c67e0 l7: 00000006
i0: f1e9c1e0 i1: 50440000 i2: 001de0aa i3: f003d484 i4: f00f2948 i5: 00000000 fp: f7175ab0 i7: f0039684
Caller[f0039684]
Caller[f00394e8]
Caller[f001e524]
Caller[f0010fe8]
Caller[f0114778]
Caller[f013476c]
Caller[f00f27bc]
Caller[f00f29d4]
Caller[f004b10c]
Caller[f001138c]
Caller[0001a37c]
Instruction DUMP: 921263d0  40002369  9410218d <c0202000> 81c7e008  91e82000  9de3bf98  90100018  7fffff5f 


>>PC;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; f0190800 <abi_table+8/134>
>>g1; 04800fe7 Before first symbol
>>g3; 04400fe0 Before first symbol
>>g4; f00291a0 <release_console_sem+68/e4>
>>g5; 53545556 Before first symbol
>>g6; f7174000 <END_OF_CODE+6f7b0e8/????>
>>o1; 044000e1 Before first symbol
>>o2; f0190800 <abi_table+8/134>
>>o3; f0190994 <console_printk+0/10>
>>sp; f7175a48 <END_OF_CODE+6f7cb30/????>
>>o7; f002016c <srmmu_pte_alloc_one+14/28>
>>l0; 049000c2 Before first symbol
>>l1; f0025814 <flush_patch_switch+34/170>
>>l2; f0025818 <flush_patch_switch+38/170>
>>l6; f67c67e0 <END_OF_CODE+65cd8c8/????>
>>i0; f1e9c1e0 <END_OF_CODE+1ca32c8/????>
>>i1; 50440000 Before first symbol
>>i2; 001de0aa Before first symbol
>>i3; f003d484 <filemap_nopage+0/2a0>
>>i4; f00f2948 <sock_write+0/a0>
>>fp; f7175ab0 <END_OF_CODE+6f7cb98/????>
>>i7; f0039684 <pte_alloc+38/90>

Trace; f0039684 <pte_alloc+38/90>
Trace; f00394e8 <handle_mm_fault+60/164>
Trace; f001e524 <do_sparc_fault+1a0/3f0>
Trace; f0010fe8 <srmmu_fault+58/68>
Trace; f0114778 <tcp_sendmsg+538/13e4>
Trace; f013476c <inet_sendmsg+40/54>
Trace; f00f27bc <sock_sendmsg+74/9c>
Trace; f00f29d4 <sock_write+8c/a0>
Trace; f004b10c <sys_write+c4/164>
Trace; f001138c <syscall_is_too_hard+34/40>
Trace; 0001a37c Before first symbol

Code;  f0020168 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f0020168 <srmmu_pte_alloc_one+10/28>
   0:   92 12 63 d0       or  %o1, 0x3d0, %o1
Code;  f002016c <srmmu_pte_alloc_one+14/28>
   4:   40 00 23 69       call  8da8 <_PC+0x8da8> f0028f10 <printk+0/1b4>
Code;  f0020170 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f0020178 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret 
Code;  f002017c <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f0020180 <srmmu_free_pte_fast+0/18>
  18:   9d e3 bf 98       save  %sp, -104, %sp
Code;  f0020184 <srmmu_free_pte_fast+4/18>
  1c:   90 10 00 18       mov  %i0, %o0
Code;  f0020188 <srmmu_free_pte_fast+8/18>
  20:   7f ff ff 5f       call  fffffd9c <_PC+0xfffffd9c> f001ff04 <srmmu_free_nocache+0/88>
Code;  f002018c <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0

kernel BUG at /usr/src/kernel-source-2.4.18/include/asm/pgalloc.h:120!
kernel BUG at srmmu.c:397!
Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 000000e0
tsk->{mm,active_mm}->pgd = fc0c2000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
apache(7922): Oops
PSR: 048000c1 PC: f0020174 NPC: f0020178 Y: 00000000    Not tainted
g0: f0190800 g1: 04800fe7 g2: 00000001 g3: 04400fe0 g4: f00291a0 g5: 53545556 g6: f5b66000 g7: 00000000
o0: 0000001b o1: 044000e1 o2: f0190800 o3: f0190994 o4: 00000124 o5: 00000000 sp: f5b67a48 o7: f002016c
l0: 049000c2 l1: f0025814 l2: f0025818 l3: 00000010 l4: 00000020 l5: 00000000 l6: f35ad280 l7: 502f42ac
i0: f4da3980 i1: 50580000 i2: f7ef7400 i3: 00000000 i4: fff00000 i5: f014e7e8 fp: f5b67ab0 i7: f0039684
Caller[f0039684]
Caller[f00394e8]
Caller[f001e524]
Caller[f0010fe8]
Caller[f0114778]
Caller[f013476c]
Caller[f00f27bc]
Caller[f00f29d4]
Caller[f004b10c]
Caller[f001138c]
Caller[0001a37c]
Instruction DUMP: 921263d0  40002369  9410218d <c0202000> 81c7e008  91e82000  9de3bf98  90100018  7fffff5f 


>>PC;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; f0190800 <abi_table+8/134>
>>g1; 04800fe7 Before first symbol
>>g3; 04400fe0 Before first symbol
>>g4; f00291a0 <release_console_sem+68/e4>
>>g5; 53545556 Before first symbol
>>g6; f5b66000 <END_OF_CODE+596d0e8/????>
>>o1; 044000e1 Before first symbol
>>o2; f0190800 <abi_table+8/134>
>>o3; f0190994 <console_printk+0/10>
>>sp; f5b67a48 <END_OF_CODE+596eb30/????>
>>o7; f002016c <srmmu_pte_alloc_one+14/28>
>>l0; 049000c2 Before first symbol
>>l1; f0025814 <flush_patch_switch+34/170>
>>l2; f0025818 <flush_patch_switch+38/170>
>>l6; f35ad280 <END_OF_CODE+33b4368/????>
>>l7; 502f42ac Before first symbol
>>i0; f4da3980 <END_OF_CODE+4baaa68/????>
>>i1; 50580000 Before first symbol
>>i2; f7ef7400 <END_OF_CODE+7cfe4e8/????>
>>i4; fff00000 <END_OF_CODE+fd070e8/????>
>>i5; f014e7e8 <L.2.15+20/24>
>>fp; f5b67ab0 <END_OF_CODE+596eb98/????>
>>i7; f0039684 <pte_alloc+38/90>

Trace; f0039684 <pte_alloc+38/90>
Trace; f00394e8 <handle_mm_fault+60/164>
Trace; f001e524 <do_sparc_fault+1a0/3f0>
Trace; f0010fe8 <srmmu_fault+58/68>
Trace; f0114778 <tcp_sendmsg+538/13e4>
Trace; f013476c <inet_sendmsg+40/54>
Trace; f00f27bc <sock_sendmsg+74/9c>
Trace; f00f29d4 <sock_write+8c/a0>
Trace; f004b10c <sys_write+c4/164>
Trace; f001138c <syscall_is_too_hard+34/40>
Trace; 0001a37c Before first symbol

Code;  f0020168 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f0020168 <srmmu_pte_alloc_one+10/28>
   0:   92 12 63 d0       or  %o1, 0x3d0, %o1
Code;  f002016c <srmmu_pte_alloc_one+14/28>
   4:   40 00 23 69       call  8da8 <_PC+0x8da8> f0028f10 <printk+0/1b4>
Code;  f0020170 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f0020178 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret 
Code;  f002017c <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f0020180 <srmmu_free_pte_fast+0/18>
  18:   9d e3 bf 98       save  %sp, -104, %sp
Code;  f0020184 <srmmu_free_pte_fast+4/18>
  1c:   90 10 00 18       mov  %i0, %o0
Code;  f0020188 <srmmu_free_pte_fast+8/18>
  20:   7f ff ff 5f       call  fffffd9c <_PC+0xfffffd9c> f001ff04 <srmmu_free_nocache+0/88>
Code;  f002018c <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0

kernel BUG at srmmu.c:397!
Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 00000058
tsk->{mm,active_mm}->pgd = fc040800
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
apache(7553): Oops
PSR: 048000c1 PC: f0020174 NPC: f0020178 Y: 00000000    Not tainted
g0: f0190800 g1: 04800fe7 g2: 00000001 g3: 04400fe0 g4: f00291a0 g5: 53545556 g6: f0fd2000 g7: 00000000
o0: 0000001b o1: 044000e1 o2: f0190800 o3: f0190994 o4: 0000033b o5: 00000000 sp: f0fd3a48 o7: f002016c
l0: 0000033b l1: f3b861f4 l2: f082d2c0 l3: f2bdb120 l4: f7f530dc l5: 0000033b l6: f3b86140 l7: 00000006
i0: f68c3780 i1: 50740000 i2: 00421faa i3: f003d484 i4: fff00000 i5: 00000000 fp: f0fd3ab0 i7: f0039684
Caller[f0039684]
Caller[f00394e8]
Caller[f001e524]
Caller[f0010fe8]
Caller[f0114778]
Caller[f013476c]
Caller[f00f27bc]
Caller[f00f29d4]
Caller[f004b10c]
Caller[f001138c]
Caller[0001a37c]
Instruction DUMP: 921263d0  40002369  9410218d <c0202000> 81c7e008  91e82000  9de3bf98  90100018  7fffff5f 


>>PC;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; f0190800 <abi_table+8/134>
>>g1; 04800fe7 Before first symbol
>>g3; 04400fe0 Before first symbol
>>g4; f00291a0 <release_console_sem+68/e4>
>>g5; 53545556 Before first symbol
>>g6; f0fd2000 <END_OF_CODE+dd90e8/????>
>>o1; 044000e1 Before first symbol
>>o2; f0190800 <abi_table+8/134>
>>o3; f0190994 <console_printk+0/10>
>>sp; f0fd3a48 <END_OF_CODE+ddab30/????>
>>o7; f002016c <srmmu_pte_alloc_one+14/28>
>>l1; f3b861f4 <END_OF_CODE+398d2dc/????>
>>l2; f082d2c0 <END_OF_CODE+6343a8/????>
>>l3; f2bdb120 <END_OF_CODE+29e2208/????>
>>l4; f7f530dc <END_OF_CODE+7d5a1c4/????>
>>l6; f3b86140 <END_OF_CODE+398d228/????>
>>i0; f68c3780 <END_OF_CODE+66ca868/????>
>>i1; 50740000 Before first symbol
>>i2; 00421faa Before first symbol
>>i3; f003d484 <filemap_nopage+0/2a0>
>>i4; fff00000 <END_OF_CODE+fd070e8/????>
>>fp; f0fd3ab0 <END_OF_CODE+ddab98/????>
>>i7; f0039684 <pte_alloc+38/90>

Trace; f0039684 <pte_alloc+38/90>
Trace; f00394e8 <handle_mm_fault+60/164>
Trace; f001e524 <do_sparc_fault+1a0/3f0>
Trace; f0010fe8 <srmmu_fault+58/68>
Trace; f0114778 <tcp_sendmsg+538/13e4>
Trace; f013476c <inet_sendmsg+40/54>
Trace; f00f27bc <sock_sendmsg+74/9c>
Trace; f00f29d4 <sock_write+8c/a0>
Trace; f004b10c <sys_write+c4/164>
Trace; f001138c <syscall_is_too_hard+34/40>
Trace; 0001a37c Before first symbol

Code;  f0020168 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f0020168 <srmmu_pte_alloc_one+10/28>
   0:   92 12 63 d0       or  %o1, 0x3d0, %o1
Code;  f002016c <srmmu_pte_alloc_one+14/28>
   4:   40 00 23 69       call  8da8 <_PC+0x8da8> f0028f10 <printk+0/1b4>
Code;  f0020170 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f0020178 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret 
Code;  f002017c <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f0020180 <srmmu_free_pte_fast+0/18>
  18:   9d e3 bf 98       save  %sp, -104, %sp
Code;  f0020184 <srmmu_free_pte_fast+4/18>
  1c:   90 10 00 18       mov  %i0, %o0
Code;  f0020188 <srmmu_free_pte_fast+8/18>
  20:   7f ff ff 5f       call  fffffd9c <_PC+0xfffffd9c> f001ff04 <srmmu_free_nocache+0/88>
Code;  f002018c <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0

kernel BUG at srmmu.c:397!
Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 0000006f
tsk->{mm,active_mm}->pgd = fc0f5800
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
apache(7991): Oops
PSR: 048000c1 PC: f0020174 NPC: f0020178 Y: 00000000    Not tainted
g0: f0190800 g1: 04800fe7 g2: 00000001 g3: 04400fe0 g4: f00291a0 g5: 53545556 010b400 sp: f10b1a48 o7: f002016c
Warning (Oops_set_regs): garbage '010b400 sp: f10b1a48 o7: f002016c' at end of register line ignored
l0: 044000c2 l1: f00fb070 l2: f002d8f4 l3: 00000010 l4: 00000020 l5: 00000000 l6: f1269580 l7: 00065000
i0: f1e9c140 i1: 50640000 i2: f01c41ec i3: f010ae90 i4: fff00000 i5: f014e7e8 fp: f10b1ab0 i7: f0039684
Caller[f0039684]
Caller[f00394e8]
Caller[f001e524]
Caller[f0010fe8]
Caller[f0114778]
Caller[f013476c]
Caller[f00f27bc]
Caller[f00f29d4]
Caller[f004b10c]
Caller[f001138c]
Caller[0001a37c]
Instruction DUMP: 921263d0  40002369  9410218d <c0202000> 81c7e008  91e82000  9de3bf98  90100018  7fffff5f 


>>PC;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; f0190800 <abi_table+8/134>
>>g1; 04800fe7 Before first symbol
>>g3; 04400fe0 Before first symbol
>>g4; f00291a0 <release_console_sem+68/e4>
>>g5; 53545556 Before first symbol
>>l0; 044000c2 Before first symbol
>>l1; f00fb070 <net_rx_action+3f0/3f4>
>>l2; f002d8f4 <do_softirq+b0/150>
>>l6; f1269580 <END_OF_CODE+1070668/????>
>>l7; 00065000 Before first symbol
>>i0; f1e9c140 <END_OF_CODE+1ca3228/????>
>>i1; 50640000 Before first symbol
>>i2; f01c41ec <softnet_data+c/40>
>>i3; f010ae90 <ip_rcv+0/548>
>>i4; fff00000 <END_OF_CODE+fd070e8/????>
>>i5; f014e7e8 <L.2.15+20/24>
>>fp; f10b1ab0 <END_OF_CODE+eb8b98/????>
>>i7; f0039684 <pte_alloc+38/90>

Trace; f0039684 <pte_alloc+38/90>
Trace; f00394e8 <handle_mm_fault+60/164>
Trace; f001e524 <do_sparc_fault+1a0/3f0>
Trace; f0010fe8 <srmmu_fault+58/68>
Trace; f0114778 <tcp_sendmsg+538/13e4>
Trace; f013476c <inet_sendmsg+40/54>
Trace; f00f27bc <sock_sendmsg+74/9c>
Trace; f00f29d4 <sock_write+8c/a0>
Trace; f004b10c <sys_write+c4/164>
Trace; f001138c <syscall_is_too_hard+34/40>
Trace; 0001a37c Before first symbol

Code;  f0020168 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f0020168 <srmmu_pte_alloc_one+10/28>
   0:   92 12 63 d0       or  %o1, 0x3d0, %o1
Code;  f002016c <srmmu_pte_alloc_one+14/28>
   4:   40 00 23 69       call  8da8 <_PC+0x8da8> f0028f10 <printk+0/1b4>
Code;  f0020170 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f0020178 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret 
Code;  f002017c <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f0020180 <srmmu_free_pte_fast+0/18>
  18:   9d e3 bf 98       save  %sp, -104, %sp
Code;  f0020184 <srmmu_free_pte_fast+4/18>
  1c:   90 10 00 18       mov  %i0, %o0
Code;  f0020188 <srmmu_free_pte_fast+8/18>
  20:   7f ff ff 5f       call  fffffd9c <_PC+0xfffffd9c> f001ff04 <srmmu_free_nocache+0/88>
Code;  f002018c <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0

kernel BUG at srmmu.c:397!
Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 00000096
tsk->{mm,active_mm}->pgd = fc0cac00
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
apache(7983): Oops
PSR: 048000c1 PC: f0020174 NPC: f0020178 Y: 00000000    Not tainted
g0: f0190800 g1: 04800fe7 g2: 00000001 g3: 04400fe0 g4: f00291a0 g5: 53545556 g6: f7ce0000 g7: 00000000
o0: 0000001b o1: 044000e1 o2: f0190800 o3: f0190994 o4: 5023c568 o5: f01507e8 sp: f7ce1a48 o7: f002016c
l0: 049010c2 l1: f0025814 l2: f0025818 l3: 00000010 l4: 00000020 l5: 00000000 l6: f3ba8000 l7: 7fffffff
i0: f4da33e0 i1: 504c0000 i2: 00001000 i3: f017ec00 i4: 00000000 i5: f3ba9dec fp: f7ce1ab0 i7: f0039684
Caller[f0039684]
Caller[f00394e8]
Caller[f001e524]
Caller[f0010fe8]
Caller[f0114778]
Caller[f013476c]
Caller[f00f27bc]
Caller[f00f29d4]
Caller[f004b10c]
Caller[f001138c]
Caller[0001a37c]
Instruction DUMP: 921263d0  40002369  9410218d <c0202000> 81c7e008  91e82000  9de3bf98  90100018  7fffff5f 


>>PC;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; f0190800 <abi_table+8/134>
>>g1; 04800fe7 Before first symbol
>>g3; 04400fe0 Before first symbol
>>g4; f00291a0 <release_console_sem+68/e4>
>>g5; 53545556 Before first symbol
>>g6; f7ce0000 <END_OF_CODE+7ae70e8/????>
>>o1; 044000e1 Before first symbol
>>o2; f0190800 <abi_table+8/134>
>>o3; f0190994 <console_printk+0/10>
>>o4; 5023c568 Before first symbol
>>o5; f01507e8 <__udivdi3+3a4/3b4>
>>sp; f7ce1a48 <END_OF_CODE+7ae8b30/????>
>>o7; f002016c <srmmu_pte_alloc_one+14/28>
>>l0; 049010c2 Before first symbol
>>l1; f0025814 <flush_patch_switch+34/170>
>>l2; f0025818 <flush_patch_switch+38/170>
>>l6; f3ba8000 <END_OF_CODE+39af0e8/????>
>>l7; 7fffffff Before first symbol
>>i0; f4da33e0 <END_OF_CODE+4baa4c8/????>
>>i1; 504c0000 Before first symbol
>>i2; 00001000 Before first symbol
>>i3; f017ec00 <prio2band+26e8/3868>
>>i5; f3ba9dec <END_OF_CODE+39b0ed4/????>
>>fp; f7ce1ab0 <END_OF_CODE+7ae8b98/????>
>>i7; f0039684 <pte_alloc+38/90>

Trace; f0039684 <pte_alloc+38/90>
Trace; f00394e8 <handle_mm_fault+60/164>
Trace; f001e524 <do_sparc_fault+1a0/3f0>
Trace; f0010fe8 <srmmu_fault+58/68>
Trace; f0114778 <tcp_sendmsg+538/13e4>
Trace; f013476c <inet_sendmsg+40/54>
Trace; f00f27bc <sock_sendmsg+74/9c>
Trace; f00f29d4 <sock_write+8c/a0>
Trace; f004b10c <sys_write+c4/164>
Trace; f001138c <syscall_is_too_hard+34/40>
Trace; 0001a37c Before first symbol

Code;  f0020168 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f0020168 <srmmu_pte_alloc_one+10/28>
   0:   92 12 63 d0       or  %o1, 0x3d0, %o1
Code;  f002016c <srmmu_pte_alloc_one+14/28>
   4:   40 00 23 69       call  8da8 <_PC+0x8da8> f0028f10 <printk+0/1b4>
Code;  f0020170 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f0020178 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret 
Code;  f002017c <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f0020180 <srmmu_free_pte_fast+0/18>
  18:   9d e3 bf 98       save  %sp, -104, %sp
Code;  f0020184 <srmmu_free_pte_fast+4/18>
  1c:   90 10 00 18       mov  %i0, %o0
Code;  f0020188 <srmmu_free_pte_fast+8/18>
  20:   7f ff ff 5f       call  fffffd9c <_PC+0xfffffd9c> f001ff04 <srmmu_free_nocache+0/88>
Code;  f002018c <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0

kernel BUG at srmmu.c:397!
Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 0000001f
tsk->{mm,active_mm}->pgd = fc0d0400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
sh(8009): Oops
PSR: 048000c3 PC: f0020174 NPC: f0020178 Y: 00000000    Not tainted
g0: f0190800 g1: 04800fe1 g2: 00000001 g3: 04400fe2 g4: f00291a0 g5: 53545556 g6: f1062000 g7: 00000000
o0: 0000001b o1: 044000e3 o2: f0190800 o3: f0190994 o4: f3736200 o5: 00000082 sp: f1063d48 o7: f002016c
l0: f3736020 l1: f01f9d58 l2: 044000e4 l3: 00009000 l4: 00000000 l5: 50082000 l6: f01cd400 l7: 500283a8
i0: f68c3dc0 i1: 50081000 i2: f4f1d4a0 i3: f4f1d4c0 i4: f4f1d4b8 i5: f4f1d4b8 fp: f1063db0 i7: f0039684
Caller[f0039684]
Caller[f00394e8]
Caller[f001e524]
Caller[f0010fe8]
Caller[500060cc]
Instruction DUMP: 921263d0  40002369  9410218d <c0202000> 81c7e008  91e82000  9de3bf98  90100018  7fffff5f 


>>PC;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; f0190800 <abi_table+8/134>
>>g1; 04800fe1 Before first symbol
>>g3; 04400fe2 Before first symbol
>>g4; f00291a0 <release_console_sem+68/e4>
>>g5; 53545556 Before first symbol
>>g6; f1062000 <END_OF_CODE+e690e8/????>
>>o1; 044000e3 Before first symbol
>>o2; f0190800 <abi_table+8/134>
>>o3; f0190994 <console_printk+0/10>
>>o4; f3736200 <END_OF_CODE+353d2e8/????>
>>sp; f1063d48 <END_OF_CODE+e6ae30/????>
>>o7; f002016c <srmmu_pte_alloc_one+14/28>
>>l0; f3736020 <END_OF_CODE+353d108/????>
>>l1; f01f9d58 <end+e40/????>
>>l2; 044000e4 Before first symbol
>>l3; 00009000 Before first symbol
>>l5; 50082000 Before first symbol
>>l6; f01cd400 <pidhash+fa0/1000>
>>l7; 500283a8 Before first symbol
>>i0; f68c3dc0 <END_OF_CODE+66caea8/????>
>>i1; 50081000 Before first symbol
>>i2; f4f1d4a0 <END_OF_CODE+4d24588/????>
>>i3; f4f1d4c0 <END_OF_CODE+4d245a8/????>
>>i4; f4f1d4b8 <END_OF_CODE+4d245a0/????>
>>i5; f4f1d4b8 <END_OF_CODE+4d245a0/????>
>>fp; f1063db0 <END_OF_CODE+e6ae98/????>
>>i7; f0039684 <pte_alloc+38/90>

Trace; f0039684 <pte_alloc+38/90>
Trace; f00394e8 <handle_mm_fault+60/164>
Trace; f001e524 <do_sparc_fault+1a0/3f0>
Trace; f0010fe8 <srmmu_fault+58/68>
Trace; 500060cc Before first symbol

Code;  f0020168 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f0020168 <srmmu_pte_alloc_one+10/28>
   0:   92 12 63 d0       or  %o1, 0x3d0, %o1
Code;  f002016c <srmmu_pte_alloc_one+14/28>
   4:   40 00 23 69       call  8da8 <_PC+0x8da8> f0028f10 <printk+0/1b4>
Code;  f0020170 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f0020178 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret 
Code;  f002017c <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f0020180 <srmmu_free_pte_fast+0/18>
  18:   9d e3 bf 98       save  %sp, -104, %sp
Code;  f0020184 <srmmu_free_pte_fast+4/18>
  1c:   90 10 00 18       mov  %i0, %o0
Code;  f0020188 <srmmu_free_pte_fast+8/18>
  20:   7f ff ff 5f       call  fffffd9c <_PC+0xfffffd9c> f001ff04 <srmmu_free_nocache+0/88>
Code;  f002018c <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0

kernel BUG at srmmu.c:397!
Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 00000046
tsk->{mm,active_mm}->pgd = fc0d0000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
sendmail(8013): Oops
PSR: 048000c5 PC: f0020174 NPC: f0020178 Y: 00000000    Not tainted
g0: f0190800 g1: 04800fe3 g2: 00000001 g3: 04400fe4 g4: f00291a0 g5: 53545556 g6: f522c000 g7: 00000000
o0: 0000001b o1: 044000e5 o2: f0190800 o3: f0190994 o4: 0000007d o5: 00000000 sp: f522dd48 o7: f002016c
l0: 00000077 l1: f3b86bf4 l2: f3e240a0 l3: f2109380 l4: f7f52b30 l5: 00000077 l6: f3b86b40 l7: 501be001
i0: f527ac00 i1: 502be000 i2: 007288aa i3: f003d484 i4: 0000013f i5: 00000000 fp: f522ddb0 i7: f0039684
Caller[f0039684]
Caller[f00394e8]
Caller[f001e524]
Caller[f0010fe8]
Caller[501f1268]
Instruction DUMP: 921263d0  40002369  9410218d <c0202000> 81c7e008  91e82000  9de3bf98  90100018  7fffff5f 


>>PC;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; f0190800 <abi_table+8/134>
>>g1; 04800fe3 Before first symbol
>>g3; 04400fe4 Before first symbol
>>g4; f00291a0 <release_console_sem+68/e4>
>>g5; 53545556 Before first symbol
>>g6; f522c000 <END_OF_CODE+50330e8/????>
>>o1; 044000e5 Before first symbol
>>o2; f0190800 <abi_table+8/134>
>>o3; f0190994 <console_printk+0/10>
>>sp; f522dd48 <END_OF_CODE+5034e30/????>
>>o7; f002016c <srmmu_pte_alloc_one+14/28>
>>l1; f3b86bf4 <END_OF_CODE+398dcdc/????>
>>l2; f3e240a0 <END_OF_CODE+3c2b188/????>
>>l3; f2109380 <END_OF_CODE+1f10468/????>
>>l4; f7f52b30 <END_OF_CODE+7d59c18/????>
>>l6; f3b86b40 <END_OF_CODE+398dc28/????>
>>l7; 501be001 Before first symbol
>>i0; f527ac00 <END_OF_CODE+5081ce8/????>
>>i1; 502be000 Before first symbol
>>i2; 007288aa Before first symbol
>>i3; f003d484 <filemap_nopage+0/2a0>
>>fp; f522ddb0 <END_OF_CODE+5034e98/????>
>>i7; f0039684 <pte_alloc+38/90>

Trace; f0039684 <pte_alloc+38/90>
Trace; f00394e8 <handle_mm_fault+60/164>
Trace; f001e524 <do_sparc_fault+1a0/3f0>
Trace; f0010fe8 <srmmu_fault+58/68>
Trace; 501f1268 Before first symbol

Code;  f0020168 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f0020168 <srmmu_pte_alloc_one+10/28>
   0:   92 12 63 d0       or  %o1, 0x3d0, %o1
Code;  f002016c <srmmu_pte_alloc_one+14/28>
   4:   40 00 23 69       call  8da8 <_PC+0x8da8> f0028f10 <printk+0/1b4>
Code;  f0020170 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f0020178 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret 
Code;  f002017c <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f0020180 <srmmu_free_pte_fast+0/18>
  18:   9d e3 bf 98       save  %sp, -104, %sp
Code;  f0020184 <srmmu_free_pte_fast+4/18>
  1c:   90 10 00 18       mov  %i0, %o0
Code;  f0020188 <srmmu_free_pte_fast+8/18>
  20:   7f ff ff 5f       call  fffffd9c <_PC+0xfffffd9c> f001ff04 <srmmu_free_nocache+0/88>
Code;  f002018c <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0

kernel BUG at srmmu.c:397!
kernel BUG at srmmu.c:397!
Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 0000001d
tsk->{mm,active_mm}->pgd = fc045c00
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
apache(7636): Oops
PSR: 048000c1 PC: f0020174 NPC: f0020178 Y: 00000000    Not tainted
g0: f0190800 g1: 04800fe7 g2: 00000001 g3: 04400fe0 g4: f00291a0 g5: 53545556 g6 : f2864000 g7: 00000000
o0: 0000001b o1: 044000e1 o2: f0190800 o3: f0190994 o4: 0000035a o5: 00000000 sp : f2865a48 o7: f002016c
l0: 0000035a l1: f3243554 l2: f6ce73e0 l3: f5689ce0 l4: f7f519f8 l5: 0000035a l6 : f32434a0 l7: f01d297c
i0: f68c3a00 i1: 50740000 i2: 0056b7aa i3: f003d484 i4: f00f2948 i5: 00000000 fp : f2865ab0 i7: f0039684
Caller[f0039684]
Caller[f00394e8]
Caller[f001e524]
Caller[f0010fe8]
Caller[f0114778]
Caller[f013476c]
Caller[f00f27bc]
Caller[f00f29d4]
Caller[f004b10c]
Caller[f001138c]
Caller[0001a37c]
Instruction DUMP: 921263d0  40002369  9410218d <c0202000> 81c7e008  91e82000  9d e3bf98  90100018  7fffff5f 
Error (Oops_code_values): invalid value 0xe3bf98 in Code line, must be 2, 4, 8 or 16 digits, value ignored


>>PC;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====

>>g0; f0190800 <abi_table+8/134>
>>g1; 04800fe7 Before first symbol
>>g3; 04400fe0 Before first symbol
>>g4; f00291a0 <release_console_sem+68/e4>
>>g5; 53545556 Before first symbol
>>g6; f2864000 <END_OF_CODE+266b0e8/????>
>>o1; 044000e1 Before first symbol
>>o2; f0190800 <abi_table+8/134>
>>o3; f0190994 <console_printk+0/10>
>>sp; f2865a48 <END_OF_CODE+266cb30/????>
>>o7; f002016c <srmmu_pte_alloc_one+14/28>
>>l1; f3243554 <END_OF_CODE+304a63c/????>
>>l2; f6ce73e0 <END_OF_CODE+6aee4c8/????>
>>l3; f5689ce0 <END_OF_CODE+5490dc8/????>
>>l4; f7f519f8 <END_OF_CODE+7d58ae0/????>
>>l6; f32434a0 <END_OF_CODE+304a588/????>
>>l7; f01d297c <tv1+4/804>
>>i0; f68c3a00 <END_OF_CODE+66caae8/????>
>>i1; 50740000 Before first symbol
>>i2; 0056b7aa Before first symbol
>>i3; f003d484 <filemap_nopage+0/2a0>
>>i4; f00f2948 <sock_write+0/a0>
>>fp; f2865ab0 <END_OF_CODE+266cb98/????>
>>i7; f0039684 <pte_alloc+38/90>

Trace; f0039684 <pte_alloc+38/90>
Trace; f00394e8 <handle_mm_fault+60/164>
Trace; f001e524 <do_sparc_fault+1a0/3f0>
Trace; f0010fe8 <srmmu_fault+58/68>
Trace; f0114778 <tcp_sendmsg+538/13e4>
Trace; f013476c <inet_sendmsg+40/54>
Trace; f00f27bc <sock_sendmsg+74/9c>
Trace; f00f29d4 <sock_write+8c/a0>
Trace; f004b10c <sys_write+c4/164>
Trace; f001138c <syscall_is_too_hard+34/40>
Trace; 0001a37c Before first symbol

Code;  f0020168 <srmmu_pte_alloc_one+10/28>
00000000 <_PC>:
Code;  f0020168 <srmmu_pte_alloc_one+10/28>
   0:   92 12 63 d0       or  %o1, 0x3d0, %o1
Code;  f002016c <srmmu_pte_alloc_one+14/28>
   4:   40 00 23 69       call  8da8 <_PC+0x8da8> f0028f10 <printk+0/1b4>
Code;  f0020170 <srmmu_pte_alloc_one+18/28>
   8:   94 10 21 8d       mov  0x18d, %o2
Code;  f0020174 <srmmu_pte_alloc_one+1c/28>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f0020178 <srmmu_pte_alloc_one+20/28>
  10:   81 c7 e0 08       ret 
Code;  f002017c <srmmu_pte_alloc_one+24/28>
  14:   91 e8 20 00       restore  %g0, 0, %o0
Code;  f0020180 <srmmu_free_pte_fast+0/18>
  18:   9d 90 10 00       unknown
Code;  f0020184 <srmmu_free_pte_fast+4/18>
  1c:   18 7f ff ff       unknown
Code;  f0020188 <srmmu_free_pte_fast+8/18>
  20:   5f 00 00 00       call  7c000020 <_PC+0x7c000020> 6c020188 Before first symbol
Code;  f002018c <srmmu_free_pte_fast+c/18>
  24:   00 00 00 00       unimp  0


2 warnings and 1 error issued.  Results may not be reliable.


# more .config | grep -v ^# 
CONFIG_UID16=y
CONFIG_HIGHMEM=y

CONFIG_EXPERIMENTAL=y

CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SPARC32=y
CONFIG_SBUS=y
CONFIG_SBUSCHAR=y
CONFIG_BUSMOUSE=y
CONFIG_SUN_MOUSE=y
CONFIG_SERIAL=y
CONFIG_SUN_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SUN_KEYBOARD=y
CONFIG_SUN_CONSOLE=y
CONFIG_SUN_AUXIO=y
CONFIG_SUN_IO=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_SUN_OPENPROMFS=m
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_SUNOS_EMUL=y

CONFIG_PROM_CONSOLE=y

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_SBUS=y
CONFIG_FB_CGSIX=y
CONFIG_FB_BWTWO=y
CONFIG_FB_CGTHREE=y
CONFIG_FB_TCX=y
CONFIG_FB_CGFOURTEEN=y
CONFIG_FB_LEO=y
CONFIG_FBCON_MFB=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_FONTWIDTH8_ONLY=y
CONFIG_FONT_SUN8x16=y

CONFIG_SUN_OPENPROMIO=m
CONFIG_SUN_MOSTEK_RTC=y

CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m

CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y

CONFIG_IPV6=m

CONFIG_SCSI=y

CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y

CONFIG_SCSI_SUNESP=y
CONFIG_SCSI_QLOGICPTI=m

CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SUNLANCE=y
CONFIG_HAPPYMEAL=m
CONFIG_SUNBMAC=m
CONFIG_SUNQE=m
CONFIG_MYRI_SBUS=m

CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_EFS_FS=m
CONFIG_ISO9660_FS=m
CONFIG_MINIX_FS=m
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y

CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=y
CONFIG_NFSD=m
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_SMB_FS=m

CONFIG_MSDOS_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-1"

