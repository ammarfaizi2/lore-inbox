Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318911AbSG1GZU>; Sun, 28 Jul 2002 02:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318912AbSG1GZU>; Sun, 28 Jul 2002 02:25:20 -0400
Received: from mail.uklinux.net ([80.84.72.21]:48912 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S318911AbSG1GZT>;
	Sun, 28 Jul 2002 02:25:19 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
From: Mark Hindley <mark@hindley.uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15683.36550.10397.855195@titan.home.hindley.uklinux.net>
Date: Sun, 28 Jul 2002 07:27:18 +0100 (BST)
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: OOPS: 2.4.18
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following oops overnight which required a hard reset.

Let me know if you need any more information.

Mark


ksymoops 2.3.7 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (specified)

Jul 28 01:09:18 titan kernel: Unable to handle kernel paging request at virtual address 0000789f
Jul 28 01:09:18 titan kernel: c0193124
Jul 28 01:09:18 titan kernel: *pde = 00000000
Jul 28 01:09:18 titan kernel: Oops: 0000
Jul 28 01:09:18 titan kernel: CPU:    0
Jul 28 01:09:18 titan kernel: EIP:    0010:[sock_poll+16/40]    Not tainted
Jul 28 01:09:18 titan kernel: EFLAGS: 00010286
Jul 28 01:09:18 titan kernel: eax: 00007777   ebx: 00000000   ecx: c2ca89c0   edx: 00007897
Jul 28 01:09:18 titan kernel: esi: c2ca89c0   edi: 00000000   ebp: c2ae7f70   esp: c2ae7f34
Jul 28 01:09:18 titan kernel: ds: 0018   es: 0018   ss: 0018
Jul 28 01:09:18 titan kernel: Process X (pid: 480, stackpage=c2ae7000)
Jul 28 01:09:18 titan kernel: Stack: c0135889 c2ca89c0 00000000 00000008 00000020 c3337380 00000145 00004000 
Jul 28 01:09:18 titan kernel:        c2ae6000 7fffffff 0000000e 00000000 0000000f 00000000 c1e97000 00000000 
Jul 28 01:09:18 titan kernel:        c0135cf2 00000100 c2ae7fa8 c2ae7fa4 c2ae6000 00000000 00000000 bffff85c 
Jul 28 01:09:18 titan kernel: Call Trace: [do_select+229/476] [sys_select+842/1156] [system_call+51/64] 
Jul 28 01:09:18 titan kernel: Code: 8b 80 28 01 00 00 ff 74 24 08 52 51 8b 40 1c ff d0 83 c4 0c 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 80 28 01 00 00         mov    0x128(%eax),%eax
Code;  00000006 Before first symbol
   6:   ff 74 24 08               pushl  0x8(%esp,1)
Code;  0000000a Before first symbol
   a:   52                        push   %edx
Code;  0000000b Before first symbol
   b:   51                        push   %ecx
Code;  0000000c Before first symbol
   c:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  0000000f Before first symbol
   f:   ff d0                     call   *%eax
Code;  00000011 Before first symbol
  11:   83 c4 0c                  add    $0xc,%esp

Jul 28 01:09:18 titan kernel:  <1>Unable to handle kernel paging request at virtual address 000077a9
Jul 28 01:09:18 titan kernel: c013b8ba
Jul 28 01:09:18 titan kernel: *pde = 00000000
Jul 28 01:09:18 titan kernel: Oops: 0000
Jul 28 01:09:18 titan kernel: CPU:    0
Jul 28 01:09:18 titan kernel: EIP:    0010:[fcntl_dirnotify+62/332]    Not tainted
Jul 28 01:09:18 titan kernel: EFLAGS: 00010202
Jul 28 01:09:18 titan kernel: eax: c05df860   ebx: c2ca89c0   ecx: 00000000   edx: c2ca89c0
Jul 28 01:09:18 titan kernel: esi: 00007777   edi: 00000000   ebp: 00000001   esp: c2ae7de0
Jul 28 01:09:18 titan kernel: ds: 0018   es: 0018   ss: 0018
Jul 28 01:09:18 titan kernel: Process X (pid: 480, stackpage=c2ae7000)
Jul 28 01:09:18 titan kernel: Stack: c2ca89c0 00000000 c22493e0 00000001 c012914a 00000000 c2ca89c0 00000000 
Jul 28 01:09:18 titan kernel:        00000001 0000000e c0112a18 c2ca89c0 c22493e0 c37f8460 c2ae6000 0000000b 
Jul 28 01:09:18 titan kernel:        0000789f c2249500 c0112fc1 c22493e0 00000000 c37f847c c354ff20 c01070c9 
Jul 28 01:09:18 titan kernel: Call Trace: [filp_close+74/100] [put_files_struct+84/184] [do_exit+169/456] [die+77/80] [do_page_fault+845/1164] 
Jul 28 01:09:18 titan kernel: Code: 0f b7 46 32 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec ff ff ff 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax
Code;  00000004 Before first symbol
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  00000009 Before first symbol
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  0000000d Before first symbol
   d:   74 0a                     je     19 <_EIP+0x19> 00000019 Before first symbol
Code;  0000000f Before first symbol
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax

