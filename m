Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270354AbTG1RC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270359AbTG1RC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:02:59 -0400
Received: from dsl-217-155-102-250.zen.co.uk ([217.155.102.250]:38345 "EHLO
	smithers.xal") by vger.kernel.org with ESMTP id S270354AbTG1RCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:02:53 -0400
Date: Mon, 28 Jul 2003 18:18:07 +0100
To: linux-kernel@vger.kernel.org
Subject: OOPS 2.6.0-test2, modprobe i810fb
Message-ID: <20030728171806.GA1860@xal.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Pavel Rabel <pavel@xal.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Got this OOPS when trying "modprobe i810fb",
kernel 2.6.0-test2


-- 
Pavel


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.4.8 on i686 2.6.0-test2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test2/ (default)
     -m /boot/System.map-2.6.0-test2 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address d00fb018
c018abd9
*pde = 013be067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c018abd9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00008086   ebx: c12c5000   ecx: d00fb018   edx: 00000000
esi: c12c5000   edi: d01372a0   ebp: d01372c8   esp: c2d29f28
ds: 007b   es: 007b   ss: 0068
Stack: ffffffed c018afd7 d00fae58 c12c5000 ffffffed d01372c8 c12c5054 c01b46f0 
       c12c5054 d01372c8 c12c505c c0267be4 d01372c8 c01b47e3 c12c5054 d01372c8 
       c0267b88 c0267b40 00000000 c01b4a2b d01372c8 d01372a0 00000000 d0137340 
Call Trace:
 [<c018afd7>] pci_bus_match+0x23/0xb8
 [<c01b46f0>] bus_match+0x20/0x64
 [<c01b47e3>] driver_attach+0x3f/0x54
 [<c01b4a2b>] bus_add_driver+0x6f/0x8c
 [<c01b4dac>] driver_register+0x34/0x38
 [<c018af44>] pci_register_driver+0x68/0x88
 [<d00fae1e>] init_module+0x3a/0x57 [i810fb]
 [<c0126d11>] sys_init_module+0xe5/0x1bc
 [<c0108993>] syscall_call+0x7/0xb
Code: 83 39 00 75 a2 83 79 08 00 75 9c 83 79 14 00 75 96 31 c0 5b 


>>EIP; c018abd9 <pci_match_device+69/80>   <=====

>>ebx; c12c5000 <_end+fced34/3fd07d34>
>>ecx; d00fb018 <_end+fe04d4c/3fd07d34>
>>esi; c12c5000 <_end+fced34/3fd07d34>
>>edi; d01372a0 <_end+fe40fd4/3fd07d34>
>>ebp; d01372c8 <_end+fe40ffc/3fd07d34>
>>esp; c2d29f28 <_end+2a33c5c/3fd07d34>

Trace; c018afd7 <pci_bus_match+23/b8>
Trace; c01b46f0 <bus_match+20/64>
Trace; c01b47e3 <driver_attach+3f/54>
Trace; c01b4a2b <bus_add_driver+6f/8c>
Trace; c01b4dac <driver_register+34/38>
Trace; c018af44 <pci_register_driver+68/88>
Trace; d00fae1e <_end+fe04b52/3fd07d34>
Trace; c0126d11 <sys_init_module+e5/1bc>
Trace; c0108993 <syscall_call+7/b>

Code;  c018abd9 <pci_match_device+69/80>
00000000 <_EIP>:
Code;  c018abd9 <pci_match_device+69/80>   <=====
   0:   83 39 00                  cmpl   $0x0,(%ecx)   <=====
Code;  c018abdc <pci_match_device+6c/80>
   3:   75 a2                     jne    ffffffa7 <_EIP+0xffffffa7>
Code;  c018abde <pci_match_device+6e/80>
   5:   83 79 08 00               cmpl   $0x0,0x8(%ecx)
Code;  c018abe2 <pci_match_device+72/80>
   9:   75 9c                     jne    ffffffa7 <_EIP+0xffffffa7>
Code;  c018abe4 <pci_match_device+74/80>
   b:   83 79 14 00               cmpl   $0x0,0x14(%ecx)
Code;  c018abe8 <pci_match_device+78/80>
   f:   75 96                     jne    ffffffa7 <_EIP+0xffffffa7>
Code;  c018abea <pci_match_device+7a/80>
  11:   31 c0                     xor    %eax,%eax
Code;  c018abec <pci_match_device+7c/80>
  13:   5b                        pop    %ebx


1 error issued.  Results may not be reliable.

--fUYQa+Pmc3FrFX/N--
