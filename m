Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267182AbUGVTx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267182AbUGVTx0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUGVTx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:53:26 -0400
Received: from web60903.mail.yahoo.com ([216.155.196.79]:33710 "HELO
	web60903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267182AbUGVTxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:53:19 -0400
Message-ID: <20040722195318.2819.qmail@web60903.mail.yahoo.com>
Date: Thu, 22 Jul 2004 12:53:18 -0700 (PDT)
From: Brian Gao <bgaolinux@yahoo.com>
Subject: Kernel crash --pls help
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a Dell 2650 running RedHat Enterprise Linux AS
2.1 ( Kernel 2.4.9-e.43enterprise). It crashes or
hanges frequently. We captured two Oop
messages(separate instances). But so far we haven't
got much out of Redhat support yet. I was wondering
whether any guru here could shed some light on it. I'd
appreciated your help.

Brian

Oop1:
---------
Unable to handle kernel paging request at virtual
address 22e59c08 
*pde = 00000000 
Oops: 0000 
Kernel 2.4.9-e.43enterprise 
CPU:    0 
EIP:    0010:[<c013208f>]    Not tainted 
EFLAGS: 00010206 
EIP is at do_generic_file_read [kernel] 0x1cf  
eax: 22e59c00   ebx: 00001000   ecx: 00000013   edx:
f706f900 
esi: 00000000   edi: f5e04ef8   ebp: 0000c3b3   esp:
e4d79ef4 
ds: 0018   es: 0018   ss: 0018 
Process _mprosrv (pid: 15473, stackpage=e4d79000) 
Stack: 00001000 f706f904 00000000 00000000 00000000
f5e04e40 00000000 00000001  
       c0b54b60 00000004 00000000 4073d550 00000000
bffeac30 c01326d7 f4ffc920  
       e4d79f8c e4d79f44 c0132550 00000000 00001000
00001000 4073e550 00000000  
Call Trace: [<c01326d7>] generic_file_new_read
[kernel] 0x67 (0xe4d79f2c) 
[<c0132550>] file_read_actor [kernel] 0x0 (0xe4d79f3c)

[<c013266b>] generic_file_read [kernel] 0x1b
(0xe4d79f60) 
[<c014725a>] sys_pread [kernel] 0xba (0xe4d79f78) 
[<c01073e3>] system_call [kernel] 0x33 (0xe4d79fc0) 
  
  
Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c6 85 f6 0f 84
8d 02 00 00  
 <0>Kernel panic: not continuing 



Oop2:
--------

Unable to handle kernel NULL pointer dereference at
virtual address 00000007
*pde = 1ac17001
Oops: 0000
Kernel 2.4.9-e.38enterprise
CPU:    3
EIP:    0010:[<c0131d7d>]    Not tainted
EFLAGS: 00010286
EIP is at generic_file_readahead [kernel] 0x1bd 
eax: ffffffff   ebx: c55b56c0   ecx: 00000013   edx:
f718ca38
esi: 00000001   edi: f4cac0f8   ebp: 00006163   esp:
ea54feac
ds: 0018   es: 0018   ss: 0018
Process _mprosrv (pid: 22818, stackpage=ea54f000)
Stack: f718ca3c 0000001f 00006162 00000001 0000000d
0000615d 0001f400 c87e73c0 
       c87e73c0 c55b56c0 f4cac0f8 0000615d c0132127
00000001 c87e73c0 f4cac040 
       c55b56c0 00000000 00001000 f718ca0c 00000001
00000000 00000000 f4cac040 
Call Trace: [<c0132127>] do_generic_file_read [kernel]
0x267 (0xea54fedc)
[<c01326d7>] generic_file_new_read [kernel] 0x67
(0xea54ff2c)
[<c0132550>] file_read_actor [kernel] 0x0 (0xea54ff3c)
[<c013266b>] generic_file_read [kernel] 0x1b
(0xea54ff60)
[<c014722a>] sys_pread [kernel] 0xba (0xea54ff78)
[<c0108f7e>] do_IRQ [kernel] 0xfe (0xea54ffa8)
[<c01073e3>] system_call [kernel] 0x33 (0xea54ffc0)
 
 
Code: 39 78 08 75 f4 39 68 0c 75 ef 89 fa 8b 0d 18 1c
3d c0 c1 ea 
CPU#2 is frozen.
CPU#1 is frozen.
CPU#0 is frozen.
< netdump activated - performing handshake with the
client. >
 
Process: 22818, {            _mprosrv}
Kernel 2.4.9-e.38enterprise
EIP: 0010:[<c0131d7d>] CPU: 3EIP is at
generic_file_readahead [kernel] 0x1bd 
 EFLAGS: 00010286    Not tainted
EAX: ffffffff EBX: c55b56c0 ECX: 00000013 EDX:
f718ca38
ESI: 00000001 EDI: f4cac0f8 EBP: 00006163 DS: 0018 ES:
0018
CR0: 8005003b CR2: 00000007 CR3: 16fd3e80 CR4:
000006f0
Call Trace: [<c0132127>] do_generic_file_read [kernel]
0x267 (0xea54fedc)
[<c01326d7>] generic_file_new_read [kernel] 0x67
(0xea54ff2c)
[<c0132550>] file_read_actor [kernel] 0x0 (0xea54ff3c)
[<c013266b>] generic_file_read [kernel] 0x1b
(0xea54ff60)
[<c014722a>] sys_pread [kernel] 0xba (0xea54ff78)
[<c0108f7e>] do_IRQ [kernel] 0xfe (0xea54ffa8)
[<c01073e3>] system_call [kernel] 0x33 (0xea54ffc0)
 
 
                         free                       
sibling
  task             PC    stack   pid father child
younger older
init          S 00000000  2836     1      0 27708     
 6       (NOTLB)
Call Trace: [<c0125704>] schedule_timeout [kernel]
0x84 (0xf7ffdf04)
[<c0125670>] process_timeout [kernel] 0x0 (0xf7ffdf1c)
[<c015753e>] do_select [kernel] 0x20e (0xf7ffdf34)
[<c01578e9>] sys_select [kernel] 0x339 (0xf7ffdf6c)
[<c01073e3>] system_call [kernel] 0x33 (0xf7ffdfc0)
 
keventd       S C03D17C0  5916     2      1           
 3       (L-TLB)
Call Trace: [<c0129bec>] context_thread [kernel] 0x13c
(0xc767bf7c)
[<c0105000>] stext [kernel] 0x0 (0xc767bfd4)
[<c0105000>] stext [kernel] 0x0 (0xc767bfe8)
[<c0105856>] arch_kernel_thread [kernel] 0x26
(0xc767bff0)
[<c0129ab0>] context_thread [kernel] 0x0 (0xc767bff8)
 
.....



		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 
