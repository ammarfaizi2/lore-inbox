Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTEEInY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTEEInY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:43:24 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:18706 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262101AbTEEInU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:43:20 -0400
Subject: 2.4.19 oops + memory.c:306: bad pmd c30b63e8(0000000028d2d027)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-PxS9DIvHDuJUtO93dh0e"
Organization: 
Message-Id: <1052124911.11946.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 May 2003 10:55:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PxS9DIvHDuJUtO93dh0e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

A machine, running for quite a ~2 months stably now, just crashed with a
kernel panic leaving pretty strange messages, like

swap_free: Unused swap offset entry 00001000
swap_dup: Bad swap file entry 00000020

and

memory.c:306: bad pmd c30b63e8(0000000028d2d027) 
memory.c:306: bad pmd c30b6488(000000002b891066)

in the logs...
I am not sure whether this is a memory problem or a kernel bug... oops+
relevant part of the logfile is attached.


--=-PxS9DIvHDuJUtO93dh0e
Content-Disposition: attachment; filename=report
Content-Type: text/plain; name=report; charset=ansi_x3.4-1968
Content-Transfer-Encoding: 7bit

May  4 22:34:51 rumba kernel: swap_free: Bad swap file entry 00000040
May  4 23:00:57 rumba kernel: VM: killing process sshd
May  4 23:00:57 rumba kernel: swap_free: Unused swap offset entry 00002000
May  4 23:00:57 rumba kernel: swap_free: Unused swap offset entry 00008000
May  4 23:00:57 rumba kernel: swap_free: Unused swap offset entry 00002000
May  4 23:05:57 rumba kernel: VM: killing process sshd
May  4 23:05:57 rumba kernel: swap_free: Unused swap offset entry 00000100
May  4 23:10:57 rumba kernel: VM: killing process sshd
May  4 23:10:57 rumba kernel: swap_free: Unused swap offset entry 00000100
May  4 23:10:57 rumba kernel: swap_free: Unused swap offset entry 00001000
May  4 23:15:43 rumba kernel: swap_dup: Bad swap file entry 00000020
May  4 23:15:43 rumba kernel: swap_dup: Bad swap file entry 00000020
May  4 23:15:43 rumba kernel: swap_dup: Bad swap file entry 00000008
May  4 23:15:43 rumba kernel: swap_free: Bad swap file entry 00000020
May  4 23:15:43 rumba kernel: swap_free: Bad swap file entry 00000020
May  4 23:15:43 rumba kernel: swap_free: Unused swap offset entry 00008800
May  4 23:15:43 rumba kernel: swap_free: Unused swap offset entry 00008000
May  4 23:15:43 rumba kernel: swap_free: Unused swap offset entry 00008000
May  4 23:15:43 rumba kernel: swap_free: Bad swap file entry 00000008
May  4 23:15:43 rumba kernel: swap_free: Bad swap file entry 00000020
May  4 23:15:43 rumba kernel: swap_free: Bad swap file entry 00000020
May  4 23:15:44 rumba kernel: swap_free: Unused swap offset entry 00008800
May  4 23:15:44 rumba kernel: swap_free: Unused swap offset entry 00008000
May  4 23:15:44 rumba kernel: swap_free: Unused swap offset entry 00008000
May  4 23:15:44 rumba kernel: swap_free: Bad swap file entry 00000008
May  5 01:40:46 rumba kernel: Unable to handle kernel paging request at virtual address 80cece43
May  5 01:40:46 rumba kernel:  printing eip:
May  5 01:40:46 rumba kernel: c013e6f8
May  5 01:40:46 rumba kernel: *pde = c3c9f045
May  5 01:40:46 rumba kernel: Unable to handle kernel paging request at virtual address 83c9f3b0
May  5 01:40:46 rumba kernel:  printing eip:
May  5 01:40:46 rumba kernel: c0117ee8
May  5 01:40:46 rumba kernel: *pde = 00047883
May  5 01:40:46 rumba kernel: *pte = 00000000
May  5 01:40:46 rumba kernel: Oops: 0000
May  5 01:40:46 rumba kernel: CPU:    1
May  5 01:40:46 rumba kernel: EIP:    0010:[<c0117ee8>]    Not tainted
May  5 01:40:46 rumba kernel: EFLAGS: 00010212
May  5 01:40:46 rumba kernel: eax: 00000013   ebx: c3c9f000   ecx: c029d628   edx: 00003af8
May  5 01:40:46 rumba kernel: esi: 00000000   edi: f7bcfec0   ebp: 000000ec   esp: f7bcfdfc
May  5 01:40:46 rumba kernel: ds: 0018   es: 0018   ss: 0018
May  5 01:40:46 rumba kernel: Process kupdated (pid: 7, stackpage=f7bcf000)
May  5 01:40:46 rumba kernel: Stack: f7bce000 00000000 c0117ba0 00001e73 c02474e5 f2b14040 00000080 00000080 
May  5 01:40:46 rumba kernel:        c0248c98 f7bce000 ea8c2b40 ea8c2b40 f2b14884 f2b14000 f7bcff3c 00000080 
May  5 01:40:46 rumba kernel:        00030001 000001f6 f2b278e0 00000000 f2b14000 00000000 00000000 c01f2c4e 
May  5 01:40:46 rumba kernel: Call Trace:    [<c0117ba0>] [<c02474e5>] [<c0248c98>] [<c01f2c4e>] [<c01f7074>]
May  5 01:40:46 rumba kernel:   [<c018c120>] [<c024c14e>] [<c0108b10>] [<c013e6f8>] [<c013ed68>] [<c01c413a>]
May  5 01:40:46 rumba kernel:   [<c01c397f>] [<c01b3f08>] [<c0142118>] [<c01412e2>] [<c01415e5>] [<c01070d8>]
May  5 01:40:46 rumba kernel: 
May  5 01:40:46 rumba kernel: Code: 8b 9c ab 00 00 00 c0 53 68 6d d4 25 c0 e8 76 42 00 00 83 c4 

