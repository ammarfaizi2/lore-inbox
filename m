Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRK0Nr7>; Tue, 27 Nov 2001 08:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279326AbRK0Nru>; Tue, 27 Nov 2001 08:47:50 -0500
Received: from mail.uklinux.net ([80.84.72.21]:37382 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S279313AbRK0Nrk>;
	Tue, 27 Nov 2001 08:47:40 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
From: Mark Hindley <mark@hindley.uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15363.39202.69338.550438@mercury.home.hindley.uklinux.net>
Date: Tue, 27 Nov 2001 13:46:10 +0000 (GMT)
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been experiencing periodic hangs on my Thinkpad 560E with the
last few kernels. It usually happens when changing consoles.

Finally, I got an oops today rather than a hang requiring a reset with
nothing in the logs.

Exactly the same think provoked it: changing VT

Let me know if you want more info.

Mark


ksymoops 2.3.4 on i586 2.4.15-greased-turkey.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-greased-turkey/ (default)
     -m /boot/System.map-2.4.15-greased-turkey (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Nov 27 09:50:02 mercury kernel: Unable to handle kernel paging request at virtual address c2820ab0
Nov 27 09:50:02 mercury kernel: c0150e40
Nov 27 09:50:02 mercury kernel: *pde = 01094067
Nov 27 09:50:02 mercury kernel: Oops: 0000
Nov 27 09:50:02 mercury kernel: CPU:    0
Nov 27 09:50:02 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Nov 27 09:50:02 mercury kernel: EFLAGS: 00010286
Nov 27 09:50:02 mercury kernel: eax: 00000005   ebx: 00000000   ecx: c01e99c0   edx: c2820aa0
Nov 27 09:50:02 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c1d57f10
Nov 27 09:50:02 mercury kernel: ds: 0018   es: 0018   ss: 0018
Nov 27 09:50:02 mercury kernel: Process sh (pid: 24739, stackpage=c1d57000)
Nov 27 09:50:02 mercury kernel: Stack: c01e99c0 00000028 c012ace1 00000500 ffffffed c137c5e0 c1fbc0e0 c1085320 
Nov 27 09:50:02 mercury kernel:        ffffffeb c1fbc0e0 c1d57f8c c0132467 c1fbc0e0 c012ae4c 00000005 00000000 
Nov 27 09:50:02 mercury kernel:        c137c5e0 c1fbc0e0 00000000 c0129fb0 c1fbc0e0 c137c5e0 00008802 c19fb000 
Nov 27 09:50:02 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Nov 27 09:50:02 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f bf 42 10               movswl 0x10(%edx),%eax
Code;  00000004 Before first symbol
   4:   39 f0                     cmp    %esi,%eax
Code;  00000006 Before first symbol
   6:   75 18                     jne    20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000008 Before first symbol
   8:   0f bf 4a 12               movswl 0x12(%edx),%ecx
Code;  0000000c Before first symbol
   c:   39 cb                     cmp    %ecx,%ebx
Code;  0000000e Before first symbol
   e:   7c 10                     jl     20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000010 Before first symbol
  10:   0f bf 42 14               movswl 0x14(%edx),%eax


Nov 27 09:55:32 mercury kernel:  <0>Kernel panic: Attempted to kill init!

1 warning issued.  Results may not be reliable.
