Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317832AbSGKNEj>; Thu, 11 Jul 2002 09:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSGKNEi>; Thu, 11 Jul 2002 09:04:38 -0400
Received: from lan.iskon.hr ([213.191.128.133]:62983 "EHLO max.zg.iskon.hr")
	by vger.kernel.org with ESMTP id <S317832AbSGKNEh>;
	Thu, 11 Jul 2002 09:04:37 -0400
Subject: [OOPS] kernel-2.4.19-pre5
From: Zeljko Brajdic <zeljko.brajdic@iskon.hr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 11 Jul 2002 15:07:17 +0200
Message-Id: <1026392838.1040.8.camel@max>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would appreciate if someone explain what causing oops?!

-----
Jul 11 14:30:17 www2 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000007
Jul 11 14:30:17 www2 kernel: c0124467
Jul 11 14:30:17 www2 kernel: *pde = 00000000
Jul 11 14:30:17 www2 kernel: Oops: 0000
Jul 11 14:30:17 www2 kernel: CPU:    0
Jul 11 14:30:17 www2 kernel: EIP:    0010:[__find_lock_page_helper+23/96]    Not tainted
Jul 11 14:30:17 www2 kernel: EFLAGS: 00010286
Jul 11 14:30:17 www2 kernel: eax: ca3030f0   ebx: ffffffff   ecx: c13374c8   edx: 00000043
Jul 11 14:30:17 www2 kernel: esi: 00000043   edi: ca3030f0   ebp: c13374c8   esp: d4705f38
Jul 11 14:30:17 www2 kernel: ds: 0018   es: 0018   ss: 0018
Jul 11 14:30:17 www2 kernel: Process gunzip (pid: 17540, stackpage=d4705000)
Jul 11 14:30:17 www2 kernel: Stack: 00001000 d4705f94 00000043 dbec268c c01244c3 c0126861 ca3030f0 00000043 
Jul 11 14:30:17 www2 kernel:        dbec268c 00000000 c471e460 ffffffea 00008000 ca3030a8 00001000 00000000 
Jul 11 14:30:17 www2 kernel:        00001000 fffffff4 00003000 00043000 00000000 ca303040 ca3030f0 00000000 
Jul 11 14:30:17 www2 kernel: Call Trace: [__find_lock_page+19/20] [generic_file_write+985/1784] [sys_write+150/240] [system_call+51/56] 
Jul 11 14:30:17 www2 kernel: Code: 39 7b 08 75 f4 39 73 0c 75 ef 85 db 74 32 ff 43 14 31 c0 0f 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; ca3030f0 <_end+a0a2dbc/1c5edccc>
>>ebx; ffffffff <END_OF_CODE+23784400/????>
>>ecx; c13374c8 <_end+10d7194/1c5edccc>
>>edi; ca3030f0 <_end+a0a2dbc/1c5edccc>
>>ebp; c13374c8 <_end+10d7194/1c5edccc>
>>esp; d4705f38 <_end+144a5c04/1c5edccc>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 7b 08                  cmp    %edi,0x8(%ebx)
Code;  00000003 Before first symbol
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> fffffff9 <END_OF_CODE+237843fa/????>
Code;  00000005 Before first symbol
   5:   39 73 0c                  cmp    %esi,0xc(%ebx)
Code;  00000008 Before first symbol
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> fffffff9 <END_OF_CODE+237843fa/????>
Code;  0000000a Before first symbol
   a:   85 db                     test   %ebx,%ebx
Code;  0000000c Before first symbol
   c:   74 32                     je     40 <_EIP+0x40> 00000040 Before first symbol
Code;  0000000e Before first symbol
   e:   ff 43 14                  incl   0x14(%ebx)
Code;  00000011 Before first symbol
  11:   31 c0                     xor    %eax,%eax
Code;  00000013 Before first symbol
  13:   0f 00 00                  sldtl  (%eax)

-- 
v            ,   v  v
Zeljko Brajdic - Zorz

