Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVG0L66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVG0L66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 07:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVG0L66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:58:58 -0400
Received: from ip212-226-133-177.adsl.kpnqwest.fi ([212.226.133.177]:42446
	"EHLO lonesom.pp.fi") by vger.kernel.org with ESMTP id S262203AbVG0L6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:58:51 -0400
Date: Wed, 27 Jul 2005 15:00:22 +0300
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
To: linux-kernel@vger.kernel.org
Subject: Ooops with 2.6.13-rc3
Message-ID: <20050727120022.GA12171@jumper.lonesom.pp.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Happened while untarring large tarball. fsck did not find anything
 serious after reboot. Haven't been able to reproduce yet.

			--j




--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oopsi.ksymoopsed"

ksymoops 2.4.9 on i686 2.6.13-rc3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.13-rc3/ (default)
     -m /boot/System.map-2.6.13-rc3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 3380c1ea
c015f843
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c015f843>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282   (2.6.13-rc3) 
eax: 3380c18e   ebx: 00000000   ecx: 0000000c   edx: 01088088
esi: 01088088   edi: 00000000   ebp: c041293c   esp: d50cdc10
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 e30bac9c e734f4c0 c019db27 d50cdcac f7e9fa00 00000000 3380c18e 
       d50cdc7c d50cdc7c 00000000 00000008 c0412940 c041293c c0160921 00001000 
       01088088 00000000 c18e337e 01088088 00000000 00001000 c18e337e c0160975 
Call Trace:
 [<c019db27>] ext3_splice_branch+0x87/0x150
 [<c0160921>] __find_get_block+0xe1/0x110
 [<c0160975>] __getblk+0x25/0x70
 [<c01a02cb>] __ext3_get_inode_loc+0x6b/0x270
 [<c01a0ae0>] ext3_do_update_inode+0x1c0/0x3d0
 [<c01a0fda>] ext3_reserve_inode_write+0x2a/0xc0
 [<c01a108a>] ext3_mark_inode_dirty+0x1a/0x40
 [<c01a112b>] ext3_dirty_inode+0x7b/0xb0
 [<c0181724>] __mark_inode_dirty+0x34/0x1c0
 [<c0161518>] __block_commit_write+0x78/0xc0
 [<c0161de0>] generic_commit_write+0x80/0xc0
 [<c019e791>] ext3_ordered_commit_write+0xa1/0x100
 [<c019e620>] ext3_journal_dirty_data+0x0/0x50
 [<c019e6f0>] ext3_ordered_commit_write+0x0/0x100
 [<c0140d5b>] generic_file_buffered_write+0x2db/0x690
 [<c01adfdc>] do_get_write_access+0x29c/0x530
 [<c0120efe>] current_fs_time+0x4e/0x70
 [<c017930f>] inode_update_time+0x3f/0xc0
 [<c014139c>] __generic_file_aio_write_nolock+0x28c/0x4d0
 [<c014186b>] generic_file_aio_write+0x6b/0xf0
 [<c019bf70>] ext3_file_write+0x30/0xb3
 [<c015dfa4>] do_sync_write+0xc4/0x120
 [<c01e12cc>] selinux_file_permission+0xec/0x180
 [<c0130840>] autoremove_wake_function+0x0/0x50
 [<c015dee0>] do_sync_write+0x0/0x120
 [<c015e0ba>] vfs_write+0xba/0x180
 [<c015e231>] sys_write+0x41/0x70
 [<c0103151>] syscall_call+0x7/0xb
Code: 00 e9 12 ff ff ff 89 f6 83 ec 38 89 74 24 2c 89 7c 24 30 89 cf 89 6c 24 34 89 5c 24 28 b9 0c 00 00 00 8b 40 04 89 d6 89 44 24 1c <2b> 48 5c 8b 98 9c 00 00 00 89 d0 89 fa d3 ea 0f ad f8 f6 c1 20 


