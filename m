Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbUCVVcu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbUCVVct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:32:49 -0500
Received: from [212.214.15.226] ([212.214.15.226]:2176 "EHLO nell.mine.nu")
	by vger.kernel.org with ESMTP id S263354AbUCVVcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:32:23 -0500
Message-ID: <405F5B64.9030004@telia.com>
Date: Mon, 22 Mar 2004 22:32:20 +0100
From: mattias abrahamsson <mattias.abrahamsson@telia.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2, 2.6.3, 2.6.4 total hang
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have a problem with my computer, it hangs sporadicly and prints some oops.
Usually I am not doing anything special when it happens, surfing the web 
or copying some files or watching tv,
so I cant narrow down when it happens. What I do know is that it happens 
wih kernels 2.6.2, 2.6.3 and 2.6.4.

My box is a Slackware 9.1 with kernel 2.6.4, Asus P3B-F, P3 800 MHz and 
768 MB memory.

Since I dont know much about kernel debugging I have tried to get some 
information with ksymoops for you guys to look at.

/Regards Mattias


Output from lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03)
00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:09.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet 
Controller (rev 02)
00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20267 
(rev 02)
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
00:0e.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 06)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4200] (rev a3)


Output from ksymoops:
ksymoops 2.4.9 on i686 2.6.4.  Options used
     -v /usr/src/linux-2.6.4/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.4/ (default)
     -m /usr/src/linux-2.6.4/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Mar 14 04:40:10 tx kernel: Unable to handle kernel paging request at 
