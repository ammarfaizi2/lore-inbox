Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKNRUH>; Tue, 14 Nov 2000 12:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQKNRTq>; Tue, 14 Nov 2000 12:19:46 -0500
Received: from d61.interaccess.net ([216.85.64.61]:16645 "EHLO zaius.poa.net")
	by vger.kernel.org with ESMTP id <S129040AbQKNRTm>;
	Tue, 14 Nov 2000 12:19:42 -0500
Date: Tue, 14 Nov 2000 11:46:26 -0500 (EST)
From: Bill Triplett <billt@ifelse.org>
To: linux-kernel@vger.kernel.org
Subject: oops
Message-ID: <Pine.LNX.4.21.0011141140110.8740-100000@zaius.poa.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recent found an oops on one of our machines. Ignorant of the
oops-tracing.txt instructions included with the kernel, I rebooted the
offending machine without hesitation. Here is the oops text and output
from ksymoops.  ksymoops was run after the restart, so I don't know if
it's output will be helpful. I don't know much about C or kernel
development, but I will provide any other information about my system you
may reqire.

Kind regards,

Bill Triplett

Nov 13 16:33:00 elvis kernel: Unable to handle kernel paging request at
virtual address 8005003b 
Nov 13 16:33:00 elvis kernel: current->tss.cr3 = 0508f000, %%cr3 =
0508f000 
Nov 13 16:33:00 elvis kernel: *pde = 00000000 
Nov 13 16:33:00 elvis kernel: Oops: 0000 
Nov 13 16:33:00 elvis kernel: CPU:    0 
Nov 13 16:33:00 elvis kernel: EIP:    0010:[math_state_restore+2/44] 
Nov 13 16:33:00 elvis kernel: EFLAGS: 00010246 
Nov 13 16:33:00 elvis kernel: eax: 8005003b   ebx: c3268000
ecx: bfffe10c   edx: 00000018 
Nov 13 16:33:00 elvis kernel: esi: ffffffff   edi: bfffdf68
ebp: bfffdf50   esp: c3269fc8 
Nov 13 16:33:00 elvis kernel: ds: 0018   es: 0018   ss: 0018 
Nov 13 16:33:00 elvis kernel: Process sendmail (pid: 17424, process
nr: 10, stackpage=c3269000) 
Nov 13 16:33:00 elvis kernel: Stack: bfffe10c bfffdf66 ffffffff bfffdf68
bfffdf50 bfffdf68 0000002b 0000002b  
Nov 13 16:33:00 elvis kernel:        ffffffff 400a15b7 00000023 00010246
bfffdb84 0000002b  
Nov 13 16:33:00 elvis kernel: Call Trace:  
Nov 13 16:33:00 elvis kernel: Code: 38 00 e0 ff ff 21 e0 66 83 b8 b8 01 00
00 00 74 09 dd a0 fc  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   38 00                     cmp    %al,(%eax)
Code;  00000002 Before first symbol
   2:   e0 ff                     loopne 3 <_EIP+0x3> 00000003 Before
first symbol
Code;  00000004 Before first symbol
   4:   ff 21                     jmp    *(%ecx)
Code;  00000006 Before first symbol
   6:   e0 66                     loopne 6e <_EIP+0x6e> 0000006e Before
first symbol
Code;  00000008 Before first symbol
   8:   83 b8 b8 01 00 00 00      cmpl   $0x0,0x1b8(%eax)
Code;  0000000f Before first symbol
   f:   74 09                     je     1a <_EIP+0x1a> 0000001a Before
first symbol
Code;  00000011 Before first symbol
  11:   dd a0 fc 00 00 00         frstor 0xfc(%eax)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