>>EIP; c015f843 <__find_get_block_slow+23/1b0>   <=====

>>eax; 3380c18e <phys_startup_32+3370c18e/c0000000>
>>edx; 01088088 <phys_startup_32+f88088/c0000000>
>>esi; 01088088 <phys_startup_32+f88088/c0000000>
>>ebp; c041293c <per_cpu__bh_lrus+1c/20>
>>esp; d50cdc10 <pg0+14ca4c10/3fbd5400>

Trace; c019db27 <ext3_splice_branch+87/150>
Trace; c0160921 <__find_get_block+e1/110>
Trace; c0160975 <__getblk+25/70>
Trace; c01a02cb <__ext3_get_inode_loc+6b/270>
Trace; c01a0ae0 <ext3_do_update_inode+1c0/3d0>
Trace; c01a0fda <ext3_reserve_inode_write+2a/c0>
Trace; c01a108a <ext3_mark_inode_dirty+1a/40>
Trace; c01a112b <ext3_dirty_inode+7b/b0>
Trace; c0181724 <__mark_inode_dirty+34/1c0>
Trace; c0161518 <__block_commit_write+78/c0>
Trace; c0161de0 <generic_commit_write+80/c0>
Trace; c019e791 <ext3_ordered_commit_write+a1/100>
Trace; c019e620 <ext3_journal_dirty_data+0/50>
Trace; c019e6f0 <ext3_ordered_commit_write+0/100>
Trace; c0140d5b <generic_file_buffered_write+2db/690>
Trace; c01adfdc <do_get_write_access+29c/530>
Trace; c0120efe <current_fs_time+4e/70>
Trace; c017930f <inode_update_time+3f/c0>
Trace; c014139c <__generic_file_aio_write_nolock+28c/4d0>
Trace; c014186b <generic_file_aio_write+6b/f0>
Trace; c019bf70 <ext3_file_write+30/b3>
Trace; c015dfa4 <do_sync_write+c4/120>
Trace; c01e12cc <selinux_file_permission+ec/180>
Trace; c0130840 <autoremove_wake_function+0/50>
Trace; c015dee0 <do_sync_write+0/120>
Trace; c015e0ba <vfs_write+ba/180>
Trace; c015e231 <sys_write+41/70>
Trace; c0103151 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c015f818 <sys_fdatasync+8/10>
00000000 <_EIP>:
Code;  c015f818 <sys_fdatasync+8/10>
   0:   00 e9                     add    %ch,%cl
Code;  c015f81a <sys_fdatasync+a/10>
   2:   12 ff                     adc    %bh,%bh
Code;  c015f81c <sys_fdatasync+c/10>
   4:   ff                        (bad)  
Code;  c015f81d <sys_fdatasync+d/10>
   5:   ff 89 f6 83 ec 38         decl   0x38ec83f6(%ecx)
Code;  c015f823 <__find_get_block_slow+3/1b0>
   b:   89 74 24 2c               mov    %esi,0x2c(%esp)
Code;  c015f827 <__find_get_block_slow+7/1b0>
   f:   89 7c 24 30               mov    %edi,0x30(%esp)
Code;  c015f82b <__find_get_block_slow+b/1b0>
  13:   89 cf                     mov    %ecx,%edi
Code;  c015f82d <__find_get_block_slow+d/1b0>
  15:   89 6c 24 34               mov    %ebp,0x34(%esp)
Code;  c015f831 <__find_get_block_slow+11/1b0>
  19:   89 5c 24 28               mov    %ebx,0x28(%esp)
Code;  c015f835 <__find_get_block_slow+15/1b0>
  1d:   b9 0c 00 00 00            mov    $0xc,%ecx
Code;  c015f83a <__find_get_block_slow+1a/1b0>
  22:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c015f83d <__find_get_block_slow+1d/1b0>
  25:   89 d6                     mov    %edx,%esi
