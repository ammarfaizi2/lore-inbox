Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbQKTOy2>; Mon, 20 Nov 2000 09:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129768AbQKTOyG>; Mon, 20 Nov 2000 09:54:06 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:26628
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129177AbQKTOx7>; Mon, 20 Nov 2000 09:53:59 -0500
Date: Mon, 20 Nov 2000 09:33:17 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test10 on sparc
Message-ID: <20001120093317.A934@animx.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii

I noticed 2 things.  One is quite annoying.
1) sunlance:
Nov 19 19:09:49 sparq kernel: eth0: Carrier Lost, trying AUI
Nov 19 19:09:52 sparq kernel: eth0: Carrier Lost, trying TPE 

This has been going on for some time since it has been up.  But I think
something oopsed to cause this

2) the oops.  It oopsed 3 times.  I have attached the oops.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.0-test10-sparc-oops"

[wakko@sparq:/home/wakko] ksymoops < kernel 
ksymoops 2.3.4 on sparc 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /boot/System.map-2.4.0-test10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Nov 19 18:18:34 sparq kernel: Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 00000abe 
Nov 19 18:18:34 sparq kernel: tsk->{mm,active_mm}->pgd = fc06cc00 
Nov 19 18:18:34 sparq kernel:               \|/ ____ \|/ 
Nov 19 18:18:34 sparq kernel:               "@'/ ,. \`@" 
Nov 19 18:18:34 sparq kernel:               /_| \__/ |_\ 
Nov 19 18:18:34 sparq kernel:                  \__U_/ 
Nov 19 18:18:34 sparq kernel: dd(2757): Oops 
Nov 19 18:18:34 sparq kernel: PSR: 409000c2 PC: f00acce8 NPC: f00accec Y: 00000000 
Using defaults from ksymoops -t elf32-sparc -a sparc
Nov 19 18:18:34 sparq kernel: g0: f42f3f08 g1: 40800fa2 g2: 0000ffff g3: 00029000 g4: f0053f30 g5: 72650000 g6: f42f2000 g7: 00000200 
Nov 19 18:18:34 sparq kernel: o0: 00029000 o1: 00029000 o2: 00000000 o3: f4c45c40 o4: 00000000 o5: 0000ffff sp: f42f3f08 o7: f0052b90 
Nov 19 18:18:34 sparq kernel: l0: f4c45c20 l1: 00000aae l2: 5003bd3e l3: 50029d28 l4: 500322a8 l5: 00000557 l6: 5002cd38 l7: 50028cb4 
Nov 19 18:18:34 sparq kernel: i0: ffffffea i1: 00029000 i2: 00000001 i3: 5004f99c i4: 00000008 i5: 50089558 fp: f42f3f70 i7: f00151dc 
Nov 19 18:18:34 sparq kernel: Caller[f00151dc] 
Nov 19 18:18:34 sparq kernel: Caller[000138fc] 
Nov 19 18:18:34 sparq kernel: Instruction DUMP: 38800012  84102000  9a100002 <c40b0000> c42a0000  86100000  80a0e000  06bffff1  8410000a  

>>PC;  f00acce8 <read_port+60/b0>   <=====
>>O7;  f0052b90 <sys_read+c4/110>
>>I7;  f00151dc <syscall_is_too_hard+34/40>
Trace; f00151dc <syscall_is_too_hard+34/40>
Trace; 000138fc Before first symbol
Code;  f00accdc <read_port+54/b0>
0000000000000000 <_PC>:
Code;  f00accdc <read_port+54/b0>
   0:   38 80 00 12       bgu,a   48 <_PC+0x48> f00acd24 <read_port+9c/b0>
Code;  f00acce0 <read_port+58/b0>
   4:   84 10 20 00       clr  %g2
Code;  f00acce4 <read_port+5c/b0>
   8:   9a 10 00 02       mov  %g2, %o5
Code;  f00acce8 <read_port+60/b0>   <=====
   c:   c4 0b 00 00       ldub  [ %o4 ], %g2   <=====
