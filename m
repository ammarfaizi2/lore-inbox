Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUIOQJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUIOQJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUIOQGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:06:30 -0400
Received: from smtpout2.uol.com.br ([200.221.11.55]:4247 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S266244AbUIOQCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:02:20 -0400
Date: Wed, 15 Sep 2004 13:01:43 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Oops with kernel 2.6.9-rc2
Message-ID: <20040915160143.GA4874@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Dear people,

Yesterday night, I was running my own self compiled kernel 2.6.9-rc2,
without any patches applied and, while I had my computer left unattended
for some moments, I saw that it generated two Oopsen in a row.

BTW, I was excited to use 2.6.9-rc2 because it included the 8 byte-fix for
USB urb's, which is needed for my desktop to cooperate with my USB Drive.

I'm attaching the decoded Oops through ksymoops. I'm using a Debian testing
machine with a Duron 600MHz processor, an Asus A7V motherboard and 386MB of
memory. The kernel is not tainted. I used GCC 3.3.4 to compile the kernel;
gcc --version says: gcc (GCC) 3.3.4 (Debian 1:3.3.4-6sarge1).

Since the decoded Oops mentioned things related to filesystems, I became
scared, with fear of data corruption.

Please let me know if any further details are necessary about the
situation.


Thanks, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="oops-data.txt"

ksymoops 2.4.9 on i686 2.6.9-rc2-1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-rc2-1/ (default)
     -m /boot/System.map-2.6.9-rc2-1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
8139too Fast Ethernet driver 0.9.27
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Unable to handle kernel paging request at virtual address 0805c130
c01274d2
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01274d2>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206   (2.6.9-rc2-1) 
eax: 0805c124   ebx: 00000006   ecx: 00000003   edx: 00000003
esi: 00000000   edi: d7c6da80   ebp: 00000000   esp: c6eb7c38
ds: 007b   es: 007b   ss: 0068
Stack: c6eb6000 00000001 00000004 d7c830c0 c01276d2 d7c6da80 00000000 000081ed 
       c6eb6000 c0190df4 00000000 c6eb7c64 c6eb7c64 00000004 c6eb6000 00000004 
       00000000 c015a739 d7c830c0 00000004 00000000 c6eb6000 c01583fd d7c830c0 
Call Trace:
 [<c01276d2>] in_group_p+0x42/0x80
 [<c0190df4>] ext3_permission+0xb4/0x1d0
 [<c015a739>] permission+0x49/0x50
 [<c01583fd>] flush_old_exec+0x2ad/0x760
 [<c0157fce>] kernel_read+0x4e/0x60
 [<c0173542>] load_elf_binary+0x2a2/0xb70
 [<c013333b>] generic_file_aio_read+0x5b/0x80
 [<c015b375>] link_path_walk+0x745/0xb70
 [<c01aec42>] copy_from_user+0x42/0x70
 [<c0158ad6>] search_binary_handler+0x56/0x1b0
 [<c0158df8>] do_execve+0x1c8/0x250
 [<c0102be2>] sys_execve+0x42/0x80
 [<c010400f>] syscall_call+0x7/0xb
Code: 1f 8d 0c 10 d1 f9 83 f9 ff 8d 81 ff 03 00 00 89 cd 0f 4f c1 c1 f8 0a 89 c2 c1 e2 0a 8b 84 87 8c 00 00 00 29 d5 89 ea 8b 6c 24 18 <2b> 2c 90 85 ed 7e 0e 8d 71 01 39 de 7c c0 31 c0 5b 5e 5f 5d c3 


>>EIP; c01274d2 <groups_search+52/80>   <=====

>>edi; d7c6da80 <pg0+178f6a80/3fc87400>
>>esp; c6eb7c38 <pg0+6b40c38/3fc87400>

Trace; c01276d2 <in_group_p+42/80>
Trace; c0190df4 <ext3_permission+b4/1d0>
Trace; c015a739 <permission+49/50>
Trace; c01583fd <flush_old_exec+2ad/760>
Trace; c0157fce <kernel_read+4e/60>
Trace; c0173542 <load_elf_binary+2a2/b70>
Trace; c013333b <generic_file_aio_read+5b/80>
Trace; c015b375 <link_path_walk+745/b70>
Trace; c01aec42 <copy_from_user+42/70>
Trace; c0158ad6 <search_binary_handler+56/1b0>
Trace; c0158df8 <do_execve+1c8/250>
Trace; c0102be2 <sys_execve+42/80>
Trace; c010400f <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01274a7 <groups_search+27/80>
00000000 <_EIP>:
Code;  c01274a7 <groups_search+27/80>
   0:   1f                        pop    %ds
Code;  c01274a8 <groups_search+28/80>
   1:   8d 0c 10                  lea    (%eax,%edx,1),%ecx
Code;  c01274ab <groups_search+2b/80>
   4:   d1 f9                     sar    %ecx
Code;  c01274ad <groups_search+2d/80>
   6:   83 f9 ff                  cmp    $0xffffffff,%ecx
Code;  c01274b0 <groups_search+30/80>
   9:   8d 81 ff 03 00 00         lea    0x3ff(%ecx),%eax
Code;  c01274b6 <groups_search+36/80>
   f:   89 cd                     mov    %ecx,%ebp
Code;  c01274b8 <groups_search+38/80>
  11:   0f 4f c1                  cmovg  %ecx,%eax
Code;  c01274bb <groups_search+3b/80>
  14:   c1 f8 0a                  sar    $0xa,%eax
Code;  c01274be <groups_search+3e/80>
  17:   89 c2                     mov    %eax,%edx
Code;  c01274c0 <groups_search+40/80>
  19:   c1 e2 0a                  shl    $0xa,%edx
Code;  c01274c3 <groups_search+43/80>
  1c:   8b 84 87 8c 00 00 00      mov    0x8c(%edi,%eax,4),%eax
Code;  c01274ca <groups_search+4a/80>
  23:   29 d5                     sub    %edx,%ebp
Code;  c01274cc <groups_search+4c/80>
  25:   89 ea                     mov    %ebp,%edx
Code;  c01274ce <groups_search+4e/80>
  27:   8b 6c 24 18               mov    0x18(%esp,1),%ebp

This decode from eip onwards should be reliable

Code;  c01274d2 <groups_search+52/80>
00000000 <_EIP>:
Code;  c01274d2 <groups_search+52/80>   <=====
   0:   2b 2c 90                  sub    (%eax,%edx,4),%ebp   <=====
Code;  c01274d5 <groups_search+55/80>
   3:   85 ed                     test   %ebp,%ebp
Code;  c01274d7 <groups_search+57/80>
   5:   7e 0e                     jle    15 <_EIP+0x15>
Code;  c01274d9 <groups_search+59/80>
   7:   8d 71 01                  lea    0x1(%ecx),%esi
Code;  c01274dc <groups_search+5c/80>
   a:   39 de                     cmp    %ebx,%esi
Code;  c01274de <groups_search+5e/80>
   c:   7c c0                     jl     ffffffce <_EIP+0xffffffce>
Code;  c01274e0 <groups_search+60/80>
   e:   31 c0                     xor    %eax,%eax
Code;  c01274e2 <groups_search+62/80>
  10:   5b                        pop    %ebx
Code;  c01274e3 <groups_search+63/80>
  11:   5e                        pop    %esi
Code;  c01274e4 <groups_search+64/80>
  12:   5f                        pop    %edi
Code;  c01274e5 <groups_search+65/80>
  13:   5d                        pop    %ebp
Code;  c01274e6 <groups_search+66/80>
  14:   c3                        ret    

Unable to handle kernel paging request at virtual address 08049074
c01274d2
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c01274d2>]    Not tainted VLI
EFLAGS: 00010206   (2.6.9-rc2-1) 
eax: 08049068   ebx: 00000006   ecx: 00000003   edx: 00000003
esi: 00000000   edi: d7c6d980   ebp: 00000046   esp: cb7f1c38
ds: 007b   es: 007b   ss: 0068
Stack: cb7f0000 00000001 00000004 d5b90630 c01276d2 d7c6d980 00000046 000081c9 
       cb7f0000 c0190df4 00000046 cb7f1c64 cb7f1c64 00000004 cb7f0000 00000004 
       00000000 c015a739 d5b90630 00000004 00000000 cb7f0000 c01583fd d5b90630 