Code;  c015f83f <__find_get_block_slow+1f/1b0>
  27:   89 44 24 1c               mov    %eax,0x1c(%esp)

This decode from eip onwards should be reliable

Code;  c015f843 <__find_get_block_slow+23/1b0>
00000000 <_EIP>:
Code;  c015f843 <__find_get_block_slow+23/1b0>   <=====
   0:   2b 48 5c                  sub    0x5c(%eax),%ecx   <=====
Code;  c015f846 <__find_get_block_slow+26/1b0>
   3:   8b 98 9c 00 00 00         mov    0x9c(%eax),%ebx
Code;  c015f84c <__find_get_block_slow+2c/1b0>
   9:   89 d0                     mov    %edx,%eax
Code;  c015f84e <__find_get_block_slow+2e/1b0>
   b:   89 fa                     mov    %edi,%edx
Code;  c015f850 <__find_get_block_slow+30/1b0>
   d:   d3 ea                     shr    %cl,%edx
Code;  c015f852 <__find_get_block_slow+32/1b0>
   f:   0f ad f8                  shrd   %cl,%edi,%eax
Code;  c015f855 <__find_get_block_slow+35/1b0>
  12:   f6 c1 20                  test   $0x20,%cl

 <1>Unable to handle kernel paging request at virtual address 3380c1ea
c015f843
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c015f843>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13-rc3) 
eax: 3380c18e   ebx: 00000000   ecx: 0000000c   edx: 00bf8095
esi: 00bf8095   edi: 00000000   ebp: c041293c   esp: f6a7fcf4
ds: 007b   es: 007b   ss: 0068
Stack: f7c4c080 00000001 00000003 f7c4c0dc f6a7e000 00000000 00000286 3380c18e 
       00000286 00000000 00000000 00000008 c0412940 c041293c c0160921 00001000 
       00bf8095 00000000 c18e337e 00bf8095 00000000 00001000 c18e337e c0160975 
Call Trace:
 [<c0160921>] __find_get_block+0xe1/0x110
 [<c0160975>] __getblk+0x25/0x70
 [<c01a02cb>] __ext3_get_inode_loc+0x6b/0x270
 [<c019e7a1>] ext3_ordered_commit_write+0xb1/0x100
 [<c01ad41d>] start_this_handle+0x7d/0x430
 [<c019e620>] ext3_journal_dirty_data+0x0/0x50
 [<c01a0fda>] ext3_reserve_inode_write+0x2a/0xc0
 [<c01a108a>] ext3_mark_inode_dirty+0x1a/0x40
 [<c01a112b>] ext3_dirty_inode+0x7b/0xb0
 [<c0181724>] __mark_inode_dirty+0x34/0x1c0
 [<c0141362>] __generic_file_aio_write_nolock+0x252/0x4d0
 [<c01dd9a4>] avc_has_perm_noaudit+0x44/0x160
 [<c010563e>] do_IRQ+0x1e/0x30
 [<c0103b86>] common_interrupt+0x1a/0x20
 [<c014186b>] generic_file_aio_write+0x6b/0xf0
 [<c019bf70>] ext3_file_write+0x30/0xb3
 [<c015dfa4>] do_sync_write+0xc4/0x120
 [<c023bfbd>] opost+0xad/0x220
 [<c01e12cc>] selinux_file_permission+0xec/0x180
 [<c0130840>] autoremove_wake_function+0x0/0x50
 [<c015dee0>] do_sync_write+0x0/0x120
 [<c015e0ba>] vfs_write+0xba/0x180
 [<c015e231>] sys_write+0x41/0x70
 [<c0103151>] syscall_call+0x7/0xb
Code: 00 e9 12 ff ff ff 89 f6 83 ec 38 89 74 24 2c 89 7c 24 30 89 cf 89 6c 24 34 89 5c 24 28 b9 0c 00 00 00 8b 40 04 89 d6 89 44 24 1c <2b> 48 5c 8b 98 9c 00 00 00 89 d0 89 fa d3 ea 0f ad f8 f6 c1 20 