Code;  f00accec <read_port+64/b0>
  10:   c4 2a 00 00       stb  %g2, [ %o0 ]
Code;  f00accf0 <read_port+68/b0>
  14:   86 10 00 00       mov  %g0, %g3
Code;  f00accf4 <read_port+6c/b0>
  18:   80 a0 e0 00       cmp  %g3, 0
Code;  f00accf8 <read_port+70/b0>
  1c:   06 bf ff f1       bl  ffffffffffffffe0 <_PC+0xffffffffffffffe0> f00accbc <read_port+34/b0>
Code;  f00accfc <read_port+74/b0>
  20:   84 10 00 0a       mov  %o2, %g2

Nov 19 18:18:36 sparq kernel: Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 00000abf 
Nov 19 18:18:36 sparq kernel: tsk->{mm,active_mm}->pgd = fc06cc00 
Nov 19 18:18:36 sparq kernel:               \|/ ____ \|/ 
Nov 19 18:18:36 sparq kernel:               "@'/ ,. \`@" 
Nov 19 18:18:36 sparq kernel:               /_| \__/ |_\ 
Nov 19 18:18:36 sparq kernel:                  \__U_/ 
Nov 19 18:18:36 sparq kernel: dd(2758): Oops 
Nov 19 18:18:36 sparq kernel: PSR: 409010c2 PC: f00acce8 NPC: f00accec Y: 00000000 
Nov 19 18:18:36 sparq kernel: g0: f461df08 g1: 40801fa2 g2: 0000ffff g3: 00029000 g4: f0053f30 g5: 72650000 g6: f461c000 g7: 00000200 
Nov 19 18:18:36 sparq kernel: o0: 00029000 o1: 00029000 o2: 00000000 o3: f4c45ca0 o4: 00000000 o5: 0000ffff sp: f461df08 o7: f0052b90 
Nov 19 18:18:36 sparq kernel: l0: f4c45c80 l1: 00000aae l2: 5003bd3e l3: 50029d28 l4: 500322a8 l5: 00000557 l6: 5002cd38 l7: 50028cb4 
Nov 19 18:18:36 sparq kernel: i0: ffffffea i1: 00029000 i2: 00000001 i3: 5004f99c i4: 00000008 i5: 50089558 fp: f461df70 i7: f00151dc 
Nov 19 18:18:36 sparq kernel: Caller[f00151dc] 
Nov 19 18:18:36 sparq kernel: Caller[000138fc] 
Nov 19 18:18:36 sparq kernel: Instruction DUMP: 38800012  84102000  9a100002 <c40b0000> c42a0000  86100000  80a0e000  06bffff1  8410000a  

>>PC;  f00acce8 <read_port+60/b0>   <=====
>>O7;  f0052b90 <sys_read+c4/110>
>>I7;  f00151dc <syscall_is_too_hard+34/40>
Trace; f00151dc <syscall_is_too_hard+34/40>
Trace; 000138fc Before first symbol
Code;  f00accdc <read_port+54/b0>
0000000000000000 <_PC>:
Code;  f00accdc <read_port+54/b0>
   0:   38 80 00 12       bgu,a   48 <_PC+0x48> f00acd24 <read_port+9c/b0>
Code;  f00acce0 <read_port+58/b0>
   4:   84 10 20 00       clr  %g2
Code;  f00acce4 <read_port+5c/b0>
   8:   9a 10 00 02       mov  %g2, %o5
Code;  f00acce8 <read_port+60/b0>   <=====
   c:   c4 0b 00 00       ldub  [ %o4 ], %g2   <=====
Code;  f00accec <read_port+64/b0>
  10:   c4 2a 00 00       stb  %g2, [ %o0 ]
Code;  f00accf0 <read_port+68/b0>
  14:   86 10 00 00       mov  %g0, %g3
Code;  f00accf4 <read_port+6c/b0>
  18:   80 a0 e0 00       cmp  %g3, 0
