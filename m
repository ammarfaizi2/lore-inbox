Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318896AbSHEW4s>; Mon, 5 Aug 2002 18:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318900AbSHEW4s>; Mon, 5 Aug 2002 18:56:48 -0400
Received: from sabre.velocet.net ([216.138.209.205]:49156 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S318896AbSHEW4r>;
	Mon, 5 Aug 2002 18:56:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Oopses
From: Gregory Stark <gsstark@mit.edu>
Date: 05 Aug 2002 19:00:22 -0400
Message-ID: <87sn1sgbcp.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I received these two oopses recently running 2.4.17. Is this a known bug? 
Is it fixed in 2.4.18?

Aug  5 17:43:07 stark kernel: Unable to handle kernel paging request at virtual address e0f390e8
Aug  5 17:43:07 stark kernel:  printing eip:
Aug  5 17:43:07 stark kernel: c0140cfc
Aug  5 17:43:07 stark kernel: *pde = 00000000
Aug  5 17:43:07 stark kernel: Oops: 0002
Aug  5 17:43:07 stark kernel: CPU:    0
Aug  5 17:43:08 stark kernel: EIP:    0010:[get_empty_inode+44/160]    Tainted: PF
Aug  5 17:43:08 stark kernel: EFLAGS: 00210206
Aug  5 17:43:08 stark kernel: eax: e0f390e8   ebx: e0f390e0   ecx: c2f390a0   edx: c2f39e08
Aug  5 17:43:08 stark kernel: esi: c3c11b00   edi: bf7ffa2c   ebp: bf7ffa2c   esp: ce463eec
Aug  5 17:43:08 stark kernel: ds: 0018   es: 0018   ss: 0018
Aug  5 17:43:08 stark kernel: Process xmms (pid: 15864, stackpage=ce463000)
Aug  5 17:43:08 stark kernel: Stack: 00000004 c0195e76 00000004 c0196a8d 00000004 bf7ff9e8 bf7ffa2c bf7ff674 
Aug  5 17:43:08 stark kernel:        ce463f70 ffffffe8 c1040000 00200202 ffffffff 00000829 c012a6ab c012a6ca 
Aug  5 17:43:08 stark kernel:        c013ba2a 00000000 cbc204a0 00000001 c013bd38 ce463f68 00000001 00000004 
Aug  5 17:43:08 stark kernel: Call Trace: [sock_alloc+6/192] [sys_accept+61/256] [__free_pages+27/32] [free_pages+26/32] [poll_freewait+58/80] 
Aug  5 17:43:08 stark kernel:    [do_select+440/464] [select_bits_free+10/16] [sys_select+1151/1168] [sys_socketcall+188/528] [system_call+51/64] 
Aug  5 17:43:08 stark kernel: 
Aug  5 17:43:08 stark kernel: Code: 89 53 08 c7 40 04 dc c5 20 c0 a3 dc c5 20 c0 c7 83 98 00 00 
Aug  5 17:43:14 stark kernel:  <1>Unable to handle kernel paging request at virtual address 1f052a68
Aug  5 17:43:14 stark kernel:  printing eip:
Aug  5 17:43:14 stark kernel: c0140cfc
Aug  5 17:43:14 stark kernel: *pde = 00000000
Aug  5 17:43:14 stark kernel: Oops: 0002
Aug  5 17:43:14 stark kernel: CPU:    0
Aug  5 17:43:14 stark kernel: EIP:    0010:[get_empty_inode+44/160]    Tainted: PF
Aug  5 17:43:14 stark kernel: EFLAGS: 00210202
Aug  5 17:43:14 stark kernel: eax: 1f052a68   ebx: 1f052a60   ecx: c2f390a0   edx: cf794878
Aug  5 17:43:14 stark kernel: esi: 00000008   edi: c027eda0   ebp: 00000002   esp: c88bbf38
Aug  5 17:43:14 stark kernel: ds: 0018   es: 0018   ss: 0018
Aug  5 17:43:14 stark kernel: Process zwgc (pid: 910, stackpage=c88bb000)
Aug  5 17:43:14 stark kernel: Stack: 00000002 c0195e76 00000002 c019677d 00000002 3d4ef172 0805ee00 bffff95c 
Aug  5 17:43:14 stark kernel:        c88ba000 00200286 00000000 cff715b4 bffffa40 00000000 c013bd7a cff715a0 
Aug  5 17:43:14 stark kernel:        c01967ed 00000002 00000002 00000000 c88bbf90 00000000 0805ee00 c01974ec 
Aug  5 17:43:14 stark kernel: Call Trace: [sock_alloc+6/192] [sock_create+173/256] [select_bits_free+10/16] [sys_socket+29/96] [sys_socketcall+108/528] 
Aug  5 17:43:14 stark kernel:    [system_call+51/64] 
Aug  5 17:43:14 stark kernel: 
Aug  5 17:43:14 stark kernel: Code: 89 53 08 c7 40 04 dc c5 20 c0 a3 dc c5 20 c0 c7 83 98 00 00 


-- 
greg