>>EIP; c015f843 <__find_get_block_slow+23/1b0>   <=====

>>eax; 3380c18e <phys_startup_32+3370c18e/c0000000>
>>edx; 00bf8095 <phys_startup_32+af8095/c0000000>
>>esi; 00bf8095 <phys_startup_32+af8095/c0000000>
>>ebp; c041293c <per_cpu__bh_lrus+1c/20>
>>esp; f6a7fcf4 <pg0+36656cf4/3fbd5400>

Trace; c0160921 <__find_get_block+e1/110>
Trace; c0160975 <__getblk+25/70>
Trace; c01a02cb <__ext3_get_inode_loc+6b/270>
Trace; c019e7a1 <ext3_ordered_commit_write+b1/100>
Trace; c01ad41d <start_this_handle+7d/430>
Trace; c019e620 <ext3_journal_dirty_data+0/50>
Trace; c01a0fda <ext3_reserve_inode_write+2a/c0>
Trace; c01a108a <ext3_mark_inode_dirty+1a/40>
Trace; c01a112b <ext3_dirty_inode+7b/b0>
Trace; c0181724 <__mark_inode_dirty+34/1c0>
Trace; c0141362 <__generic_file_aio_write_nolock+252/4d0>
Trace; c01dd9a4 <avc_has_perm_noaudit+44/160>
Trace; c010563e <do_IRQ+1e/30>
Trace; c0103b86 <common_interrupt+1a/20>
Trace; c014186b <generic_file_aio_write+6b/f0>
Trace; c019bf70 <ext3_file_write+30/b3>
Trace; c015dfa4 <do_sync_write+c4/120>
Trace; c023bfbd <opost+ad/220>
Trace; c01e12cc <selinux_file_permission+ec/180>
Trace; c0130840 <autoremove_wake_function+0/50>
Trace; c015dee0 <do_sync_write+0/120>
Trace; c015e0ba <vfs_write+ba/180>
Trace; c015e231 <sys_write+41/70>
Trace; c0103151 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c015f818 <sys_fdatasync+8/10>
00000000 <_EIP>:
Code;  c015f818 <sys_fdatasync+8/10>
   0:   00 e9                     add    %ch,%cl
Code;  c015f81a <sys_fdatasync+a/10>
   2:   12 ff                     adc    %bh,%bh
Code;  c015f81c <sys_fdatasync+c/10>
   4:   ff                        (bad)  
Code;  c015f81d <sys_fdatasync+d/10>
   5:   ff 89 f6 83 ec 38         decl   0x38ec83f6(%ecx)
Code;  c015f823 <__find_get_block_slow+3/1b0>
   b:   89 74 24 2c               mov    %esi,0x2c(%esp)
Code;  c015f827 <__find_get_block_slow+7/1b0>
   f:   89 7c 24 30               mov    %edi,0x30(%esp)
Code;  c015f82b <__find_get_block_slow+b/1b0>
  13:   89 cf                     mov    %ecx,%edi
Code;  c015f82d <__find_get_block_slow+d/1b0>
  15:   89 6c 24 34               mov    %ebp,0x34(%esp)
Code;  c015f831 <__find_get_block_slow+11/1b0>
  19:   89 5c 24 28               mov    %ebx,0x28(%esp)
Code;  c015f835 <__find_get_block_slow+15/1b0>
  1d:   b9 0c 00 00 00            mov    $0xc,%ecx
Code;  c015f83a <__find_get_block_slow+1a/1b0>
  22:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c015f83d <__find_get_block_slow+1d/1b0>
  25:   89 d6                     mov    %edx,%esi
Code;  c015f83f <__find_get_block_slow+1f/1b0>
  27:   89 44 24 1c               mov    %eax,0x1c(%esp)

This decode from eip onwards should be reliable