Code;  f00accf8 <read_port+70/b0>
  1c:   06 bf ff f1       bl  ffffffffffffffe0 <_PC+0xffffffffffffffe0> f00accbc <read_port+34/b0>
Code;  f00accfc <read_port+74/b0>
  20:   84 10 00 0a       mov  %o2, %g2

Nov 19 18:19:19 sparq kernel: Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 00000ac4 
Nov 19 18:19:19 sparq kernel: tsk->{mm,active_mm}->pgd = fc06cc00 
Nov 19 18:19:19 sparq kernel:               \|/ ____ \|/ 
Nov 19 18:19:19 sparq kernel:               "@'/ ,. \`@" 
Nov 19 18:19:19 sparq kernel:               /_| \__/ |_\ 
Nov 19 18:19:19 sparq kernel:                  \__U_/ 
Nov 19 18:19:19 sparq kernel: cat(2763): Oops 
Nov 19 18:19:19 sparq kernel: PSR: 409010c2 PC: f00acce8 NPC: f00accec Y: 05000000 
Nov 19 18:19:19 sparq kernel: g0: 21a00001 g1: 40801fa2 g2: 0000ffff g3: 00022210 g4: f0053f30 g5: 006c642d g6: f461c000 g7: 00000200 
Nov 19 18:19:19 sparq kernel: o0: 00022210 o1: 00022210 o2: 00000fff o3: f4431aa0 o4: 00000000 o5: 0000ffff sp: f461df08 o7: f0052b90 
Nov 19 18:19:19 sparq kernel: l0: f4431a80 l1: 50080e5c l2: 5008043c l3: 00000020 l4: 03015701 l5: 00000000 l6: 00000000 l7: 50028cb4 
Nov 19 18:19:19 sparq kernel: i0: ffffffea i1: 00022210 i2: 00001000 i3: 00011b6c i4: 00000000 i5: fffff000 fp: f461df70 i7: f00151dc 
Nov 19 18:19:19 sparq kernel: Caller[f00151dc] 
Nov 19 18:19:19 sparq kernel: Caller[00011610] 
Nov 19 18:19:19 sparq kernel: Instruction DUMP: 38800012  84102000  9a100002 <c40b0000> c42a0000  86100000  80a0e000  06bffff1  8410000a  

>>PC;  f00acce8 <read_port+60/b0>   <=====
>>O7;  f0052b90 <sys_read+c4/110>
>>I7;  f00151dc <syscall_is_too_hard+34/40>
Trace; f00151dc <syscall_is_too_hard+34/40>
Trace; 00011610 Before first symbol
Code;  f00accdc <read_port+54/b0>
0000000000000000 <_PC>:
Code;  f00accdc <read_port+54/b0>
   0:   38 80 00 12       bgu,a   48 <_PC+0x48> f00acd24 <read_port+9c/b0>
Code;  f00acce0 <read_port+58/b0>
   4:   84 10 20 00       clr  %g2
Code;  f00acce4 <read_port+5c/b0>
   8:   9a 10 00 02       mov  %g2, %o5
Code;  f00acce8 <read_port+60/b0>   <=====
   c:   c4 0b 00 00       ldub  [ %o4 ], %g2   <=====
Code;  f00accec <read_port+64/b0>
  10:   c4 2a 00 00       stb  %g2, [ %o0 ]
Code;  f00accf0 <read_port+68/b0>
  14:   86 10 00 00       mov  %g0, %g3
Code;  f00accf4 <read_port+6c/b0>
  18:   80 a0 e0 00       cmp  %g3, 0
Code;  f00accf8 <read_port+70/b0>
  1c:   06 bf ff f1       bl  ffffffffffffffe0 <_PC+0xffffffffffffffe0> f00accbc <read_port+34/b0>
Code;  f00accfc <read_port+74/b0>
  20:   84 10 00 0a       mov  %o2, %g2


1 warning issued.  Results may not be reliable.
[wakko@sparq:/home/wakko] 

--u3/rZRmxL6MmkK24--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
