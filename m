Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTA1XKg>; Tue, 28 Jan 2003 18:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbTA1XKg>; Tue, 28 Jan 2003 18:10:36 -0500
Received: from pc2-cmbg2-4-cust80.cmbg.cable.ntl.com ([80.2.247.80]:46318 "EHLO
	flat") by vger.kernel.org with ESMTP id <S261733AbTA1XKe>;
	Tue, 28 Jan 2003 18:10:34 -0500
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [oops] [2.5.59{,-mm6}] [modules] Inserting modules during boot causes oops
Date: Tue, 28 Jan 2003 23:19:35 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301282319.36723.cb-lkml@fish.zetnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The last kernel I tried was 2.5.56 which works fine. This oops occurs in 2.5.59
and 2.5.59-mm6.

Using modutils 0.9.8 from Debian sid.



Unable to handle kernel paging request at virtual address eb80c025
 printing eip:
c01279a1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01279a1>]    Not tainted
EFLAGS: 00010093
EIP is at __find_symbol+0x3d/0x78
eax: c024bce2   ebx: c8ccef07   ecx: 00000000   edx: c02d4e80
esi: eb80c025   edi: c8ccef07   ebp: 000005a5   esp: c77f5ec8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 50, threadinfo=c77f4000 task=c13ef2a0)
Stack: c77f4000 c8cccfe4 c8cd0420 c8cb066c c012837b c8ccef07 c77f5ef4 00000001 
       c8ccc2e4 c8cccfe4 000001b8 00000046 c01285ad c8cb066c 0000001c c8cccfe4 
       c8ccef07 c8cd0420 0000001e c8ca0000 c8cb066c c8cd0420 00000000 00000288 
Call Trace:
 [<c012837b>] resolve_symbol+0x2b/0x68
 [<c01285ad>] simplify_symbols+0x81/0xe4
 [<c0128e34>] load_module+0x5cc/0x7f4
 [<c01290bb>] sys_init_module+0x5f/0x1a4
 [<c0108a43>] syscall_call+0x7/0xb

Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 0e 
 <6>note: modprobe[50] exited with preempt_count 1

