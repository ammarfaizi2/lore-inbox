Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbTCZHLo>; Wed, 26 Mar 2003 02:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbTCZHLo>; Wed, 26 Mar 2003 02:11:44 -0500
Received: from lakemtao03.cox.net ([68.1.17.242]:42903 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP
	id <S261492AbTCZHLj>; Wed, 26 Mar 2003 02:11:39 -0500
Message-ID: <3E8155B1.5000506@cox.net>
Date: Wed, 26 Mar 2003 01:24:33 -0600
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.66 crashes and lockups (modutils & gdm-binary)
Content-Type: multipart/mixed;
 boundary="------------030402060800040308000108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030402060800040308000108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I never had any problems with any kernel before 2.5.66 (beta or stable) 
locking up or crashing.
I activated the NMI watchdog and still have been getting some really 
massive lockups, but now I'm getting some crash dumps. Attached is a 
group of snippets from my /var/log/messages from a couple of bootups.

If any information is needed, just ask.

Regards,
David

--------------030402060800040308000108
Content-Type: text/plain;
 name="kernel.messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel.messages"

Mar 26 00:31:55 aeon kernel: Unable to handle kernel paging request at virtual address dbfc0030
Mar 26 00:31:55 aeon kernel:  printing eip:
Mar 26 00:31:55 aeon kernel: c013c532
Mar 26 00:31:55 aeon kernel: *pde = 1bc001e3
Mar 26 00:31:55 aeon kernel: Oops: 0000 [#1]
Mar 26 00:31:55 aeon kernel: CPU:    0
Mar 26 00:31:55 aeon kernel: EIP:    0060:[<c013c532>]    Tainted: PF 
Mar 26 00:31:55 aeon kernel: EFLAGS: 00010286
Mar 26 00:31:55 aeon kernel: EIP is at handle_mm_fault+0x58/0x15e
Mar 26 00:31:55 aeon kernel: eax: dbfc0030   ebx: da88c400   ecx: 00000007   edx: dbfc0030
Mar 26 00:31:55 aeon kernel: esi: 4000c3b0   edi: dd64dc80   ebp: dc09ff04   esp: dc09fedc
Mar 26 00:31:55 aeon kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 00:31:55 aeon kernel: Process modprobe (pid: 1185, threadinfo=dc09e000 task=dc07f880)
Mar 26 00:31:55 aeon kernel: Stack: dd64dc80 de6e4740 42010f07 00000000 dc09d040 da88c420 d9064b20 dd64dc80 
Mar 26 00:31:55 aeon kernel:        dd64dca0 4000c3b0 dc09ffb4 c0118dcd dd64dc80 de6e44c0 4000c3b0 00000000 
Mar 26 00:31:55 aeon kernel:        00000000 de6e44c0 dc07f880 00000000 00000002 00030002 00000000 00100073 
Mar 26 00:31:55 aeon kernel: Call Trace:
Mar 26 00:31:55 aeon kernel:  [<c0118dcd>] do_page_fault+0x131/0x430
Mar 26 00:31:55 aeon kernel:  [<c011067b>] old_mmap+0xd3/0x12a
Mar 26 00:31:55 aeon kernel:  [<c0147a9f>] filp_close+0x4b/0x74
Mar 26 00:31:55 aeon kernel:  [<c0118c9c>] do_page_fault+0x0/0x430
Mar 26 00:31:55 aeon kernel:  [<c010b5bd>] error_code+0x2d/0x38
Mar 26 00:31:55 aeon kernel: 
Mar 26 00:31:55 aeon kernel: Code: 8b 00 a8 81 0f 85 86 00 00 00 85 c0 74 5e a9 40 00 00 00 74 
Mar 26 00:31:55 aeon kernel:  <6>note: modprobe[1185] exited with preempt_count 1
Mar 26 00:31:58 aeon kernel: Unable to handle kernel paging request at virtual address dbc9d148
Mar 26 00:31:58 aeon kernel:  printing eip:
Mar 26 00:31:58 aeon kernel: c013c532
Mar 26 00:31:58 aeon kernel: *pde = 1bc001e3
Mar 26 00:31:58 aeon kernel: Oops: 0000 [#2]
Mar 26 00:31:58 aeon kernel: CPU:    0
Mar 26 00:31:58 aeon kernel: EIP:    0060:[<c013c532>]    Tainted: PF 
Mar 26 00:31:58 aeon kernel: EFLAGS: 00010286
Mar 26 00:31:58 aeon kernel: EIP is at handle_mm_fault+0x58/0x15e
Mar 26 00:31:58 aeon kernel: eax: dbc9d148   ebx: da82e420   ecx: 00000007   edx: dbc9d148
Mar 26 00:31:58 aeon kernel: esi: 42052500   edi: de6e5980   ebp: d989bf04   esp: d989bedc
Mar 26 00:31:58 aeon kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 00:31:58 aeon kernel: Process modprobe (pid: 1188, threadinfo=d989a000 task=da99b300)
Mar 26 00:31:58 aeon kernel: Stack: de6e5980 de6e44c0 420af9c0 00000000 dbc9d2bc da82e420 0001c000 de6e5980 
Mar 26 00:31:58 aeon kernel:        de6e59a0 42052500 d989bfb4 c0118dcd de6e5980 de6e44c0 42052500 00000000 
Mar 26 00:31:58 aeon kernel:        00000000 de6e44c0 da99b300 c013d340 de6e5980 00030002 de6e4880 de6e4864 
Mar 26 00:31:58 aeon kernel: Call Trace:
Mar 26 00:31:58 aeon kernel:  [<c0118dcd>] do_page_fault+0x131/0x430
Mar 26 00:31:58 aeon kernel:  [<c013d340>] vma_link+0x58/0x76
Mar 26 00:31:58 aeon kernel:  [<c014f8c6>] vfs_fstat+0x14/0x4e
Mar 26 00:31:58 aeon kernel:  [<c014fe95>] sys_fstat64+0x1b/0x38
Mar 26 00:31:58 aeon kernel:  [<c0128d08>] sys_newuname+0x8a/0x8e
Mar 26 00:31:58 aeon kernel:  [<c0118c9c>] do_page_fault+0x0/0x430
Mar 26 00:31:58 aeon kernel:  [<c010b5bd>] error_code+0x2d/0x38
Mar 26 00:31:58 aeon kernel: 
Mar 26 00:31:58 aeon kernel: Code: 8b 00 a8 81 0f 85 86 00 00 00 85 c0 74 5e a9 40 00 00 00 74 
Mar 26 00:31:58 aeon kernel:  <6>note: modprobe[1188] exited with preempt_count 1

Mar 26 00:36:11 aeon kernel: general protection fault: 0000 [#1]
Mar 26 00:36:11 aeon kernel: CPU:    0
Mar 26 00:36:11 aeon kernel: EIP:    0060:[<c0140192>]    Tainted: PF 
Mar 26 00:36:11 aeon kernel: EFLAGS: 00010286
Mar 26 00:36:11 aeon kernel: EIP is at page_remove_rmap+0xbc/0x12e
Mar 26 00:36:11 aeon kernel: eax: ffffffff   ebx: d9f51b80   ecx: ffffffff   edx: 0000001f
Mar 26 00:36:11 aeon kernel: esi: c14626c0   edi: 00000000   ebp: d95d7b64   esp: d95d7b48
Mar 26 00:36:11 aeon kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 00:36:11 aeon kernel: Process gdm-binary (pid: 1438, threadinfo=d95d6000 task=dc2ded80)
Mar 26 00:36:11 aeon kernel: Stack: d5bad14c ffffffff d9f51b80 15bad14c d5bad14c 0000b000 0002b000 d95d7b94 
Mar 26 00:36:11 aeon kernel:        c013ad1b c14626e8 00000007 d95d7bc0 d95d7ba4 c14626c0 1c0f8005 c0434894 
Mar 26 00:36:11 aeon kernel:        d72ea084 08448000 08073000 d95d7bbc c013ade2 c0434894 d72ea080 08048000 
Mar 26 00:36:11 aeon kernel: Call Trace:
Mar 26 00:36:11 aeon kernel:  [<c013ad1b>] zap_pte_range+0x15b/0x1d6
Mar 26 00:36:11 aeon kernel:  [<c013ade2>] zap_pmd_range+0x4c/0x68
Mar 26 00:36:11 aeon kernel:  [<c013ae3f>] unmap_page_range+0x41/0x68
Mar 26 00:36:11 aeon kernel:  [<c013af38>] unmap_vmas+0xd2/0x222
Mar 26 00:36:11 aeon kernel:  [<c013e752>] exit_mmap+0x76/0x172
Mar 26 00:36:11 aeon kernel:  [<c011b8e4>] mmput+0x3e/0x80
Mar 26 00:36:11 aeon kernel:  [<c0150882>] exec_mmap+0x8e/0xf2
Mar 26 00:36:11 aeon kernel:  [<c015094a>] flush_old_exec+0x1a/0x6e8
Mar 26 00:36:11 aeon kernel:  [<c01507e6>] kernel_read+0x4a/0x58
Mar 26 00:36:11 aeon kernel:  [<c016a5df>] load_elf_binary+0x2f7/0xc5a
Mar 26 00:36:11 aeon kernel:  [<c01340bb>] __alloc_pages+0x83/0x2aa
Mar 26 00:36:11 aeon kernel:  [<c015036e>] copy_strings+0x1c2/0x236
Mar 26 00:36:11 aeon kernel:  [<c015138c>] search_binary_handler+0x104/0x1a8
Mar 26 00:36:11 aeon kernel:  [<c01515b4>] do_execve+0x184/0x1c8
Mar 26 00:36:11 aeon kernel:  [<c0109697>] sys_execve+0x4b/0x7a
Mar 26 00:36:11 aeon kernel:  [<c010ab93>] syscall_call+0x7/0xb
Mar 26 00:36:11 aeon kernel: 
Mar 26 00:36:11 aeon kernel: Code: 8b 01 85 c0 89 45 e8 74 03 0f 18 00 31 d2 8b 44 91 04 85 c0 
Mar 26 00:36:11 aeon kernel:  <6>note: gdm-binary[1438] exited with preempt_count 1
Mar 26 00:36:11 aeon kernel: Unable to handle kernel paging request at virtual address da073600
Mar 26 00:36:11 aeon kernel:  printing eip:
Mar 26 00:36:11 aeon kernel: c0140544
Mar 26 00:36:11 aeon kernel: *pde = 1a0001e3
Mar 26 00:36:11 aeon kernel: Oops: 0000 [#2]
Mar 26 00:36:11 aeon kernel: CPU:    0
Mar 26 00:36:11 aeon kernel: EIP:    0060:[<c0140544>]    Tainted: PF 
Mar 26 00:36:11 aeon kernel: EFLAGS: 00010296
Mar 26 00:36:11 aeon kernel: EIP is at __pte_chain_free+0xc/0x42
Mar 26 00:36:11 aeon kernel: eax: 00000000   ebx: da073600   ecx: 15fc24d0   edx: 00000004
Mar 26 00:36:11 aeon kernel: esi: da073600   edi: da073600   ebp: d95d7e94   esp: d95d7e88
Mar 26 00:36:11 aeon kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 00:36:11 aeon kernel: Process gdm-binary (pid: 1440, threadinfo=d95d6000 task=dc2ded80)
Mar 26 00:36:11 aeon kernel: Stack: c1363aa8 d5fc24d0 00000001 d95d7ed4 c013b79b da073600 00000007 c1363aa8 
Mar 26 00:36:11 aeon kernel:        db49b000 000004d0 d5b11000 dd2c0680 d95d7ed4 c1363aa8 da073600 c1443838 
Mar 26 00:36:11 aeon kernel:        d7d9b420 42134654 dd2c0680 d95d7f04 c013c629 dd2c0680 d7c3ac40 42134654 
Mar 26 00:36:11 aeon kernel: Call Trace:
Mar 26 00:36:11 aeon kernel:  [<c013b79b>] do_wp_page+0x99/0x342
Mar 26 00:36:11 aeon kernel:  [<c013c629>] handle_mm_fault+0x14f/0x15e
Mar 26 00:36:11 aeon kernel:  [<c0118dcd>] do_page_fault+0x131/0x430
Mar 26 00:36:11 aeon kernel:  [<c0109697>] sys_execve+0x4b/0x7a
Mar 26 00:36:11 aeon kernel:  [<c0118c9c>] do_page_fault+0x0/0x430
Mar 26 00:36:11 aeon kernel:  [<c010b5bd>] error_code+0x2d/0x38
Mar 26 00:36:11 aeon kernel: 
Mar 26 00:36:11 aeon kernel: Code: 8b 03 85 c0 74 06 c7 03 00 00 00 00 8b 15 6c e4 38 c0 85 d2 
Mar 26 00:36:11 aeon kernel:  general protection fault: 0000 [#3]
Mar 26 00:36:11 aeon kernel: CPU:    0
Mar 26 00:36:11 aeon kernel: EIP:    0060:[<c0140192>]    Tainted: PF 
Mar 26 00:36:11 aeon kernel: EFLAGS: 00010286
Mar 26 00:36:11 aeon kernel: EIP is at page_remove_rmap+0xbc/0x12e
Mar 26 00:36:11 aeon kernel: eax: ffffffff   ebx: d9f51b80   ecx: ffffffff   edx: 0000001f
Mar 26 00:36:11 aeon kernel: esi: c14626c0   edi: 00000000   ebp: d95d7a74   esp: d95d7a58
Mar 26 00:36:11 aeon kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 00:36:11 aeon kernel: Process gdm-binary (pid: 1441, threadinfo=d95d6000 task=dc2ded80)
Mar 26 00:36:11 aeon kernel: Stack: d3f0714c ffffffff d9f51b80 13f0714c d3f0714c 0000b000 0002b000 d95d7aa4 
Mar 26 00:36:11 aeon kernel:        c013ad1b c14626e8 00000007 d95d7ad0 d95d7ab4 c14626c0 1c0f8005 c0434894 
Mar 26 00:36:11 aeon kernel:        d7d9b084 08448000 08073000 d95d7acc c013ade2 c0434894 d7d9b080 08048000 
Mar 26 00:36:11 aeon kernel: Call Trace:
Mar 26 00:36:11 aeon kernel:  [<c013ad1b>] zap_pte_range+0x15b/0x1d6
Mar 26 00:36:11 aeon kernel:  [<c013ade2>] zap_pmd_range+0x4c/0x68
Mar 26 00:36:11 aeon kernel:  [<c013ae3f>] unmap_page_range+0x41/0x68
Mar 26 00:36:11 aeon kernel:  [<c013af38>] unmap_vmas+0xd2/0x222
Mar 26 00:36:11 aeon kernel:  [<c013e752>] exit_mmap+0x76/0x172
Mar 26 00:36:11 aeon kernel:  [<c011b8e4>] mmput+0x3e/0x80
Mar 26 00:36:11 aeon kernel:  [<c0150882>] exec_mmap+0x8e/0xf2
Mar 26 00:36:11 aeon kernel:  [<c015094a>] flush_old_exec+0x1a/0x6e8
Mar 26 00:36:11 aeon kernel:  [<c01507e6>] kernel_read+0x4a/0x58
Mar 26 00:36:11 aeon kernel:  [<c016a5df>] load_elf_binary+0x2f7/0xc5a
Mar 26 00:36:11 aeon kernel:  [<c01477de>] dentry_open+0x1aa/0x1c8
Mar 26 00:36:11 aeon kernel:  [<c015138c>] search_binary_handler+0x104/0x1a8
Mar 26 00:36:11 aeon kernel:  [<c01510e6>] prepare_binprm+0xce/0xe0
Mar 26 00:36:11 aeon kernel:  [<c0169acd>] load_script+0x209/0x23c
Mar 26 00:36:11 aeon kernel:  [<c0133fcf>] buffered_rmqueue+0x93/0xfc
Mar 26 00:36:11 aeon kernel:  [<c01340bb>] __alloc_pages+0x83/0x2aa
Mar 26 00:36:11 aeon kernel:  [<c01eaa2a>] __copy_from_user_ll+0x70/0x76
Mar 26 00:36:11 aeon kernel:  [<c015138c>] search_binary_handler+0x104/0x1a8
Mar 26 00:36:11 aeon kernel:  [<c01515b4>] do_execve+0x184/0x1c8
Mar 26 00:36:11 aeon kernel:  [<c0109697>] sys_execve+0x4b/0x7a
Mar 26 00:36:11 aeon kernel:  [<c010ab93>] syscall_call+0x7/0xb
Mar 26 00:36:11 aeon kernel: 
Mar 26 00:36:11 aeon kernel: Code: 8b 01 85 c0 89 45 e8 74 03 0f 18 00 31 d2 8b 44 91 04 85 c0 
Mar 26 00:36:11 aeon kernel:  <6>note: gdm-binary[1441] exited with preempt_count 1

Mar 26 00:47:29 aeon kernel: Unable to handle kernel paging request at virtual address dc084000
Mar 26 00:47:29 aeon kernel:  printing eip:
Mar 26 00:47:29 aeon kernel: c013c532
Mar 26 00:47:29 aeon kernel: *pde = 1c0001e3
Mar 26 00:47:29 aeon kernel: Oops: 0000 [#1]
Mar 26 00:47:29 aeon kernel: CPU:    0
Mar 26 00:47:29 aeon kernel: EIP:    0060:[<c013c532>]    Tainted: PF 
Mar 26 00:47:29 aeon kernel: EFLAGS: 00010286
Mar 26 00:47:29 aeon kernel: EIP is at handle_mm_fault+0x58/0x15e
Mar 26 00:47:29 aeon kernel: eax: dc084000   ebx: db820400   ecx: 00000007   edx: dc084000
Mar 26 00:47:29 aeon kernel: esi: 40000a50   edi: df7eee00   ebp: dbfebf04   esp: dbfebedc
Mar 26 00:47:29 aeon kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 00:47:29 aeon kernel: Process modprobe (pid: 1147, threadinfo=dbfea000 task=dab97280)
Mar 26 00:47:29 aeon kernel: Stack: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 df7eee00 
Mar 26 00:47:29 aeon kernel:        df7eee20 40000a50 dbfebfb4 c0118dcd df7eee00 dcdb3340 40000a50 00000000 
Mar 26 00:47:29 aeon kernel:        00000000 dcdb3340 dab97280 00000000 00000000 00030002 df7eee00 bffffee0 
Mar 26 00:47:29 aeon kernel: Call Trace:
Mar 26 00:47:29 aeon kernel:  [<c0118dcd>] do_page_fault+0x131/0x430
Mar 26 00:47:29 aeon kernel:  [<c01096c4>] sys_execve+0x78/0x7a
Mar 26 00:47:29 aeon kernel:  [<c010abde>] work_notifysig+0x13/0x15
Mar 26 00:47:29 aeon kernel:  [<c0118c9c>] do_page_fault+0x0/0x430
Mar 26 00:47:29 aeon kernel:  [<c010b5bd>] error_code+0x2d/0x38
Mar 26 00:47:29 aeon kernel: 
Mar 26 00:47:29 aeon kernel: Code: 8b 00 a8 81 0f 85 86 00 00 00 85 c0 74 5e a9 40 00 00 00 74 
Mar 26 00:47:29 aeon kernel:  <6>note: modprobe[1147] exited with preempt_count 1

Mar 26 00:54:09 aeon kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001
Mar 26 00:54:09 aeon kernel:  printing eip:
Mar 26 00:54:09 aeon kernel: c012e067
Mar 26 00:54:09 aeon kernel: *pde = 00000000
Mar 26 00:54:09 aeon kernel: Oops: 0000 [#1]
Mar 26 00:54:09 aeon kernel: CPU:    0
Mar 26 00:54:09 aeon kernel: EIP:    0060:[<c012e067>]    Tainted: PF 
Mar 26 00:54:09 aeon kernel: EFLAGS: 00010246
Mar 26 00:54:09 aeon kernel: EIP is at print_unload_info+0x73/0xfc
Mar 26 00:54:09 aeon kernel: eax: 00000000   ebx: 00000001   ecx: 00001000   edx: c033e1b0
Mar 26 00:54:09 aeon kernel: esi: e08d9000   edi: dd56ea00   ebp: dc58df04   esp: dc58dee4
Mar 26 00:54:09 aeon kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 00:54:09 aeon kernel: Process lsmod (pid: 1447, threadinfo=dc58c000 task=d6746180)
Mar 26 00:54:09 aeon kernel: Stack: dd56ea00 c033e1ad c0fff33c 00000001 e08d8e80 e08d8e84 e08d8e80 dd56ea00 
Mar 26 00:54:09 aeon kernel:        dc58df28 c012f7ad dd56ea00 e08d8e80 e08d8e8c 00004080 00000400 dd56ea00 
Mar 26 00:54:09 aeon kernel:        e08d8e84 dc58df70 c0160b68 dd56ea00 e08d8e84 dc58df54 dc6d3080 dc597d80 
Mar 26 00:54:09 aeon kernel: Call Trace:
Mar 26 00:54:09 aeon kernel:  [<e08d8e80>] +0x0/0x200 [snd_mixer_oss]
Mar 26 00:54:09 aeon kernel:  [<e08d8e84>] +0x4/0x200 [snd_mixer_oss]
Mar 26 00:54:09 aeon kernel:  [<e08d8e80>] +0x0/0x200 [snd_mixer_oss]
Mar 26 00:54:09 aeon kernel:  [<c012f7ad>] m_show+0x45/0xac
Mar 26 00:54:09 aeon kernel:  [<e08d8e80>] +0x0/0x200 [snd_mixer_oss]
Mar 26 00:54:09 aeon kernel:  [<e08d8e8c>] +0xc/0x200 [snd_mixer_oss]
Mar 26 00:54:09 aeon kernel:  [<e08d8e84>] +0x4/0x200 [snd_mixer_oss]
Mar 26 00:54:09 aeon kernel:  [<c0160b68>] seq_read+0x1bc/0x2e2
Mar 26 00:54:09 aeon kernel:  [<e08d8e84>] +0x4/0x200 [snd_mixer_oss]
Mar 26 00:54:09 aeon kernel:  [<c0148188>] vfs_read+0xb0/0x146
Mar 26 00:54:09 aeon kernel:  [<c0148456>] sys_read+0x3c/0x52
Mar 26 00:54:09 aeon kernel:  [<c010ab93>] syscall_call+0x7/0xb
Mar 26 00:54:09 aeon kernel: 
Mar 26 00:54:09 aeon kernel: Code: 8b 03 0f 18 00 39 f3 75 db 8b 45 f0 8b 80 a4 00 00 00 85 c0 
Mar 26 00:54:09 aeon kernel:  <1>Unable to handle kernel paging request at virtual address dad82004

Mar 26 00:59:21 aeon kernel: Unable to handle kernel paging request at virtual address d967cc84
Mar 26 00:59:21 aeon kernel:  printing eip:
Mar 26 00:59:21 aeon kernel: c0149173
Mar 26 00:59:21 aeon kernel: *pde = 194001e3
Mar 26 00:59:21 aeon kernel: Oops: 0002 [#1]
Mar 26 00:59:21 aeon kernel: CPU:    0
Mar 26 00:59:21 aeon kernel: EIP:    0060:[<c0149173>]    Tainted: PF 
Mar 26 00:59:21 aeon kernel: EFLAGS: 00010287
Mar 26 00:59:21 aeon kernel: EIP is at file_kill+0xf/0x1c
Mar 26 00:59:21 aeon kernel: eax: d5da4b00   ebx: dde24e80   ecx: dde24e80   edx: d967cc80
Mar 26 00:59:21 aeon kernel: esi: dfff6440   edi: dffde57c   ebp: d8609f24   esp: d8609f24
Mar 26 00:59:21 aeon kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 00:59:21 aeon kernel: Process modprobe (pid: 1351, threadinfo=d8608000 task=dab8b280)
Mar 26 00:59:21 aeon kernel: Stack: d8609f44 c014907e dde24e80 dde24e80 dfb94e80 da36db00 dcec3c80 dcec3c80 
Mar 26 00:59:21 aeon kernel:        d8609f58 c013e03d da36db00 40030000 00000000 d8609f70 c013e065 dcec3c80 
Mar 26 00:59:21 aeon kernel:        da36db00 40030000 40014000 d8609fa0 c013e3f2 dcec3c80 da36db00 d7c1bec0 
Mar 26 00:59:21 aeon kernel: Call Trace:
Mar 26 00:59:21 aeon kernel:  [<c014907e>] __fput+0x76/0xd2
Mar 26 00:59:21 aeon kernel:  [<c013e03d>] unmap_vma+0x71/0x7c
Mar 26 00:59:21 aeon kernel:  [<c013e065>] unmap_vma_list+0x1d/0x2a
Mar 26 00:59:21 aeon kernel:  [<c013e3f2>] do_munmap+0x134/0x17c
Mar 26 00:59:21 aeon kernel:  [<c013e47d>] sys_munmap+0x43/0x62
Mar 26 00:59:21 aeon kernel:  [<c010ab93>] syscall_call+0x7/0xb
Mar 26 00:59:21 aeon kernel: 
Mar 26 00:59:21 aeon kernel: Code: 89 42 04 89 10 89 49 04 89 09 5d c3 90 55 89 e5 53 8b 45 08 

--------------030402060800040308000108--

