Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285691AbRLYS1K>; Tue, 25 Dec 2001 13:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbRLYS1B>; Tue, 25 Dec 2001 13:27:01 -0500
Received: from p50801997.dip.t-dialin.net ([80.128.25.151]:6404 "EHLO
	asok.cccrewhome.de") by vger.kernel.org with ESMTP
	id <S285691AbRLYS0n>; Tue, 25 Dec 2001 13:26:43 -0500
Mime-Version: 1.0
Message-Id: <p05100300b84e73ad5e5f@[192.168.100.2]>
Date: Tue, 25 Dec 2001 19:26:35 +0100
To: linux-kernel@vger.kernel.org
From: Sebastian Wenleder <Sebastian@wenleder.de>
Subject: 2.4.17-rc2 oops
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I received this oops after approx. 4 days uptime...
gcc --version = 2.95.3

-
ksymoops 2.4.1 on i686 2.4.17-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc2/ (default)
     -m /boot/System.map-2.4.17-rc2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Dec 25 18:48:22 asok kernel: Unable to handle kernel paging request at virtual address 63697233
Dec 25 18:48:22 asok kernel: c013a000
Dec 25 18:48:22 asok kernel: *pde = 00000000
Dec 25 18:48:22 asok kernel: Oops: 0000
Dec 25 18:48:22 asok kernel: CPU:    0
Dec 25 18:48:22 asok kernel: EIP:    0010:[prune_dcache+16/328]    Not tainted
Dec 25 18:48:22 asok kernel: EFLAGS: 00010a83
Dec 25 18:48:22 asok kernel: eax: 00000300   ebx: 6369722f   ecx: 00000006   edx: 00000000
Dec 25 18:48:22 asok kernel: esi: 000001d2   edi: 00000020   ebp: 00000300   esp: c5083e0c
Dec 25 18:48:22 asok kernel: ds: 0018   es: 0018   ss: 0018
Dec 25 18:48:22 asok kernel: Process setiathome (pid: 22765, stackpage=c5083000)
Dec 25 18:48:22 asok kernel: Stack: 00000017 000001d2 00000020 00000006 c013a38b 00000300 c0124b60 00000006
Dec 25 18:48:22 asok kernel:        000001d2 00000006 000001d2 c02af6c8 c02af6c8 c02af6c8 c0124b9c 00000020
Dec 25 18:48:22 asok kernel:        c5082000 00000000 000001d2 c012556f c02af844 00000100 00000010 00000000
Dec 25 18:48:22 asok kernel: Call Trace: [shrink_dcache_memory+27/52] [shrink_caches+108/132] [try_to_free_pages+36/68] [balance_classzone+103/564] [__alloc_pages+262/356]
Dec 25 18:48:22 asok kernel: Code: 8b 53 04 8b 03 89 50 04 89 02 89 1b 89 5b 04 8d 73 e8 8b 46
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  00000003 Before first symbol
   3:   8b 03                     mov    (%ebx),%eax
Code;  00000005 Before first symbol
   5:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000008 Before first symbol
   8:   89 02                     mov    %eax,(%edx)
Code;  0000000a Before first symbol
   a:   89 1b                     mov    %ebx,(%ebx)
Code;  0000000c Before first symbol
   c:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  0000000f Before first symbol
   f:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  00000012 Before first symbol
  12:   8b 46 00                  mov    0x0(%esi),%eax


2 warnings issued.  Results may not be reliable.
