Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314352AbSEIUz7>; Thu, 9 May 2002 16:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314358AbSEIUz4>; Thu, 9 May 2002 16:55:56 -0400
Received: from [147.91.26.2] ([147.91.26.2]:46047 "EHLO alfa.mas.bg.ac.yu")
	by vger.kernel.org with ESMTP id <S314352AbSEIUzW>;
	Thu, 9 May 2002 16:55:22 -0400
Date: Thu, 9 May 2002 22:55:06 +0200 (CEST)
From: Goran Gajic <ggajic@alfa.mas.bg.ac.yu>
To: <linux-kernel@vger.kernel.org>
Subject: Oops with 2.4.18
Message-ID: <Pine.LNX.4.33.0205092231360.18003-100000@alfa.mas.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, I have encountered two oops with 2.4.18 so far. First one was with
kswapd (I don't have trace), second one with umount (both at reboot).
I have used gcc version egcs-2.91.66, and binutils  2.9.1.0.25 to build
kernel. On machine I have problems so far I have used 2.2.17 (which worked
ok for long time). BTW. I also have SGI xfs patch applied (since I plan to
use xfs) but I don;t have any xfs partitions so far..

gg.


Unable to handle kernel paging request at virtual address 6769736e
c013ed4c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013ed4c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a87
eax: c69e3878   ebx: 6769736e   ecx: 6769736e   edx: c6963778
esi: c12c3038   edi: 00000000   ebp: c12c3000   esp: c7e55f40
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 556, stackpage=c7e55000)
Stack: c12c3000 c12c3038 00000000 00000000 c01336d0 c12c3000 c12c3000 c12c3038
       c014234f c12c3000 00000001 00000000 ffffffff c75da000 c7e55f98 8ffffda8
       c0142472 c12062e0 00000000 c7e54000 0804f792 0804c817 c127f420 c12062e0
Call Trace: [<c01336d0>] [<c014234f>] [<c0142472>] [<c0142498>] [<c0106c03>]
Code: 8b 09 39 6b 38 75 ef 8b 13 8b 43 04 89 42 04 89 10 a1 68 1f


>>EIP; c013ed4c <shrink_dcache_sb+18/144>   <=====

>>eax; c69e3878 <END_OF_CODE+667db74/????>
>>ebx; 6769736e Before first symbol
>>ecx; 6769736e Before first symbol
>>edx; c6963778 <END_OF_CODE+65fda74/????>
>>esi; c12c3038 <END_OF_CODE+f5d334/????>
>>ebp; c12c3000 <END_OF_CODE+f5d2fc/????>
>>esp; c7e55f40 <END_OF_CODE+7af023c/????>

Trace; c01336d0 <do_remount_sb+50/d8>
Trace; c014234f <do_umount+6b/f0>
Trace; c0142472 <sys_umount+9e/b8>
Trace; c0142498 <sys_oldumount+c/10>
Trace; c0106c03 <system_call+33/40>

Code;  c013ed4c <shrink_dcache_sb+18/144>
00000000 <_EIP>:
Code;  c013ed4c <shrink_dcache_sb+18/144>   <=====
   0:   8b 09             movl   (%ecx),%ecx   <=====
Code;  c013ed4e <shrink_dcache_sb+1a/144>
   2:   39 6b 38          cmpl   %ebp,0x38(%ebx)
Code;  c013ed51 <shrink_dcache_sb+1d/144>
   5:   75 ef             jne    fffffff6 <_EIP+0xfffffff6> c013ed42 <shrink_dcache_sb+e/144>
Code;  c013ed53 <shrink_dcache_sb+1f/144>
   7:   8b 13             movl   (%ebx),%edx
Code;  c013ed55 <shrink_dcache_sb+21/144>
   9:   8b 43 04          movl   0x4(%ebx),%eax
Code;  c013ed58 <shrink_dcache_sb+24/144>
   c:   89 42 04          movl   %eax,0x4(%edx)
Code;  c013ed5b <shrink_dcache_sb+27/144>
   f:   89 10             movl   %edx,(%eax)
Code;  c013ed5d <shrink_dcache_sb+29/144>
  11:   a1 68 1f 00 00    movl   0x1f68,%eax