Code;  c015f843 <__find_get_block_slow+23/1b0>
00000000 <_EIP>:
Code;  c015f843 <__find_get_block_slow+23/1b0>   <=====
   0:   2b 48 5c                  sub    0x5c(%eax),%ecx   <=====
Code;  c015f846 <__find_get_block_slow+26/1b0>
   3:   8b 98 9c 00 00 00         mov    0x9c(%eax),%ebx
Code;  c015f84c <__find_get_block_slow+2c/1b0>
   9:   89 d0                     mov    %edx,%eax
Code;  c015f84e <__find_get_block_slow+2e/1b0>
   b:   89 fa                     mov    %edi,%edx
Code;  c015f850 <__find_get_block_slow+30/1b0>
   d:   d3 ea                     shr    %cl,%edx
Code;  c015f852 <__find_get_block_slow+32/1b0>
   f:   0f ad f8                  shrd   %cl,%edi,%eax
Code;  c015f855 <__find_get_block_slow+35/1b0>
  12:   f6 c1 20                  test   $0x20,%cl

 <1>Unable to handle kernel paging request at virtual address 3380c1ea
c015f843
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c015f843>]    Not tainted VLI
EFLAGS: 00010286   (2.6.13-rc3) 
eax: 3380c18e   ebx: 00000000   ecx: 0000000c   edx: 00bf8800
esi: 00bf8800   edi: 00000000   ebp: c041293c   esp: c84cbd44
ds: 007b   es: 007b   ss: 0068
Stack: c01dd9a4 00000000 00000000 00000003 00000001 c2201598 c84cbd6c 3380c18e 
       00bf8800 00000000 00000000 00000008 c0412940 c041293c c0160921 00001000 
       00bf8800 00000000 c18e337e 00bf8800 00000000 00001000 c18e337e c0160975 
Call Trace:
 [<c01dd9a4>] avc_has_perm_noaudit+0x44/0x160
 [<c0160921>] __find_get_block+0xe1/0x110
 [<c0160975>] __getblk+0x25/0x70
 [<c019e1d1>] ext3_getblk+0xf1/0x270
 [<c019e369>] ext3_bread+0x19/0x80
 [<c01a1d77>] htree_dirblock_to_tree+0x27/0xd0
 [<c01a1e7f>] ext3_htree_fill_tree+0x5f/0x1d0
 [<c01ddb1a>] avc_has_perm+0x5a/0x70
 [<c019be02>] ext3_dx_readdir+0x102/0x1c0
 [<c0171700>] filldir64+0x0/0xe0
 [<c0171700>] filldir64+0x0/0xe0
 [<c019b886>] ext3_readdir+0x346/0x4b0
 [<c0171700>] filldir64+0x0/0xe0
 [<c0171700>] filldir64+0x0/0xe0
 [<c017142b>] vfs_readdir+0x9b/0xb0
 [<c0171853>] sys_getdents64+0x73/0xc8
 [<c0103151>] syscall_call+0x7/0xb
Code: 00 e9 12 ff ff ff 89 f6 83 ec 38 89 74 24 2c 89 7c 24 30 89 cf 89 6c 24 34 89 5c 24 28 b9 0c 00 00 00 8b 40 04 89 d6 89 44 24 1c <2b> 48 5c 8b 98 9c 00 00 00 89 d0 89 fa d3 ea 0f ad f8 f6 c1 20


>>EIP; c015f843 <__find_get_block_slow+23/1b0>   <=====

>>eax; 3380c18e <phys_startup_32+3370c18e/c0000000>
>>edx; 00bf8800 <phys_startup_32+af8800/c0000000>
>>esi; 00bf8800 <phys_startup_32+af8800/c0000000>
>>ebp; c041293c <per_cpu__bh_lrus+1c/20>
>>esp; c84cbd44 <pg0+80a2d44/3fbd5400>

