Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSKRTwP>; Mon, 18 Nov 2002 14:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSKRTwP>; Mon, 18 Nov 2002 14:52:15 -0500
Received: from tantale.fifi.org ([216.27.190.146]:25221 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S264815AbSKRTwM>;
	Mon, 18 Nov 2002 14:52:12 -0500
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: 2.2.20-pre11: oops in sys_sigsuspend
From: Philippe Troin <phil@fifi.org>
Date: 18 Nov 2002 11:59:07 -0800
Message-ID: <87d6p2wsxg.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seen on:

Linux tantale 2.4.20-pre11 #1 SMP Tue Oct 15 21:37:01 PDT 2002 i686 unknown

which is a dual-PPro box.

ksymoops 2.4.5 on i686 2.4.20-pre11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre11/ (default)
     -m /boot/System.map-2.4.20-pre11 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Nov 15 16:37:22 tantale kernel: Unable to handle kernel paging request at virtual address fffffffc
Nov 15 16:37:22 tantale kernel: c01062fb
Nov 15 16:37:22 tantale kernel: *pde = 00003063
Nov 15 16:37:22 tantale kernel: Oops: 0002
Nov 15 16:37:22 tantale kernel: CPU:    1
Nov 15 16:37:22 tantale kernel: EIP:    0010:[sys_sigsuspend+83/160]    Not tainted
Nov 15 16:37:22 tantale kernel: EFLAGS: 00010296
Nov 15 16:37:22 tantale kernel: eax: fffffffc   ebx: c9896000   ecx: 00000010   edx: fffffffc
Nov 15 16:37:22 tantale kernel: esi: 00000000   edi: 00000000   ebp: bffff00c   esp: c9897fc4
Nov 15 16:37:22 tantale kernel: ds: 0018   es: 0018   ss: 0018
Nov 15 16:37:22 tantale kernel: Process ping (pid: 18866, stackpage=c9897000)
Nov 15 16:37:22 tantale kernel: Stack: 00000011 bfffdf04 000003e8 00000000 00000000 bffff00c 00000066 0000002b 
Nov 15 16:37:22 tantale kernel:        0000002b 00000066 40102892 00000023 00000293 bfffdf00 0000002b 
Nov 15 16:37:22 tantale kernel: Call Trace:   
Nov 15 16:37:22 tantale kernel: Code: 00 00 0b 98 78 06 00 00 0f 95 c2 89 d1 83 e1 01 89 48 08 c6 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; fffffffc <END_OF_CODE+2f68815d/????>
>>ebx; c9896000 <_end+9582df4/104f0df4>
>>edx; fffffffc <END_OF_CODE+2f68815d/????>
>>ebp; bffff00c Before first symbol
>>esp; c9897fc4 <_end+9584db8/104f0df4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   00 00                     add    %al,(%eax)
Code;  00000002 Before first symbol
   2:   0b 98 78 06 00 00         or     0x678(%eax),%ebx
Code;  00000008 Before first symbol
   8:   0f 95 c2                  setne  %dl
Code;  0000000b Before first symbol
   b:   89 d1                     mov    %edx,%ecx
Code;  0000000d Before first symbol
   d:   83 e1 01                  and    $0x1,%ecx
Code;  00000010 Before first symbol
  10:   89 48 08                  mov    %ecx,0x8(%eax)
Code;  00000013 Before first symbol
  13:   c6 00 00                  movb   $0x0,(%eax)


1 warning issued.  Results may not be reliable.
