Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293712AbSCFRVm>; Wed, 6 Mar 2002 12:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293701AbSCFRVV>; Wed, 6 Mar 2002 12:21:21 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:22469 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S293704AbSCFRT7>; Wed, 6 Mar 2002 12:19:59 -0500
Date: Wed, 6 Mar 2002 18:10:01 +0100 (CET)
From: eduard.epi@t-online.de (Peter Bornemann)
To: <linux-kernel@vger.kernel.org>
Subject: Oops with kernel 2.4.19-pre2
Message-ID: <Pine.LNX.4.33.0203061730140.1450-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

today I got the following Oops in my logs (run through ksymoops):
ksymoops 2.4.2 on i686 2.4.19-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre2/ (default)
     -m /boot/System.map-2.4.19-pre2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar  6 02:38:00 eduard kernel: Unable to handle kernel paging request at
virtual address 5a5a5abe
Mar  6 02:38:00 eduard kernel: e0a7b0c5
Mar  6 02:38:00 eduard kernel: *pde = 00000000
Mar  6 02:38:00 eduard kernel: Oops: 0000
Mar  6 02:38:00 eduard kernel: CPU:    0
Mar  6 02:38:00 eduard kernel: EIP:    0010:[<e0a7b0c5>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Mar  6 02:38:00 eduard kernel: EFLAGS: 00010206
Mar  6 02:38:00 eduard kernel: eax: 00000000   ebx: 5a5a5a5a   ecx:
d8ceef28   edx: 00000000
Mar  6 02:38:00 eduard kernel: esi: 00000000   edi: 0000003f   ebp:
bfffed0c   esp: da6c9f40
Mar  6 02:38:00 eduard kernel: ds: 0018   es: 0018   ss: 0018
Mar  6 02:38:00 eduard kernel: Process rmmod (pid: 19906,
stackpage=da6c9000)
Mar  6 02:38:00 eduard kernel: Stack: c4b4edec e0a7f780 e5c8f000 e0a754cb
0000003f c4b4edec 0000003f c4b4ee84
Mar  6 02:38:00 eduard kernel:        c4b4edec e0a7f6e4 e0a75541 c4b4edec
c4b4edec fffffff0 e0a796b0 c4b4edec
Mar  6 02:38:00 eduard kernel:        e5c8f000 e5c8f6df 0000003f e5c8f0cf
e5c93b61 c01186f7 e5c8f000 fffffff0
Mar  6 02:38:00 eduard kernel: Call Trace: [<e0a7f780>] [<e0a754cb>]
[<e0a7f6e4>] [<e0a75541>] [<e0a796b0>]
Mar  6 02:38:00 eduard kernel:    [<e5c8f6df>] [<e5c8f0cf>] [<e5c93b61>]
[free_module+23/160] [sys_delete_module+247/448] [system_call+51/56]
Mar  6 02:38:00 eduard kernel: Code: 0f a3 7b 60 19 c0 85 c0 74 26 6a 00 57
8b 43 44 50 e8 15 09

>>EIP; e0a7b0c4 <[pppoe]__module_license+20/2c>   <=====
Trace; e0a7f780 <[isdn_bsdcomp].rodata.end+62/122>
Trace; e0a754ca <[snd-seq-midi].bss.end+37ac/72e2>
Trace; e0a7f6e4 <[isdn_bsdcomp].rodata.start+544/57e>
Trace; e0a75540 <[snd-seq-midi].bss.end+3822/72e2>
Trace; e0a796b0 <[pppox].bss.end+fa/1a4a>
Trace; e5c8f6de <END_OF_CODE+9ec80/????>
Trace; e5c8f0ce <END_OF_CODE+9e670/????>
Trace; e5c93b60 <END_OF_CODE+a3102/????>
Code;  e0a7b0c4 <[pppoe]__module_license+20/2c>
00000000 <_EIP>:
Code;  e0a7b0c4 <[pppoe]__module_license+20/2c>   <=====
   0:   0f a3 7b 60               bt     %edi,0x60(%ebx)   <=====
Code;  e0a7b0c8 <[pppoe]__module_license+24/2c>
   4:   19 c0                     sbb    %eax,%eax
Code;  e0a7b0ca <[pppoe]__module_license+26/2c>
   6:   85 c0                     test   %eax,%eax
Code;  e0a7b0cc <[pppoe]__module_license+28/2c>
   8:   74 26                     je     30 <_EIP+0x30> e0a7b0f4
<[pppoe]__get_item+24/60>
Code;  e0a7b0ce <[pppoe]__module_license+2a/2c>
   a:   6a 00                     push   $0x0
Code;  e0a7b0d0 <[pppoe]__get_item+0/60>
   c:   57                        push   %edi
Code;  e0a7b0d0 <[pppoe]__get_item+0/60>
   d:   8b 43 44                  mov    0x44(%ebx),%eax
Code;  e0a7b0d4 <[pppoe]__get_item+4/60>
  10:   50                        push   %eax
Code;  e0a7b0d4 <[pppoe]__get_item+4/60>
  11:   e8 15 09 00 00            call   92b <_EIP+0x92b> e0a7b9ee
<[pppoe]pppoe_connect+9e/280>


1 warning issued.  Results may not be reliable.

After this, the box became rather funny (lpd wouldn start, perl didn run),
so I preferred to reboot. Now the problem with this Oops is, that pppoe
should never be insmoded or rmmoded, for I am running ntpd over it, which
needs to be always connected to the net. So something may have tried to
remove pppoe while it was busy and it went bang. But why didn't it just
give the busy flag? And why is __module_license called during rmmod? Can it
by any chance have been taken for some isdn-module? I have my isdn-card
removed for the moment, but did not change the configuration, so the
modules are loaded but remain unused.
The kernel is flat 2.4.19-pre2, only the alsa-drivers went in.

This is the first time, this happened, I compiled 2.4.29-pre2 when it came
out and it has worked ever since.

Cheers

Peter B

