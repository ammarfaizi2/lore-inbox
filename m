Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSEULaE>; Tue, 21 May 2002 07:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312581AbSEULaD>; Tue, 21 May 2002 07:30:03 -0400
Received: from news.cistron.nl ([195.64.68.38]:17160 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S312576AbSEULaC>;
	Tue, 21 May 2002 07:30:02 -0400
From: Rene Blokland <reneb@orac.aais.org>
Subject: OOPS kernel2.5.17 in vatfs?
Date: Tue, 21 May 2002 13:21:39 +0200
Organization: Cistron
Message-ID: <slrnaekbe3.4u.reneb@orac.aais.org>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1021980602 20010 195.64.94.30 (21 May 2002 11:30:02 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all When installing vmlinuz op a fat partinion i get a nice :-/ oops
If you need more information please tell me.
Thanks Rene

ksymoops 2.4.5 on i586 2.5.17.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.17/ (default)
     -m /usr/src/linux/System.map (default)
     -I

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 0000004c
c0161018
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[msdos_lookup+120/224]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: d23247c0   ecx: d3f32a68   edx: d23247d0
esi: d1bdf1e0   edi: d38bec00   ebp: d23247c0   esp: d2549e6c
ds: 0018   es: 0018   ss: 0018
Stack: d1bdf1e0 d23247c0 00000000 d1be0420 d1bde300 00001d98 fffffff4 d1bdf0dc
       d1bdf080 c013aa0f d1bdf080 d23247c0 00000000 00000000 d2549f38 d3ff6520
       c013acb8 d23246c0 d2549f00 00000004 d2549f00 00000000 d330900b d2549f38
Call Trace: [real_lookup+143/192] [do_lookup+280/416] [link_path_walk+424/2112] [__user_walk+42/64] [vfs_lstat+23/96]
Code: c7 40 4c 44 17 27 c0 89 c3 59 5e c7 04 24 00 00 00 00 8b 44
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; d23247c0 <END_OF_CODE+1202e464/????>
>>ecx; d3f32a68 <END_OF_CODE+13c3c70c/????>
>>edx; d23247d0 <END_OF_CODE+1202e474/????>
>>esi; d1bdf1e0 <END_OF_CODE+118e8e84/????>
>>edi; d38bec00 <END_OF_CODE+135c88a4/????>
>>ebp; d23247c0 <END_OF_CODE+1202e464/????>
>>esp; d2549e6c <END_OF_CODE+12253b10/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c7 40 4c 44 17 27 c0      movl   $0xc0271744,0x4c(%eax)
Code;  00000007 Before first symbol
   7:   89 c3                     mov    %eax,%ebx
Code;  00000009 Before first symbol
   9:   59                        pop    %ecx
Code;  0000000a Before first symbol
   a:   5e                        pop    %esi
Code;  0000000b Before first symbol
   b:   c7 04 24 00 00 00 00      movl   $0x0,(%esp,1)
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000004c
c0161018
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[msdos_lookup+120/224]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: d2324740   ecx: d3f3e9e0   edx: d2324750
esi: d1bdf340   edi: d38bec00   ebp: d2324740   esp: d2549e6c
ds: 0018   es: 0018   ss: 0018
Stack: d1bdf340 d2324740 00000000 d1be0e20 d2031260 00028793 fffffff4 d1bdf23c
       d1bdf1e0 c013aa0f d1bdf1e0 d2324740 00000000 00000000 d2549f38 d3ff6520
       c013acb8 d23247c0 d2549f00 00000004 d2549f00 00000000 d2549f00 d2549f38
Call Trace: [real_lookup+143/192] [do_lookup+280/416] [link_path_walk+1148/2112] [__user_walk+42/64] [vfs_lstat+23/96]
Code: c7 40 4c 44 17 27 c0 89 c3 59 5e c7 04 24 00 00 00 00 8b 44


>>ebx; d2324740 <END_OF_CODE+1202e3e4/????>
>>ecx; d3f3e9e0 <END_OF_CODE+13c48684/????>
>>edx; d2324750 <END_OF_CODE+1202e3f4/????>
>>esi; d1bdf340 <END_OF_CODE+118e8fe4/????>
>>edi; d38bec00 <END_OF_CODE+135c88a4/????>
>>ebp; d2324740 <END_OF_CODE+1202e3e4/????>
>>esp; d2549e6c <END_OF_CODE+12253b10/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c7 40 4c 44 17 27 c0      movl   $0xc0271744,0x4c(%eax)
Code;  00000007 Before first symbol
   7:   89 c3                     mov    %eax,%ebx
Code;  00000009 Before first symbol
   9:   59                        pop    %ecx
Code;  0000000a Before first symbol
   a:   5e                        pop    %esi
Code;  0000000b Before first symbol
   b:   c7 04 24 00 00 00 00      movl   $0x0,(%esp,1)
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax


--
Groeten / Regards, Rene J. Blokland

