Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTBKVW2>; Tue, 11 Feb 2003 16:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbTBKVW2>; Tue, 11 Feb 2003 16:22:28 -0500
Received: from [62.32.26.18] ([62.32.26.18]:62736 "EHLO gate.rola.local")
	by vger.kernel.org with ESMTP id <S266615AbTBKVWZ>;
	Tue, 11 Feb 2003 16:22:25 -0500
Date: Tue, 11 Feb 2003 22:31:13 +0100 (CET)
From: Martin Furter <mf@rola.ch>
To: linux-kernel@vger.kernel.org
Subject: usb ftdi_sio kernel 2.4.20 panic
Message-ID: <Pine.LNX.4.21.0302112220540.24477-100000@gate.rola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all!

I connected the USB-Serial Converter via a nullmodem cable to ttyS0 and
the isuued the following commands:
tty1> cat /dev/ttyS0
tty2> echo hello > /dev/ttyUSB0
The I get a kernel panic, the output of ksymoops is included.

Please have a look at it even when my kernel is tainted.
The non-GPL modules are the ones from VMWare, Win4Lin and the NVidia
GForce driver.
But the oops happens also on the laptop of a friend and on another machine
which both have standard kernels without any nonstandard kernel modules.

Thanks in advance
Tinu



ksymoops 2.4.6 on i686 2.4.20-w4l.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-w4l/ (default)
     -m /boot/System.map-2.4.20-w4l (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_ksyms_lsmod): module Mvnetint is in lsmod but not in ksyms, probably no symbols exported
Warning (map_ksym_to_module): cannot match loaded module Mvnetd to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mvnet to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mvw to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mvmouse to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mvkbd to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mvgic to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mvdsp to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mserial to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mmpip to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module Mmerge to a unique module object.  Trace may not be reliable.
Unable to handle kernel paging request at virtual address fffffffc
c01157f8
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    1010:[<c01157f8>]    Tainted:  PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010013
eax: dffe1e9c   ebx: 00000000   ecx: 00000001   edx: 00000001
esi: deb2081c   edi: 00000001   ebp: c0269ed4   esp: c0269ebc
ds: 1018   es: 1018   ss: 1018
Process swapper (pid: 0, stackpage=c0269000)
Stack: 00000030 deb2081c ddc3a000 dffe1e9c 00000282 00000001 00000002 e0898ef7
       00000000 dec2ca00 00000000 00000286 deb20800 dffe1d80 00000286 dffe1e80
       e088daaa dec2ca00 debb8268 00000282 c15a7d18 c15a7c80 00000000 00000000
Call Trace:    [<e0898ef7>] [<e088daaa>] [<e088db5a>] [<e088dcb9>] [<c0108fad>]
  [<c0109116>] [<c01062a0>] [<c01062a0>] [<c010b258>] [<c01062a0>] [<c01062a0>]
  [<c01062c3>] [<c0106329>] [<c01060a7>]
Code: 8b 4b fc 8b 01 85 45 fc 74 4e 31 c0 9c 5e fa c7 01 00 00 00


>>EIP; c01157f8 <__wake_up+28/98>   <=====

>>eax; dffe1e9c <_end+1fd328f0/20568a54>
>>esi; deb2081c <_end+1e871270/20568a54>
>>ebp; c0269ed4 <init_task_union+1ed4/2000>
>>esp; c0269ebc <init_task_union+1ebc/2000>

Trace; e0898ef7 <[ftdi_sio]ftdi_read_bulk_callback+18b/324>
Trace; e088daaa <[uhci]uhci_call_completion+132/1b0>
Trace; e088db5a <[uhci]uhci_finish_completion+32/4c>
Trace; e088dcb9 <[uhci]uhci_interrupt+b9/c4>
Trace; c0108fad <handle_IRQ_event+31/5c>
Trace; c0109116 <do_IRQ+6a/a8>
Trace; c01062a0 <default_idle+0/28>
Trace; c01062a0 <default_idle+0/28>
Trace; c010b258 <call_do_IRQ+5/d>
Trace; c01062a0 <default_idle+0/28>
Trace; c01062a0 <default_idle+0/28>
Trace; c01062c3 <default_idle+23/28>
Trace; c0106329 <cpu_idle+41/54>
Trace; c01060a7 <rest_init+27/28>

Code;  c01157f8 <__wake_up+28/98>
00000000 <_EIP>:
Code;  c01157f8 <__wake_up+28/98>   <=====
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=====
Code;  c01157fb <__wake_up+2b/98>
   3:   8b 01                     mov    (%ecx),%eax
Code;  c01157fd <__wake_up+2d/98>
   5:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0115800 <__wake_up+30/98>
   8:   74 4e                     je     58 <_EIP+0x58> c0115850 <__wake_up+80/98>
Code;  c0115802 <__wake_up+32/98>
   a:   31 c0                     xor    %eax,%eax
Code;  c0115804 <__wake_up+34/98>
   c:   9c                        pushf  
Code;  c0115805 <__wake_up+35/98>
   d:   5e                        pop    %esi
Code;  c0115806 <__wake_up+36/98>
   e:   fa                        cli    
Code;  c0115807 <__wake_up+37/98>
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

 <0>Kernel panic: Aiee, killing interrupt handler!

12 warnings issued.  Results may not be reliable.

