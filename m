Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269252AbUIIA4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbUIIA4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUIIAz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:55:59 -0400
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:62150 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S269252AbUIIAyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:54:12 -0400
Message-ID: <413FA9AE.90304@bigpond.net.au>
Date: Thu, 09 Sep 2004 10:54:06 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.9-rc1-bk14 Oops] In groups_search()
Content-Type: multipart/mixed;
 boundary="------------050206000308000909090304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050206000308000909090304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This problem also existed in bk12 but not in the base 2.6.9-rc1.  (I 
don't know about other bk versions as I have only tried these two.) It 
is triggered by gdmgreeter and gdm-binary.  System being used is Fedora 
Core 2 on an UP i386 machine.  The system survives the Oops and is still 
usable.

Output from syslog and the results of running ksymoops on that output 
are attached.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050206000308000909090304
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Sep  9 10:01:08 mudlark kernel: Unable to handle kernel paging request at virtual address 0806a64c
Sep  9 10:01:08 mudlark kernel:  printing eip:
Sep  9 10:01:08 mudlark kernel: c0124ac1
Sep  9 10:01:08 mudlark kernel: *pde = 00000000
Sep  9 10:01:08 mudlark kernel: Oops: 0000 [#1]
Sep  9 10:01:08 mudlark kernel: PREEMPT 
Sep  9 10:01:08 mudlark kernel: Modules linked in: tulip ohci_hcd
Sep  9 10:01:08 mudlark kernel: CPU:    0
Sep  9 10:01:08 mudlark kernel: EIP:    0060:[<c0124ac1>]    Not tainted VLI
Sep  9 10:01:08 mudlark kernel: EFLAGS: 00010206   (2.6.9-rc1-bk14) 
Sep  9 10:01:08 mudlark kernel: EIP is at groups_search+0x48/0x6a
Sep  9 10:01:08 mudlark kernel: eax: 0806a640   ebx: 00000006   ecx: 00000003   edx: 00000003
Sep  9 10:01:08 mudlark kernel: esi: 00000000   edi: c1921880   ebp: 00000000   esp: f7339c30
Sep  9 10:01:09 mudlark kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 10:01:09 mudlark kernel: Process gdmgreeter (pid: 2968, threadinfo=f7338000 task=f798f000)
Sep  9 10:01:09 mudlark kernel: Stack: f7338000 00000001 00000004 f79bbf00 c0124caf c1921880 00000000 000081ed 
Sep  9 10:01:09 mudlark kernel:        f633a758 c015a1f7 00000000 00000004 f7338000 f78da700 c015a2c3 f633a758 
Sep  9 10:01:09 mudlark kernel:        00000004 f7338000 f7338000 c0157df4 f633a758 00000004 00000000 00000001 
Sep  9 10:01:09 mudlark kernel: Call Trace:
Sep  9 10:01:09 mudlark kernel:  [<c0124caf>] in_group_p+0x42/0x76
Sep  9 10:01:09 mudlark kernel:  [<c015a1f7>] vfs_permission+0x7a/0x117
Sep  9 10:01:09 mudlark kernel:  [<c015a2c3>] permission+0x2f/0x4b
Sep  9 10:01:09 mudlark kernel:  [<c0157df4>] flush_old_exec+0x30f/0x8cd
Sep  9 10:01:09 mudlark kernel:  [<c01578ed>] kernel_read+0x50/0x5f
Sep  9 10:01:09 mudlark kernel:  [<c01766e9>] load_elf_binary+0x32d/0xc67
Sep  9 10:01:09 mudlark kernel:  [<c01310b2>] generic_file_aio_read+0x5a/0x74
Sep  9 10:01:09 mudlark kernel:  [<c015743d>] copy_strings+0x1da/0x228
Sep  9 10:01:09 mudlark kernel:  [<c01763bc>] load_elf_binary+0x0/0xc67
Sep  9 10:01:09 mudlark kernel:  [<c0158728>] search_binary_handler+0x17a/0x2a8
Sep  9 10:01:09 mudlark kernel:  [<c0158a25>] do_execve+0x1cf/0x247
Sep  9 10:01:09 mudlark kernel:  [<c0102c06>] sys_execve+0x42/0x79
Sep  9 10:01:09 mudlark kernel:  [<c0103f61>] sysenter_past_esp+0x52/0x71
Sep  9 10:01:09 mudlark kernel: Code: 1f 8d 0c 10 d1 f9 83 f9 ff 8d 81 ff 03 00 00 89 cd 0f 4f c1 c1 f8 0a 89 c2 8b 84 87 8c 00 00 00 c1 e2 0a 29 d5 89 ea 8b 6c 24 18 <2b> 2c 90 85 ed 7e 0e 8d 71 01 39 de 7c c0 31 c0 5b 5e 5f 5d c3 
Sep  9 10:01:11 mudlark kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000e24
Sep  9 10:01:11 mudlark kernel:  printing eip:
Sep  9 10:01:11 mudlark kernel: c0124ac1
Sep  9 10:01:11 mudlark kernel: *pde = 35c28067
Sep  9 10:01:11 mudlark kernel: *pte = 00000000
Sep  9 10:01:11 mudlark kernel: Oops: 0000 [#2]
Sep  9 10:01:11 mudlark kernel: PREEMPT 
Sep  9 10:01:11 mudlark kernel: Modules linked in: tulip ohci_hcd
Sep  9 10:01:11 mudlark kernel: CPU:    0
Sep  9 10:01:11 mudlark kernel: EIP:    0060:[<c0124ac1>]    Not tainted VLI
Sep  9 10:01:11 mudlark kernel: EFLAGS: 00010202   (2.6.9-rc1-bk14) 
Sep  9 10:01:11 mudlark kernel: EIP is at groups_search+0x48/0x6a
Sep  9 10:01:11 mudlark kernel: eax: 00000000   ebx: 00000712   ecx: 00000389   edx: 00000389
Sep  9 10:01:11 mudlark kernel: esi: 00000000   edi: c1921880   ebp: 00000000   esp: f6dcfe60
Sep  9 10:01:11 mudlark kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 10:01:11 mudlark kernel: Process gdm-binary (pid: 3020, threadinfo=f6dce000 task=f798f000)
Sep  9 10:01:11 mudlark kernel: Stack: f6dce000 00000001 f7d01c50 f6dcff60 c0124caf c1921880 00000000 f7876001 
Sep  9 10:01:11 mudlark kernel:        000041ed c015b4b6 00000000 00000000 f78c7000 f78c7000 0000088c f789b300 
Sep  9 10:01:11 mudlark kernel:        00000000 f7d917f0 00000001 f78c7000 00223300 f789b300 00000000 c013f779 
Sep  9 10:01:11 mudlark kernel: Call Trace:
Sep  9 10:01:11 mudlark kernel:  [<c0124caf>] in_group_p+0x42/0x76
Sep  9 10:01:11 mudlark kernel:  [<c015b4b6>] link_path_walk+0xcd5/0xd78
Sep  9 10:01:11 mudlark kernel:  [<c013f779>] handle_mm_fault+0xd6/0x174
Sep  9 10:01:11 mudlark kernel:  [<c015b7d2>] path_lookup+0x80/0x13c
Sep  9 10:01:11 mudlark kernel:  [<c015be78>] open_namei+0x85/0x5f2
Sep  9 10:01:11 mudlark kernel:  [<c014c7eb>] filp_open+0x3e/0x64
Sep  9 10:01:11 mudlark kernel:  [<c014d4a5>] vfs_read+0xc9/0x119
Sep  9 10:01:11 mudlark kernel:  [<c014ca6a>] get_unused_fd+0x37/0xd9
Sep  9 10:01:11 mudlark kernel:  [<c014cbcb>] sys_open+0x49/0x89
Sep  9 10:01:11 mudlark kernel:  [<c0103fb3>] syscall_call+0x7/0xb
Sep  9 10:01:11 mudlark kernel: Code: 1f 8d 0c 10 d1 f9 83 f9 ff 8d 81 ff 03 00 00 89 cd 0f 4f c1 c1 f8 0a 89 c2 8b 84 87 8c 00 00 00 c1 e2 0a 29 d5 89 ea 8b 6c 24 18 <2b> 2c 90 85 ed 7e 0e 8d 71 01 39 de 7c c0 31 c0 5b 5e 5f 5d c3 
Sep  9 10:01:11 mudlark kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000624
Sep  9 10:01:11 mudlark kernel:  printing eip:
Sep  9 10:01:11 mudlark kernel: c0124ac1
Sep  9 10:01:12 mudlark kernel: *pde = 35c24067
Sep  9 10:01:12 mudlark kernel: *pte = 00000000
Sep  9 10:01:12 mudlark kernel: Oops: 0000 [#3]
Sep  9 10:01:12 mudlark kernel: PREEMPT 
Sep  9 10:01:12 mudlark kernel: Modules linked in: tulip ohci_hcd
Sep  9 10:01:12 mudlark kernel: CPU:    0
Sep  9 10:01:12 mudlark kernel: EIP:    0060:[<c0124ac1>]    Not tainted VLI
Sep  9 10:01:12 mudlark kernel: EFLAGS: 00010202   (2.6.9-rc1-bk14) 
Sep  9 10:01:12 mudlark kernel: EIP is at groups_search+0x48/0x6a
Sep  9 10:01:12 mudlark kernel: eax: 00000000   ebx: 00000312   ecx: 00000189   edx: 00000189
Sep  9 10:01:12 mudlark kernel: esi: 00000000   edi: c1921880   ebp: 00000000   esp: f6dcbe60
Sep  9 10:01:12 mudlark kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 10:01:12 mudlark kernel: Process gdm-binary (pid: 3019, threadinfo=f6dca000 task=f7948aa0)
Sep  9 10:01:12 mudlark kernel: Stack: f6dca000 00000001 f7d01c50 f6dcbf60 c0124caf c1921880 00000000 f7866001 
Sep  9 10:01:12 mudlark kernel:        000041ed c015b4b6 00000000 c16b1620 c013e9a2 c16b1620 00000ca0 f7958800 
Sep  9 10:01:12 mudlark kernel:        c013d673 c16b8480 00000001 f763c000 00328970 f7958800 00000001 c013f7ef 
Sep  9 10:01:12 mudlark kernel: Call Trace:
Sep  9 10:01:12 mudlark kernel:  [<c0124caf>] in_group_p+0x42/0x76
Sep  9 10:01:12 mudlark kernel:  [<c015b4b6>] link_path_walk+0xcd5/0xd78
Sep  9 10:01:12 mudlark kernel:  [<c013e9a2>] do_wp_page+0x2df/0x361
Sep  9 10:01:12 mudlark kernel:  [<c013d673>] pte_alloc_map+0x7c/0x9a
Sep  9 10:01:12 mudlark kernel:  [<c013f7ef>] handle_mm_fault+0x14c/0x174
Sep  9 10:01:12 mudlark kernel:  [<c015b7d2>] path_lookup+0x80/0x13c
Sep  9 10:01:12 mudlark kernel:  [<c015be78>] open_namei+0x85/0x5f2
Sep  9 10:01:12 mudlark kernel:  [<c011a4eb>] do_wait+0x1b7/0x4c6
Sep  9 10:01:12 mudlark kernel:  [<c014c7eb>] filp_open+0x3e/0x64
Sep  9 10:01:12 mudlark kernel:  [<c014ca6a>] get_unused_fd+0x37/0xd9
Sep  9 10:01:12 mudlark kernel:  [<c014cbcb>] sys_open+0x49/0x89
Sep  9 10:01:12 mudlark kernel:  [<c0103f61>] sysenter_past_esp+0x52/0x71
Sep  9 10:01:12 mudlark kernel: Code: 1f 8d 0c 10 d1 f9 83 f9 ff 8d 81 ff 03 00 00 89 cd 0f 4f c1 c1 f8 0a 89 c2 8b 84 87 8c 00 00 00 c1 e2 0a 29 d5 89 ea 8b 6c 24 18 <2b> 2c 90 85 ed 7e 0e 8d 71 01 39 de 7c c0 31 c0 5b 5e 5f 5d c3 

--------------050206000308000909090304
Content-Type: text/plain;
 name="ksymoops.op.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.op.txt"

ksymoops 2.4.8 on i686 2.6.9-rc1-bk14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-rc1-bk14/ (default)
     -m /boot/System.map-2.6.9-rc1-bk14 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Sep  9 10:01:08 mudlark kernel: Unable to handle kernel paging request at virtual address 0806a64c
Sep  9 10:01:08 mudlark kernel: c0124ac1
Sep  9 10:01:08 mudlark kernel: *pde = 00000000
Sep  9 10:01:08 mudlark kernel: Oops: 0000 [#1]
Sep  9 10:01:08 mudlark kernel: CPU:    0
Sep  9 10:01:08 mudlark kernel: EIP:    0060:[<c0124ac1>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Sep  9 10:01:08 mudlark kernel: EFLAGS: 00010206   (2.6.9-rc1-bk14) 
Sep  9 10:01:08 mudlark kernel: eax: 0806a640   ebx: 00000006   ecx: 00000003   edx: 00000003
Sep  9 10:01:08 mudlark kernel: esi: 00000000   edi: c1921880   ebp: 00000000   esp: f7339c30
Sep  9 10:01:09 mudlark kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 10:01:09 mudlark kernel: Stack: f7338000 00000001 00000004 f79bbf00 c0124caf c1921880 00000000 000081ed 
Sep  9 10:01:09 mudlark kernel:        f633a758 c015a1f7 00000000 00000004 f7338000 f78da700 c015a2c3 f633a758 
Sep  9 10:01:09 mudlark kernel:        00000004 f7338000 f7338000 c0157df4 f633a758 00000004 00000000 00000001 
Sep  9 10:01:09 mudlark kernel: Call Trace:
Sep  9 10:01:09 mudlark kernel:  [<c0124caf>] in_group_p+0x42/0x76
Sep  9 10:01:09 mudlark kernel:  [<c015a1f7>] vfs_permission+0x7a/0x117
Sep  9 10:01:09 mudlark kernel:  [<c015a2c3>] permission+0x2f/0x4b
Sep  9 10:01:09 mudlark kernel:  [<c0157df4>] flush_old_exec+0x30f/0x8cd
Sep  9 10:01:09 mudlark kernel:  [<c01578ed>] kernel_read+0x50/0x5f
Sep  9 10:01:09 mudlark kernel:  [<c01766e9>] load_elf_binary+0x32d/0xc67
Sep  9 10:01:09 mudlark kernel:  [<c01310b2>] generic_file_aio_read+0x5a/0x74
Sep  9 10:01:09 mudlark kernel:  [<c015743d>] copy_strings+0x1da/0x228
Sep  9 10:01:09 mudlark kernel:  [<c01763bc>] load_elf_binary+0x0/0xc67
Sep  9 10:01:09 mudlark kernel:  [<c0158728>] search_binary_handler+0x17a/0x2a8
Sep  9 10:01:09 mudlark kernel:  [<c0158a25>] do_execve+0x1cf/0x247
Sep  9 10:01:09 mudlark kernel:  [<c0102c06>] sys_execve+0x42/0x79
Sep  9 10:01:09 mudlark kernel:  [<c0103f61>] sysenter_past_esp+0x52/0x71
Sep  9 10:01:09 mudlark kernel: Code: 1f 8d 0c 10 d1 f9 83 f9 ff 8d 81 ff 03 00 00 89 cd 0f 4f c1 c1 f8 0a 89 c2 8b 84 87 8c 00 00 00 c1 e2 0a 29 d5 89 ea 8b 6c 24 18 <2b> 2c 90 85 ed 7e 0e 8d 71 01 39 de 7c c0 31 c0 5b 5e 5f 5d c3 


>>EIP; c0124ac1 <groups_search+48/6a>   <=====

>>edi; c1921880 <pg0+1451880/3fb2e400>
>>esp; f7339c30 <pg0+36e69c30/3fb2e400>

Trace; c0124caf <in_group_p+42/76>
Trace; c015a1f7 <vfs_permission+7a/117>
Trace; c015a2c3 <permission+2f/4b>
Trace; c0157df4 <flush_old_exec+30f/8cd>
Trace; c01578ed <kernel_read+50/5f>
Trace; c01766e9 <load_elf_binary+32d/c67>
Trace; c01310b2 <generic_file_aio_read+5a/74>
Trace; c015743d <copy_strings+1da/228>
Trace; c01763bc <load_elf_binary+0/c67>
Trace; c0158728 <search_binary_handler+17a/2a8>
Trace; c0158a25 <do_execve+1cf/247>
Trace; c0102c06 <sys_execve+42/79>
Trace; c0103f61 <sysenter_past_esp+52/71>

Code;  c0124a96 <groups_search+1d/6a>
00000000 <_EIP>:
Code;  c0124a96 <groups_search+1d/6a>
   0:   1f                        pop    %ds
Code;  c0124a97 <groups_search+1e/6a>
   1:   8d 0c 10                  lea    (%eax,%edx,1),%ecx
Code;  c0124a9a <groups_search+21/6a>
   4:   d1 f9                     sar    %ecx
Code;  c0124a9c <groups_search+23/6a>
   6:   83 f9 ff                  cmp    $0xffffffff,%ecx
Code;  c0124a9f <groups_search+26/6a>
   9:   8d 81 ff 03 00 00         lea    0x3ff(%ecx),%eax
Code;  c0124aa5 <groups_search+2c/6a>
   f:   89 cd                     mov    %ecx,%ebp
Code;  c0124aa7 <groups_search+2e/6a>
  11:   0f 4f c1                  cmovg  %ecx,%eax
Code;  c0124aaa <groups_search+31/6a>
  14:   c1 f8 0a                  sar    $0xa,%eax
Code;  c0124aad <groups_search+34/6a>
  17:   89 c2                     mov    %eax,%edx
Code;  c0124aaf <groups_search+36/6a>
  19:   8b 84 87 8c 00 00 00      mov    0x8c(%edi,%eax,4),%eax
Code;  c0124ab6 <groups_search+3d/6a>
  20:   c1 e2 0a                  shl    $0xa,%edx
Code;  c0124ab9 <groups_search+40/6a>
  23:   29 d5                     sub    %edx,%ebp
Code;  c0124abb <groups_search+42/6a>
  25:   89 ea                     mov    %ebp,%edx
Code;  c0124abd <groups_search+44/6a>
  27:   8b 6c 24 18               mov    0x18(%esp),%ebp
Code;  c0124ac1 <groups_search+48/6a>   <=====
  2b:   2b 2c 90                  sub    (%eax,%edx,4),%ebp   <=====
Code;  c0124ac4 <groups_search+4b/6a>
  2e:   85 ed                     test   %ebp,%ebp
Code;  c0124ac6 <groups_search+4d/6a>
  30:   7e 0e                     jle    40 <_EIP+0x40>
Code;  c0124ac8 <groups_search+4f/6a>
  32:   8d 71 01                  lea    0x1(%ecx),%esi
Code;  c0124acb <groups_search+52/6a>
  35:   39 de                     cmp    %ebx,%esi
Code;  c0124acd <groups_search+54/6a>
  37:   7c c0                     jl     fffffff9 <_EIP+0xfffffff9>
Code;  c0124acf <groups_search+56/6a>
  39:   31 c0                     xor    %eax,%eax
Code;  c0124ad1 <groups_search+58/6a>
  3b:   5b                        pop    %ebx
Code;  c0124ad2 <groups_search+59/6a>
  3c:   5e                        pop    %esi
Code;  c0124ad3 <groups_search+5a/6a>
  3d:   5f                        pop    %edi
Code;  c0124ad4 <groups_search+5b/6a>
  3e:   5d                        pop    %ebp
Code;  c0124ad5 <groups_search+5c/6a>
  3f:   c3                        ret    

Sep  9 10:01:11 mudlark kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000e24
Sep  9 10:01:11 mudlark kernel: c0124ac1
Sep  9 10:01:11 mudlark kernel: *pde = 35c28067
Sep  9 10:01:11 mudlark kernel: Oops: 0000 [#2]
Sep  9 10:01:11 mudlark kernel: CPU:    0
Sep  9 10:01:11 mudlark kernel: EIP:    0060:[<c0124ac1>]    Not tainted VLI
Sep  9 10:01:11 mudlark kernel: EFLAGS: 00010202   (2.6.9-rc1-bk14) 
Sep  9 10:01:11 mudlark kernel: eax: 00000000   ebx: 00000712   ecx: 00000389   edx: 00000389
Sep  9 10:01:11 mudlark kernel: esi: 00000000   edi: c1921880   ebp: 00000000   esp: f6dcfe60
Sep  9 10:01:11 mudlark kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 10:01:11 mudlark kernel: Stack: f6dce000 00000001 f7d01c50 f6dcff60 c0124caf c1921880 00000000 f7876001 
Sep  9 10:01:11 mudlark kernel:        000041ed c015b4b6 00000000 00000000 f78c7000 f78c7000 0000088c f789b300 
Sep  9 10:01:11 mudlark kernel:        00000000 f7d917f0 00000001 f78c7000 00223300 f789b300 00000000 c013f779 
Sep  9 10:01:11 mudlark kernel: Call Trace:
Sep  9 10:01:11 mudlark kernel:  [<c0124caf>] in_group_p+0x42/0x76
Sep  9 10:01:11 mudlark kernel:  [<c015b4b6>] link_path_walk+0xcd5/0xd78
Sep  9 10:01:11 mudlark kernel:  [<c013f779>] handle_mm_fault+0xd6/0x174
Sep  9 10:01:11 mudlark kernel:  [<c015b7d2>] path_lookup+0x80/0x13c
Sep  9 10:01:11 mudlark kernel:  [<c015be78>] open_namei+0x85/0x5f2
Sep  9 10:01:11 mudlark kernel:  [<c014c7eb>] filp_open+0x3e/0x64
Sep  9 10:01:11 mudlark kernel:  [<c014d4a5>] vfs_read+0xc9/0x119
Sep  9 10:01:11 mudlark kernel:  [<c014ca6a>] get_unused_fd+0x37/0xd9
Sep  9 10:01:11 mudlark kernel:  [<c014cbcb>] sys_open+0x49/0x89
Sep  9 10:01:11 mudlark kernel:  [<c0103fb3>] syscall_call+0x7/0xb
Sep  9 10:01:11 mudlark kernel: Code: 1f 8d 0c 10 d1 f9 83 f9 ff 8d 81 ff 03 00 00 89 cd 0f 4f c1 c1 f8 0a 89 c2 8b 84 87 8c 00 00 00 c1 e2 0a 29 d5 89 ea 8b 6c 24 18 <2b> 2c 90 85 ed 7e 0e 8d 71 01 39 de 7c c0 31 c0 5b 5e 5f 5d c3 


>>EIP; c0124ac1 <groups_search+48/6a>   <=====

>>edi; c1921880 <pg0+1451880/3fb2e400>
>>esp; f6dcfe60 <pg0+368ffe60/3fb2e400>

Trace; c0124caf <in_group_p+42/76>
Trace; c015b4b6 <link_path_walk+cd5/d78>
Trace; c013f779 <handle_mm_fault+d6/174>
Trace; c015b7d2 <path_lookup+80/13c>
Trace; c015be78 <open_namei+85/5f2>
Trace; c014c7eb <filp_open+3e/64>
Trace; c014d4a5 <vfs_read+c9/119>
Trace; c014ca6a <get_unused_fd+37/d9>
Trace; c014cbcb <sys_open+49/89>
Trace; c0103fb3 <syscall_call+7/b>

Code;  c0124a96 <groups_search+1d/6a>
00000000 <_EIP>:
Code;  c0124a96 <groups_search+1d/6a>
   0:   1f                        pop    %ds
Code;  c0124a97 <groups_search+1e/6a>
   1:   8d 0c 10                  lea    (%eax,%edx,1),%ecx
Code;  c0124a9a <groups_search+21/6a>
   4:   d1 f9                     sar    %ecx
Code;  c0124a9c <groups_search+23/6a>
   6:   83 f9 ff                  cmp    $0xffffffff,%ecx
Code;  c0124a9f <groups_search+26/6a>
   9:   8d 81 ff 03 00 00         lea    0x3ff(%ecx),%eax
Code;  c0124aa5 <groups_search+2c/6a>
   f:   89 cd                     mov    %ecx,%ebp
Code;  c0124aa7 <groups_search+2e/6a>
  11:   0f 4f c1                  cmovg  %ecx,%eax
Code;  c0124aaa <groups_search+31/6a>
  14:   c1 f8 0a                  sar    $0xa,%eax
Code;  c0124aad <groups_search+34/6a>
  17:   89 c2                     mov    %eax,%edx
Code;  c0124aaf <groups_search+36/6a>
  19:   8b 84 87 8c 00 00 00      mov    0x8c(%edi,%eax,4),%eax
Code;  c0124ab6 <groups_search+3d/6a>
  20:   c1 e2 0a                  shl    $0xa,%edx
Code;  c0124ab9 <groups_search+40/6a>
  23:   29 d5                     sub    %edx,%ebp
Code;  c0124abb <groups_search+42/6a>
  25:   89 ea                     mov    %ebp,%edx
Code;  c0124abd <groups_search+44/6a>
  27:   8b 6c 24 18               mov    0x18(%esp),%ebp
Code;  c0124ac1 <groups_search+48/6a>   <=====
  2b:   2b 2c 90                  sub    (%eax,%edx,4),%ebp   <=====
Code;  c0124ac4 <groups_search+4b/6a>
  2e:   85 ed                     test   %ebp,%ebp
Code;  c0124ac6 <groups_search+4d/6a>
  30:   7e 0e                     jle    40 <_EIP+0x40>
Code;  c0124ac8 <groups_search+4f/6a>
  32:   8d 71 01                  lea    0x1(%ecx),%esi
Code;  c0124acb <groups_search+52/6a>
  35:   39 de                     cmp    %ebx,%esi
Code;  c0124acd <groups_search+54/6a>
  37:   7c c0                     jl     fffffff9 <_EIP+0xfffffff9>
Code;  c0124acf <groups_search+56/6a>
  39:   31 c0                     xor    %eax,%eax
Code;  c0124ad1 <groups_search+58/6a>
  3b:   5b                        pop    %ebx
Code;  c0124ad2 <groups_search+59/6a>
  3c:   5e                        pop    %esi
Code;  c0124ad3 <groups_search+5a/6a>
  3d:   5f                        pop    %edi
Code;  c0124ad4 <groups_search+5b/6a>
  3e:   5d                        pop    %ebp
Code;  c0124ad5 <groups_search+5c/6a>
  3f:   c3                        ret    

Sep  9 10:01:11 mudlark kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000624
Sep  9 10:01:11 mudlark kernel: c0124ac1
Sep  9 10:01:12 mudlark kernel: *pde = 35c24067
Sep  9 10:01:12 mudlark kernel: Oops: 0000 [#3]
Sep  9 10:01:12 mudlark kernel: CPU:    0
Sep  9 10:01:12 mudlark kernel: EIP:    0060:[<c0124ac1>]    Not tainted VLI
Sep  9 10:01:12 mudlark kernel: EFLAGS: 00010202   (2.6.9-rc1-bk14) 
Sep  9 10:01:12 mudlark kernel: eax: 00000000   ebx: 00000312   ecx: 00000189   edx: 00000189
Sep  9 10:01:12 mudlark kernel: esi: 00000000   edi: c1921880   ebp: 00000000   esp: f6dcbe60
Sep  9 10:01:12 mudlark kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 10:01:12 mudlark kernel: Stack: f6dca000 00000001 f7d01c50 f6dcbf60 c0124caf c1921880 00000000 f7866001 
Sep  9 10:01:12 mudlark kernel:        000041ed c015b4b6 00000000 c16b1620 c013e9a2 c16b1620 00000ca0 f7958800 
Sep  9 10:01:12 mudlark kernel:        c013d673 c16b8480 00000001 f763c000 00328970 f7958800 00000001 c013f7ef 
Sep  9 10:01:12 mudlark kernel: Call Trace:
Sep  9 10:01:12 mudlark kernel:  [<c0124caf>] in_group_p+0x42/0x76
Sep  9 10:01:12 mudlark kernel:  [<c015b4b6>] link_path_walk+0xcd5/0xd78
Sep  9 10:01:12 mudlark kernel:  [<c013e9a2>] do_wp_page+0x2df/0x361
Sep  9 10:01:12 mudlark kernel:  [<c013d673>] pte_alloc_map+0x7c/0x9a
Sep  9 10:01:12 mudlark kernel:  [<c013f7ef>] handle_mm_fault+0x14c/0x174
Sep  9 10:01:12 mudlark kernel:  [<c015b7d2>] path_lookup+0x80/0x13c
Sep  9 10:01:12 mudlark kernel:  [<c015be78>] open_namei+0x85/0x5f2
Sep  9 10:01:12 mudlark kernel:  [<c011a4eb>] do_wait+0x1b7/0x4c6
Sep  9 10:01:12 mudlark kernel:  [<c014c7eb>] filp_open+0x3e/0x64
Sep  9 10:01:12 mudlark kernel:  [<c014ca6a>] get_unused_fd+0x37/0xd9
Sep  9 10:01:12 mudlark kernel:  [<c014cbcb>] sys_open+0x49/0x89
Sep  9 10:01:12 mudlark kernel:  [<c0103f61>] sysenter_past_esp+0x52/0x71
Sep  9 10:01:12 mudlark kernel: Code: 1f 8d 0c 10 d1 f9 83 f9 ff 8d 81 ff 03 00 00 89 cd 0f 4f c1 c1 f8 0a 89 c2 8b 84 87 8c 00 00 00 c1 e2 0a 29 d5 89 ea 8b 6c 24 18 <2b> 2c 90 85 ed 7e 0e 8d 71 01 39 de 7c c0 31 c0 5b 5e 5f 5d c3 


>>EIP; c0124ac1 <groups_search+48/6a>   <=====

>>edi; c1921880 <pg0+1451880/3fb2e400>
>>esp; f6dcbe60 <pg0+368fbe60/3fb2e400>

Trace; c0124caf <in_group_p+42/76>
Trace; c015b4b6 <link_path_walk+cd5/d78>
Trace; c013e9a2 <do_wp_page+2df/361>
Trace; c013d673 <pte_alloc_map+7c/9a>
Trace; c013f7ef <handle_mm_fault+14c/174>
Trace; c015b7d2 <path_lookup+80/13c>
Trace; c015be78 <open_namei+85/5f2>
Trace; c011a4eb <do_wait+1b7/4c6>
Trace; c014c7eb <filp_open+3e/64>
Trace; c014ca6a <get_unused_fd+37/d9>
Trace; c014cbcb <sys_open+49/89>
Trace; c0103f61 <sysenter_past_esp+52/71>

Code;  c0124a96 <groups_search+1d/6a>
00000000 <_EIP>:
Code;  c0124a96 <groups_search+1d/6a>
   0:   1f                        pop    %ds
Code;  c0124a97 <groups_search+1e/6a>
   1:   8d 0c 10                  lea    (%eax,%edx,1),%ecx
Code;  c0124a9a <groups_search+21/6a>
   4:   d1 f9                     sar    %ecx
Code;  c0124a9c <groups_search+23/6a>
   6:   83 f9 ff                  cmp    $0xffffffff,%ecx
Code;  c0124a9f <groups_search+26/6a>
   9:   8d 81 ff 03 00 00         lea    0x3ff(%ecx),%eax
Code;  c0124aa5 <groups_search+2c/6a>
   f:   89 cd                     mov    %ecx,%ebp
Code;  c0124aa7 <groups_search+2e/6a>
  11:   0f 4f c1                  cmovg  %ecx,%eax
Code;  c0124aaa <groups_search+31/6a>
  14:   c1 f8 0a                  sar    $0xa,%eax
Code;  c0124aad <groups_search+34/6a>
  17:   89 c2                     mov    %eax,%edx
Code;  c0124aaf <groups_search+36/6a>
  19:   8b 84 87 8c 00 00 00      mov    0x8c(%edi,%eax,4),%eax
Code;  c0124ab6 <groups_search+3d/6a>
  20:   c1 e2 0a                  shl    $0xa,%edx
Code;  c0124ab9 <groups_search+40/6a>
  23:   29 d5                     sub    %edx,%ebp
Code;  c0124abb <groups_search+42/6a>
  25:   89 ea                     mov    %ebp,%edx
Code;  c0124abd <groups_search+44/6a>
  27:   8b 6c 24 18               mov    0x18(%esp),%ebp
Code;  c0124ac1 <groups_search+48/6a>   <=====
  2b:   2b 2c 90                  sub    (%eax,%edx,4),%ebp   <=====
Code;  c0124ac4 <groups_search+4b/6a>
  2e:   85 ed                     test   %ebp,%ebp
Code;  c0124ac6 <groups_search+4d/6a>
  30:   7e 0e                     jle    40 <_EIP+0x40>
Code;  c0124ac8 <groups_search+4f/6a>
  32:   8d 71 01                  lea    0x1(%ecx),%esi
Code;  c0124acb <groups_search+52/6a>
  35:   39 de                     cmp    %ebx,%esi
Code;  c0124acd <groups_search+54/6a>
  37:   7c c0                     jl     fffffff9 <_EIP+0xfffffff9>
Code;  c0124acf <groups_search+56/6a>
  39:   31 c0                     xor    %eax,%eax
Code;  c0124ad1 <groups_search+58/6a>
  3b:   5b                        pop    %ebx
Code;  c0124ad2 <groups_search+59/6a>
  3c:   5e                        pop    %esi
Code;  c0124ad3 <groups_search+5a/6a>
  3d:   5f                        pop    %edi
Code;  c0124ad4 <groups_search+5b/6a>
  3e:   5d                        pop    %ebp
Code;  c0124ad5 <groups_search+5c/6a>
  3f:   c3                        ret    


1 error issued.  Results may not be reliable.

--------------050206000308000909090304--

