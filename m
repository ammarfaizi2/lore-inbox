Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVDEDz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVDEDz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 23:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVDEDz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 23:55:58 -0400
Received: from mails.tsinghua.edu.cn ([166.111.8.16]:64178 "HELO
	mails.tsinghua.edu.cn") by vger.kernel.org with SMTP
	id S261482AbVDEDyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 23:54:40 -0400
Message-ID: <312672713.10161@mails.tsinghua.edu.cn>
X-WebMAIL-MUA: [221.216.162.30]
From: sns_main@mails.tsinghua.edu.cn
To: linux-kernel@vger.kernel.org
Date: Tue, 05 Apr 2005 11:45:13 +0800
Reply-To: sns_main@mails.tsinghua.edu.cn
X-Priority: 3
Subject: help with the result of ksymoops < oops.txt
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.9 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle Kernel paging request at virtual address 2f087844
c01fbbb1
*pde = 00000000
Oops: 0002
eax: 00000001 ebx: f3dc53f0 ecx: 05ec108e edx: c0354000
esi: e9a9ca80 edi: 0000003f ebp: f62125e8 esp: c0355f18
ds: 0018 es: 0018 ss: 0018
Stack:  00000001 d442a080 0000003f f7ece000 f7ece1f0 00000000 f7ede160 00000000
        f7ece2f8 c01fb897 f7ece160 f7ece000 f5fe0a80 14000001 00000000 c0355fa0
        c0108fd9 00000012 f7ece000 c0355fa0 c0374300 00000012 f5fe0a80 00009000
Call Trace: [<c01fb897>] [<c0108fd9>] [<c01091f8>] [<c01053d0>] [<c010bd88>]
        [<c01053d0>] [<c01053f9>] [<c0105492>] [<c0105000>]
Code: 00 8b 54 24 2c 3b 7a 0c 0f 44 f8 89 fd c1 e5 04 8b 02 01 05
Using defaults from ksymoops -t elf32-i386 -a i386


>>edx; c0354000 <pci_vendor_list+4a80/4ea0>
>>esp; c0355f18 <udp_protocol+0/18>

Trace; c01fb897 <e1000_intr+57/c0>
Trace; c0108fd9 <handle_IRQ_event+79/b0>
Trace; c01091f8 <do_IRQ+98/f0>
Trace; c01053d0 <default_idle+0/50>
Trace; c010bd88 <call_do_IRQ+5/d>
Trace; c01053d0 <default_idle+0/50>
Trace; c01053f9 <default_idle+29/50>
Trace; c0105492 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   00 8b 54 24 2c 3b         add    %cl,0x3b2c2454(%ebx)
Code;  00000006 Before first symbol
   6:   7a 0c                     jp     14 <_EIP+0x14>
Code;  00000008 Before first symbol
   8:   0f 44 f8                  cmove  %eax,%edi
Code;  0000000b Before first symbol
   b:   89 fd                     mov    %edi,%ebp
Code;  0000000d Before first symbol
   d:   c1 e5 04                  shl    $0x4,%ebp
Code;  00000010 Before first symbol
  10:   8b 02                     mov    (%edx),%eax
Code;  00000012 Before first symbol
  12:   01 05 00 00 00 00         add    %eax,0x0

<0>Kernel panic: Aiee, killing interrupts handler!

1 warning and 1 error issued.  Results may not be reliable.