Call Trace:
 [<c01276d2>] in_group_p+0x42/0x80
 [<c0190df4>] ext3_permission+0xb4/0x1d0
 [<c015a739>] permission+0x49/0x50
 [<c01583fd>] flush_old_exec+0x2ad/0x760
 [<c0157fce>] kernel_read+0x4e/0x60
 [<c0173542>] load_elf_binary+0x2a2/0xb70
 [<c013333b>] generic_file_aio_read+0x5b/0x80
 [<c015b51b>] link_path_walk+0x8eb/0xb70
 [<c01aec42>] copy_from_user+0x42/0x70
 [<c0158ad6>] search_binary_handler+0x56/0x1b0
 [<c0158df8>] do_execve+0x1c8/0x250
 [<c0102be2>] sys_execve+0x42/0x80
 [<c010400f>] syscall_call+0x7/0xb
Code: 1f 8d 0c 10 d1 f9 83 f9 ff 8d 81 ff 03 00 00 89 cd 0f 4f c1 c1 f8 0a 89 c2 c1 e2 0a 8b 84 87 8c 00 00 00 29 d5 89 ea 8b 6c 24 18 <2b> 2c 90 85 ed 7e 0e 8d 71 01 39 de 7c c0 31 c0 5b 5e 5f 5d c3 


