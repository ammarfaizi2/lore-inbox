Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289331AbSBJHeT>; Sun, 10 Feb 2002 02:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289336AbSBJHeJ>; Sun, 10 Feb 2002 02:34:09 -0500
Received: from h205n2fls34o809.telia.com ([217.208.95.205]:15566 "EHLO
	pizza.sajd.net") by vger.kernel.org with ESMTP id <S289331AbSBJHd7>;
	Sun, 10 Feb 2002 02:33:59 -0500
Message-ID: <3C662264.9090207@telia.com>
Date: Sun, 10 Feb 2002 08:33:56 +0100
From: Pawel Worach <pawel.worach@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020208
X-Accept-Language: en, en-us, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

during an cvs update of the mozilla source tree the machine oops'ed and 
hung hard. system is a abit bp6 with two intel celeron cpu's. this seems 
to be swap/cache related, memory has been tested with memtest86 without 
any faults

../Pawel

decoded oops:

VM: killing process sendmail
swap_free: Unused swap offset entry 00004000
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0149674
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[d_lookup+116/304]    Not tainted
EIP:    0010:[<c0149674>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: c1580000   ebx: fffffff0   ecx: 00000010   edx: d5139bab
esi: c6efb4e0   edi: c6ee2600   ebp: 00000000   esp: c28b1ee8
ds: 0018   es: 0018   ss: 0018
Process cvs (pid: 31350, stackpage=c28b1000)
Stack: c15e10c8 c4ff2008 d5139bab 00000007 c28b1f54 c6efb4e0 c6ee2600 
c28b1f90
c0140610 c6efb4e0 c28b1f54 c28b1f54 c0140e2c c6efb4e0 c28b1f54 00000000
00000009 c4ff200f 00000000 000041ed 00000002 c6de14c0 00001000 fffffff4
Call Trace: [cached_lookup+16/80] [link_path_walk+1452/2048] 
[getname+94/160] [__user_walk+51/80] [sys_access+126/288]
Call Trace: [<c0140610>] [<c0140e2c>] [<c014034e>] [<c01414f3>] 
[<c01357ee>]
[<c010700b>]
Code: 8b 6d 00 39 53 44 0f 85 83 00 00 00 8b 44 24 24 39 43 0c 75

 >>EIP; c0149674 <d_lookup+74/130>   <=====
Trace; c0140610 <cached_lookup+10/50>
Trace; c0140e2c <link_path_walk+5ac/800>
Trace; c014034e <getname+5e/a0>
Trace; c01414f3 <__user_walk+33/50>
Trace; c01357ee <sys_access+7e/120>
Trace; c010700b <system_call+33/38>
Code;  c0149674 <d_lookup+74/130>
00000000 <_EIP>:
Code;  c0149674 <d_lookup+74/130>   <=====
    0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c0149677 <d_lookup+77/130>
    3:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c014967a <d_lookup+7a/130>
    6:   0f 85 83 00 00 00         jne    8f <_EIP+0x8f> c0149703 
<d_lookup+103/130>
Code;  c0149680 <d_lookup+80/130>
    c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0149684 <d_lookup+84/130>
   10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c0149687 <d_lookup+87/130>
   13:   75 00                     jne    15 <_EIP+0x15> c0149689 
<d_lookup+89/130>


