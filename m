Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293327AbSCBRYH>; Sat, 2 Mar 2002 12:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310402AbSCBRX6>; Sat, 2 Mar 2002 12:23:58 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:3600 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S293327AbSCBRXt>; Sat, 2 Mar 2002 12:23:49 -0500
Date: Sat, 2 Mar 2002 18:23:44 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Ooops with 2.5.3 and ext3 (using cvs).
Message-ID: <20020302172344.GA17505@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I had the following oops on 2.5.3 with ext3.
The Sytem.map is accurate. I could not try
later kernels, because nothing above 2.5.3
copiles for me.
As a sidenote: I have a "patchset" to make 2.5.3
compile, but I'm quite upset because small patches
are usually ignored unless they come from a "valueable"
source. Problematic parts are matrox_fb, rt8130too,
eepro100 and serial drivers.

cheers,
Patrick

Oops:

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0152abb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000007b   ebx: c35e9eb0   ecx: c0297ed8   edx: c33ca000
esi: c1780800   edi: cdeee740   ebp: d497f4c0   esp: c33cbdf0
ds: 0018   es: 0018   ss: 0018
Process cvs (pid: 4030, stackpage=c33cb000)
Stack: c0236f80 c0237501 c0236f60 000004df c0237540 00560574 d2d0d3e0 cf35c8a0 
cf35c8a0 c1780894 c014a3c1 d2d0d3e0 cdeee740 00560574 cf35c820 d2d0d3e0 
c33cbf2c 00560574 cf35c820 d2d0d3e0 c014beee d2d0d3e0 00000000 cf35c8a0 
Call Trace: [<c014a3c1>] [<c014beee>] [<c0157013>] [<c01571a5>] [<c014c013>] 
[<c014c35e>] [<c014c3c6>] [<c0156e9f>] [<c0151b09>] [<c014a48d>] [<c014a528>] 
[<c014a5c7>] [<c014a528>] [<c013ce3c>] [<c013b658>] [<c01355e6>] [<c01356c1>] 
[<c01085f3>] 
Code: 0f 0b 83 c4 14 8b 43 18 85 c0 74 30 39 e8 74 25 68 a0 74 23 

>>EIP; c0152aba <journal_forget+12e/190>   <=====
Trace; c014a3c0 <ext3_forget+50/c8>
Trace; c014beee <ext3_clear_blocks+fe/124>
Trace; c0157012 <journal_free_journal_head+e/14>
Trace; c01571a4 <__journal_remove_journal_head+d0/d8>
Trace; c014c012 <ext3_free_data+fe/164>
Trace; c014c35e <ext3_truncate+d6/3a4>
Trace; c014c3c6 <ext3_truncate+13e/3a4>
Trace; c0156e9e <__jbd_kmalloc+1a/68>
Trace; c0151b08 <journal_start+a4/cc>
Trace; c014a48c <start_transaction+54/80>
Trace; c014a528 <ext3_delete_inode+0/11c>
Trace; c014a5c6 <ext3_delete_inode+9e/11c>
Trace; c014a528 <ext3_delete_inode+0/11c>
Trace; c013ce3c <iput+bc/198>
Trace; c013b658 <d_delete+4c/6c>
Trace; c01355e6 <vfs_unlink+f6/12c>
Trace; c01356c0 <sys_unlink+a4/11c>
Trace; c01085f2 <syscall_traced+6/a>
Code;  c0152aba <journal_forget+12e/190>
00000000 <_EIP>:
Code;  c0152aba <journal_forget+12e/190>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0152abc <journal_forget+130/190>
   2:   83 c4 14                  add    $0x14,%esp
Code;  c0152abe <journal_forget+132/190>
   5:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c0152ac2 <journal_forget+136/190>
   8:   85 c0                     test   %eax,%eax
Code;  c0152ac4 <journal_forget+138/190>
   a:   74 30                     je     3c <_EIP+0x3c> c0152af6 <journal_forget+16a/190>
Code;  c0152ac6 <journal_forget+13a/190>
   c:   39 e8                     cmp    %ebp,%eax
Code;  c0152ac8 <journal_forget+13c/190>
   e:   74 25                     je     35 <_EIP+0x35> c0152aee <journal_forget+162/190>
Code;  c0152aca <journal_forget+13e/190>
  10:   68 a0 74 23 00            push   $0x2374a0
