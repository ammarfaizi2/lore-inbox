Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269083AbTBXCQx>; Sun, 23 Feb 2003 21:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269084AbTBXCQw>; Sun, 23 Feb 2003 21:16:52 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:41089 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP
	id <S269083AbTBXCQv>; Sun, 23 Feb 2003 21:16:51 -0500
Message-ID: <3E595840.8060006@terra.com.br>
Date: Sun, 23 Feb 2003 23:24:48 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chaffee@cs.berkeley.edu
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4..20-ac2 -> file.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Please let me know if you need any more info.

	Thanks.

Felipe

ksymoops 2.4.6 on i686 2.4.20-ac2.  Options used
      -V (specified)
      -k /proc/ksyms (specified)
      -l /proc/modules (specified)
      -o /lib/modules/2.4.20-ac2 (specified)
      -m /usr/src/linux/System.map (specified)

kernel BUG at file.c:76!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c016b2cc>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c8f14d60   ecx: 00003c82   edx: 00000000
esi: 00079068   edi: c7ceb920   ebp: ca8b5800   esp: cff6de5c
ds: 0018   es: 0018   ss: 0018
Process xchat (pid: 1612, stackpage=cff6d000)
Stack: 00000200 00000000 0000f20d 00000000 0000f20d c013463a c8f14d60 
00079068
        c7ceb920 00000001 0000f20d 00000000 0000f20d c189df3c ce6e7000 
cff6deac
        c7ceb920 00000200 00079068 c7ceb920 cff6ded4 00001000 c0134da9 
c8f14d60
Call Trace:    [<c013463a>] [<c0134da9>] [<c016b224>] [<c016cbd6>] 
[<c016b224>]
   [<c01262e6>] [<c016b342>] [<c016b319>] [<c0132526>] [<c0106b1b>]
Code: 0f 0b 4c 00 fd 96 2a c0 0f b7 43 30 66 89 47 0c 89 57 04 80


 >>EIP; c016b2cc <fat_get_block+a8/c8>   <=====

 >>ebx; c8f14d60 <_end+8b898a4/14544b44>
 >>edi; c7ceb920 <_end+7960464/14544b44>
 >>ebp; ca8b5800 <_end+a52a344/14544b44>
 >>esp; cff6de5c <_end+fbe29a0/14544b44>

Trace; c013463a <__block_prepare_write+da/2d0>
Trace; c0134da9 <cont_prepare_write+1a1/254>
Trace; c016b224 <fat_get_block+0/c8>
Trace; c016cbd6 <fat_prepare_write+26/2c>
Trace; c016b224 <fat_get_block+0/c8>
Trace; c01262e6 <generic_file_write+49e/718>
Trace; c016b342 <default_fat_file_write+22/50>
Trace; c016b319 <fat_file_write+2d/34>
Trace; c0132526 <sys_write+96/f0>
Trace; c0106b1b <system_call+33/38>

Code;  c016b2cc <fat_get_block+a8/c8>
0000000000000000 <_EIP>:
Code;  c016b2cc <fat_get_block+a8/c8>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c016b2ce <fat_get_block+aa/c8>
    2:   4c                        dec    %esp
Code;  c016b2cf <fat_get_block+ab/c8>
    3:   00 fd                     add    %bh,%ch
Code;  c016b2d1 <fat_get_block+ad/c8>
    5:   96                        xchg   %eax,%esi
Code;  c016b2d2 <fat_get_block+ae/c8>
    6:   2a c0                     sub    %al,%al
Code;  c016b2d4 <fat_get_block+b0/c8>
    8:   0f b7 43 30               movzwl 0x30(%ebx),%eax
Code;  c016b2d8 <fat_get_block+b4/c8>
    c:   66 89 47 0c               mov    %ax,0xc(%edi)
Code;  c016b2dc <fat_get_block+b8/c8>
   10:   89 57 04                  mov    %edx,0x4(%edi)
Code;  c016b2df <fat_get_block+bb/c8>
   13:   80 00 00                  addb   $0x0,(%eax)