>>EIP; c01274d2 <groups_search+52/80>   <=====

>>edi; d7c6d980 <pg0+178f6980/3fc87400>
>>esp; cb7f1c38 <pg0+b47ac38/3fc87400>

Trace; c01276d2 <in_group_p+42/80>
Trace; c0190df4 <ext3_permission+b4/1d0>
Trace; c015a739 <permission+49/50>
Trace; c01583fd <flush_old_exec+2ad/760>
Trace; c0157fce <kernel_read+4e/60>
Trace; c0173542 <load_elf_binary+2a2/b70>
Trace; c013333b <generic_file_aio_read+5b/80>
Trace; c015b51b <link_path_walk+8eb/b70>
Trace; c01aec42 <copy_from_user+42/70>
Trace; c0158ad6 <search_binary_handler+56/1b0>
Trace; c0158df8 <do_execve+1c8/250>
Trace; c0102be2 <sys_execve+42/80>
Trace; c010400f <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01274a7 <groups_search+27/80>
00000000 <_EIP>:
Code;  c01274a7 <groups_search+27/80>
   0:   1f                        pop    %ds
Code;  c01274a8 <groups_search+28/80>
   1:   8d 0c 10                  lea    (%eax,%edx,1),%ecx
Code;  c01274ab <groups_search+2b/80>
   4:   d1 f9                     sar    %ecx
Code;  c01274ad <groups_search+2d/80>
   6:   83 f9 ff                  cmp    $0xffffffff,%ecx
Code;  c01274b0 <groups_search+30/80>
   9:   8d 81 ff 03 00 00         lea    0x3ff(%ecx),%eax
Code;  c01274b6 <groups_search+36/80>
   f:   89 cd                     mov    %ecx,%ebp
Code;  c01274b8 <groups_search+38/80>
  11:   0f 4f c1                  cmovg  %ecx,%eax
Code;  c01274bb <groups_search+3b/80>
  14:   c1 f8 0a                  sar    $0xa,%eax
Code;  c01274be <groups_search+3e/80>
  17:   89 c2                     mov    %eax,%edx
Code;  c01274c0 <groups_search+40/80>
  19:   c1 e2 0a                  shl    $0xa,%edx
Code;  c01274c3 <groups_search+43/80>
  1c:   8b 84 87 8c 00 00 00      mov    0x8c(%edi,%eax,4),%eax
Code;  c01274ca <groups_search+4a/80>
  23:   29 d5                     sub    %edx,%ebp
Code;  c01274cc <groups_search+4c/80>
  25:   89 ea                     mov    %ebp,%edx
Code;  c01274ce <groups_search+4e/80>
  27:   8b 6c 24 18               mov    0x18(%esp,1),%ebp

This decode from eip onwards should be reliable

Code;  c01274d2 <groups_search+52/80>
00000000 <_EIP>:
Code;  c01274d2 <groups_search+52/80>   <=====
   0:   2b 2c 90                  sub    (%eax,%edx,4),%ebp   <=====
Code;  c01274d5 <groups_search+55/80>
   3:   85 ed                     test   %ebp,%ebp
Code;  c01274d7 <groups_search+57/80>
   5:   7e 0e                     jle    15 <_EIP+0x15>
Code;  c01274d9 <groups_search+59/80>
   7:   8d 71 01                  lea    0x1(%ecx),%esi
Code;  c01274dc <groups_search+5c/80>
   a:   39 de                     cmp    %ebx,%esi
Code;  c01274de <groups_search+5e/80>
   c:   7c c0                     jl     ffffffce <_EIP+0xffffffce>
Code;  c01274e0 <groups_search+60/80>
   e:   31 c0                     xor    %eax,%eax
Code;  c01274e2 <groups_search+62/80>
  10:   5b                        pop    %ebx
Code;  c01274e3 <groups_search+63/80>
  11:   5e                        pop    %esi
Code;  c01274e4 <groups_search+64/80>
  12:   5f                        pop    %edi
Code;  c01274e5 <groups_search+65/80>
  13:   5d                        pop    %ebp
Code;  c01274e6 <groups_search+66/80>
  14:   c3                        ret    


1 warning and 1 error issued.  Results may not be reliable.

--yrj/dFKFPuw6o+aM--
