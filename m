Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRL0UxT>; Thu, 27 Dec 2001 15:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279981AbRL0UxN>; Thu, 27 Dec 2001 15:53:13 -0500
Received: from mail.uklinux.net ([80.84.72.21]:23308 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S281004AbRL0Uw5>;
	Thu, 27 Dec 2001 15:52:57 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Thu, 27 Dec 2001 20:51:09 +0000
From: Mark Hindley <mark@hindley.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Oops report
Message-ID: <20011227205109.A460@hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii

I have just had an oops with 1.4.17 on my Thinkpad 560E.

It seems to be related to the serial driver after removing a pcmcia modem card. The logs said:

Dec 27 20:35:01 mercury kernel: serial: failed to unregister serial driver (-16)Dec 27 20:35:01 mercury kernel: serial: failed to unregister callout driver (-16

The processed oops is attached. There seem to be a lot of them. I am not sure if they are all useful.

Let me know if you need any more info.


Mark


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.3.4 on i586 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Dec 27 20:35:02 mercury kernel: Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:02 mercury kernel: c0150e70
Dec 27 20:35:02 mercury kernel: *pde = 01094067
Dec 27 20:35:02 mercury kernel: Oops: 0000
Dec 27 20:35:02 mercury kernel: CPU:    0
Dec 27 20:35:02 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:02 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:02 mercury kernel: eax: 00000005   ebx: 00000000   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:02 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c137ff10
Dec 27 20:35:02 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:02 mercury kernel: Process sh (pid: 3511, stackpage=c137f000)
Dec 27 20:35:02 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000500 ffffffed c1bfc5c0 c1bb1460 c1085320 
Dec 27 20:35:02 mercury kernel:        ffffffeb c1bb1460 c137ff8c c0132487 c1bb1460 c012ae5c 00000005 00000000 
Dec 27 20:35:02 mercury kernel:        c1bfc5c0 c1bb1460 00000000 c0129fc0 c1bb1460 c1bfc5c0 00008802 c05d1000 
Dec 27 20:35:02 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:02 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 
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

Dec 27 20:35:04 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:04 mercury kernel: c0150e70
Dec 27 20:35:04 mercury kernel: *pde = 01094067
Dec 27 20:35:04 mercury kernel: Oops: 0000
Dec 27 20:35:04 mercury kernel: CPU:    0
Dec 27 20:35:04 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:04 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:04 mercury kernel: eax: 00000005   ebx: 00000000   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:04 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c1821f10
Dec 27 20:35:04 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:04 mercury kernel: Process sh (pid: 3512, stackpage=c1821000)
Dec 27 20:35:04 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000500 ffffffed c13d1520 c1bb1460 c1085320 
Dec 27 20:35:04 mercury kernel:        ffffffeb c1bb1460 c1821f8c c0132487 c1bb1460 c012ae5c 00000005 00000000 
Dec 27 20:35:04 mercury kernel:        c13d1520 c1bb1460 00000000 c0129fc0 c1bb1460 c13d1520 00008802 c1719000 
Dec 27 20:35:04 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:04 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:06 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:06 mercury kernel: c0150e70
Dec 27 20:35:06 mercury kernel: *pde = 01094067
Dec 27 20:35:06 mercury kernel: Oops: 0000
Dec 27 20:35:06 mercury kernel: CPU:    0
Dec 27 20:35:06 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:06 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:06 mercury kernel: eax: 00000005   ebx: 00000000   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:06 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c1821f10
Dec 27 20:35:06 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:06 mercury kernel: Process sh (pid: 3513, stackpage=c1821000)
Dec 27 20:35:06 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000500 ffffffed c1bfc440 c1bb1460 c1085320 
Dec 27 20:35:06 mercury kernel:        ffffffeb c1bb1460 c1821f8c c0132487 c1bb1460 c012ae5c 00000005 00000000 
Dec 27 20:35:06 mercury kernel:        c1bfc440 c1bb1460 00000000 c0129fc0 c1bb1460 c1bfc440 00008802 c17c6000 
Dec 27 20:35:06 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:06 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:08 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:08 mercury kernel: c0150e70
Dec 27 20:35:08 mercury kernel: *pde = 01094067
Dec 27 20:35:08 mercury kernel: Oops: 0000
Dec 27 20:35:08 mercury kernel: CPU:    0
Dec 27 20:35:08 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:08 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:08 mercury kernel: eax: 00000005   ebx: 00000000   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:08 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c19d3f10
Dec 27 20:35:08 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:08 mercury kernel: Process sh (pid: 3514, stackpage=c19d3000)
Dec 27 20:35:08 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000500 ffffffed c180e1c0 c1bb1460 c1085320 
Dec 27 20:35:09 mercury kernel:        ffffffeb c1bb1460 c19d3f8c c0132487 c1bb1460 c012ae5c 00000005 00000000 
Dec 27 20:35:09 mercury kernel:        c180e1c0 c1bb1460 00000000 c0129fc0 c1bb1460 c180e1c0 00008802 c1ed9000 
Dec 27 20:35:09 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:09 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:11 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:11 mercury kernel: c0150e70
Dec 27 20:35:11 mercury kernel: *pde = 01094067
Dec 27 20:35:11 mercury kernel: Oops: 0000
Dec 27 20:35:11 mercury kernel: CPU:    0
Dec 27 20:35:11 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:11 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:11 mercury kernel: eax: 00000005   ebx: 00000000   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:11 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c19d3f10
Dec 27 20:35:11 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:11 mercury kernel: Process sh (pid: 3516, stackpage=c19d3000)
Dec 27 20:35:11 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000500 ffffffed c10e2f20 c1bb1460 c1085320 
Dec 27 20:35:11 mercury kernel:        ffffffeb c1bb1460 c19d3f8c c0132487 c1bb1460 c012ae5c 00000005 00000000 
Dec 27 20:35:11 mercury kernel:        c10e2f20 c1bb1460 00000000 c0129fc0 c1bb1460 c10e2f20 00008802 c1821000 
Dec 27 20:35:11 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:11 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:13 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:13 mercury kernel: c0150e70
Dec 27 20:35:13 mercury kernel: *pde = 01094067
Dec 27 20:35:13 mercury kernel: Oops: 0000
Dec 27 20:35:13 mercury kernel: CPU:    0
Dec 27 20:35:13 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:13 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:13 mercury kernel: eax: 00000005   ebx: 00000000   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:13 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c19d3f10
Dec 27 20:35:13 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:13 mercury kernel: Process sh (pid: 3518, stackpage=c19d3000)
Dec 27 20:35:13 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000500 ffffffed c10e2c20 c1bb1460 c1085320 
Dec 27 20:35:13 mercury kernel:        ffffffeb c1bb1460 c19d3f8c c0132487 c1bb1460 c012ae5c 00000005 00000000 
Dec 27 20:35:13 mercury kernel:        c10e2c20 c1bb1460 00000000 c0129fc0 c1bb1460 c10e2c20 00008802 c14cc000 
Dec 27 20:35:13 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:13 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000000   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c19d3f10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process sh (pid: 3519, stackpage=c19d3000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000500 ffffffed c0381460 c1bb1460 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c1bb1460 c19d3f8c c0132487 c1bb1460 c012ae5c 00000005 00000000 
Dec 27 20:35:15 mercury kernel:        c0381460 c1bb1460 00000000 c0129fc0 c1bb1460 c0381460 00008802 c149d000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3523, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c1bfc640 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c1bfc640 c10b09c0 00000000 c0129fc0 c10b09c0 c1bfc640 00000902 c1b14000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3524, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c032ea20 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c032ea20 c10b09c0 00000000 c0129fc0 c10b09c0 c032ea20 00000902 c1f48000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3525, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c0381ee0 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c0381ee0 c10b09c0 00000000 c0129fc0 c10b09c0 c0381ee0 00000902 c1385000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3526, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c10e23a0 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c10e23a0 c10b09c0 00000000 c0129fc0 c10b09c0 c10e23a0 00000902 c160d000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3527, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c13acbc0 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c13acbc0 c10b09c0 00000000 c0129fc0 c10b09c0 c13acbc0 00000902 c1ee1000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3528, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c0381ae0 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c0381ae0 c10b09c0 00000000 c0129fc0 c10b09c0 c0381ae0 00000902 c1aef000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3529, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c180e340 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c180e340 c10b09c0 00000000 c0129fc0 c10b09c0 c180e340 00000902 c1fe7000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3530, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c14725a0 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c14725a0 c10b09c0 00000000 c0129fc0 c10b09c0 c14725a0 00000902 c1b55000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3531, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c180e2c0 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c180e2c0 c10b09c0 00000000 c0129fc0 c10b09c0 c180e2c0 00000902 c12d4000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c115ff10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 3532, stackpage=c115f000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c0381f60 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c115ff8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c0381f60 c10b09c0 00000000 c0129fc0 c10b09c0 c0381f60 00000902 c1516000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <1>Unable to handle kernel paging request at virtual address c2820ab0
Dec 27 20:35:15 mercury kernel: c0150e70
Dec 27 20:35:15 mercury kernel: *pde = 01094067
Dec 27 20:35:15 mercury kernel: Oops: 0000
Dec 27 20:35:15 mercury kernel: CPU:    0
Dec 27 20:35:15 mercury kernel: EIP:    0010:[get_tty_driver+36/84]    Not tainted
Dec 27 20:35:15 mercury kernel: EFLAGS: 00010286
Dec 27 20:35:15 mercury kernel: eax: 00000005   ebx: 00000001   ecx: c01e9ae0   edx: c2820aa0
Dec 27 20:35:15 mercury kernel: esi: 00000005   edi: 00000005   ebp: c02345e4   esp: c1093f10
Dec 27 20:35:15 mercury kernel: ds: 0018   es: 0018   ss: 0018
Dec 27 20:35:15 mercury kernel: Process init (pid: 1, stackpage=c1093000)
Dec 27 20:35:15 mercury kernel: Stack: c01e9ae0 00000028 c012acf1 00000501 ffffffed c0381760 c10b09c0 c1085320 
Dec 27 20:35:15 mercury kernel:        ffffffeb c10b09c0 c1093f8c c0132487 c10b09c0 c012ae5c 00000005 00000001 
Dec 27 20:35:15 mercury kernel:        c0381760 c10b09c0 00000000 c0129fc0 c10b09c0 c0381760 00000901 c17fe000 
Dec 27 20:35:15 mercury kernel: Call Trace: [get_chrfops+105/212] [permission+43/48] [chrdev_open+40/84] [dentry_open+228/388] [filp_open+74/84] 
Dec 27 20:35:15 mercury kernel: Code: 0f bf 42 10 39 f0 75 18 0f bf 4a 12 39 cb 7c 10 0f bf 42 14 

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

Dec 27 20:35:15 mercury kernel:  <0>Kernel panic: Attempted to kill init!

1 warning issued.  Results may not be reliable.

--Dxnq1zWXvFF0Q93v--
