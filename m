Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbTAVMUZ>; Wed, 22 Jan 2003 07:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAVMUY>; Wed, 22 Jan 2003 07:20:24 -0500
Received: from smtp1.libero.it ([193.70.192.51]:56552 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S267445AbTAVMUX>;
	Wed, 22 Jan 2003 07:20:23 -0500
Message-Id: <5.1.0.14.2.20030122130105.00c47880@popmail.libero.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 22 Jan 2003 13:29:28 +0100
To: linux-kernel@vger.kernel.org
From: Visitor <visitors@libero.it>
Subject: Kernel panic: Attempted to kill the idle task!
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today is a good day to... oops
this is the ksymoops output

ksymoops 2.4.5 on i686 2.4.20.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.20/ (default)
      -m /boot/System.map-2.4.20 (default)
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
CPU:    0
EIP:    0010:[<c011472c>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 06e1c000   ebx: c2508a00   ecx: 00000000   edx: 00000000
esi: c3580000   edi: c7d07a00   ebp: c02bdfc8   esp: c02bdf98
ds: 0018    es: 0018    ss: 0018
Process swapper (pid: 0, stackpage=c02bd000)
Stack: c01052a0 c02bc000 c01052a0 c7d07a00 c02a4d20 00000000 00000000 00000001
        0000002e 00000000 c02bc000 c03079c0 0008e000 c010533e 00000000 000a0200
        c0105000 c0105050 c02be729 c0258860 00008000 00008000 00008000 00008000
Call Trace:        [<c01052a0>] [<c01052a0>] [<c010533e>] [<c0105000>] 
[<c0105050>]
Code: 0f 22 d8 e9 84 00 00 00 8b 45 f4 c1 e0 03 c7 80 04 64 30 c0

 >>EIP; c011472c <schedule+3b4/550>   <=====
 >>eax; 06e1c000 Before first symbol
 >>ebx; c2508a00 <_end+219fa24/8980024>
 >>esi; c3580000 <_end+3217024/8980024>
 >>edi; c7d07a00 <_end+799ea24/8980024>
 >>ebp; c02bdfc8 <init_task_union+1fc8/2000>
 >>esp; c02bdf98 <init_task_union+1f98/2000>
Trace; c01052a0 <default_idle+0/34>
Trace; c01052a0 <default_idle+0/34>
Trace; c010533e <cpu_idle+4a/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105050 <rest_init+50/54>
Code;  c011472c <schedule+3b4/550>
00000000 <_EIP>:
Code;  c011472c <schedule+3b4/550>   <=====
    0:   0f 22 d8                  mov    %eax,%cr3   <=====
Code;  c011472f <schedule+3b7/550>
    3:   e9 84 00 00 00            jmp    8c <_EIP+0x8c> c01147b8 
<schedule+440/550>
Code;  c0114734 <schedule+3bc/550>
    8:   8b 45 f4                  mov    0xfffffff4(%ebp),%eax
Code;  c0114737 <schedule+3bf/550>
    b:   c1 e0 03                  shl    $0x3,%eax
Code;  c011473a <schedule+3c2/550>
    e:   c7 80 04 64 30 c0 00      movl   $0x0,0xc0306404(%eax)
Code;  c0114741 <schedule+3c9/550>
   15:   00 00 00
  <0>Kernel panic: Attempted to kill the idle task!
1 warning issued.  Results may not be reliable.


My system is a dual pentium pro with 512k cache per processor
kernel is 2.4.20 running debian 3.0
thank you for any advice
bye
	Visik7

