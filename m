Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbRE3UYQ>; Wed, 30 May 2001 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262017AbRE3UX4>; Wed, 30 May 2001 16:23:56 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:46863 "HELO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with SMTP
	id <S262027AbRE3UXs>; Wed, 30 May 2001 16:23:48 -0400
Date: Wed, 30 May 2001 22:03:38 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Oops on 2.2.5
Message-ID: <Pine.LNX.4.33.0105302156450.457-100000@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

There is two "Oops" from user's space (pine,epic) programs. On 2.2.x
kernels, on this machine, it had never happened.
(2.4.5 #1 SMP Pentium III (Coppermine), 800MHz, RH 7.1, gcc 2.96)

ksymoops 2.4.0 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
May 24 22:46:17 oceanic kernel: Unable to handle kernel NULL pointer
May 24 22:46:17 oceanic kernel: c0106c28
May 24 22:46:17 oceanic kernel: *pde = 00000000
May 24 22:46:17 oceanic kernel: Oops: 0000
May 24 22:46:17 oceanic kernel: CPU:    0
May 24 22:46:17 oceanic kernel: EFLAGS: 00010286
May 24 22:46:17 oceanic kernel: eax: 00000000   ebx: ce702000   ecx: 00000000 edx: ce702000
May 24 22:46:17 oceanic kernel: esi: 00000016   edi: 00000016   ebp: 00006b19 esp: ce703f28
May 24 22:46:17 oceanic kernel: ds: 0018   es: 0018   ss: 0018
May 24 22:46:17 oceanic kernel: Process epic (pid: 27417, stackpage=ce703000)
May 24 22:46:17 oceanic kernel: Stack: ce702640 ce703fc4 00000016 00000000 00000080 00000000 00000000 c01476dc
May 24 22:46:17 oceanic kernel:        e4bbc0c0 c02b0b18 dc7a91c0 dc7a91c0 db843000 bfffc484 db843000 00005403
May 24 22:46:17 oceanic kernel:        c018ad42 db843000 bfffc484 00000002 bfffc484 c010876e 00000001 c0301068
May 24 22:46:17 oceanic kernel: Call Trace: [<c01476dc>] [<c018ad42>] [<c010876e>] [<c01434f9>] [<c0106e5c>]
May 24 22:46:17 oceanic kernel: Code: f6 80 48 01 00 00 01 75 0a 6a 11 52 e8 c7 7a 01 00 5e 5f e8
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c01476dc <d_prune_aliases+8c/a0>
Trace; c018ad42 <initialize_tty_struct+162/190>
Trace; c010876e <handle_IRQ_event+5e/90>
Trace; c01434f9 <old_readdir+19/60>
Trace; c0106e5c <signal_return+14/18>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 80 48 01 00 00 01      testb  $0x1,0x148(%eax)
Code;  00000007 Before first symbol
   7:   75 0a                     jne    13 <_EIP+0x13> 00000013 Before first symbol
Code;  00000009 Before first symbol
   9:   6a 11                     push   $0x11
Code;  0000000b Before first symbol
   b:   52                        push   %edx
Code;  0000000c Before first symbol
   c:   e8 c7 7a 01 00            call   17ad8 <_EIP+0x17ad8> 00017ad8 Before first symbol
Code;  00000011 Before first symbol
  11:   5e                        pop    %esi
Code;  00000012 Before first symbol
  12:   5f                        pop    %edi
Code;  00000013 Before first symbol
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> 00000018 Before first symbol


1 warning issued.  Results may not be reliable.
ksymoops 2.4.0 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
May 30 17:47:59 oceanic kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000148
May 30 17:47:59 oceanic kernel: c0106c28
May 30 17:47:59 oceanic kernel: *pde = 00000000
May 30 17:47:59 oceanic kernel: Oops: 0000
May 30 17:47:59 oceanic kernel: CPU:    0
May 30 17:47:59 oceanic kernel: EIP:    0010:[<c0106c28>]
Using defaults from ksymoops -t elf32-i386 -a i386
May 30 17:47:59 oceanic kernel: EFLAGS: 00010286
May 30 17:47:59 oceanic kernel: eax: 00000000   ebx: ddb40000   ecx: 00000000 edx: ddb40000
May 30 17:47:59 oceanic kernel: esi: 00000016   edi: 00000016   ebp: 0000461f esp: ddb41f28
May 30 17:47:59 oceanic kernel: ds: 0018   es: 0018   ss: 0018
May 30 17:47:59 oceanic kernel: Process pine (pid: 17951, stackpage=ddb41000)
May 30 17:47:59 oceanic kernel: Stack: ddb40640 ddb41fc4 00000016 00000000 00000080 00000000 00000000 ecdb84e0
May 30 17:47:59 oceanic kernel:        ecdb8500 d45f3f60 00000000 4001e000 c018cf60 00000000 dbf26b60 00000282
May 30 17:47:59 oceanic kernel:        d967d000 f4ef78a0 ffffffea 00000000 0000003e f4ef78a0 fffffe00 00000000
May 30 17:47:59 oceanic kernel: Call Trace: [<c018cf60>] [<c0134132>] [<c0106e5c>]
May 30 17:47:59 oceanic kernel: Code: f6 80 48 01 00 00 01 75 0a 6a 11 52 e8 37 7a 01 00 5e 5f e8

>>EIP; c0106c28 <do_signal+1b8/2b0>   <=====
Trace; c018cf60 <write_chan+0/210>
Trace; c0134132 <sys_write+c2/d0>
Trace; c0106e5c <signal_return+14/18>
Code;  c0106c28 <do_signal+1b8/2b0>
00000000 <_EIP>:
Code;  c0106c28 <do_signal+1b8/2b0>   <=====
   0:   f6 80 48 01 00 00 01      testb  $0x1,0x148(%eax)   <=====
Code;  c0106c2f <do_signal+1bf/2b0>
   7:   75 0a                     jne    13 <_EIP+0x13> c0106c3b <do_signal+1cb/2b0>
Code;  c0106c31 <do_signal+1c1/2b0>
   9:   6a 11                     push   $0x11
Code;  c0106c33 <do_signal+1c3/2b0>
   b:   52                        push   %edx
Code;  c0106c34 <do_signal+1c4/2b0>
   c:   e8 37 7a 01 00            call   17a48 <_EIP+0x17a48> c011e670 <notify_parent+0/30>
Code;  c0106c39 <do_signal+1c9/2b0>
  11:   5e                        pop    %esi
Code;  c0106c3a <do_signal+1ca/2b0>
  12:   5f                        pop    %edi
Code;  c0106c3b <do_signal+1cb/2b0>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0106c40 <do_signal+1d0/2b0>


1 warning issued.  Results may not be reliable.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

