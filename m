Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbREXMoV>; Thu, 24 May 2001 08:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbREXMoM>; Thu, 24 May 2001 08:44:12 -0400
Received: from u212-239-159-208.goplanet.pi.be ([212.239.159.208]:26121 "EHLO
	jebril.pi.be") by vger.kernel.org with ESMTP id <S261758AbREXMny>;
	Thu, 24 May 2001 08:43:54 -0400
Message-Id: <200105241243.f4OChRL11218@jebril.pi.be>
X-Mailer: exmh version 2.3.1 01/18/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 smp: 16 oopses in a row, then a complete lock up 
Date: Thu, 24 May 2001 14:43:27 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greets,

Upon closing a ppp connection, I got a burst of intense disk activity and 
a whole series of oopses. Trimmed logs are included below (note that some 
oopses are damaged: that's how I found them). After the last one in the
series the machine locked up completely.

A few days ago it also suddenly locked up on me twice, without leaving
anything in the logs.

It's a simle 2.4.4 smp P5 box that has been very stable under most 2.3.x 
and 2.4.x kernels the past year(s), so I guess the problem must be due to 
something relatively new. I skipped 2.4.3, though.

I'll happily provide ksymoops output and/or detailed kernel config info
etc. on request, as I don't want to make this mail even bigger for those
uninterested.

MCE

--------------------------------------------------------------------------

01:34:49: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:34:49:  printing eip:
01:34:49: c01a0275
01:34:49: *pde = 00000000
01:34:49: Oops: 0000
01:34:49: CPU:    0
01:34:49: EIP:    0010:[sockfd_lookup+37/116]
01:34:49: EFLAGS: 00010282
01:34:49: eax: 00000000   ebx: 00000006   ecx: 00000006   edx: c2fef0e0
01:34:49: esi: c2fef0e0   edi: 00000000   ebp: c167bed0   esp: c167be9c
01:34:49: ds: 0018   es: 0018   ss: 0018
01:34:49: Process pppd (pid: 5804, stackpage=c167b000)
01:34:49: Stack: 00000006 bfffeed4 00000000 00000000 c01a11b6 00000006 c167bed0 00000006 
01:34:49:        bfffeed4 bfffee48 bfffef8c c203b2e0 401579e4 c3891260 401579e4 ffffffff 
01:34:49:        00000001 c011fe8d c3891260 c203b2e0 401579e4 c2c3d55c 0168e065 c3891260 
01:34:49: Call Trace: [sys_sendto+42/232] [handle_mm_fault+149/196] [do_page_fault+351/1100] [do_page_fault+0/1100] [do_sigaction+185/276] [sys_send+30/36] [sys_socketcall+281/512] 
01:34:49:        [system_call+55/64] 
01:34:49: 
01:34:49: Code: 8b 58 08 80 bb f8 00 00 00 00 74 0a 8d bb 08 01 00 00 85 ff 
01:34:49: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:34:49:  printing eip:
01:34:49: c013766a
01:34:49: *pde = 00000000
01:34:49: Oops: 0000
01:34:49: CPU:    1
01:34:49: EIP:    0010:[sys_fstat64+26/96]
01:34:49: EFLAGS: 00010282
01:34:49: eax: c0f25ae0   ebx: 00000000   ecx: 00000001   edx: c0f25ae0
01:34:49: esi: fffffff7   edi: c0f25ae0   ebp: bffff0e4   esp: c45bffb4
01:34:49: ds: 0018   es: 0018   ss: 0018
01:34:49: Process date (pid: 10021, stackpage=c45bf000)
01:34:50: Stack: c45be000 bffff144 00000001 c0106c97 00000001 bffff144 40121460 bffff144 
01:34:50:        00000001 bffff0e4 000000c5 0000002b 0000002b 000000c5 400d7d17 00000023 
01:34:50:        00000216 bffff0c8 0000002b 
01:34:50: Call Trace: [system_call+55/64] 
01:34:50: 
01:34:50: Code: 8b 43 08 8b 80 84 00 00 00 85 c0 74 11 8b 40 34 85 c0 74 0a 
01:34:50: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:34:50:  printing eip:
01:34:50: c012f084
01:34:50: *pde = 00000000
01:34:50: Oops: 0000
01:34:50: CPU:    0
01:34:50: EIP:    0010:[sys_read+44/196]
01:34:50: EFLAGS: 00010202
01:34:50: eax: 00000000   ebx: c2fef0e0   ecx: 00000007   edx: c2fef0e0
01:34:50: esi: 00003480   edi: ffffffff   ebp: 00000080   esp: c4eadfb0
01:34:50: ds: 0018   es: 0018   ss: 0018
01:34:50: Process ppp-off (pid: 10018, stackpage=c4ead000)
01:34:50: St>k: tack:  to handle kernel NULL pointer dereferencec4eac000 00003546  at virtual address 00000008
01:34:50: ffffffff  printing eip:
01:34:50: bffff414 c0145357
01:34:50: c0106c97 <1>*pde = 00000000
01:34:50: 00000007 bffff394 00000080 
01:34:50:        00003546 ffffffff bffff414 00000003 0000002b 0000002b 00000003 400df9b4 
01:34:50:        00000023 00000293 bffff354 0000002b 
01:34:50: Call Trace: [system_call+55/64] 
01:34:50: 
01:34:50: Code: 8b 50 08 8b 7b 24 83 ba 9c 00 00 00 00 74 2e 8b 82 8c 00 00 
01:34:50: Oops: 0000
01:34:50: CPU:    1
01:34:50: EIP:    0010:[fcntl_dirnotify+59/352]
01:34:50: EFLAGS: 00010202
01:34:50: eax: 00000000   ebx: c0f25ae0   ecx: 00000000   edx: c0f25ae0
01:34:50: esi: 00000001   edi: 00000000   ebp: 00000001   esp: c45bfe60
01:34:50: ds: 0018   es: 0018   ss: 0018
01:34:50: Process date (pid: 10021, stackpage=c45bf000)
01:34:50: Stack: c0f25ae0 00000001 00000000 00000001 c012ed00 00000000 c0f25ae0 00000000 
01:34:50:        0000001f 00000001 c0f28940 c01151fb c0f25ae0 c0f28940 c0b01ee0 c45be000 
01:34:50:        0000000b c45bff80 c0f28a60 c01159ba c0f28940 00000000 08048000 00000008 
01:34:50: Call Trace: [filp_close+160/188] [put_files_struct+79/184] [do_exit+298/684] [die+86/88] [do_page_fault+851/1100] [do_page_fault+0/1100] [do_page_fault+351/1100] 
01:34:50:        [do_page_fault+0/1100] [unmap_fixup+98/344] [do_munmap+569/584] [error_code+52/64] [sys_fstat64+26/96] [system_call+55/64] 
01:34:50: 
01:34:50: Code: 8b 70 08 66 8b 46 2a 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec 
01:34:51: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:34:51:  printing eip:
01:34:51: c0145357
01:34:51: *pde = 00000000
01:34:51: Oops: 0000
01:34:51: CPU:    0
01:34:51: EIP:    0010:[fcntl_dirnotify+59/352]
01:34:51: EFLAGS: 00010202
01:34:51: eax: 00000000   ebx: c2fef0e0   ecx: 00000000   edx: c2fef0e0
01:34:51: esi: 00000007   edi: 00000000   ebp: 00000001   esp: c4eade5c
01:34:51: ds: 0018   es: 0018   ss: 0018
01:34:51: Process ppp-off (pid: 10018, stackpage=c4ead000)
01:34:51: Stack: c2fef0e0 00000007 00000000 00000001 c012ed00 00000000 c2fef0e0 00000000 
01:34:51:        00000001 00000007 c0f28e20 c01151fb c2fef0e0 c0f28e20 c0c3a0a0 c4eac000 
01:34:51:        0000000b c4eadf7c c0f28f40 c01159ba c0f28e20 00000000 08048000 00000008 
01:34:51: Call Trace: [filp_close+160/188] [put_files_struct+79/184] [do_exit+298/684] [die+86/88] [do_page_fault+851/1100] [do_page_fault+0/1100] [update_atime+68/80] 
01:34:51:        [do_generic_file_read+1355/1368] [generic_file_read+91/116] [error_code+52/64] [sys_read+44/196] [system_call+55/64] 
01:34:51: 
01:34:51: Code: 8b 70 08 66 8b 46 2a 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec 
01:34:51: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:34:51:  printing eip:
01:34:51: c012fd34
01:34:51: *pde = 00000000
01:34:51: Oops: 0000
01:34:51: CPU:    0
01:34:51: EIP:    0010:[fput+12/232]
01:34:51: EFLAGS: 00010246
01:34:51: eax: c0b3b320   ebx: c0b3b320   ecx: 0000000a   edx: c0b3b320
01:34:51: esi: 00000000   edi: 00000400   ebp: 00000000   esp: c4f03f30
01:34:51: ds: 0018   es: 0018   ss: 0018
01:34:51: Process named (pid: 64, stackpage=c4f03000)
01:34:51: Stack: 00000000 c0b3b320 00000400 c4f03f70 c013e69f 00000001 00000004 c0fc48f8 
01:34:51:        00000000 00000145 c4f02000 00000000 0000000a 00000000 00000000 c5229000 
01:34:51:        00000000 c013eaf2 0000000c c4f03fa8 c4f03fa4 c4f02000 00000000 bffffc1c 
01:34:51: Call Trace: [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:34:51: 
01:34:51: Code: 8b 7d 08 f0 ff 4b 14 0f 94 c0 84 c0 0f 84 c5 00 00 00 53 e8 
01:34:51: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:34:51:  printing eip:
01:34:52: c0145357
01:34:52: *pde = 00000000
01:34:52: Oops: 0000
01:34:52: CPU:    0
01:34:52: EIP:    0010:[fcntl_dirnotify+59/352]
01:34:52: EFLAGS: 00010202
01:34:52: eax: 00000000   ebx: c0b3b320   ecx: 00000000   edx: c0b3b320
01:34:52: esi: 0000000a   edi: 00000000   ebp: 00000001   esp: c4f03ddc
01:34:52: ds: 0018   es: 0018   ss: 0018
01:34:52: Process named (pid: 64, stackpage=c4f03000)
01:34:52: Stack: c0b3b320 0000000a 00000000 00000001 c012ed00 00000000 c0b3b320 00000000 
01:34:52:        00000003 0000000a c11b66c0 c01151fb c0b3b320 c11b66c0 c5e24d40 c4f02000 
01:34:52:        0000000b c4f03efc c11b67e0 c01159ba c11b66c0 00000000 08048000 00000008 
01:34:52: Call Trace: [filp_close+160/188] [put_files_struct+79/184] [do_exit+298/684] [die+86/88] [do_page_fault+851/1100] [do_page_fault+0/1100] [udp_queue_rcv_skb+111/224] 
01:34:52:        [schedule+958/1464] [error_code+52/64] [fput+12/232] [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:34:52: 
01:34:52: Code: 8b 70 08 66 8b 46 2a 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec 
01:35:28: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:35:28:  printing eip:
01:35:28: c01200c0
01:35:28: *pde = 00000000
01:35:28: Oops: 0000
01:35:28: CPU:    0
01:35:28: EIP:    0010:[lock_vma_mappings+16/40]
01:35:28: EFLAGS: 00010282
01:35:28: eax: 00000000   ebx: c0a17820   ecx: c5b74d20   edx: 00000000
01:35:28: esi: c5e24d40   edi: 40015000   ebp: 00001000   esp: c133dee4
01:35:28: ds: 0018   es: 0018   ss: 0018
01:35:28: Process sh (pid: 10031, stackpage=c133d000)
01:35:28: Stack: c012118d c0a17820 c5e24d40 c133c000 00000007 c133dfc4 c5b71520 c0111654 
01:35:28:        c5e24d40 c5e24d40 c0115962 c5e24d40 00000007 00000007 c133c000 c0106b41 
01:35:28:        00000007 c133c000 00000004 c010f5a4 bfffef1c c133df40 c133c640 00000007 
01:35:28: Call Trace: [exit_mmap+129/292] [mmput+56/80] [do_exit+210/684] [do_signal+573/668] [do_page_fault+0/1100] [insert_vm_struct+63/76] [do_mmap_pgoff+862/1036] 
01:35:28:        [filp_close+178/188] [sys_close+91/116] [error_code+52/64] [signal_return+20/32] 
01:35:28: 
01:35:28: Code: 8b 40 08 8b 90 a0 00 00 00 85 d2 74 0a f0 fe 4a 2c 0f 88 89 
01:39:40: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:39:40:  printing eip:
01:39:40: c012fd34
01:39:40: *pde = 00000000
01:39:40: Oops: 0000
01:39:40: CPU:    0
01:39:40: EIP:    0010:[fput+12/232]
01:39:40: EFLAGS: 00013246
01:39:40: eax: c34b8c80   ebx: c34b8c80   ecx: 0000000f   edx: c34b8c80
01:39:40: esi: 00000000   edi: 00008000   ebp: 00000000   esp: c49b1f30
01:39:40: ds: 0018   es: 0018   ss: 0018
01:39:40: Process X (pid: 96, stackpage=c49b1000)
01:39:40: Stack: 00000000 c34b8c80 00008000 c49b1f70 c013e69f 00000008 00000020 c4da2b20 
01:39:40:        00000000 00000145 c49b0000 00001de7 0000000f c49b1f68 00000000 c31d0000 
01:39:40:        00000000 c013eaf2 00000014 c49b1fa8 c49b1fa4 c49b0000 00000000 bffff6b4 
01:39:40: Call Trace: [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:39:40: 
01:39:40: Code: 8b 7d 08 f0 ff 4b 14 0f 94 c0 84 c0 0f 84 c5 00 00 00 53 e8 
01:39:40: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:39:40:  printing eip:
01:39:40: c0145357
01:39:40: *pde = 00000000
01:39:40: Oops: 0000
01:39:40: CPU:    0
01:39:40: EIP:    0010:[fcntl_dirnotify+59/352]
01:39:40: EFLAGS: 00013202
01:39:40: eax: 00000000   ebx: c34b8c80   ecx: 00000000   edx: c34b8c80
01:39:40: esi: 0000000f   edi: 00000000   ebp: 00000001   esp: c49b1ddc
01:39:40: ds: 0018   es: 0018   ss: 0018
01:39:40: Process X (pid: 96, stackpage=c49b1000)
01:39:40: Stack: c34b8c80 0000000f 00000000 00000001 c012ed00 00000000 c34b8c80 00000000 
01:39:41:        0000001f 0000000f c4cb9700 c01151fb c34b8c80 c4cb9700 c5e249c0 c49b0000 
01:39:41:        0000000b c49b1efc c4cb9820 c01159ba c4cb9700 00000000 08048000 00000008 
01:39:41: Call Trace: [filp_close+160/188] [put_files_struct+79/184] [do_exit+298/684] [die+86/88] [do_page_fault+851/1100] [do_page_fault+0/1100] [sock_def_readable+54/96] 
01:39:41:        [ide-cd:__insmod_ide-cd_O/lib/modules/2.4.4/kernel/drivers/ide/ide-+-188718/96] [sock_sendmsg+105/136] [__alloc_pages+205/696] [__pollwait+136/144] [error_code+52/64] [fput+12/232] [do_select+283/516] [sys_select+834/1164] 
01:39:41:        [system_call+55/64] 
01:39:41: 
01:39:41: Code: 8b 70 08 66 8b 46 2a 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec 
01:39:41: VFS: Close: file count is 0
01:39:41: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:39:41:  printing eip:
01:39:41: c012fd34
01:39:41: *pde = 00000000
01:39:41: Oops: 0000
01:39:41: CPU:    0
01:39:41: EIP:    0010:[fput+12/232]
01:39:41: EFLAGS: 00010246
01:39:41: eax: c3317f00   ebx: c3317f00   ecx: 00000006   edx: c3317f00
01:39:41: esi: 00000000   edi: 00000040   ebp: 00000000   esp: c34b5f30
01:39:41: ds: 0018   es: 0018   ss: 0018
01:39:41: Process xppp (pid: 178, stackpage=c34b5000)
01:39:41: Stack: 00000000 c3317f00 00000040 c34b5f70 c013e69f 00000001 00000004 c34fcbb8 
01:39:41:        00000000 00000145 c34b4000 7fffffff 00000006 00000000 00000000 c4e0a000 
01:39:41:        00000000 c013eaf2 00000007 c34b5fa8 c34b5fa4 c34b4000 bffff73c 00000000 
01:39:41: Call Trace: [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:39:41: 
01:39:41: Code: 8b 7d 08 f0 ff 4b 14 0f 94 c0 84 c0 0f 84 c5 00 00 00 53 e8 
01:39:41: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:39:41:  printing eip:
01:39:41: c012fd34
01:39:42: *pde = 00000000
01:39:42: Oops: 0000
01:39:42: CPU:    1
01:39:42: EIP:    0010:[fput+12/232]
01:39:42: EFLAGS: 00010286
01:39:42: eax: c2b59de0   ebx: c2b59de0   ecx: c237ac7c   edx: c1600000
01:39:42: Unable to handle kernel NULL p<inte>Un debleefeto encand ce k601rne9c
01:39:42:  printing eip:
01:39:42:  printing eip:
01:39:42: ci014: 435761, stackpage=c1601000)<1>ack:
01:39:42:        bffff7f0 c0106c97 00000000 40017000 00001000 08057bd0 080617e6 bffff7f0 
01:39:42:        00000003 0000002b 0000002b 00000003 401199b4 00000023 00000297 bffff7c0 
01:39:42: Call Trace: [sys_read+188/196] [system_call+55/64] 
01:39:42: 
01:39:42: Code: 8b 7d 08 f0 ff 4b 14 0f 94 c0 84 c0 0f 84 c5 00 00 00 53 e8 
01:39:42: Oops: 0000
01:39:42: CPU:    0
01:39:42: EIP:    0010:[fcntl_dirnotify+59/352]
01:39:42: EFLAGS: 00010202
01:39:42: eax: 00000000   ebx: c3317f00   ecx: 00000000   edx: c3317f00
01:39:42: esi: 00000006   edi: 00000000   ebp: 00000001   esp: c34b5ddc
01:39:42: ds: 0018   es: 0018   ss: 0018
01:39:42: Process xppp (pid: 178, stackpage=c34b5000)
01:39:42: Stack: c3317f00 00000006 00000000 00000001 c012ed00 00000000 c3317f00 00000000 
01:39:42:        00000001 00000006 c5b8dbc0 c01151fb c3317f00 c5b8dbc0 c5f59e20 c34b4000 
01:39:43:        0000000b c34b5efc c5b8dce0 c01159ba c5b8dbc0 00000000 08048000 00000008 
01:39:43: Call Trace: [filp_close+160/188] [put_files_struct+79/184] [do_exit+298/684] [die+86/88] [do_page_fault+851/1100] [do_page_fault+0/1100] [reschedule_idle+99/536] 
01:39:43:        [schedule+958/1464] [error_code+52/64] [fput+12/232] [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:39:43: 
01:39:43: Code: 8b 70 08 66 8b 46 2a 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec 
01:39:43: VFS: Close: file count is 0
01:39:43: VFS: Close: file count is 0
01:39:43: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:39:43:  printing eip:
01:39:43: c012fd34
01:39:43: *pde = 00000000
01:39:43: Oops: 0000
01:39:43: CPU:    1
01:39:43: EIP:    0010:[fput+12/232]
01:39:43: EFLAGS: 00010246
01:39:43: eax: c33172a0   ebx: c33172a0   ecx: 0000000c   edx: c33172a0
01:39:43: esi: 00000000   edi: 00001000   ebp: 00000000   esp: c34e5f30
01:39:43: ds: 0018   es: 0018   ss: 0018
01:39:43: Process exmh (pid: 179, stackpage=c34e5000)
01:39:43: Stack: 00000000 c33172a0 00001000 c34e5f70 c013e69f 00000001 00000004 c0fc42b8 
01:39:43:        00000001 00000145 c34e4000 00000a6c 0000000c 00000000 00000000 c23ee000 
01:39:43:        00000000 c013eaf2 0000000d c34e5fa8 c34e5fa4 c34e4000 08049ff4 bffff72c 
01:39:43: Call Trace: [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:39:43: 
01:39:43: Code: 8b 7d 08 f0 ff 4b 14 0f 94 c0 84 c0 0f 84 c5 00 00 00 53 e8 
01:39:43: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:39:43:  printing eip:
01:39:43: c012fd34
01:39:43: *pde = 00000000
01:39:43: Oops: 0000
01:39:43: CPU:    0
01:39:43: EIP:    0010:[fput+12/232]
01:39:44: EFLAGS: 00010246
01:39:44: eax: c34b8860   ebx: c34b8860   ecx: 00000006   edx: c34b8860
01:39:44: esi: 00000000   edi: 00000040   ebp: 00000000   esp: c34ddf30
01:39:44: ds: 0018   es: 0018   ss: 0018
01:39:44: Process xload (pid: 176, stackpage=c34dd000)
01:39:44: Stack: 00000000 c34b8860 00000040 c34ddf70 c013e69f 00000001 00000004 c5f993f8 
01:39:44:        00000000 00000145 c34dc000 000002a1 00000006 00000000 00000000 c167d000 
01:39:44:        00000000 c013eaf2 00000007 c34ddfa8 c34ddfa4 c34dc000 bffff21c bffff2bc 
01:39:44: Call Trace: [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:39:44: 
01:39:44: Code: 8b 7d 08 f0 ff 4b 14 0f 94 c0 84 c0 0f 84 c5 00 00 00 53 e8 
01:39:44: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:39:44:  printing eip:
01:39:44: c0145357
01:39:44: *pde = 00000000
01:39:44: Oops: 0000
01:39:44: CPU:    0
01:39:44: EIP:    0010:[fcntl_dirnotify+59/352]
01:39:44: EFLAGS: 00010202
01:39:44: eax: 00000000   ebx: c34b8860   ecx: 00000000   edx: c34b8860
01:39:44: esi: 00000006   edi: 00000000   ebp: 00000001   esp: c34ddddc
01:39:44: ds: 0018   es: 0018   ss: 0018
01:39:44: Process xload (pid: 176, stackpage=c34dd000)
01:39:44: Stack: c34b8860 00000006 00000000 00000001 c012ed00 00000000 c34b8860 00000000 
01:39:44:        00000003 00000006 c5b8d880 c01151fb c34b8860 c5b8d880 c5f59d20 c34dc000 
01:39:44:        0000000b c34ddefc c5b8d9a0 c01159ba c5b8d880 00000000 08048000 00000008 
01:39:44: Call Trace: [filp_close+160/188] [put_files_struct+79/184] [do_exit+298/684] [die+86/88] [do_page_fault+851/1100] [do_page_fault+0/1100] [schedule+958/1464] 
01:39:44:        [error_code+52/64] [fput+12/232] [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:39:44: 
01:39:44: Code: 8b 70 08 66 8b 46 2a 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec 
01:39:44: VFS: Close: file count is 0
01:39:44: VFS: Close: file count is 0
01:39:44: Unable to handle kernel NULL pointer dereference at virtual address 00000008
01:39:44:  printing eip:
01:39:44: c0145357
01:39:44: *pde = 00000000
01:39:45: Oops: 0000
01:39:45: CPU:    1
01:39:45: EIP:    0010:[fcntl_dirnotify+59/352]
01:39:45: EFLAGS: 00010202
01:39:45: eax: 00000000   ebx: c33172a0   ecx: 00000000   edx: c33172a0
01:39:45: esi: 0000000c   edi: 00000000   ebp: 00000001   esp: c34e5ddc
01:39:45: ds: 0018   es: 0018   ss: 0018
01:39:45: Process exmh (pid: 179, stackpage=c34e5000)
01:39:45: Stack: c33172a0 0000000c 00000000 00000001 c012ed00 00000000 c33172a0 00000000 
01:39:45:        00000005 0000000c c4cb93c0 c01151fb c33172a0 c4cb93c0 c5e24740 c34e4000 
01:39:45:        0000000b c34e5efc c4cb94e0 c01159ba c4cb93c0 00000000 08048000 00000008 
01:39:45: Call Trace: [filp_close+160/188] [put_files_struct+79/184] [do_exit+298/684] [die+86/88] [do_page_fault+851/1100] [do_page_fault+0/1100] [reschedule_idle+99/536] 
01:39:45:        [__switch_to+62/216] [schedule+958/1464] [error_code+52/64] [fput+12/232] [do_select+283/516] [sys_select+834/1164] [system_call+55/64] 
01:39:45: 
01:39:45: Code: 8b 70 08 66 8b 46 2a 25 00 f0 ff ff 66 3d 00 40 74 0a b8 ec 

-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1              mce@pi.be
GCS d+ s+:- a35 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