ksymoops 2.4.5 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.19 failed
ksymoops: No such file or directory
 Unable to handle kernel paging request at virtual address 80cece43
 c013e6f8
 *pde = c3c9f045
 Unable to handle kernel paging request at virtual address 83c9f3b0
 c0117ee8
 *pde = 00047883
 Oops: 0000
 CPU:    1
 EIP:    0010:[<c0117ee8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010212
 eax: 00000013   ebx: c3c9f000   ecx: c029d628   edx: 00003af8
 esi: 00000000   edi: f7bcfec0   ebp: 000000ec   esp: f7bcfdfc
 ds: 0018   es: 0018   ss: 0018
 Process kupdated (pid: 7, stackpage=f7bcf000)
 Stack: f7bce000 00000000 c0117ba0 00001e73 c02474e5 f2b14040 00000080 00000080 
        c0248c98 f7bce000 ea8c2b40 ea8c2b40 f2b14884 f2b14000 f7bcff3c 00000080 
        00030001 000001f6 f2b278e0 00000000 f2b14000 00000000 00000000 c01f2c4e 
 Call Trace:    [<c0117ba0>] [<c02474e5>] [<c0248c98>] [<c01f2c4e>] [<c01f7074>]
   [<c018c120>] [<c024c14e>] [<c0108b10>] [<c013e6f8>] [<c013ed68>] [<c01c413a>]
   [<c01c397f>] [<c01b3f08>] [<c0142118>] [<c01412e2>] [<c01415e5>] [<c01070d8>]
 Code: 8b 9c ab 00 00 00 c0 53 68 6d d4 25 c0 e8 76 42 00 00 83 c4 


>>EIP; c0117ee8 <__verify_write+4f8/980>   <=====

>>ebx; c3c9f000 <___strtok+393a180/386a01e0>
>>ecx; c029d628 <abi_defhandler_libcso+1b0/288>
>>edx; 00003af8 Before first symbol
>>edi; f7bcfec0 <___strtok+3786b040/386a01e0>
>>esp; f7bcfdfc <___strtok+3786af7c/386a01e0>

Trace; c0117ba0 <__verify_write+1b0/980>
Trace; c02474e5 <rpc_restart_call+d45/28c0>
Trace; c0248c98 <rpc_restart_call+24f8/28c0>
Trace; c01f2c4e <task_read_24+87e/21d0>
Trace; c01f7074 <export_probe_for_drive+d34/23e0>
Trace; c018c120 <zlib_fs_inflateSyncPoint+12790/21e90>
Trace; c024c14e <put_rpccred+12e/930>
Trace; c0108b10 <__read_lock_failed+12a0/27b0>
Trace; c013e6f8 <get_hash_table+78/a0>
Trace; c013ed68 <getblk+18/f0>
Trace; c01c413a <load_nls_default+213aa/29220>
Trace; c01c397f <load_nls_default+20bef/29220>
Trace; c01b3f08 <load_nls_default+11178/29220>
Trace; c0142118 <drop_super+128/160>
Trace; c01412e2 <try_to_free_buffers+2f2/360>
Trace; c01415e5 <block_sync_page+295/2c0>
Trace; c01070d8 <kernel_thread+28/1f0>

Code;  c0117ee8 <__verify_write+4f8/980>
00000000 <_EIP>:
Code;  c0117ee8 <__verify_write+4f8/980>   <=====
   0:   8b 9c ab 00 00 00 c0      mov    0xc0000000(%ebx,%ebp,4),%ebx   <=====
Code;  c0117eef <__verify_write+4ff/980>
   7:   53                        push   %ebx
Code;  c0117ef0 <__verify_write+500/980>
   8:   68 6d d4 25 c0            push   $0xc025d46d
Code;  c0117ef5 <__verify_write+505/980>
   d:   e8 76 42 00 00            call   4288 <_EIP+0x4288>
Code;  c0117efa <__verify_write+50a/980>
  12:   83 c4 00                  add    $0x0,%esp


1 warning and 1 error issued.  Results may not be reliable.

--=-PxS9DIvHDuJUtO93dh0e--