Trace; c01dd9a4 <avc_has_perm_noaudit+44/160>
Trace; c0160921 <__find_get_block+e1/110>
Trace; c0160975 <__getblk+25/70>
Trace; c019e1d1 <ext3_getblk+f1/270>
Trace; c019e369 <ext3_bread+19/80>
Trace; c01a1d77 <htree_dirblock_to_tree+27/d0>
Trace; c01a1e7f <ext3_htree_fill_tree+5f/1d0>
Trace; c01ddb1a <avc_has_perm+5a/70>
Trace; c019be02 <ext3_dx_readdir+102/1c0>
Trace; c0171700 <filldir64+0/e0>
Trace; c0171700 <filldir64+0/e0>
Trace; c019b886 <ext3_readdir+346/4b0>
Trace; c0171700 <filldir64+0/e0>
Trace; c0171700 <filldir64+0/e0>
Trace; c017142b <vfs_readdir+9b/b0>
Trace; c0171853 <sys_getdents64+73/c8>
Trace; c0103151 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c015f818 <sys_fdatasync+8/10>
00000000 <_EIP>:
Code;  c015f818 <sys_fdatasync+8/10>
   0:   00 e9                     add    %ch,%cl
Code;  c015f81a <sys_fdatasync+a/10>
   2:   12 ff                     adc    %bh,%bh
Code;  c015f81c <sys_fdatasync+c/10>
   4:   ff                        (bad)  
Code;  c015f81d <sys_fdatasync+d/10>
   5:   ff 89 f6 83 ec 38         decl   0x38ec83f6(%ecx)
Code;  c015f823 <__find_get_block_slow+3/1b0>
   b:   89 74 24 2c               mov    %esi,0x2c(%esp)
Code;  c015f827 <__find_get_block_slow+7/1b0>
   f:   89 7c 24 30               mov    %edi,0x30(%esp)
Code;  c015f82b <__find_get_block_slow+b/1b0>
  13:   89 cf                     mov    %ecx,%edi
Code;  c015f82d <__find_get_block_slow+d/1b0>
  15:   89 6c 24 34               mov    %ebp,0x34(%esp)
Code;  c015f831 <__find_get_block_slow+11/1b0>
  19:   89 5c 24 28               mov    %ebx,0x28(%esp)
Code;  c015f835 <__find_get_block_slow+15/1b0>
  1d:   b9 0c 00 00 00            mov    $0xc,%ecx
Code;  c015f83a <__find_get_block_slow+1a/1b0>
  22:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c015f83d <__find_get_block_slow+1d/1b0>
  25:   89 d6                     mov    %edx,%esi
Code;  c015f83f <__find_get_block_slow+1f/1b0>
  27:   89 44 24 1c               mov    %eax,0x1c(%esp)

This decode from eip onwards should be reliable

Code;  c015f843 <__find_get_block_slow+23/1b0>
00000000 <_EIP>:
Code;  c015f843 <__find_get_block_slow+23/1b0>   <=====
   0:   2b 48 5c                  sub    0x5c(%eax),%ecx   <=====
Code;  c015f846 <__find_get_block_slow+26/1b0>
   3:   8b 98 9c 00 00 00         mov    0x9c(%eax),%ebx
Code;  c015f84c <__find_get_block_slow+2c/1b0>
   9:   89 d0                     mov    %edx,%eax
Code;  c015f84e <__find_get_block_slow+2e/1b0>
   b:   89 fa                     mov    %edi,%edx
Code;  c015f850 <__find_get_block_slow+30/1b0>
   d:   d3 ea                     shr    %cl,%edx
Code;  c015f852 <__find_get_block_slow+32/1b0>
   f:   0f ad f8                  shrd   %cl,%edi,%eax
Code;  c015f855 <__find_get_block_slow+35/1b0>
  12:   f6 c1 20                  test   $0x20,%cl


1 warning and 1 error issued.  Results may not be reliable.

--VbJkn9YxBvnuCH5J--