virtual add
ress 05d21000
Mar 14 04:40:10 tx kernel: c0173d20
Mar 14 04:40:10 tx kernel: *pde = 00000000
Mar 14 04:40:10 tx kernel: Oops: 0000 [#2]
Mar 14 04:40:10 tx kernel: CPU:    0
Mar 14 04:40:10 tx kernel: EIP:    0060:[<c0173d20>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 14 04:40:10 tx kernel: EFLAGS: 00010206
Mar 14 04:40:10 tx kernel: eax: 05d21000   ebx: 0010db08   ecx: 
0000ffff   edx:
05d21000
Mar 14 04:40:10 tx kernel: esi: efb3f800   edi: c17e0958   ebp: 
efb3f800   esp:
ce635e10
Mar 14 04:40:10 tx kernel: ds: 007b   es: 007b   ss: 0068
Mar 14 04:40:10 tx kernel: Stack: 00000000 ce634000 e33c4840 0010db08 
c01743e2 e
fb3f800 c17e0958 0010db08
Mar 14 04:40:10 tx kernel:        c17e0958 0010db08 e33c4840 efb3f800 
e33c4840 c
01c91ab efb3f800 0010db08
Mar 14 04:40:10 tx kernel:        da10a43c fffffff4 db0d2cdc db0d2c74 
c0167a3c d
b0d2c74 e33c4840 ce635f38
Mar 14 04:40:10 tx kernel: Call Trace:
Mar 14 04:40:10 tx kernel:  [<c01743e2>] iget_locked+0x52/0xd0
Mar 14 04:40:10 tx kernel:  [<c01c91ab>] ext3_lookup+0x6b/0xd0
Mar 14 04:40:10 tx kernel:  [<c0167a3c>] real_lookup+0xcc/0xf0
Mar 14 04:40:10 tx kernel:  [<c0167ce6>] do_lookup+0xa6/0xc0
Mar 14 04:40:10 tx kernel:  [<c01681cf>] link_path_walk+0x4cf/0x980
Mar 14 04:40:10 tx kernel:  [<c01749c2>] update_atime+0x92/0xf0
Mar 14 04:40:10 tx kernel:  [<c0168b89>] __user_walk+0x49/0x60
Mar 14 04:40:10 tx kernel:  [<c016378c>] vfs_lstat+0x1c/0x60
Mar 14 04:40:10 tx kernel:  [<c0163f0b>] sys_lstat64+0x1b/0x40
Mar 14 04:40:10 tx kernel:  [<c010aeeb>] syscall_call+0x7/0xb
Mar 14 04:40:10 tx kernel: Code: 8b 10 0f 18 02 90 39 58 18 74 0d 85 d2 
89 d0 75
 ef 31 c0 59


 >>EIP; c0173d20 <find_inode_fast+20/60>   <=====

 >>esi; efb3f800 <_end+2f4506bc/3f90eebc>
 >>edi; c17e0958 <_end+10f1814/3f90eebc>
 >>ebp; efb3f800 <_end+2f4506bc/3f90eebc>
 >>esp; ce635e10 <_end+df46ccc/3f90eebc>

Trace; c01743e2 <iget_locked+52/d0>
Trace; c01c91ab <ext3_lookup+6b/d0>
Trace; c0167a3c <real_lookup+cc/f0>
Trace; c0167ce6 <do_lookup+a6/c0>
Trace; c01681cf <link_path_walk+4cf/980>
Trace; c01749c2 <update_atime+92/f0>
Trace; c0168b89 <__user_walk+49/60>
Trace; c016378c <vfs_lstat+1c/60>
Trace; c0163f0b <sys_lstat64+1b/40>
Trace; c010aeeb <syscall_call+7/b>

Code;  c0173d20 <find_inode_fast+20/60>
00000000 <_EIP>:
Code;  c0173d20 <find_inode_fast+20/60>   <=====
   0:   8b 10                     mov    (%eax),%edx   <=====
Code;  c0173d22 <find_inode_fast+22/60>
   2:   0f 18 02                  prefetchnta (%edx)
Code;  c0173d25 <find_inode_fast+25/60>
   5:   90                        nop   
Code;  c0173d26 <find_inode_fast+26/60>
   6:   39 58 18                  cmp    %ebx,0x18(%eax)
Code;  c0173d29 <find_inode_fast+29/60>
   9:   74 0d                     je     18 <_EIP+0x18>
Code;  c0173d2b <find_inode_fast+2b/60>
   b:   85 d2                     test   %edx,%edx
Code;  c0173d2d <find_inode_fast+2d/60>
   d:   89 d0                     mov    %edx,%eax
Code;  c0173d2f <find_inode_fast+2f/60>
   f:   75 ef                     jne    0 <_EIP>
Code;  c0173d31 <find_inode_fast+31/60>
  11:   31 c0                     xor    %eax,%eax
Code;  c0173d33 <find_inode_fast+33/60>
  13:   59                        pop    %ecx

Mar 14 04:40:10 tx kernel: Call Trace:
Mar 14 04:40:10 tx kernel:  [<c011d377>] schedule+0x597/0x5a0
Mar 14 04:40:10 tx kernel:  [<c0149beb>] zap_pmd_range+0x4b/0x70
Mar 14 04:40:10 tx kernel:  [<c0149c5b>] unmap_page_range+0x4b/0x80
Mar 14 04:40:10 tx kernel:  [<c0149e6d>] unmap_vmas+0x1dd/0x240
Mar 14 04:40:10 tx kernel:  [<c014dee0>] exit_mmap+0x80/0x1a0
Mar 14 04:40:10 tx kernel:  [<c011ee05>] mmput+0x65/0x90
Mar 14 04:40:10 tx kernel:  [<c0123217>] do_exit+0x167/0x400
Mar 14 04:40:10 tx kernel:  [<c010bf9c>] die+0xfc/0x100
Mar 14 04:40:10 tx kernel:  [<c011b419>] do_page_fault+0x1f9/0x519
Mar 14 04:40:10 tx kernel:  [<c01c4974>] ext3_getblk+0xb4/0x2a0
Mar 14 04:40:10 tx kernel:  [<c015ab6f>] wake_up_buffer+0xf/0x30
Mar 14 04:40:10 tx kernel:  [<c015abc3>] unlock_buffer+0x33/0x60
Mar 14 04:40:10 tx kernel:  [<c015e9cd>] ll_rw_block+0x4d/0x90
Mar 14 04:40:10 tx kernel:  [<c01c8e10>] ext3_find_entry+0x340/0x430
Mar 14 04:40:10 tx kernel:  [<c011b220>] do_page_fault+0x0/0x519
Mar 14 04:40:10 tx kernel:  [<c010b8f5>] error_code+0x2d/0x38
Mar 14 04:40:10 tx kernel:  [<c0173d20>] find_inode_fast+0x20/0x60
Mar 14 04:40:10 tx kernel:  [<c01743e2>] iget_locked+0x52/0xd0
Mar 14 04:40:10 tx kernel:  [<c01c91ab>] ext3_lookup+0x6b/0xd0
Mar 14 04:40:10 tx kernel:  [<c0167a3c>] real_lookup+0xcc/0xf0
Mar 14 04:40:10 tx kernel:  [<c0167ce6>] do_lookup+0xa6/0xc0
Mar 14 04:40:10 tx kernel:  [<c01681cf>] link_path_walk+0x4cf/0x980
Mar 14 04:40:10 tx kernel:  [<c01749c2>] update_atime+0x92/0xf0
Mar 14 04:40:10 tx kernel:  [<c0168b89>] __user_walk+0x49/0x60
Mar 14 04:40:10 tx kernel:  [<c016378c>] vfs_lstat+0x1c/0x60
Mar 14 04:40:10 tx kernel:  [<c0163f0b>] sys_lstat64+0x1b/0x40
Mar 14 04:40:10 tx kernel:  [<c010aeeb>] syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c011d377 <schedule+597/5a0>
Trace; c0149beb <zap_pmd_range+4b/70>
Trace; c0149c5b <unmap_page_range+4b/80>
Trace; c0149e6d <unmap_vmas+1dd/240>
Trace; c014dee0 <exit_mmap+80/1a0>
Trace; c011ee05 <mmput+65/90>
Trace; c0123217 <do_exit+167/400>
Trace; c010bf9c <die+fc/100>
Trace; c011b419 <do_page_fault+1f9/519>
Trace; c01c4974 <ext3_getblk+b4/2a0>
Trace; c015ab6f <wake_up_buffer+f/30>
Trace; c015abc3 <unlock_buffer+33/60>
Trace; c015e9cd <ll_rw_block+4d/90>
Trace; c01c8e10 <ext3_find_entry+340/430>
Trace; c011b220 <do_page_fault+0/519>
Trace; c010b8f5 <error_code+2d/38>
Trace; c0173d20 <find_inode_fast+20/60>
Trace; c01743e2 <iget_locked+52/d0>
Trace; c01c91ab <ext3_lookup+6b/d0>
Trace; c0167a3c <real_lookup+cc/f0>
Trace; c0167ce6 <do_lookup+a6/c0>
Trace; c01681cf <link_path_walk+4cf/980>
Trace; c01749c2 <update_atime+92/f0>
Trace; c0168b89 <__user_walk+49/60>
Trace; c016378c <vfs_lstat+1c/60>
Trace; c0163f0b <sys_lstat64+1b/40>
Trace; c010aeeb <syscall_call+7/b>

Mar 15 00:21:44 tx kernel: Unable to handle kernel paging request at 
virtual add
ress 05d20408
Mar 15 00:21:44 tx kernel: c0173822
Mar 15 00:21:44 tx kernel: *pde = 00000000
Mar 15 00:21:44 tx kernel: Oops: 0000 [#3]
Mar 15 00:21:44 tx kernel: CPU:    0
Mar 15 00:21:44 tx kernel: EIP:    0060:[<c0173822>]    Tainted: P 
Mar 15 00:21:44 tx kernel: EFLAGS: 00010207
Mar 15 00:21:44 tx kernel: eax: ea280400   ebx: 05d20408   ecx: 
c05d1f44   edx:
ee13e000
Mar 15 00:21:44 tx kernel: esi: dc7080f4   edi: 05d20408   ebp: 
c05d1f34   esp:
ee13fee0
Mar 15 00:21:44 tx kernel: ds: 007b   es: 007b   ss: 0068
Mar 15 00:21:44 tx kernel: Stack: 00000000 00000000 00000000 ea280400 
ee13e000 e
e13ff0c ee13e000 c0173908
Mar 15 00:21:44 tx kernel:        c05d1f34 ea280400 ee13ff0c ee13ff0c 
ee13ff0c e
a28044c ea280400 c05d5b20
Mar 15 00:21:44 tx kernel:        ee13e000 c0160209 ea280400 ee13e000 
0000000f c
05d5c60 c0160d01 ea280400
Mar 15 00:21:44 tx kernel: Call Trace:
Mar 15 00:21:44 tx kernel:  [<c0173908>] invalidate_inodes+0x48/0xd0
Mar 15 00:21:44 tx kernel:  [<c0160209>] generic_shutdown_super+0x79/0x190
Mar 15 00:21:44 tx kernel:  [<c0160d01>] kill_anon_super+0x21/0x70
Mar 15 00:21:44 tx kernel:  [<c01f9639>] nfs_kill_super+0x19/0x30
Mar 15 00:21:44 tx kernel:  [<c016004f>] deactivate_super+0x5f/0xc0
Mar 15 00:21:44 tx kernel:  [<c017709f>] sys_umount+0x3f/0xa0
Mar 15 00:21:44 tx kernel:  [<c0177117>] sys_oldumount+0x17/0x20
Mar 15 00:21:44 tx kernel:  [<c010aeeb>] syscall_call+0x7/0xb
Mar 15 00:21:44 tx kernel: Code: 8b 3f 39 eb 74 7f 8d 73 f8 8b 44 24 24 
39 86 80
 00 00 00 75


 >>EIP; c0173822 <invalidate_list+22/c0>   <=====

 >>eax; ea280400 <_end+29b912bc/3f90eebc>
 >>ecx; c05d1f44 <inode_lock+0/0>
 >>edx; ee13e000 <_end+2da4eebc/3f90eebc>
 >>esi; dc7080f4 <_end+1c018fb0/3f90eebc>
 >>ebp; c05d1f34 <inode_in_use+0/8>
 >>esp; ee13fee0 <_end+2da50d9c/3f90eebc>

Trace; c0173908 <invalidate_inodes+48/d0>
Trace; c0160209 <generic_shutdown_super+79/190>
Trace; c0160d01 <kill_anon_super+21/70>
Trace; c01f9639 <nfs_kill_super+19/30>
Trace; c016004f <deactivate_super+5f/c0>
Trace; c017709f <sys_umount+3f/a0>
Trace; c0177117 <sys_oldumount+17/20>
Trace; c010aeeb <syscall_call+7/b>

Code;  c0173822 <invalidate_list+22/c0>
00000000 <_EIP>:
Code;  c0173822 <invalidate_list+22/c0>   <=====
   0:   8b 3f                     mov    (%edi),%edi   <=====
Code;  c0173824 <invalidate_list+24/c0>
   2:   39 eb                     cmp    %ebp,%ebx
Code;  c0173826 <invalidate_list+26/c0>
   4:   74 7f                     je     85 <_EIP+0x85>
Code;  c0173828 <invalidate_list+28/c0>
   6:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  c017382b <invalidate_list+2b/c0>
   9:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c017382f <invalidate_list+2f/c0>
   d:   39 86 80 00 00 00         cmp    %eax,0x80(%esi)
Code;  c0173835 <invalidate_list+35/c0>
  13:   75 00                     jne    15 <_EIP+0x15>

Mar 15 00:21:44 tx kernel: Call Trace:
Mar 15 00:21:44 tx kernel:  [<c011d377>] schedule+0x597/0x5a0
Mar 15 00:21:44 tx kernel:  [<c0149beb>] zap_pmd_range+0x4b/0x70
Mar 15 00:21:44 tx kernel:  [<c0149c5b>] unmap_page_range+0x4b/0x80
Mar 15 00:21:44 tx kernel:  [<c0149e6d>] unmap_vmas+0x1dd/0x240
Mar 15 00:21:44 tx kernel:  [<c014dee0>] exit_mmap+0x80/0x1a0
Mar 15 00:21:44 tx kernel:  [<c011ee05>] mmput+0x65/0x90
Mar 15 00:21:44 tx kernel:  [<c0123217>] do_exit+0x167/0x400
Mar 15 00:21:44 tx kernel:  [<c010bf9c>] die+0xfc/0x100
Mar 15 00:21:44 tx kernel:  [<c011b419>] do_page_fault+0x1f9/0x519
Mar 15 00:21:44 tx kernel:  [<c011cdb5>] scheduler_tick+0x4e5/0x500
Mar 15 00:21:44 tx kernel:  [<c01291d6>] update_process_times+0x46/0x60
Mar 15 00:21:44 tx kernel:  [<c0129046>] update_wall_time+0x16/0x40
Mar 15 00:21:44 tx kernel:  [<c0131bfe>] rcu_process_callbacks+0xee/0x120
Mar 15 00:21:44 tx kernel:  [<c0124ff6>] tasklet_action+0x46/0x70
Mar 15 00:21:44 tx kernel:  [<c010d697>] do_IRQ+0x107/0x140
Mar 15 00:21:44 tx kernel:  [<c011b220>] do_page_fault+0x0/0x519
Mar 15 00:21:44 tx kernel:  [<c010b8f5>] error_code+0x2d/0x38
Mar 15 00:21:44 tx kernel:  [<c0173822>] invalidate_list+0x22/0xc0
Mar 15 00:21:44 tx kernel:  [<c0173908>] invalidate_inodes+0x48/0xd0
Mar 15 00:21:44 tx kernel:  [<c0160209>] generic_shutdown_super+0x79/0x190
Mar 15 00:21:44 tx kernel:  [<c0160d01>] kill_anon_super+0x21/0x70
Mar 15 00:21:44 tx kernel:  [<c01f9639>] nfs_kill_super+0x19/0x30
Mar 15 00:21:44 tx kernel:  [<c016004f>] deactivate_super+0x5f/0xc0
Mar 15 00:21:44 tx kernel:  [<c017709f>] sys_umount+0x3f/0xa0
Mar 15 00:21:44 tx kernel:  [<c0177117>] sys_oldumount+0x17/0x20
Mar 15 00:21:44 tx kernel:  [<c010aeeb>] syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c011d377 <schedule+597/5a0>
Trace; c0149beb <zap_pmd_range+4b/70>
Trace; c0149c5b <unmap_page_range+4b/80>
Trace; c0149e6d <unmap_vmas+1dd/240>
Trace; c014dee0 <exit_mmap+80/1a0>
Trace; c011ee05 <mmput+65/90>
Trace; c0123217 <do_exit+167/400>
Trace; c010bf9c <die+fc/100>
Trace; c011b419 <do_page_fault+1f9/519>
Trace; c011cdb5 <scheduler_tick+4e5/500>
Trace; c01291d6 <update_process_times+46/60>
Trace; c0129046 <update_wall_time+16/40>
Trace; c0131bfe <rcu_process_callbacks+ee/120>
Trace; c0124ff6 <tasklet_action+46/70>
Trace; c010d697 <do_IRQ+107/140>
Trace; c011b220 <do_page_fault+0/519>
Trace; c010b8f5 <error_code+2d/38>
Trace; c0173822 <invalidate_list+22/c0>
Trace; c0173908 <invalidate_inodes+48/d0>
Trace; c0160209 <generic_shutdown_super+79/190>
Trace; c0160d01 <kill_anon_super+21/70>
Trace; c01f9639 <nfs_kill_super+19/30>
Trace; c016004f <deactivate_super+5f/c0>
Trace; c017709f <sys_umount+3f/a0>
Trace; c0177117 <sys_oldumount+17/20>
Trace; c010aeeb <syscall_call+7/b>

