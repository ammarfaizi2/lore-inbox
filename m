Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262978AbTCLB1O>; Tue, 11 Mar 2003 20:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbTCLB1O>; Tue, 11 Mar 2003 20:27:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:35559 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262978AbTCLB1I>; Tue, 11 Mar 2003 20:27:08 -0500
Date: Tue, 11 Mar 2003 17:28:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 462] New: PNPBios blows up hard during boot 
Message-ID: <51660000.1047432500@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=462

           Summary: PNPBios blows up hard during boot
    Kernel Version: 2.5.64-bk2
            Status: NEW
          Severity: high
             Owner: ambx1@neo.rr.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: Compaq Armada 1590DMT Laptop
Software Environment: GCC 2.95.4
Problem Description:
I'm trying out 2.5 on my laptop, and it blows up hard during boot; so hard that
ksymsall oops too :(

Linux Plug and Play Support v0.95 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x2621, dseg 0xf0000
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
Unable to handle kernel paging request at virtual address 00005edb
 printing eip:
00002238
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0098:[<00002238>]    Not tainted
EFLAGS: 00010046
EIP is at 0x2238
eax: 000000c0   ebx: 00000002   ecx: 00020000   edx: 000000e4
esi: c4fc9c83   edi: c4fa00e5   ebp: c4fc5edc   esp: c4fc5ed6
ds: 00b0   es: 00b0   ss: 0068
Process swapper (pid: 1, threadinfo=c4fc4000 task=c4fc2000)
Stack: 00009c83 00260000 002e984e 232e00a0 9c830000 5ef6002e 00e50002 00e40000
       000000a0 5f28984e 9d1b00a0 00462719 0006267a 007b0000 f064007b 5fbbc4fa
       00a0c4fc 00b00000 00010002 00a80000 02020000 000b0000 00010090 00a80000
Call Trace:
 [<c0124132>] unblock_all_signals+0xe/0x1e0
Unable to handle kernel paging request at virtual address c5000000
 printing eip:
c0109de0
*pde = 00000000
arch/i386/kernel/traps.c:251: spin_lock(arch/i386/kernel/traps.c:c0377e3c) alrea
dy locked by arch/i386/kernel/traps.c/251
Oops: 0000
CPU:    0
EIP:    0060:[<c0109de0>]    Not tainted
EFLAGS: 00010002
EIP is at show_trace+0x30/0x8c
eax: c4fffffe   ebx: 922b8222   ecx: 0000001e   edx: 00000096
esi: 00000018   edi: 00000068   ebp: 00000001   esp: c4fc5d8e
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c4fc4000 task=c4fc2000)
Stack: c4fc5f36 c0109ec6 c4fffffe c02f6a66 c4fc5ed6 c4fc5ea2 c0109fd2 c4fc5ed6
       c02f6bcc c0377e3c 00000002 c4fc5ea2 c4fc5edc c010a1a0 c4fc5ea2 c02f6c81
       c02fe0de 00000002 c4fc5ea2 00000001 00000000 c4fc2000 00005edb c01134dc
Call Trace:
 [<c0109ec6>] show_stack+0x6a/0x70
 [<c0109fd2>] show_registers+0xf6/0x16


I'm going to recompile without ksysmall, and then ksymoops the oops to get the
whole thing...

